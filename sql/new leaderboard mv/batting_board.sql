CREATE MATERIALIZED VIEW mv_batting_leaderboard AS
WITH rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id   ORDER BY ba    DESC NULLS LAST) AS rn_ba,
    ROW_NUMBER() OVER (PARTITION BY league_id   ORDER BY obp   DESC NULLS LAST) AS rn_obp,
    ROW_NUMBER() OVER (PARTITION BY league_id   ORDER BY slg   DESC NULLS LAST) AS rn_slg,
    ROW_NUMBER() OVER (PARTITION BY league_id   ORDER BY ops   DESC NULLS LAST) AS rn_ops,
    ROW_NUMBER() OVER (PARTITION BY league_id   ORDER BY babip DESC NULLS LAST) AS rn_babip
  FROM mv_enriched_stats
  WHERE plate_appearances >= pa_threshold
),
count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hits          DESC NULLS LAST) AS rn_hits,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY singles       DESC NULLS LAST) AS rn_singles,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY doubles       DESC NULLS LAST) AS rn_doubles,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY triples       DESC NULLS LAST) AS rn_triples,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY home_runs     DESC NULLS LAST) AS rn_hr,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY walked        DESC NULLS LAST) AS rn_walks,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hit_by_pitch  DESC NULLS LAST) AS rn_hbp,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY stolen_bases  DESC NULLS LAST) AS rn_sb,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY caught_stealing DESC NULLS LAST) AS rn_cs,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY struck_out    DESC NULLS LAST) AS rn_k,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY runs          DESC NULLS LAST) AS rn_runs,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY runs_batted_in DESC NULLS LAST) AS rn_rbi
  FROM mv_enriched_stats
),
combined_rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY ba    DESC NULLS LAST) AS rn_ba,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY obp   DESC NULLS LAST) AS rn_obp,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY slg   DESC NULLS LAST) AS rn_slg,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY ops   DESC NULLS LAST) AS rn_ops,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY babip DESC NULLS LAST) AS rn_babip
  FROM mv_enriched_stats
  WHERE plate_appearances >= pa_threshold
),
combined_count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hits          DESC NULLS LAST) AS rn_hits,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY singles       DESC NULLS LAST) AS rn_singles,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY doubles       DESC NULLS LAST) AS rn_doubles,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY triples       DESC NULLS LAST) AS rn_triples,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY home_runs     DESC NULLS LAST) AS rn_hr,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY walked        DESC NULLS LAST) AS rn_walks,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hit_by_pitch  DESC NULLS LAST) AS rn_hbp,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY stolen_bases  DESC NULLS LAST) AS rn_sb,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY caught_stealing DESC NULLS LAST) AS rn_cs,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY struck_out    DESC NULLS LAST) AS rn_k,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY runs          DESC NULLS LAST) AS rn_runs,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY runs_batted_in DESC NULLS LAST) AS rn_rbi
  FROM mv_enriched_stats
)

-- helper macro to avoid repeating the SELECT column list
-- per-league rate stats
SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       ba AS stat_value,    'Batting Average (BA)' AS stat_key, rn_ba AS rank_in_league FROM rate_ranked WHERE rn_ba    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       obp,   'On Base Percentage (OBP)',                rn_obp   FROM rate_ranked WHERE rn_obp   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       slg,   'Slugging Percentage (SLG)',               rn_slg   FROM rate_ranked WHERE rn_slg   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       ops,   'On Base Plus Slugging (OPS)',             rn_ops   FROM rate_ranked WHERE rn_ops   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       babip, 'Batting Average on Balls in Play (BABIP)', rn_babip FROM rate_ranked WHERE rn_babip <= 10
-- per-league count stats
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       hits,           'Hits',             rn_hits   FROM count_ranked WHERE rn_hits   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       singles,        'Singles',          rn_singles FROM count_ranked WHERE rn_singles <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       doubles,        'Doubles',          rn_doubles FROM count_ranked WHERE rn_doubles <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       triples,        'Triples',          rn_triples FROM count_ranked WHERE rn_triples <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       home_runs,      'Home Runs',        rn_hr      FROM count_ranked WHERE rn_hr      <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       walked,         'Walks (BB)',        rn_walks   FROM count_ranked WHERE rn_walks   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       hit_by_pitch,   'Hit By Pitch (HBP)', rn_hbp   FROM count_ranked WHERE rn_hbp    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       stolen_bases,   'Stolen Bases',     rn_sb      FROM count_ranked WHERE rn_sb      <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       caught_stealing,'Caught Stealing',  rn_cs      FROM count_ranked WHERE rn_cs      <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       struck_out,     'Struck Out',       rn_k       FROM count_ranked WHERE rn_k       <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       runs,           'Runs',             rn_runs    FROM count_ranked WHERE rn_runs    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, plate_appearances, pa_threshold,
       runs_batted_in, 'Runs Batted In (RBI)', rn_rbi FROM count_ranked WHERE rn_rbi    <= 10
-- combined rate stats
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       ba,    'Batting Average (BA)',                    rn_ba    FROM combined_rate_ranked WHERE rn_ba    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       obp,   'On Base Percentage (OBP)',                rn_obp   FROM combined_rate_ranked WHERE rn_obp   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       slg,   'Slugging Percentage (SLG)',               rn_slg   FROM combined_rate_ranked WHERE rn_slg   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       ops,   'On Base Plus Slugging (OPS)',             rn_ops   FROM combined_rate_ranked WHERE rn_ops   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       babip, 'Batting Average on Balls in Play (BABIP)', rn_babip FROM combined_rate_ranked WHERE rn_babip <= 10
-- combined count stats
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       hits,           'Hits',             rn_hits   FROM combined_count_ranked WHERE rn_hits   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       singles,        'Singles',          rn_singles FROM combined_count_ranked WHERE rn_singles <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       doubles,        'Doubles',          rn_doubles FROM combined_count_ranked WHERE rn_doubles <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       triples,        'Triples',          rn_triples FROM combined_count_ranked WHERE rn_triples <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       home_runs,      'Home Runs',        rn_hr      FROM combined_count_ranked WHERE rn_hr      <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       walked,         'Walks',            rn_walks   FROM combined_count_ranked WHERE rn_walks   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       hit_by_pitch,   'Hit By Pitch (HBP)', rn_hbp   FROM combined_count_ranked WHERE rn_hbp    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       stolen_bases,   'Stolen Bases',     rn_sb      FROM combined_count_ranked WHERE rn_sb      <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       caught_stealing,'Caught Stealing',  rn_cs      FROM combined_count_ranked WHERE rn_cs      <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       struck_out,     'Struck Out',       rn_k       FROM combined_count_ranked WHERE rn_k       <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       runs,           'Runs',             rn_runs    FROM combined_count_ranked WHERE rn_runs    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, plate_appearances, pa_threshold,
       runs_batted_in, 'Runs Batted In (RBI)', rn_rbi FROM combined_count_ranked WHERE rn_rbi    <= 10;

CREATE UNIQUE INDEX ON mv_batting_leaderboard (player_id, stat_key, league_id);