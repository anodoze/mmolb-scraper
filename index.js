import 'dotenv/config';
import { createClient } from '@supabase/supabase-js';
import { ALL_LEAGUES } from './config.js';
import { fetchLeague, fetchTeam, fetchPlayers } from './fetch.js';
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
  const { data, error } = await supabase.from('players').select('id');
  if (error) throw error;
  return data.map(p => p.id);
}

async function processPlayerDetails(players, fullRun = false) {
  const detailRows = [];
  const attributeRows = [];

  for (const player of players) {
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

async function runFull() {
  const startedAt = new Date().toISOString();
  let teamsScraped = 0;
  let errors = 0;

  logger.info('Starting full scrape run');

  // Upsert leagues from config — no API call needed
  for (const leagueConfig of ALL_LEAGUES) {
    await upsertLeague(leagueConfig);
  }
  logger.info(`Upserted ${ALL_LEAGUES.length} leagues`);

  const existingTeamIds = await getExistingTeamIds();
  logger.info(`Found ${existingTeamIds.size} existing teams in DB`);

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
    logger.info(`League ${leagueConfig.name}: ${teamIds.length} teams`);

    for (const teamId of teamIds) {
      let teamData;
      try {
        teamData = await fetchTeam(teamId);
      } catch (err) {
        logger.error(`Failed to fetch team ${teamId}: ${err.message}`);
        errors++;
        continue;
      }

      const record = teamData.Record?.['Regular Season'] ?? {};
      const wins   = record.Wins ?? 0;
      const losses = record.Losses ?? 0;

      // Skip teams with no games played unless they're already in the DB
      if (wins === 0 && losses === 0 && !existingTeamIds.has(teamId)) {
        logger.info(`Skipping inactive team ${teamData.Name ?? teamId}`);
        continue;
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

        const allPlayers = [
          ...(teamData.Players ?? []).map(p => ({ ...p, isBench: false })),
          ...(Array.isArray(teamData.Bench?.Batters) ? teamData.Bench.Batters : []).map(p => ({ ...p, isBench: true })),
          ...(Array.isArray(teamData.Bench?.Pitchers) ? teamData.Bench.Pitchers : []).map(p => ({ ...p, isBench: true })),
        ];

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

        // Collect player IDs for bulk detail fetch
        const playerIds = allPlayers.map(p => p.PlayerID);
        const playerDetails = await fetchPlayers(playerIds);
        await processPlayerDetails(playerDetails, true);

        teamsScraped++;
        logger.info(`Scraped team ${teamData.Name} (${teamsScraped})`);
      } catch (err) {
        logger.error(`Failed to process team ${teamId}: ${err.message ?? JSON.stringify(err)}`);
        errors++;
      }
    }
  }

  await logScrapeRun({
    startedAt,
    finishedAt:   new Date().toISOString(),
    teamsScraped,
    errors,
    notes:        'full',
  });

  logger.info(`Full run complete. Teams scraped: ${teamsScraped}, errors: ${errors}`);
}

async function runDetails() {
  const startedAt = new Date().toISOString();
  let errors = 0;

  logger.info('Starting details scrape run');

  const playerIds = await getAllPlayerIds();
  logger.info(`Fetching details for ${playerIds.length} players`);

  const players = await fetchPlayers(playerIds);
  await processPlayerDetails(players, false);

  await logScrapeRun({
    startedAt,
    finishedAt: new Date().toISOString(),
    teamsScraped: 0,
    errors,
    notes: 'details',
  });

  logger.info(`Details run complete. Players updated: ${players.length}, errors: ${errors}`);
}

if (mode === '--full') {
  await runFull();
} else if (mode === '--details') {
  await runDetails();
} else {
  logger.error(`Unknown mode: ${mode}. Use --full or --details`);
  process.exit(1);
}