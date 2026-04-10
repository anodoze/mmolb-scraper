import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import { ALL_LEAGUES } from './config.js';
import { fetchLeague, fetchTeam, fetchPlayers, fetchBulkTeamRecords, refreshLeaderboards } from './fetch.js';
import { upsertLeague, upsertTeam, upsertPlayers, upsertPlayersStats,
         upsertPlayersAttributes, upsertPlayersDetails, logScrapeRun } from './db.js';
import { computeAttributes, attributeTotals } from './attributes.js';
import { logger } from './logger.js';

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

const mode = process.argv[2] ?? '--full';

async function getExistingTeamIds() {
  const { data, error } = await supabase.from('teams').select('id');
  if (error) throw error;
  return new Set(data.map(t => t.id));
}

async function getAllPlayerIds() {
  let allIds = [];
  let page = 0;
  const pageSize = 1000;
  
  while (true) {
    const { data, error } = await supabase
      .from('players')
      .select('id')
      .range(page * pageSize, (page + 1) * pageSize - 1);
    
    if (error) throw error;
    if (data.length === 0) break;
    
    allIds.push(...data.map(p => p.id).filter(id => id && id !== '#'));
    if (data.length < pageSize) break;
    page++;
  }
  
  return allIds;
}

async function processPlayerDetails(players, fullRun = false) {
  const detailRows = [];
  const attributeRows = [];

  for (let i = 0; i < players.length; i++) {
    const player = players[i];
    if (i % 500 === 0) logger.info(`Processing ${players.length} players`);
    try {
      const computed = computeAttributes(player);
      detailRows.push({
        playerId: player._id,
        details: {
          firstName:            player.FirstName,
          lastName:             player.LastName,
          suffix:               player.Suffix,
          number:               player.Number,
          position:             player.Position,
          positionType:         player.PositionType,
          level:                player.Level,
          likes:                player.Likes,
          dislikes:             player.Dislikes,
          home:                 player.Home,
          bats:                 player.Bats,
          throws:               player.Throws,
          priority:             player.Priority,
          lesserBoon:           player.LesserBoon,
          foodBuffs:            player.FoodBuffs,
          equipment:            player.Equipment,
          augmentHistory:       player.AugmentHistory,
          baseAttributeBonuses: player.BaseAttributeBonuses,
          appliedLevelUps:      player.AppliedLevelUps,
          pendingLevelUps:      player.PendingLevelUps,
          scheduledLevelUps:    player.ScheduledLevelUps,
          pitchTypes:           player.PitchTypes,
          pitchSelection:       player.PitchSelection,
          seasonStats:          player.SeasonStats,
          modifications:        player.Modifications,
          attributeBreakdown:   computed,
        },
      });

      if (fullRun) {
        attributeRows.push({
          playerId:   player._id,
          attributes: attributeTotals(computed),
        });
      }
    } catch (err) {
      logger.error(`Failed to compute attributes for player ${player._id}: ${err.message}`);
    }
  }

  await upsertPlayersDetails(detailRows);
  if (fullRun && attributeRows.length > 0) {
    await upsertPlayersAttributes(attributeRows);
  }
}

async function processTeam(teamId, leagueConfig, existingTeamIds) {
  let teamData;
  try {
    teamData = await fetchTeam(teamId);
  } catch (err) {
    logger.error(`Failed to fetch team ${teamId}: ${err.message}`);
    return { success: false };
  }

  const record = teamData.Record?.['Regular Season'] ?? {};
  const wins   = record.Wins ?? 0;
  const losses = record.Losses ?? 0;

  if (wins === 0 && losses === 0 && !existingTeamIds.has(teamId)) {
    logger.info(`skipping inactive team ${teamData.Name ?? teamId}`);
    return { success: true, skipped: true };
  }

  try {
    await upsertTeam({
      id:       teamId,
      leagueId: leagueConfig.id,
      name:     teamData.Name,
      location: teamData.Location,
      emoji:    teamData.Emoji,
      color:    teamData.Color,
      wins,
      losses,
    });

    const allPlayersRaw = [
      ...(Array.isArray(teamData.Players) ? teamData.Players : []),
      ...(Array.isArray(teamData.Bench?.Batters) ? teamData.Bench.Batters : []),
      ...(Array.isArray(teamData.Bench?.Pitchers) ? teamData.Bench.Pitchers : []),
    ];

    const seen = new Set();
    const allPlayers = allPlayersRaw.filter(p => {
      if (!p.PlayerID || p.PlayerID === '#') return false;
      if (seen.has(p.PlayerID)) return false;
      seen.add(p.PlayerID);
      return true;
    });

    // logger.info(`Player IDs for ${teamData.Name}: ${allPlayers.map(p => p.PlayerID).join(',')}`);

    const playerRows = allPlayers.map(p => ({
      id:           p.PlayerID,
      teamId:       teamId,
      firstName:    p.FirstName,
      lastName:     p.LastName,
      suffix:       p.Suffix,
      number:       p.Number,
      position:     p.Position,
      positionType: p.PositionType,
      slot:         p.Slot,
      level:        p.Level,
    }));

    const statsRows = allPlayers.map(p => ({
      playerId: p.PlayerID,
      stats:    p.Stats ?? {},
    }));

    await upsertPlayers(playerRows);
    await upsertPlayersStats(statsRows);

    const playerIds = allPlayers.map(p => p.PlayerID);
    const playerDetails = await fetchPlayers(playerIds);
    await processPlayerDetails(playerDetails, true);

    logger.info(`Scraped team ${teamData.Location} ${teamData.Name}`);
    return { success: true };
  } catch (err) {
    logger.error(`Failed to process team ${teamId}: ${err.message ?? JSON.stringify(err)}`);
    return { success: false };
  }
}

async function runWithConcurrency(tasks, limit) {
  let index = 0;
  let teamsScraped = 0;
  let errors = 0;

  async function worker() {
    while (index < tasks.length) {
      const task = tasks[index++];
      const result = await task();
      if (result.success && !result.skipped) teamsScraped++;
      else if (!result.success) errors++;
    }
  }

  await Promise.all(Array.from({ length: limit }, worker));
  return { teamsScraped, errors };
}

async function runFull() {
  const startedAt = new Date().toISOString();
  let errors = 0;

  logger.info('Starting full scrape run');

  for (const league of ALL_LEAGUES) {
    await upsertLeague(league);
  }
  logger.info(`Upserted ${ALL_LEAGUES.length} leagues`);

  const existingTeamIds = await getExistingTeamIds();
  logger.info(`Found ${existingTeamIds.size} existing teams in DB`);

  // collect all team IDs across all leagues first
  const leagueTeams = []; // [{ leagueConfig, teamId }]
  for (const leagueConfig of ALL_LEAGUES) {
    let leagueData;
    try {
      leagueData = await fetchLeague(leagueConfig.id);
    } catch (err) {
      logger.error(`Failed to fetch league ${leagueConfig.name}: ${err.message}`);
      errors++;
      continue;
    }
    const teamIds = leagueData.Teams ?? [];
    logger.info(`==== League ${leagueConfig.name}: ${teamIds.length} teams ====`);
    for (const teamId of teamIds) {
      leagueTeams.push({ leagueConfig, teamId });
    }
  }

  // bulk fetch records and filter inactive teams
  const allTeamIds = leagueTeams.map(t => t.teamId);
  const bulkRecords = await fetchBulkTeamRecords(allTeamIds);

  const allTasks = [];
  let inactiveCount = 0;
    
  for (const { leagueConfig, teamId } of leagueTeams) {
    const record = bulkRecords.get(teamId);
    if (!record) continue;
    if (record.wins === 0 && record.losses === 0 && !existingTeamIds.has(teamId)) {
      inactiveCount ++;
      continue;
    }
    allTasks.push(() => processTeam(teamId, leagueConfig, existingTeamIds));
  }
  
  logger.info(`Skipping ${inactiveCount} inactive teams.`);
  logger.info(`Scraping ${allTasks.length} active teams`);

  const CONCURRENCY = 6;
  const { teamsScraped, errors: teamErrors } = await runWithConcurrency(allTasks, CONCURRENCY);
  errors += teamErrors;

  await refreshLeaderboards();

  await logScrapeRun({
    startedAt,
    finishedAt: new Date().toISOString(),
    teamsScraped,
    errors,
    notes: 'full',
  });

  const duration = ((new Date() - new Date(startedAt)) / 1000 / 60).toFixed(1);
  logger.info(`Full run complete in ${duration} minutes. Teams scraped: ${teamsScraped}, errors: ${errors}`);
}

async function runDetails() {
  const startedAt = new Date().toISOString();
  let errors = 0;

  logger.info('Starting details scrape run');

  const playerIds = await getAllPlayerIds();
  logger.info(`Fetching details for ${playerIds.length} players`);

  const players = await fetchPlayers(playerIds, true);
  await processPlayerDetails(players, false);

  await logScrapeRun({
    startedAt,
    finishedAt:   new Date().toISOString(),
    teamsScraped: 0,
    errors,
    notes: 'details',
  });

  logger.info(`Details run complete. Players updated: ${players.length}, errors: ${errors}`);
}

async function runTeam(teamId) {
  logger.info(`Running single team scrape for ${teamId}`);
  
  const existingTeamIds = await getExistingTeamIds();
  
  // Find which league this team belongs to by checking all leagues
  let leagueConfig = null;
  for (const league of ALL_LEAGUES) {
    let leagueData;
    try {
      leagueData = await fetchLeague(league.id);
    } catch (err) {
      logger.error(`${err}`)
      continue;
    }
    if (leagueData.Teams?.includes(teamId)) {
      leagueConfig = league;
      break;
    }
  }

  if (!leagueConfig) {
    logger.error(`Could not find league for team ${teamId}`);
    process.exit(1);
  }

  logger.info(`Found team in league ${leagueConfig.name}`);
  const result = await processTeam(teamId, leagueConfig, existingTeamIds);
  logger.info(`Done. Success: ${result.success}`);
}

if (mode === '--full') {
  await runFull();
} else if (mode === '--details') {
  await runDetails();
} else if (mode === '--team') {
  const teamId = process.argv[3];
  if (!teamId) {
    logger.error('Usage: node index.js --team <teamId>');
    process.exit(1);
  }
  await runTeam(teamId);
} else {
  logger.error(`Unknown mode: ${mode}. Use --full or --details`);
  process.exit(1);
}