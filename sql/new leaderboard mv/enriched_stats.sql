CREATE MATERIALIZED VIEW mv_enriched_stats AS
SELECT
  ps.player_id,
  p.first_name, p.last_name, p.suffix, p.position, p.position_type,
  t.id AS team_id, t.name AS team_name, t.location AS team_location, t.emoji AS team_emoji,
  l.id AS league_id, l.name AS league_name, l.league_type,
  gp.games_played,
  (gp.games_played * 1.0)::numeric  AS ip_threshold,
  (gp.games_played * 3.1)::numeric  AS pa_threshold,
  -- batting rate
  ps.plate_appearances, ps.ba, ps.obp, ps.slg, ps.ops, ps.babip,
  -- batting counting
  ps.hits, ps.singles, ps.doubles, ps.triples, ps.home_runs,
  ps.walked, ps.hit_by_pitch, ps.stolen_bases, ps.caught_stealing,
  ps.struck_out, ps.runs, ps.runs_batted_in,
  -- pitching rate
  ps.innings_pitched, ps.era, ps.whip, ps.k9, ps.bb9, ps.h9, ps.hr9,
  -- pitching counting
  ps.strikeouts, ps.hit_batters, ps.wins, ps.quality_starts, ps.saves,
  -- for fip calculation (done in pitching leaderboard)
  ps.home_runs_allowed, ps.walks,
  lpc.fip_constant
FROM player_stats ps
JOIN players p      ON ps.player_id = p.id
JOIN teams t        ON p.team_id = t.id
JOIN leagues l      ON t.league_id = l.id
JOIN mv_games_played gp ON gp.league_type = l.league_type
LEFT JOIN mv_league_pitching_context lpc ON lpc.league_id =
  CASE WHEN l.league_type = 'Greater' THEN '__greater__' ELSE l.id END;

CREATE UNIQUE INDEX ON mv_enriched_stats (player_id);