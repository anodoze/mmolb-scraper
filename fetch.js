import { API_BASE } from './config.js';
import { logger } from './logger.js';

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