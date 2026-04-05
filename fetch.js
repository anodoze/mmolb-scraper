import { API_BASE } from './config.js';

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

export async function fetchPlayers(playerIds) {
  // API accepts up to 100 IDs at a time
  const chunks = [];
  for (let i = 0; i < playerIds.length; i += 100) {
    chunks.push(playerIds.slice(i, i + 100));
  }

  const results = [];
  for (const chunk of chunks) {
    const data = await apiFetch(`players?ids=${chunk.join(',')}`);
    results.push(...data.players);
  }
  return results;
}