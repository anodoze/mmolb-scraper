import { createClient } from '@supabase/supabase-js';
import 'dotenv/config';

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

export async function upsertLeague(league) {
  const { error } = await supabase
    .from('leagues')
    .upsert({
      id: league.id,
      name: league.name,
      emoji: league.emoji,
      color: league.color,
      league_type: league.league_type,
    }, { onConflict: 'id' });
  if (error) throw error;
}

export async function upsertTeam(team) {
  const { error } = await supabase
    .from('teams')
    .upsert({
      id: team.id,
      league_id: team.leagueId,
      name: team.name,
      location: team.location,
      emoji: team.emoji,
      color: team.color,
      wins: team.wins ?? 0,
      losses: team.losses ?? 0,
      last_updated: new Date().toISOString(),
    }, { onConflict: 'id' });
  if (error) throw error;
}

export async function upsertPlayer(player) {
  const { error } = await supabase
    .from('players')
    .upsert({
      id: player.id,
      team_id: player.teamId,
      first_name: player.firstName,
      last_name: player.lastName,
      suffix: player.suffix ?? null,
      number: player.number,
      position: player.position,
      position_type: player.positionType,
      slot: player.slot,
      level: player.level ?? 0,
      last_updated: new Date().toISOString(),
    }, { onConflict: 'id' });
  if (error) throw error;
}

export async function upsertPlayerStats(playerId, stats) {
  const s = stats ?? {};
  const { error } = await supabase
    .from('player_stats')
    .upsert({
      player_id: playerId,
      // Batting
      plate_appearances: s.plate_appearances ?? 0,
      at_bats: s.at_bats ?? 0,
      runs: s.runs ?? 0,
      singles: s.singles ?? 0,
      doubles: s.doubles ?? 0,
      triples: s.triples ?? 0,
      home_runs: s.home_runs ?? 0,
      runs_batted_in: s.runs_batted_in ?? 0,
      walked: s.walked ?? 0,
      struck_out: s.struck_out ?? 0,
      hit_by_pitch: s.hit_by_pitch ?? 0,
      stolen_bases: s.stolen_bases ?? 0,
      caught_stealing: s.caught_stealing ?? 0,
      left_on_base: s.left_on_base ?? 0,
      sac_flies: s.sac_flies ?? 0,
      reached_on_error: s.reached_on_error ?? 0,
      grounded_into_double_play: s.grounded_into_double_play ?? 0,
      // Fielding
      putouts: s.putouts ?? 0,
      assists: s.assists ?? 0,
      errors: s.errors ?? 0,
      double_plays: s.double_plays ?? 0,
      force_outs: s.force_outs ?? 0,
      runners_caught_stealing: s.runners_caught_stealing ?? 0,
      allowed_stolen_bases: s.allowed_stolen_bases ?? 0,
      // Pitching
      appearances: s.appearances ?? 0,
      starts: s.starts ?? 0,
      wins: s.wins ?? 0,
      losses: s.losses ?? 0,
      saves: s.saves ?? 0,
      holds: s.holds ?? 0,
      outs: s.outs ?? 0,
      batters_faced: s.batters_faced ?? 0,
      hits_allowed: s.hits_allowed ?? 0,
      home_runs_allowed: s.home_runs_allowed ?? 0,
      earned_runs: s.earned_runs ?? 0,
      walks: s.walks ?? 0,
      strikeouts: s.strikeouts ?? 0,
      pitches_thrown: s.pitches_thrown ?? 0,
      complete_games: s.complete_games ?? 0,
      shutouts: s.shutouts ?? 0,
      no_hitters: s.no_hitters ?? 0,
      quality_starts: s.quality_starts ?? 0,
      hit_batters: s.hit_batters ?? 0,
      mound_visits: s.mound_visits ?? 0,
      inherited_runners: s.inherited_runners ?? 0,
      inherited_runs_allowed: s.inherited_runs_allowed ?? 0,
      games_finished: s.games_finished ?? 0,
      last_updated: new Date().toISOString(),
    }, { onConflict: 'player_id' });
  if (error) throw error;
}

export async function upsertPlayerAttributes(playerId, attributes) {
  const a = attributes ?? {};
  const { error } = await supabase
    .from('player_attributes')
    .upsert({
      player_id: playerId,
      // Batting
      discipline: a.discipline ?? 0,
      vision: a.vision ?? 0,
      intimidation: a.intimidation ?? 0,
      muscle: a.muscle ?? 0,
      contact: a.contact ?? 0,
      cunning: a.cunning ?? 0,
      selflessness: a.selflessness ?? 0,
      determination: a.determination ?? 0,
      wisdom: a.wisdom ?? 0,
      insight: a.insight ?? 0,
      aiming: a.aiming ?? 0,
      lift: a.lift ?? 0,
      // Pitching
      control: a.control ?? 0,
      velocity: a.velocity ?? 0,
      rotation: a.rotation ?? 0,
      stuff: a.stuff ?? 0,
      deception: a.deception ?? 0,
      intuition: a.intuition ?? 0,
      persuasion: a.persuasion ?? 0,
      presence: a.presence ?? 0,
      defiance: a.defiance ?? 0,
      accuracy: a.accuracy ?? 0,
      stamina: a.stamina ?? 0,
      guts: a.guts ?? 0,
      // Baserunning
      performance: a.performance ?? 0,
      speed: a.speed ?? 0,
      greed: a.greed ?? 0,
      stealth: a.stealth ?? 0,
      // Defense
      arm: a.arm ?? 0,
      dexterity: a.dexterity ?? 0,
      reaction: a.reaction ?? 0,
      acrobatics: a.acrobatics ?? 0,
      agility: a.agility ?? 0,
      patience: a.patience ?? 0,
      awareness: a.awareness ?? 0,
      composure: a.composure ?? 0,
      // Other
      luck: a.luck ?? 0,
    }, { onConflict: 'player_id' });
  if (error) throw error;
}

export async function upsertPlayerDetails(playerId, details) {
  const { error } = await supabase
    .from('player_details')
    .upsert({
      player_id: playerId,
      details,
      last_updated: new Date().toISOString(),
    }, { onConflict: 'player_id' });
  if (error) throw error;
}

export async function upsertPlayers(players) {
  const { error } = await supabase
    .from('players')
    .upsert(players.map(p => ({
      id:            p.id,
      team_id:       p.teamId,
      first_name:    p.firstName,
      last_name:     p.lastName,
      suffix:        p.suffix ?? null,
      number:        p.number,
      position:      p.position,
      position_type: p.positionType,
      slot:          p.slot,
      level:         p.level ?? 0,
      last_updated:  new Date().toISOString(),
    })), { onConflict: 'id' });
  if (error) throw error;
}

export async function upsertPlayersStats(playerStats) {
  const { error } = await supabase
    .from('player_stats')
    .upsert(playerStats.map(({ playerId, stats: s }) => ({
      player_id:                   playerId,
      plate_appearances:           s.plate_appearances ?? 0,
      at_bats:                     s.at_bats ?? 0,
      runs:                        s.runs ?? 0,
      singles:                     s.singles ?? 0,
      doubles:                     s.doubles ?? 0,
      triples:                     s.triples ?? 0,
      home_runs:                   s.home_runs ?? 0,
      runs_batted_in:              s.runs_batted_in ?? 0,
      walked:                      s.walked ?? 0,
      struck_out:                  s.struck_out ?? 0,
      hit_by_pitch:                s.hit_by_pitch ?? 0,
      stolen_bases:                s.stolen_bases ?? 0,
      caught_stealing:             s.caught_stealing ?? 0,
      left_on_base:                s.left_on_base ?? 0,
      sac_flies:                   s.sac_flies ?? 0,
      reached_on_error:            s.reached_on_error ?? 0,
      grounded_into_double_play:   s.grounded_into_double_play ?? 0,
      putouts:                     s.putouts ?? 0,
      assists:                     s.assists ?? 0,
      errors:                      s.errors ?? 0,
      double_plays:                s.double_plays ?? 0,
      force_outs:                  s.force_outs ?? 0,
      runners_caught_stealing:     s.runners_caught_stealing ?? 0,
      allowed_stolen_bases:        s.allowed_stolen_bases ?? 0,
      appearances:                 s.appearances ?? 0,
      starts:                      s.starts ?? 0,
      wins:                        s.wins ?? 0,
      losses:                      s.losses ?? 0,
      saves:                       s.saves ?? 0,
      holds:                       s.holds ?? 0,
      outs:                        s.outs ?? 0,
      batters_faced:               s.batters_faced ?? 0,
      hits_allowed:                s.hits_allowed ?? 0,
      home_runs_allowed:           s.home_runs_allowed ?? 0,
      earned_runs:                 s.earned_runs ?? 0,
      walks:                       s.walks ?? 0,
      strikeouts:                  s.strikeouts ?? 0,
      pitches_thrown:              s.pitches_thrown ?? 0,
      complete_games:              s.complete_games ?? 0,
      shutouts:                    s.shutouts ?? 0,
      no_hitters:                  s.no_hitters ?? 0,
      quality_starts:              s.quality_starts ?? 0,
      hit_batters:                 s.hit_batters ?? 0,
      mound_visits:                s.mound_visits ?? 0,
      inherited_runners:           s.inherited_runners ?? 0,
      inherited_runs_allowed:      s.inherited_runs_allowed ?? 0,
      games_finished:              s.games_finished ?? 0,
      last_updated:                new Date().toISOString(),
    })), { onConflict: 'player_id' });
  if (error) throw error;
}

export async function upsertPlayersAttributes(playerAttributes) {
  const { error } = await supabase
    .from('player_attributes')
    .upsert(playerAttributes.map(({ playerId, attributes: a }) => ({
      player_id:     playerId,
      discipline:    a.discipline ?? 0,
      vision:        a.vision ?? 0,
      intimidation:  a.intimidation ?? 0,
      muscle:        a.muscle ?? 0,
      contact:       a.contact ?? 0,
      cunning:       a.cunning ?? 0,
      selflessness:  a.selflessness ?? 0,
      determination: a.determination ?? 0,
      wisdom:        a.wisdom ?? 0,
      insight:       a.insight ?? 0,
      aiming:        a.aiming ?? 0,
      lift:          a.lift ?? 0,
      control:       a.control ?? 0,
      velocity:      a.velocity ?? 0,
      rotation:      a.rotation ?? 0,
      stuff:         a.stuff ?? 0,
      deception:     a.deception ?? 0,
      intuition:     a.intuition ?? 0,
      persuasion:    a.persuasion ?? 0,
      presence:      a.presence ?? 0,
      defiance:      a.defiance ?? 0,
      accuracy:      a.accuracy ?? 0,
      stamina:       a.stamina ?? 0,
      guts:          a.guts ?? 0,
      performance:   a.performance ?? 0,
      speed:         a.speed ?? 0,
      greed:         a.greed ?? 0,
      stealth:       a.stealth ?? 0,
      arm:           a.arm ?? 0,
      dexterity:     a.dexterity ?? 0,
      reaction:      a.reaction ?? 0,
      acrobatics:    a.acrobatics ?? 0,
      agility:       a.agility ?? 0,
      patience:      a.patience ?? 0,
      awareness:     a.awareness ?? 0,
      composure:     a.composure ?? 0,
      luck:          a.luck ?? 0,
    })), { onConflict: 'player_id' });
  if (error) throw error;
}

export async function upsertPlayersDetails(playerDetails) {
  const { error } = await supabase
    .from('player_details')
    .upsert(playerDetails.map(({ playerId, details }) => ({
      player_id:    playerId,
      details,
      last_updated: new Date().toISOString(),
    })), { onConflict: 'player_id' });
  if (error) throw error;
}

export async function logScrapeRun(run) {
  const { error } = await supabase
    .from('scrape_runs')
    .insert({
      started_at: run.startedAt,
      finished_at: run.finishedAt,
      teams_scraped: run.teamsScraped,
      errors: run.errors,
      notes: run.notes ?? null,
    });
  if (error) throw error;
}