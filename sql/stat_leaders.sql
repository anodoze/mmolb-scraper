-- ============================================================
-- HELPER: games played proxy, capped at 120, per league type
-- ============================================================
CREATE MATERIALIZED VIEW mv_games_played AS
SELECT
  l.league_type,
  LEAST(MAX(t.wins + t.losses), 120) AS games_played
FROM teams t
JOIN leagues l ON t.league_id = l.id
GROUP BY l.league_type;

CREATE UNIQUE INDEX ON mv_games_played (league_type);

-- ============================================================
-- HELPER: league pitching context
-- one row per Lesser subleague + one '__lesser__' rollup row
-- one '__greater__' unified row for both Greater leagues
-- ============================================================
CREATE MATERIALIZED VIEW mv_league_pitching_context AS
WITH qualified AS (
  SELECT
    ps.earned_runs, ps.innings_pitched,
    ps.hits_allowed, ps.home_runs_allowed,
    ps.walks, ps.strikeouts,
    ps.era, ps.whip, ps.k9, ps.bb9, ps.h9, ps.hr9,
    l.id AS league_id, l.name AS league_name, l.league_type
  FROM player_stats ps
  JOIN players p  ON ps.player_id = p.id
  JOIN teams t    ON p.team_id = t.id
  JOIN leagues l  ON t.league_id = l.id
  JOIN mv_games_played gp ON gp.league_type = l.league_type
  WHERE ps.innings_pitched >= gp.games_played * 1.0
    AND ps.innings_pitched > 0
),

agg AS (
  SELECT
    league_id, league_name, league_type,
    COUNT(*)                AS qualified_pitchers,
    SUM(earned_runs)        AS sum_er,
    SUM(innings_pitched)    AS sum_ip,
    SUM(hits_allowed)       AS sum_h,
    SUM(home_runs_allowed)  AS sum_hr,
    SUM(walks)              AS sum_bb,
    SUM(strikeouts)         AS sum_k
  FROM qualified
  GROUP BY league_type, league_id, league_name
),

with_rates AS (
  SELECT
    league_id, league_name, league_type, qualified_pitchers,
    sum_er, sum_ip, sum_h, sum_hr, sum_bb, sum_k,
    sum_er * 9.0  / NULLIF(sum_ip, 0)              AS avg_era,
    (sum_h + sum_bb)::float / NULLIF(sum_ip, 0)    AS avg_whip,
    sum_k  * 9.0  / NULLIF(sum_ip, 0)              AS avg_k9,
    sum_bb * 9.0  / NULLIF(sum_ip, 0)              AS avg_bb9,
    sum_h  * 9.0  / NULLIF(sum_ip, 0)              AS avg_h9,
    sum_hr * 9.0  / NULLIF(sum_ip, 0)              AS avg_hr9,
    -- FIP constant = lgERA - (13*HR + 3*BB - 2*K) / IP
    sum_er * 9.0  / NULLIF(sum_ip, 0)
      - (13.0 * sum_hr + 3.0 * sum_bb - 2.0 * sum_k)
        / NULLIF(sum_ip, 0)                         AS fip_constant
  FROM agg
),

lesser_subleagues AS (
  SELECT * FROM with_rates WHERE league_type = 'Lesser'
),

lesser_rollup AS (
  SELECT
    '__lesser__'::text  AS league_id,
    'All Lesser'::text  AS league_name,
    'Lesser'::text      AS league_type,
    SUM(qualified_pitchers) AS qualified_pitchers,
    SUM(sum_er)         AS sum_er,
    SUM(sum_ip)         AS sum_ip,
    SUM(sum_h)          AS sum_h,
    SUM(sum_hr)         AS sum_hr,
    SUM(sum_bb)         AS sum_bb,
    SUM(sum_k)          AS sum_k,
    SUM(sum_er) * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_era,
    (SUM(sum_h) + SUM(sum_bb))::float / NULLIF(SUM(sum_ip), 0) AS avg_whip,
    SUM(sum_k)  * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_k9,
    SUM(sum_bb) * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_bb9,
    SUM(sum_h)  * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_h9,
    SUM(sum_hr) * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_hr9,
    SUM(sum_er) * 9.0  / NULLIF(SUM(sum_ip), 0)
      - (13.0 * SUM(sum_hr) + 3.0 * SUM(sum_bb) - 2.0 * SUM(sum_k))
        / NULLIF(SUM(sum_ip), 0)                            AS fip_constant
  FROM with_rates WHERE league_type = 'Lesser'
),

greater_unified AS (
  SELECT
    '__greater__'::text AS league_id,
    'All Greater'::text AS league_name,
    'Greater'::text     AS league_type,
    SUM(qualified_pitchers) AS qualified_pitchers,
    SUM(sum_er)         AS sum_er,
    SUM(sum_ip)         AS sum_ip,
    SUM(sum_h)          AS sum_h,
    SUM(sum_hr)         AS sum_hr,
    SUM(sum_bb)         AS sum_bb,
    SUM(sum_k)          AS sum_k,
    SUM(sum_er) * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_era,
    (SUM(sum_h) + SUM(sum_bb))::float / NULLIF(SUM(sum_ip), 0) AS avg_whip,
    SUM(sum_k)  * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_k9,
    SUM(sum_bb) * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_bb9,
    SUM(sum_h)  * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_h9,
    SUM(sum_hr) * 9.0  / NULLIF(SUM(sum_ip), 0)            AS avg_hr9,
    SUM(sum_er) * 9.0  / NULLIF(SUM(sum_ip), 0)
      - (13.0 * SUM(sum_hr) + 3.0 * SUM(sum_bb) - 2.0 * SUM(sum_k))
        / NULLIF(SUM(sum_ip), 0)                            AS fip_constant
  FROM with_rates WHERE league_type = 'Greater'
)

SELECT * FROM lesser_subleagues
UNION ALL SELECT * FROM lesser_rollup
UNION ALL SELECT * FROM greater_unified;

CREATE UNIQUE INDEX ON mv_league_pitching_context (league_id);

-- ============================================================
-- HELPER: league batting context
-- one row per Lesser subleague + one '__lesser__' rollup row
-- one '__greater__' unified row
-- ============================================================
CREATE MATERIALIZED VIEW mv_league_batting_context AS
WITH qualified AS (
  SELECT
    ps.ba, ps.obp, ps.slg, ps.ops, ps.babip,
    ps.plate_appearances,
    ps.hits, ps.at_bats, ps.walked, ps.hit_by_pitch, ps.sac_flies,
    ps.singles, ps.doubles, ps.triples, ps.home_runs,
    ps.struck_out,
    l.id AS league_id, l.name AS league_name, l.league_type
  FROM player_stats ps
  JOIN players p  ON ps.player_id = p.id
  JOIN teams t    ON p.team_id = t.id
  JOIN leagues l  ON t.league_id = l.id
  JOIN mv_games_played gp ON gp.league_type = l.league_type
  WHERE ps.plate_appearances >= gp.games_played * 3.1
),

agg AS (
  SELECT
    league_id, league_name, league_type,
    COUNT(*)              AS qualified_batters,
    SUM(hits)             AS sum_h,
    SUM(at_bats)          AS sum_ab,
    SUM(walked)           AS sum_bb,
    SUM(hit_by_pitch)     AS sum_hbp,
    SUM(sac_flies)        AS sum_sf,
    SUM(singles)          AS sum_1b,
    SUM(doubles)          AS sum_2b,
    SUM(triples)          AS sum_3b,
    SUM(home_runs)        AS sum_hr,
    SUM(struck_out)       AS sum_k
  FROM qualified
  GROUP BY league_type, league_id, league_name
),

with_rates AS (
  SELECT
    league_id, league_name, league_type, qualified_batters,
    sum_h, sum_ab, sum_bb, sum_hbp, sum_sf,
    sum_1b, sum_2b, sum_3b, sum_hr, sum_k,
    sum_h::float / NULLIF(sum_ab, 0)
      AS avg_ba,
    (sum_h + sum_bb + sum_hbp)::float
      / NULLIF(sum_ab + sum_bb + sum_hbp + sum_sf, 0)
      AS avg_obp,
    (sum_1b + 2.0*sum_2b + 3.0*sum_3b + 4.0*sum_hr)
      / NULLIF(sum_ab, 0)
      AS avg_slg,
    (sum_h - sum_hr)::float
      / NULLIF(sum_ab - sum_k - sum_hr + sum_sf, 0)
      AS avg_babip
  FROM agg
),

final AS (
  SELECT *, avg_obp + avg_slg AS avg_ops FROM with_rates
)

SELECT * FROM final WHERE league_type = 'Lesser'
UNION ALL
SELECT
  '__lesser__', 'All Lesser', 'Lesser',
  SUM(qualified_batters),
  SUM(sum_h), SUM(sum_ab), SUM(sum_bb), SUM(sum_hbp), SUM(sum_sf),
  SUM(sum_1b), SUM(sum_2b), SUM(sum_3b), SUM(sum_hr), SUM(sum_k),
  SUM(sum_h)::float / NULLIF(SUM(sum_ab), 0),
  (SUM(sum_h) + SUM(sum_bb) + SUM(sum_hbp))::float
    / NULLIF(SUM(sum_ab) + SUM(sum_bb) + SUM(sum_hbp) + SUM(sum_sf), 0),
  (SUM(sum_1b) + 2.0*SUM(sum_2b) + 3.0*SUM(sum_3b) + 4.0*SUM(sum_hr))
    / NULLIF(SUM(sum_ab), 0),
  (SUM(sum_h) - SUM(sum_hr))::float
    / NULLIF(SUM(sum_ab) - SUM(sum_k) - SUM(sum_hr) + SUM(sum_sf), 0),
  -- ops
  (SUM(sum_h) + SUM(sum_bb) + SUM(sum_hbp))::float
    / NULLIF(SUM(sum_ab) + SUM(sum_bb) + SUM(sum_hbp) + SUM(sum_sf), 0)
  + (SUM(sum_1b) + 2.0*SUM(sum_2b) + 3.0*SUM(sum_3b) + 4.0*SUM(sum_hr))
    / NULLIF(SUM(sum_ab), 0)
FROM final WHERE league_type = 'Lesser'
UNION ALL
SELECT
  '__greater__', 'All Greater', 'Greater',
  SUM(qualified_batters),
  SUM(sum_h), SUM(sum_ab), SUM(sum_bb), SUM(sum_hbp), SUM(sum_sf),
  SUM(sum_1b), SUM(sum_2b), SUM(sum_3b), SUM(sum_hr), SUM(sum_k),
  SUM(sum_h)::float / NULLIF(SUM(sum_ab), 0),
  (SUM(sum_h) + SUM(sum_bb) + SUM(sum_hbp))::float
    / NULLIF(SUM(sum_ab) + SUM(sum_bb) + SUM(sum_hbp) + SUM(sum_sf), 0),
  (SUM(sum_1b) + 2.0*SUM(sum_2b) + 3.0*SUM(sum_3b) + 4.0*SUM(sum_hr))
    / NULLIF(SUM(sum_ab), 0),
  (SUM(sum_h) - SUM(sum_hr))::float
    / NULLIF(SUM(sum_ab) - SUM(sum_k) - SUM(sum_hr) + SUM(sum_sf), 0),
  (SUM(sum_h) + SUM(sum_bb) + SUM(sum_hbp))::float
    / NULLIF(SUM(sum_ab) + SUM(sum_bb) + SUM(sum_hbp) + SUM(sum_sf), 0)
  + (SUM(sum_1b) + 2.0*SUM(sum_2b) + 3.0*SUM(sum_3b) + 4.0*SUM(sum_hr))
    / NULLIF(SUM(sum_ab), 0)
FROM final WHERE league_type = 'Greater';

CREATE UNIQUE INDEX ON mv_league_batting_context (league_id);

-- ============================================================
-- MAIN: batting leaderboard
-- ============================================================
CREATE MATERIALIZED VIEW mv_batting_leaderboard AS
WITH enriched AS (
  SELECT
    ps.player_id,
    p.first_name, p.last_name, p.position, p.suffix,
    t.name AS team_name, t.id AS team_id,
    t.location AS team_location,
    t.emoji AS team_emoji,
    l.id AS league_id, l.name AS league_name, l.league_type,
    gp.games_played * 3.1                              AS pa_threshold,
    ps.plate_appearances,
    ps.ba, ps.obp, ps.slg, ps.ops, ps.babip,
    ps.hits, ps.singles, ps.doubles, ps.triples,
    ps.home_runs, ps.walked, ps.hit_by_pitch,
    ps.stolen_bases, ps.caught_stealing, ps.struck_out
  FROM player_stats ps
  JOIN players p      ON ps.player_id = p.id
  JOIN teams t        ON p.team_id = t.id
  JOIN leagues l      ON t.league_id = l.id
  JOIN mv_games_played gp ON gp.league_type = l.league_type
),

rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY ba    DESC NULLS LAST) AS rn_ba,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY obp   DESC NULLS LAST) AS rn_obp,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY slg   DESC NULLS LAST) AS rn_slg,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY ops   DESC NULLS LAST) AS rn_ops,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY babip DESC NULLS LAST) AS rn_babip
  FROM enriched
  WHERE plate_appearances >= pa_threshold
),

count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hits           DESC NULLS LAST) AS rn_hits,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY singles        DESC NULLS LAST) AS rn_singles,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY doubles        DESC NULLS LAST) AS rn_doubles,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY triples        DESC NULLS LAST) AS rn_triples,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY home_runs      DESC NULLS LAST) AS rn_hr,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY walked         DESC NULLS LAST) AS rn_walks,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hit_by_pitch   DESC NULLS LAST) AS rn_hbp,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY stolen_bases   DESC NULLS LAST) AS rn_sb,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY caught_stealing DESC NULLS LAST) AS rn_cs,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY struck_out     DESC NULLS LAST) AS rn_k
  FROM enriched
),

-- add these two CTEs after count_ranked in mv_batting_leaderboard

combined_rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY ba    DESC NULLS LAST) AS rn_ba,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY obp   DESC NULLS LAST) AS rn_obp,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY slg   DESC NULLS LAST) AS rn_slg,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY ops   DESC NULLS LAST) AS rn_ops,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY babip DESC NULLS LAST) AS rn_babip
  FROM enriched
  WHERE plate_appearances >= pa_threshold
),

combined_count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hits            DESC NULLS LAST) AS rn_hits,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY singles         DESC NULLS LAST) AS rn_singles,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY doubles         DESC NULLS LAST) AS rn_doubles,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY triples         DESC NULLS LAST) AS rn_triples,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY home_runs       DESC NULLS LAST) AS rn_hr,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY walked          DESC NULLS LAST) AS rn_walks,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hit_by_pitch    DESC NULLS LAST) AS rn_hbp,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY stolen_bases    DESC NULLS LAST) AS rn_sb,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY caught_stealing DESC NULLS LAST) AS rn_cs,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY struck_out      DESC NULLS LAST) AS rn_k
  FROM enriched
)

SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       ba AS stat_value, 'Batting Average (BA)' AS stat_key, rn_ba AS rank_in_league FROM rate_ranked WHERE rn_ba <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       obp, 'On Base Percentage (OBP)', rn_obp FROM rate_ranked WHERE rn_obp <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       slg, 'Slugging Percentage (SLG)', rn_slg FROM rate_ranked WHERE rn_slg <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       ops, 'On Base Plus Slugging (OPS)', rn_ops FROM rate_ranked WHERE rn_ops <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       babip, 'Batting Average on Balls in Play (BABIP)', rn_babip FROM rate_ranked WHERE rn_babip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       hits, 'Hits', rn_hits FROM count_ranked WHERE rn_hits <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       singles, 'Singles', rn_singles FROM count_ranked WHERE rn_singles <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       doubles, 'Doubles', rn_doubles FROM count_ranked WHERE rn_doubles <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       triples, 'Triples', rn_triples FROM count_ranked WHERE rn_triples <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       home_runs, 'Home Runs', rn_hr FROM count_ranked WHERE rn_hr <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       walked, 'Walks (BB)', rn_walks FROM count_ranked WHERE rn_walks <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       hit_by_pitch, 'Hit By Pitch (HBP)', rn_hbp FROM count_ranked WHERE rn_hbp <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       stolen_bases, 'Stolen Bases', rn_sb FROM count_ranked WHERE rn_sb <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       caught_stealing,'Caught Stealing', rn_cs FROM count_ranked WHERE rn_cs <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       struck_out, 'Struck Out', rn_k FROM count_ranked WHERE rn_k <= 10
UNION ALL --greater and lesser leaderboards
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       ba, 'Batting Average (BA)', rn_ba FROM combined_rate_ranked WHERE rn_ba <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       obp, 'On Base Percentage (OBP)', rn_obp FROM combined_rate_ranked WHERE rn_obp <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       slg, 'Slugging Percentage (SLG)', rn_slg FROM combined_rate_ranked WHERE rn_slg <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       ops, 'On Base Plus Slugging (OPS)', rn_ops FROM combined_rate_ranked WHERE rn_ops <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       babip, 'Batting Average on Balls in Play (BABIP)', rn_babip FROM combined_rate_ranked WHERE rn_babip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       hits, 'Hits', rn_hits FROM combined_count_ranked WHERE rn_hits <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       singles, 'Singles', rn_singles FROM combined_count_ranked WHERE rn_singles <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       doubles, 'Doubles', rn_doubles FROM combined_count_ranked WHERE rn_doubles <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       triples, 'Triples', rn_triples FROM combined_count_ranked WHERE rn_triples <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       home_runs, 'Home Runs', rn_hr FROM combined_count_ranked WHERE rn_hr <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       walked, 'Walks', rn_walks FROM combined_count_ranked WHERE rn_walks <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       hit_by_pitch, 'Hit By Pitch (HBP)', rn_hbp FROM combined_count_ranked WHERE rn_hbp <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       stolen_bases, 'Stolen Bases', rn_sb FROM combined_count_ranked WHERE rn_sb <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       caught_stealing, 'Caught Stealing', rn_cs FROM combined_count_ranked WHERE rn_cs <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       struck_out, 'Struck Out', rn_k FROM combined_count_ranked WHERE rn_k <= 10;

CREATE UNIQUE INDEX ON mv_batting_leaderboard (player_id, stat_key, league_id);

-- ============================================================
-- MAIN: pitching leaderboard
-- ============================================================
CREATE MATERIALIZED VIEW mv_pitching_leaderboard AS
WITH enriched AS (
  SELECT
    ps.player_id,
    p.first_name, p.last_name, p.position, p.suffix,
    t.name AS team_name, 
    t.id AS team_id,
    t.location AS team_location,
    t.emoji AS team_emoji,
    l.id AS league_id, 
    l.name AS league_name, 
    l.league_type,
    gp.games_played * 1.0 AS ip_threshold,
    ps.innings_pitched,
    ps.era, ps.whip, ps.k9, ps.bb9, ps.h9, ps.hr9,
    ps.strikeouts, ps.hit_batters,
    (13.0 * ps.home_runs_allowed + 3.0 * ps.walks - 2.0 * ps.strikeouts)
      / NULLIF(ps.innings_pitched, 0)
      + lpc.fip_constant AS fip
  FROM player_stats ps
  JOIN players p      ON ps.player_id = p.id
  JOIN teams t        ON p.team_id = t.id
  JOIN leagues l      ON t.league_id = l.id
  JOIN mv_games_played gp ON gp.league_type = l.league_type
  JOIN mv_league_pitching_context lpc
    ON lpc.league_id = CASE
      WHEN l.league_type = 'Greater' THEN '__greater__'
      ELSE l.id
    END
),

rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY era  ASC  NULLS LAST) AS rn_era,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY fip  ASC  NULLS LAST) AS rn_fip,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY whip ASC  NULLS LAST) AS rn_whip,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY k9   DESC NULLS LAST) AS rn_k9,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY bb9  ASC  NULLS LAST) AS rn_bb9,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY h9   ASC  NULLS LAST) AS rn_h9,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hr9  ASC  NULLS LAST) AS rn_hr9
  FROM enriched
  WHERE innings_pitched >= ip_threshold
),

count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY innings_pitched DESC NULLS LAST) AS rn_ip,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY strikeouts      DESC NULLS LAST) AS rn_k,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hit_batters     DESC NULLS LAST) AS rn_hbp
  FROM enriched
),

-- add these two CTEs after count_ranked in mv_pitching_leaderboard

combined_rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY era  ASC  NULLS LAST) AS rn_era,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY fip  ASC  NULLS LAST) AS rn_fip,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY whip ASC  NULLS LAST) AS rn_whip,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY k9   DESC NULLS LAST) AS rn_k9,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY bb9  ASC  NULLS LAST) AS rn_bb9,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY h9   ASC  NULLS LAST) AS rn_h9,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hr9  ASC  NULLS LAST) AS rn_hr9
  FROM enriched
  WHERE innings_pitched >= ip_threshold
),

combined_count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY innings_pitched DESC NULLS LAST) AS rn_ip,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY strikeouts      DESC NULLS LAST) AS rn_k,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hit_batters     DESC NULLS LAST) AS rn_hbp
  FROM enriched
)

SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       era AS stat_value, 'Earned Run Average (ERA)' AS stat_key, rn_era  AS rank_in_league FROM rate_ranked WHERE rn_era <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       fip, 'Fielding Independent Pitching (FIP)', rn_fip FROM rate_ranked WHERE rn_fip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       whip, 'Walks and Hits per Inning Pitched (WHIP)', rn_whip FROM rate_ranked WHERE rn_whip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       k9, 'Strikeouts per 9 Innings (K/9)', rn_k9 FROM rate_ranked WHERE rn_k9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       bb9, 'Walks per 9 Innings (BB/9)', rn_bb9 FROM rate_ranked WHERE rn_bb9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       h9, 'Hits per 9 Innings (H/9)', rn_h9 FROM rate_ranked WHERE rn_h9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       hr9, 'Homeruns per 9 Innings (HR/9)', rn_hr9 FROM rate_ranked WHERE rn_hr9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       innings_pitched, 'Innings Pitched (IP)', rn_ip FROM count_ranked WHERE rn_ip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       strikeouts, 'Strikeouts', rn_k FROM count_ranked WHERE rn_k  <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       hit_batters, 'Hit Batters', rn_hbp FROM count_ranked WHERE rn_hbp <= 10
UNION ALL -- lesser and greater leagues
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       era, 'Earned Run Average (ERA)', rn_era FROM combined_rate_ranked WHERE rn_era <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       fip, 'Fielding Independent Pitching (FIP)', rn_fip FROM combined_rate_ranked WHERE rn_fip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       whip, 'Walks and Hits per Inning Pitched (WHIP)', rn_whip FROM combined_rate_ranked WHERE rn_whip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       k9, 'Strikeouts per 9 Innings (K/9)', rn_k9 FROM combined_rate_ranked WHERE rn_k9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       bb9, 'Walks per 9 Innings (BB/9)', rn_bb9 FROM combined_rate_ranked WHERE rn_bb9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       h9, 'Hits per 9 Innings (H/9)', rn_h9 FROM combined_rate_ranked WHERE rn_h9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       hr9, 'Homeruns per 9 Innings (HR/9)', rn_hr9 FROM combined_rate_ranked WHERE rn_hr9 <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       innings_pitched, 'Innings Pitched (IP)', rn_ip FROM combined_count_ranked WHERE rn_ip <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       strikeouts, 'Strikeouts', rn_k FROM combined_count_ranked WHERE rn_k <= 10
UNION ALL
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       hit_batters, 'Hit Batters', rn_hbp FROM combined_count_ranked WHERE rn_hbp <= 10;

CREATE UNIQUE INDEX ON mv_pitching_leaderboard (player_id, stat_key, league_id);

-- ============================================================
-- REFRESH ORDER (run at end of each scrape)
-- ============================================================
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_games_played;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_league_pitching_context;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_league_batting_context;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_batting_leaderboard;
-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_pitching_leaderboard;


-- =============================================================
-- DROP ALL VIEWS - run to delete all mvs to make changes
-- =============================================================
-- DROP MATERIALIZED VIEW IF EXISTS mv_batting_leaderboard;
-- DROP MATERIALIZED VIEW IF EXISTS mv_pitching_leaderboard;
-- DROP MATERIALIZED VIEW IF EXISTS mv_league_pitching_context;
-- DROP MATERIALIZED VIEW IF EXISTS mv_league_batting_context;
-- DROP MATERIALIZED VIEW IF EXISTS mv_games_played;