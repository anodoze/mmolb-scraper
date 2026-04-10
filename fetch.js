import { API_BASE } from './config.js';
import { logger } from './logger.js';
import { supabase } from './db.js';

async function apiFetch(path) {
  const res = await fetch(`${API_BASE}/${path}`);
  if (!res.ok) throw new Error(`API error ${res.status} fetching ${path}`);
  return res.json();
}

export async function fetchLeague(leagueId) {
  return apiFetch(`league/${leagueId}`);
}

export async function fetchTeam(teamId) {
  return apiFetch(`team/${teamId}`);
}

export async function fetchPlayers(playerIds, logProgress = false) {
  // API accepts up to 100 IDs at a time
  const chunks = [];
  for (let i = 0; i < playerIds.length; i += 100) {
    chunks.push(playerIds.slice(i, i + 100));
  }

  const results = [];
  for (let i = 0; i < chunks.length; i++) {
    const data = await apiFetch(`players?ids=${chunks[i].join(',')}`);
    results.push(...data.players);
    if (logProgress) {
      logger.info(`Fetched chunk ${i + 1}/${chunks.length} (${results.length} players so far)`);
    }
  }
  return results;
}

export async function fetchBulkTeamRecords(teamIds) {
  const chunkSize = 100;
  const results = new Map();
  
  for (let i = 0; i < teamIds.length; i += chunkSize) {
    const chunk = teamIds.slice(i, i + chunkSize);
    const url = `https://mmolb.com/api/teams?ids=${chunk.join(',')}`;
    const res = await fetch(url);
    const data = await res.json();
    for (const team of data.teams) {
      const record = team.Record?.['Regular Season'] ?? {};
      results.set(team._id, { wins: record.Wins ?? 0, losses: record.Losses ?? 0 });
    }
  }
  
  return results;
}

export async function refreshLeaderboards() {
  const views = [
    'mv_games_played',
    'mv_league_pitching_context',
    'mv_league_batting_context',
    'mv_batting_leaderboard',
    'mv_pitching_leaderboard',
    'mv_attribute_leaderboard'
  ];

  for (const view of views) {
    logger.info(`Refreshing ${view}...`);
    const { error } = await supabase.rpc('refresh_materialized_view', { view_name: view });
    if (error) logger.error(`Failed to refresh ${view}: ${error.message}`);
  }
}