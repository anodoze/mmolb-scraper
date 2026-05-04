CREATE MATERIALIZED VIEW mv_pitching_leaderboard AS
WITH fip_computed AS (
  SELECT *,
    ((13.0 * home_runs_allowed + 3.0 * walks - 2.0 * strikeouts) / NULLIF(innings_pitched, 0) + fip_constant) AS fip
  FROM mv_enriched_stats
  WHERE innings_pitched >= ip_threshold
),
rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY fip  ASC NULLS LAST) AS rn_fip,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY era  ASC  NULLS LAST) AS rn_era,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY whip ASC  NULLS LAST) AS rn_whip,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY k9   DESC NULLS LAST) AS rn_k9,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY bb9  ASC  NULLS LAST) AS rn_bb9,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY h9   ASC  NULLS LAST) AS rn_h9,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hr9  ASC  NULLS LAST) AS rn_hr9
  FROM fip_computed
),
count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY innings_pitched DESC NULLS LAST) AS rn_ip,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY strikeouts      DESC NULLS LAST) AS rn_k,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY hit_batters     DESC NULLS LAST) AS rn_hbp,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY quality_starts  DESC NULLS LAST) AS rn_qs,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY wins            DESC NULLS LAST) AS rn_wins,
    ROW_NUMBER() OVER (PARTITION BY league_id ORDER BY saves           DESC NULLS LAST) AS rn_saves
  FROM mv_enriched_stats
),
combined_rate_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY fip  ASC NULLS LAST) AS rn_fip,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY era  ASC  NULLS LAST) AS rn_era,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY whip ASC  NULLS LAST) AS rn_whip,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY k9   DESC NULLS LAST) AS rn_k9,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY bb9  ASC  NULLS LAST) AS rn_bb9,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY h9   ASC  NULLS LAST) AS rn_h9,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hr9  ASC  NULLS LAST) AS rn_hr9
  FROM fip_computed
),
combined_count_ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY innings_pitched DESC NULLS LAST) AS rn_ip,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY strikeouts      DESC NULLS LAST) AS rn_k,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY hit_batters     DESC NULLS LAST) AS rn_hbp,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY quality_starts  DESC NULLS LAST) AS rn_qs,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY wins            DESC NULLS LAST) AS rn_wins,
    ROW_NUMBER() OVER (PARTITION BY league_type ORDER BY saves           DESC NULLS LAST) AS rn_saves
  FROM mv_enriched_stats
)

SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       era AS stat_value,  'Earned Run Average (ERA)' AS stat_key, rn_era AS rank_in_league FROM rate_ranked WHERE rn_era  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       fip,  'Fielding Independent Pitching (FIP)',        rn_fip  FROM rate_ranked WHERE rn_fip  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       whip, 'Walks and Hits per Inning Pitched (WHIP)',   rn_whip FROM rate_ranked WHERE rn_whip <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       k9,   'Strikeouts per 9 Innings (K/9)',             rn_k9   FROM rate_ranked WHERE rn_k9   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       bb9,  'Walks per 9 Innings (BB/9)',                 rn_bb9  FROM rate_ranked WHERE rn_bb9  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       h9,   'Hits per 9 Innings (H/9)',                   rn_h9   FROM rate_ranked WHERE rn_h9   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       hr9,  'Homeruns per 9 Innings (HR/9)',              rn_hr9  FROM rate_ranked WHERE rn_hr9  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       innings_pitched, 'Innings Pitched (IP)',            rn_ip   FROM count_ranked WHERE rn_ip   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       strikeouts,      'Strikeouts',                      rn_k    FROM count_ranked WHERE rn_k    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       hit_batters,     'Hit Batters',                     rn_hbp  FROM count_ranked WHERE rn_hbp  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       quality_starts,  'Quality Starts',                  rn_qs   FROM count_ranked WHERE rn_qs   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       wins,            'Wins',                            rn_wins FROM count_ranked WHERE rn_wins  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       league_id, league_name, league_type, innings_pitched, ip_threshold,
       saves, 'Saves', rn_saves FROM count_ranked WHERE rn_saves <= 10
-- combined rate
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       era,  'Earned Run Average (ERA)',                   rn_era  FROM combined_rate_ranked WHERE rn_era  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       fip,  'Fielding Independent Pitching (FIP)',        rn_fip  FROM combined_rate_ranked WHERE rn_fip  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       whip, 'Walks and Hits per Inning Pitched (WHIP)',   rn_whip FROM combined_rate_ranked WHERE rn_whip <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       k9,   'Strikeouts per 9 Innings (K/9)',             rn_k9   FROM combined_rate_ranked WHERE rn_k9   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       bb9,  'Walks per 9 Innings (BB/9)',                 rn_bb9  FROM combined_rate_ranked WHERE rn_bb9  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       h9,   'Hits per 9 Innings (H/9)',                   rn_h9   FROM combined_rate_ranked WHERE rn_h9   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       hr9,  'Homeruns per 9 Innings (HR/9)',              rn_hr9  FROM combined_rate_ranked WHERE rn_hr9  <= 10
-- combined count
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       innings_pitched, 'Innings Pitched (IP)',            rn_ip   FROM combined_count_ranked WHERE rn_ip   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       strikeouts,      'Strikeouts',                      rn_k    FROM combined_count_ranked WHERE rn_k    <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       hit_batters,     'Hit Batters',                     rn_hbp  FROM combined_count_ranked WHERE rn_hbp  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       quality_starts,  'Quality Starts',                  rn_qs   FROM combined_count_ranked WHERE rn_qs   <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       wins,            'Wins',                            rn_wins FROM combined_count_ranked WHERE rn_wins  <= 10
UNION ALL SELECT player_id, first_name, last_name, suffix, position, team_name, team_location, team_id, team_emoji,
       CASE WHEN league_type = 'Lesser' THEN '__lesser__' ELSE '__greater__' END,
       CASE WHEN league_type = 'Lesser' THEN 'All Lesser' ELSE 'All Greater' END,
       league_type, innings_pitched, ip_threshold,
       saves, 'Saves', rn_saves FROM combined_count_ranked WHERE rn_saves <= 10;

CREATE UNIQUE INDEX ON mv_pitching_leaderboard (player_id, stat_key, league_id);