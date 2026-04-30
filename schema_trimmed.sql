CREATE TABLE public.leagues (
    id text NOT NULL,
    name text NOT NULL,
    color text,
    emoji text,
    league_type text
);

CREATE TABLE public.player_attributes (
    player_id text NOT NULL,
    discipline double precision,
    vision double precision,
    intimidation double precision,
    muscle double precision,
    contact double precision,
    cunning double precision,
    selflessness double precision,
    determination double precision,
    wisdom double precision,
    insight double precision,
    aiming double precision,
    lift double precision,
    control double precision,
    velocity double precision,
    rotation double precision,
    stuff double precision,
    deception double precision,
    intuition double precision,
    persuasion double precision,
    presence double precision,
    defiance double precision,
    accuracy double precision,
    stamina double precision,
    guts double precision,
    performance double precision,
    speed double precision,
    greed double precision,
    stealth double precision,
    arm double precision,
    dexterity double precision,
    reaction double precision,
    acrobatics double precision,
    agility double precision,
    patience double precision,
    awareness double precision,
    composure double precision,
    luck double precision
);

CREATE TABLE public.players (
    id text NOT NULL,
    team_id text,
    first_name text,
    last_name text,
    suffix text,
    number integer,
    "position" text,
    position_type text,
    level integer,
    last_updated timestamp with time zone,
    slot text
);


CREATE TABLE public.teams (
    id text NOT NULL,
    league_id text,
    name text NOT NULL,
    location text,
    emoji text,
    color text,
    wins integer,
    losses integer,
    rundiff integer,
    last_updated timestamp with time zone
);

CREATE MATERIALIZED VIEW public.mv_attribute_leaderboard AS
 WITH unpivoted AS (
         SELECT pa.player_id,
            p.first_name,
            p.last_name,
            p.suffix,
            p."position",
            t.name AS team_name,
            t.location AS team_location,
            t.id AS team_id,
            t.emoji AS team_emoji,
            a.attr_name,
            a.attr_value
           FROM (((public.player_attributes pa
             JOIN public.players p ON ((pa.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             CROSS JOIN LATERAL ( VALUES ('Discipline'::text,pa.discipline), ('Vision'::text,pa.vision), ('Intimidation'::text,pa.intimidation), ('Muscle'::text,pa.muscle), ('Contact'::text,pa.contact), ('Cunning'::text,pa.cunning), ('Selflessness'::text,pa.selflessness), ('Determination'::text,pa.determination), ('Wisdom'::text,pa.wisdom), ('Insight'::text,pa.insight), ('Aiming'::text,pa.aiming), ('Lift'::text,pa.lift), ('Control'::text,pa.control), ('Velocity'::text,pa.velocity), ('Rotation'::text,pa.rotation), ('Stuff'::text,pa.stuff), ('Deception'::text,pa.deception), ('Intuition'::text,pa.intuition), ('Persuasion'::text,pa.persuasion), ('Presence'::text,pa.presence), ('Defiance'::text,pa.defiance), ('Accuracy'::text,pa.accuracy), ('Stamina'::text,pa.stamina), ('Guts'::text,pa.guts), ('Performance'::text,pa.performance), ('Speed'::text,pa.speed), ('Greed'::text,pa.greed), ('Stealth'::text,pa.stealth), ('Arm'::text,pa.arm), ('Dexterity'::text,pa.dexterity), ('Reaction'::text,pa.reaction), ('Acrobatics'::text,pa.acrobatics), ('Agility'::text,pa.agility), ('Patience'::text,pa.patience), ('Awareness'::text,pa.awareness), ('Composure'::text,pa.composure), ('Luck'::text,pa.luck)) a(attr_name, attr_value))
        ), ranked AS (
         SELECT unpivoted.player_id,
            unpivoted.first_name,
            unpivoted.last_name,
            unpivoted.suffix,
            unpivoted."position",
            unpivoted.team_name,
            unpivoted.team_location,
            unpivoted.team_id,
            unpivoted.team_emoji,
            unpivoted.attr_name,
            unpivoted.attr_value,
            row_number() OVER (PARTITION BY unpivoted.attr_name ORDER BY unpivoted.attr_value DESC NULLS LAST) AS rank_overall
           FROM unpivoted
        )
 SELECT player_id,
    first_name,
    last_name,
    suffix,
    "position",
    team_name,
    team_location,
    team_id,
    team_emoji,
    attr_name,
    attr_value,
    rank_overall
   FROM ranked
  WHERE (rank_overall <= 10)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_attribute_leaderboard OWNER TO postgres;

--
-- Name: mv_games_played; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_games_played AS
 SELECT l.league_type,
    LEAST(max((t.wins + t.losses)), 120) AS games_played
   FROM (public.teams t
     JOIN public.leagues l ON ((t.league_id = l.id)))
  GROUP BY l.league_type
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_games_played OWNER TO postgres;

--
-- Name: player_stats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player_stats (
    player_id text NOT NULL,
    plate_appearances integer,
    at_bats integer,
    runs integer,
    singles integer,
    doubles integer,
    triples integer,
    home_runs integer,
    runs_batted_in integer,
    walked integer,
    struck_out integer,
    hit_by_pitch integer,
    stolen_bases integer,
    caught_stealing integer,
    left_on_base integer,
    sac_flies integer,
    reached_on_error integer,
    grounded_into_double_play integer,
    hits double precision GENERATED ALWAYS AS (
CASE
    WHEN (at_bats > 0) THEN ((((singles + doubles) + triples) + home_runs))::double precision
    ELSE NULL::double precision
END) STORED,
    ba double precision GENERATED ALWAYS AS (
CASE
    WHEN (at_bats > 0) THEN (((((singles + doubles) + triples) + home_runs))::double precision / (at_bats)::double precision)
    ELSE NULL::double precision
END) STORED,
    obp double precision GENERATED ALWAYS AS (
CASE
    WHEN ((((at_bats + walked) + hit_by_pitch) + sac_flies) > 0) THEN (((((((singles + doubles) + triples) + home_runs) + walked) + hit_by_pitch))::double precision / ((((at_bats + walked) + hit_by_pitch) + sac_flies))::double precision)
    ELSE NULL::double precision
END) STORED,
    slg double precision GENERATED ALWAYS AS (
CASE
    WHEN (at_bats > 0) THEN (((((singles + (2 * doubles)) + (3 * triples)) + (4 * home_runs)))::double precision / (at_bats)::double precision)
    ELSE NULL::double precision
END) STORED,
    ops double precision GENERATED ALWAYS AS (
CASE
    WHEN ((at_bats > 0) AND ((((at_bats + walked) + hit_by_pitch) + sac_flies) > 0)) THEN ((((((((singles + doubles) + triples) + home_runs) + walked) + hit_by_pitch))::double precision / ((((at_bats + walked) + hit_by_pitch) + sac_flies))::double precision) + (((((singles + (2 * doubles)) + (3 * triples)) + (4 * home_runs)))::double precision / (at_bats)::double precision))
    ELSE NULL::double precision
END) STORED,
    babip double precision GENERATED ALWAYS AS (
CASE
    WHEN ((((at_bats - struck_out) - home_runs) + sac_flies) > 0) THEN ((((singles + doubles) + triples))::double precision / ((((at_bats - struck_out) - home_runs) + sac_flies))::double precision)
    ELSE NULL::double precision
END) STORED,
    putouts integer,
    assists integer,
    errors integer,
    double_plays integer,
    force_outs integer,
    runners_caught_stealing integer,
    allowed_stolen_bases integer,
    rcs_pct double precision GENERATED ALWAYS AS (
CASE
    WHEN ((runners_caught_stealing + allowed_stolen_bases) > 0) THEN ((runners_caught_stealing)::double precision / ((runners_caught_stealing + allowed_stolen_bases))::double precision)
    ELSE NULL::double precision
END) STORED,
    appearances integer,
    starts integer,
    wins integer,
    losses integer,
    saves integer,
    holds integer,
    outs integer,
    batters_faced integer,
    hits_allowed integer,
    home_runs_allowed integer,
    earned_runs integer,
    walks integer,
    strikeouts integer,
    pitches_thrown integer,
    complete_games integer,
    shutouts integer,
    no_hitters integer,
    quality_starts integer,
    hit_batters integer,
    mound_visits integer,
    inherited_runners integer,
    inherited_runs_allowed integer,
    games_finished integer,
    innings_pitched double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN ((outs)::double precision / (3)::double precision)
    ELSE NULL::double precision
END) STORED,
    era double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((earned_runs)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    whip double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((walks + hits_allowed))::double precision / ((outs)::double precision / (3)::double precision))
    ELSE NULL::double precision
END) STORED,
    k9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((strikeouts)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    bb9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((walks)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    h9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((hits_allowed)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    hr9 double precision GENERATED ALWAYS AS (
CASE
    WHEN (outs > 0) THEN (((home_runs_allowed)::double precision / (outs)::double precision) * (27)::double precision)
    ELSE NULL::double precision
END) STORED,
    last_updated timestamp with time zone
);

CREATE MATERIALIZED VIEW public.mv_batting_leaderboard AS
 WITH enriched AS (
         SELECT ps.player_id,
            p.first_name,
            p.last_name,
            p."position",
            p.suffix,
            t.name AS team_name,
            t.id AS team_id,
            t.location AS team_location,
            t.emoji AS team_emoji,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type,
            ((gp.games_played)::numeric * 3.1) AS pa_threshold,
            ps.plate_appearances,
            ps.ba,
            ps.obp,
            ps.slg,
            ps.ops,
            ps.babip,
            ps.hits,
            ps.singles,
            ps.doubles,
            ps.triples,
            ps.home_runs,
            ps.walked,
            ps.hit_by_pitch,
            ps.stolen_bases,
            ps.caught_stealing,
            ps.struck_out
           FROM ((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
        ), rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.ba DESC NULLS LAST) AS rn_ba,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.obp DESC NULLS LAST) AS rn_obp,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.slg DESC NULLS LAST) AS rn_slg,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.ops DESC NULLS LAST) AS rn_ops,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.babip DESC NULLS LAST) AS rn_babip
           FROM enriched
          WHERE ((enriched.plate_appearances)::numeric >= enriched.pa_threshold)
        ), count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hits DESC NULLS LAST) AS rn_hits,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.singles DESC NULLS LAST) AS rn_singles,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.doubles DESC NULLS LAST) AS rn_doubles,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.triples DESC NULLS LAST) AS rn_triples,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.home_runs DESC NULLS LAST) AS rn_hr,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.walked DESC NULLS LAST) AS rn_walks,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hit_by_pitch DESC NULLS LAST) AS rn_hbp,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.stolen_bases DESC NULLS LAST) AS rn_sb,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.caught_stealing DESC NULLS LAST) AS rn_cs,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.struck_out DESC NULLS LAST) AS rn_k
           FROM enriched
        ), combined_rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.ba DESC NULLS LAST) AS rn_ba,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.obp DESC NULLS LAST) AS rn_obp,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.slg DESC NULLS LAST) AS rn_slg,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.ops DESC NULLS LAST) AS rn_ops,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.babip DESC NULLS LAST) AS rn_babip
           FROM enriched
          WHERE ((enriched.plate_appearances)::numeric >= enriched.pa_threshold)
        ), combined_count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.pa_threshold,
            enriched.plate_appearances,
            enriched.ba,
            enriched.obp,
            enriched.slg,
            enriched.ops,
            enriched.babip,
            enriched.hits,
            enriched.singles,
            enriched.doubles,
            enriched.triples,
            enriched.home_runs,
            enriched.walked,
            enriched.hit_by_pitch,
            enriched.stolen_bases,
            enriched.caught_stealing,
            enriched.struck_out,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hits DESC NULLS LAST) AS rn_hits,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.singles DESC NULLS LAST) AS rn_singles,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.doubles DESC NULLS LAST) AS rn_doubles,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.triples DESC NULLS LAST) AS rn_triples,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.home_runs DESC NULLS LAST) AS rn_hr,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.walked DESC NULLS LAST) AS rn_walks,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hit_by_pitch DESC NULLS LAST) AS rn_hbp,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.stolen_bases DESC NULLS LAST) AS rn_sb,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.caught_stealing DESC NULLS LAST) AS rn_cs,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.struck_out DESC NULLS LAST) AS rn_k
           FROM enriched
        )
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.ba AS stat_value,
    'Batting Average (BA)'::text AS stat_key,
    rate_ranked.rn_ba AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_ba <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.obp AS stat_value,
    'On Base Percentage (OBP)'::text AS stat_key,
    rate_ranked.rn_obp AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_obp <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.slg AS stat_value,
    'Slugging Percentage (SLG)'::text AS stat_key,
    rate_ranked.rn_slg AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_slg <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.ops AS stat_value,
    'On Base Plus Slugging (OPS)'::text AS stat_key,
    rate_ranked.rn_ops AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_ops <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.plate_appearances,
    rate_ranked.pa_threshold,
    rate_ranked.babip AS stat_value,
    'Batting Average on Balls in Play (BABIP)'::text AS stat_key,
    rate_ranked.rn_babip AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_babip <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.hits AS stat_value,
    'Hits'::text AS stat_key,
    count_ranked.rn_hits AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hits <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.singles AS stat_value,
    'Singles'::text AS stat_key,
    count_ranked.rn_singles AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_singles <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.doubles AS stat_value,
    'Doubles'::text AS stat_key,
    count_ranked.rn_doubles AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_doubles <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.triples AS stat_value,
    'Triples'::text AS stat_key,
    count_ranked.rn_triples AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_triples <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.home_runs AS stat_value,
    'Home Runs'::text AS stat_key,
    count_ranked.rn_hr AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hr <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.walked AS stat_value,
    'Walks (BB)'::text AS stat_key,
    count_ranked.rn_walks AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_walks <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.hit_by_pitch AS stat_value,
    'Hit By Pitch (HBP)'::text AS stat_key,
    count_ranked.rn_hbp AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hbp <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.stolen_bases AS stat_value,
    'Stolen Bases'::text AS stat_key,
    count_ranked.rn_sb AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_sb <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.caught_stealing AS stat_value,
    'Caught Stealing'::text AS stat_key,
    count_ranked.rn_cs AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_cs <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.plate_appearances,
    count_ranked.pa_threshold,
    count_ranked.struck_out AS stat_value,
    'Struck Out'::text AS stat_key,
    count_ranked.rn_k AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_k <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.ba AS stat_value,
    'Batting Average (BA)'::text AS stat_key,
    combined_rate_ranked.rn_ba AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_ba <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.obp AS stat_value,
    'On Base Percentage (OBP)'::text AS stat_key,
    combined_rate_ranked.rn_obp AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_obp <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.slg AS stat_value,
    'Slugging Percentage (SLG)'::text AS stat_key,
    combined_rate_ranked.rn_slg AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_slg <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.ops AS stat_value,
    'On Base Plus Slugging (OPS)'::text AS stat_key,
    combined_rate_ranked.rn_ops AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_ops <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.plate_appearances,
    combined_rate_ranked.pa_threshold,
    combined_rate_ranked.babip AS stat_value,
    'Batting Average on Balls in Play (BABIP)'::text AS stat_key,
    combined_rate_ranked.rn_babip AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_babip <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.hits AS stat_value,
    'Hits'::text AS stat_key,
    combined_count_ranked.rn_hits AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hits <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.singles AS stat_value,
    'Singles'::text AS stat_key,
    combined_count_ranked.rn_singles AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_singles <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.doubles AS stat_value,
    'Doubles'::text AS stat_key,
    combined_count_ranked.rn_doubles AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_doubles <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.triples AS stat_value,
    'Triples'::text AS stat_key,
    combined_count_ranked.rn_triples AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_triples <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.home_runs AS stat_value,
    'Home Runs'::text AS stat_key,
    combined_count_ranked.rn_hr AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hr <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.walked AS stat_value,
    'Walks'::text AS stat_key,
    combined_count_ranked.rn_walks AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_walks <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.hit_by_pitch AS stat_value,
    'Hit By Pitch (HBP)'::text AS stat_key,
    combined_count_ranked.rn_hbp AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hbp <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.stolen_bases AS stat_value,
    'Stolen Bases'::text AS stat_key,
    combined_count_ranked.rn_sb AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_sb <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.caught_stealing AS stat_value,
    'Caught Stealing'::text AS stat_key,
    combined_count_ranked.rn_cs AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_cs <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.plate_appearances,
    combined_count_ranked.pa_threshold,
    combined_count_ranked.struck_out AS stat_value,
    'Struck Out'::text AS stat_key,
    combined_count_ranked.rn_k AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_k <= 10)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.mv_batting_leaderboard OWNER TO postgres;

--
-- Name: mv_league_batting_context; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW public.mv_league_batting_context AS
 WITH qualified AS (
         SELECT ps.ba,
            ps.obp,
            ps.slg,
            ps.ops,
            ps.babip,
            ps.plate_appearances,
            ps.hits,
            ps.at_bats,
            ps.walked,
            ps.hit_by_pitch,
            ps.sac_flies,
            ps.singles,
            ps.doubles,
            ps.triples,
            ps.home_runs,
            ps.struck_out,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type
           FROM ((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
          WHERE ((ps.plate_appearances)::numeric >= ((gp.games_played)::numeric * 3.1))
        ), agg AS (
         SELECT qualified.league_id,
            qualified.league_name,
            qualified.league_type,
            count(*) AS qualified_batters,
            sum(qualified.hits) AS sum_h,
            sum(qualified.at_bats) AS sum_ab,
            sum(qualified.walked) AS sum_bb,
            sum(qualified.hit_by_pitch) AS sum_hbp,
            sum(qualified.sac_flies) AS sum_sf,
            sum(qualified.singles) AS sum_1b,
            sum(qualified.doubles) AS sum_2b,
            sum(qualified.triples) AS sum_3b,
            sum(qualified.home_runs) AS sum_hr,
            sum(qualified.struck_out) AS sum_k
           FROM qualified
          GROUP BY qualified.league_type, qualified.league_id, qualified.league_name
        ), with_rates AS (
         SELECT agg.league_id,
            agg.league_name,
            agg.league_type,
            agg.qualified_batters,
            agg.sum_h,
            agg.sum_ab,
            agg.sum_bb,
            agg.sum_hbp,
            agg.sum_sf,
            agg.sum_1b,
            agg.sum_2b,
            agg.sum_3b,
            agg.sum_hr,
            agg.sum_k,
            (agg.sum_h / (NULLIF(agg.sum_ab, 0))::double precision) AS avg_ba,
            (((agg.sum_h + (agg.sum_bb)::double precision) + (agg.sum_hbp)::double precision) / (NULLIF((((agg.sum_ab + agg.sum_bb) + agg.sum_hbp) + agg.sum_sf), 0))::double precision) AS avg_obp,
            (((((agg.sum_1b)::numeric + (2.0 * (agg.sum_2b)::numeric)) + (3.0 * (agg.sum_3b)::numeric)) + (4.0 * (agg.sum_hr)::numeric)) / (NULLIF(agg.sum_ab, 0))::numeric) AS avg_slg,
            ((agg.sum_h - (agg.sum_hr)::double precision) / (NULLIF((((agg.sum_ab - agg.sum_k) - agg.sum_hr) + agg.sum_sf), 0))::double precision) AS avg_babip
           FROM agg
        ), final AS (
         SELECT with_rates.league_id,
            with_rates.league_name,
            with_rates.league_type,
            with_rates.qualified_batters,
            with_rates.sum_h,
            with_rates.sum_ab,
            with_rates.sum_bb,
            with_rates.sum_hbp,
            with_rates.sum_sf,
            with_rates.sum_1b,
            with_rates.sum_2b,
            with_rates.sum_3b,
            with_rates.sum_hr,
            with_rates.sum_k,
            with_rates.avg_ba,
            with_rates.avg_obp,
            with_rates.avg_slg,
            with_rates.avg_babip,
            (with_rates.avg_obp + (with_rates.avg_slg)::double precision) AS avg_ops
           FROM with_rates
        )
 SELECT final.league_id,
    final.league_name,
    final.league_type,
    final.qualified_batters,
    final.sum_h,
    final.sum_ab,
    final.sum_bb,
    final.sum_hbp,
    final.sum_sf,
    final.sum_1b,
    final.sum_2b,
    final.sum_3b,
    final.sum_hr,
    final.sum_k,
    final.avg_ba,
    final.avg_obp,
    final.avg_slg,
    final.avg_babip,
    final.avg_ops
   FROM final
  WHERE (final.league_type = 'Lesser'::text)
UNION ALL
 SELECT '__lesser__'::text AS league_id,
    'All Lesser'::text AS league_name,
    'Lesser'::text AS league_type,
    sum(final.qualified_batters) AS qualified_batters,
    sum(final.sum_h) AS sum_h,
    sum(final.sum_ab) AS sum_ab,
    sum(final.sum_bb) AS sum_bb,
    sum(final.sum_hbp) AS sum_hbp,
    sum(final.sum_sf) AS sum_sf,
    sum(final.sum_1b) AS sum_1b,
    sum(final.sum_2b) AS sum_2b,
    sum(final.sum_3b) AS sum_3b,
    sum(final.sum_hr) AS sum_hr,
    sum(final.sum_k) AS sum_k,
    (sum(final.sum_h) / (NULLIF(sum(final.sum_ab), (0)::numeric))::double precision) AS avg_ba,
    (((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_obp,
    ((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)) AS avg_slg,
    ((sum(final.sum_h) - (sum(final.sum_hr))::double precision) / (NULLIF((((sum(final.sum_ab) - sum(final.sum_k)) - sum(final.sum_hr)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_babip,
    ((((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) + (((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)))::double precision) AS avg_ops
   FROM final
  WHERE (final.league_type = 'Lesser'::text)
UNION ALL
 SELECT '__greater__'::text AS league_id,
    'All Greater'::text AS league_name,
    'Greater'::text AS league_type,
    sum(final.qualified_batters) AS qualified_batters,
    sum(final.sum_h) AS sum_h,
    sum(final.sum_ab) AS sum_ab,
    sum(final.sum_bb) AS sum_bb,
    sum(final.sum_hbp) AS sum_hbp,
    sum(final.sum_sf) AS sum_sf,
    sum(final.sum_1b) AS sum_1b,
    sum(final.sum_2b) AS sum_2b,
    sum(final.sum_3b) AS sum_3b,
    sum(final.sum_hr) AS sum_hr,
    sum(final.sum_k) AS sum_k,
    (sum(final.sum_h) / (NULLIF(sum(final.sum_ab), (0)::numeric))::double precision) AS avg_ba,
    (((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_obp,
    ((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)) AS avg_slg,
    ((sum(final.sum_h) - (sum(final.sum_hr))::double precision) / (NULLIF((((sum(final.sum_ab) - sum(final.sum_k)) - sum(final.sum_hr)) + sum(final.sum_sf)), (0)::numeric))::double precision) AS avg_babip,
    ((((sum(final.sum_h) + (sum(final.sum_bb))::double precision) + (sum(final.sum_hbp))::double precision) / (NULLIF((((sum(final.sum_ab) + sum(final.sum_bb)) + sum(final.sum_hbp)) + sum(final.sum_sf)), (0)::numeric))::double precision) + (((((sum(final.sum_1b) + (2.0 * sum(final.sum_2b))) + (3.0 * sum(final.sum_3b))) + (4.0 * sum(final.sum_hr))) / NULLIF(sum(final.sum_ab), (0)::numeric)))::double precision) AS avg_ops
   FROM final
  WHERE (final.league_type = 'Greater'::text)
  WITH NO DATA;

CREATE MATERIALIZED VIEW public.mv_league_pitching_context AS
 WITH qualified AS (
         SELECT ps.earned_runs,
            ps.innings_pitched,
            ps.hits_allowed,
            ps.home_runs_allowed,
            ps.walks,
            ps.strikeouts,
            ps.era,
            ps.whip,
            ps.k9,
            ps.bb9,
            ps.h9,
            ps.hr9,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type
           FROM ((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
          WHERE ((ps.innings_pitched >= (((gp.games_played)::numeric * 1.0))::double precision) AND (ps.innings_pitched > (0)::double precision))
        ), agg AS (
         SELECT qualified.league_id,
            qualified.league_name,
            qualified.league_type,
            count(*) AS qualified_pitchers,
            sum(qualified.earned_runs) AS sum_er,
            sum(qualified.innings_pitched) AS sum_ip,
            sum(qualified.hits_allowed) AS sum_h,
            sum(qualified.home_runs_allowed) AS sum_hr,
            sum(qualified.walks) AS sum_bb,
            sum(qualified.strikeouts) AS sum_k
           FROM qualified
          GROUP BY qualified.league_type, qualified.league_id, qualified.league_name
        ), with_rates AS (
         SELECT agg.league_id,
            agg.league_name,
            agg.league_type,
            agg.qualified_pitchers,
            agg.sum_er,
            agg.sum_ip,
            agg.sum_h,
            agg.sum_hr,
            agg.sum_bb,
            agg.sum_k,
            ((((agg.sum_er)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_era,
            (((agg.sum_h + agg.sum_bb))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_whip,
            ((((agg.sum_k)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_k9,
            ((((agg.sum_bb)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_bb9,
            ((((agg.sum_h)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_h9,
            ((((agg.sum_hr)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) AS avg_hr9,
            (((((agg.sum_er)::numeric * 9.0))::double precision / NULLIF(agg.sum_ip, (0)::double precision)) - (((((13.0 * (agg.sum_hr)::numeric) + (3.0 * (agg.sum_bb)::numeric)) - (2.0 * (agg.sum_k)::numeric)))::double precision / NULLIF(agg.sum_ip, (0)::double precision))) AS fip_constant
           FROM agg
        ), lesser_subleagues AS (
         SELECT with_rates.league_id,
            with_rates.league_name,
            with_rates.league_type,
            with_rates.qualified_pitchers,
            with_rates.sum_er,
            with_rates.sum_ip,
            with_rates.sum_h,
            with_rates.sum_hr,
            with_rates.sum_bb,
            with_rates.sum_k,
            with_rates.avg_era,
            with_rates.avg_whip,
            with_rates.avg_k9,
            with_rates.avg_bb9,
            with_rates.avg_h9,
            with_rates.avg_hr9,
            with_rates.fip_constant
           FROM with_rates
          WHERE (with_rates.league_type = 'Lesser'::text)
        ), lesser_rollup AS (
         SELECT '__lesser__'::text AS league_id,
            'All Lesser'::text AS league_name,
            'Lesser'::text AS league_type,
            sum(with_rates.qualified_pitchers) AS qualified_pitchers,
            sum(with_rates.sum_er) AS sum_er,
            sum(with_rates.sum_ip) AS sum_ip,
            sum(with_rates.sum_h) AS sum_h,
            sum(with_rates.sum_hr) AS sum_hr,
            sum(with_rates.sum_bb) AS sum_bb,
            sum(with_rates.sum_k) AS sum_k,
            (((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_era,
            (((sum(with_rates.sum_h) + sum(with_rates.sum_bb)))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_whip,
            (((sum(with_rates.sum_k) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_k9,
            (((sum(with_rates.sum_bb) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_bb9,
            (((sum(with_rates.sum_h) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_h9,
            (((sum(with_rates.sum_hr) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_hr9,
            ((((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) - (((((13.0 * sum(with_rates.sum_hr)) + (3.0 * sum(with_rates.sum_bb))) - (2.0 * sum(with_rates.sum_k))))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision))) AS fip_constant
           FROM with_rates
          WHERE (with_rates.league_type = 'Lesser'::text)
        ), greater_unified AS (
         SELECT '__greater__'::text AS league_id,
            'All Greater'::text AS league_name,
            'Greater'::text AS league_type,
            sum(with_rates.qualified_pitchers) AS qualified_pitchers,
            sum(with_rates.sum_er) AS sum_er,
            sum(with_rates.sum_ip) AS sum_ip,
            sum(with_rates.sum_h) AS sum_h,
            sum(with_rates.sum_hr) AS sum_hr,
            sum(with_rates.sum_bb) AS sum_bb,
            sum(with_rates.sum_k) AS sum_k,
            (((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_era,
            (((sum(with_rates.sum_h) + sum(with_rates.sum_bb)))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_whip,
            (((sum(with_rates.sum_k) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_k9,
            (((sum(with_rates.sum_bb) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_bb9,
            (((sum(with_rates.sum_h) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_h9,
            (((sum(with_rates.sum_hr) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) AS avg_hr9,
            ((((sum(with_rates.sum_er) * 9.0))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision)) - (((((13.0 * sum(with_rates.sum_hr)) + (3.0 * sum(with_rates.sum_bb))) - (2.0 * sum(with_rates.sum_k))))::double precision / NULLIF(sum(with_rates.sum_ip), (0)::double precision))) AS fip_constant
           FROM with_rates
          WHERE (with_rates.league_type = 'Greater'::text)
        )
 SELECT lesser_subleagues.league_id,
    lesser_subleagues.league_name,
    lesser_subleagues.league_type,
    lesser_subleagues.qualified_pitchers,
    lesser_subleagues.sum_er,
    lesser_subleagues.sum_ip,
    lesser_subleagues.sum_h,
    lesser_subleagues.sum_hr,
    lesser_subleagues.sum_bb,
    lesser_subleagues.sum_k,
    lesser_subleagues.avg_era,
    lesser_subleagues.avg_whip,
    lesser_subleagues.avg_k9,
    lesser_subleagues.avg_bb9,
    lesser_subleagues.avg_h9,
    lesser_subleagues.avg_hr9,
    lesser_subleagues.fip_constant
   FROM lesser_subleagues
UNION ALL
 SELECT lesser_rollup.league_id,
    lesser_rollup.league_name,
    lesser_rollup.league_type,
    lesser_rollup.qualified_pitchers,
    lesser_rollup.sum_er,
    lesser_rollup.sum_ip,
    lesser_rollup.sum_h,
    lesser_rollup.sum_hr,
    lesser_rollup.sum_bb,
    lesser_rollup.sum_k,
    lesser_rollup.avg_era,
    lesser_rollup.avg_whip,
    lesser_rollup.avg_k9,
    lesser_rollup.avg_bb9,
    lesser_rollup.avg_h9,
    lesser_rollup.avg_hr9,
    lesser_rollup.fip_constant
   FROM lesser_rollup
UNION ALL
 SELECT greater_unified.league_id,
    greater_unified.league_name,
    greater_unified.league_type,
    greater_unified.qualified_pitchers,
    greater_unified.sum_er,
    greater_unified.sum_ip,
    greater_unified.sum_h,
    greater_unified.sum_hr,
    greater_unified.sum_bb,
    greater_unified.sum_k,
    greater_unified.avg_era,
    greater_unified.avg_whip,
    greater_unified.avg_k9,
    greater_unified.avg_bb9,
    greater_unified.avg_h9,
    greater_unified.avg_hr9,
    greater_unified.fip_constant
   FROM greater_unified
  WITH NO DATA;

CREATE MATERIALIZED VIEW public.mv_pitching_leaderboard AS
 WITH enriched AS (
         SELECT ps.player_id,
            p.first_name,
            p.last_name,
            p."position",
            p.suffix,
            t.name AS team_name,
            t.id AS team_id,
            t.location AS team_location,
            t.emoji AS team_emoji,
            l.id AS league_id,
            l.name AS league_name,
            l.league_type,
            ((gp.games_played)::numeric * 1.0) AS ip_threshold,
            ps.innings_pitched,
            ps.era,
            ps.whip,
            ps.k9,
            ps.bb9,
            ps.h9,
            ps.hr9,
            ps.strikeouts,
            ps.hit_batters,
            ((((((13.0 * (ps.home_runs_allowed)::numeric) + (3.0 * (ps.walks)::numeric)) - (2.0 * (ps.strikeouts)::numeric)))::double precision / NULLIF(ps.innings_pitched, (0)::double precision)) + lpc.fip_constant) AS fip
           FROM (((((public.player_stats ps
             JOIN public.players p ON ((ps.player_id = p.id)))
             JOIN public.teams t ON ((p.team_id = t.id)))
             JOIN public.leagues l ON ((t.league_id = l.id)))
             JOIN public.mv_games_played gp ON ((gp.league_type = l.league_type)))
             JOIN public.mv_league_pitching_context lpc ON ((lpc.league_id =
                CASE
                    WHEN (l.league_type = 'Greater'::text) THEN '__greater__'::text
                    ELSE l.id
                END)))
        ), rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.era) AS rn_era,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.fip) AS rn_fip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.whip) AS rn_whip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.k9 DESC NULLS LAST) AS rn_k9,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.bb9) AS rn_bb9,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.h9) AS rn_h9,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hr9) AS rn_hr9
           FROM enriched
          WHERE (enriched.innings_pitched >= (enriched.ip_threshold)::double precision)
        ), count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.innings_pitched DESC NULLS LAST) AS rn_ip,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.strikeouts DESC NULLS LAST) AS rn_k,
            row_number() OVER (PARTITION BY enriched.league_id ORDER BY enriched.hit_batters DESC NULLS LAST) AS rn_hbp
           FROM enriched
        ), combined_rate_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.era) AS rn_era,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.fip) AS rn_fip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.whip) AS rn_whip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.k9 DESC NULLS LAST) AS rn_k9,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.bb9) AS rn_bb9,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.h9) AS rn_h9,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hr9) AS rn_hr9
           FROM enriched
          WHERE (enriched.innings_pitched >= (enriched.ip_threshold)::double precision)
        ), combined_count_ranked AS (
         SELECT enriched.player_id,
            enriched.first_name,
            enriched.last_name,
            enriched."position",
            enriched.suffix,
            enriched.team_name,
            enriched.team_id,
            enriched.team_location,
            enriched.team_emoji,
            enriched.league_id,
            enriched.league_name,
            enriched.league_type,
            enriched.ip_threshold,
            enriched.innings_pitched,
            enriched.era,
            enriched.whip,
            enriched.k9,
            enriched.bb9,
            enriched.h9,
            enriched.hr9,
            enriched.strikeouts,
            enriched.hit_batters,
            enriched.fip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.innings_pitched DESC NULLS LAST) AS rn_ip,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.strikeouts DESC NULLS LAST) AS rn_k,
            row_number() OVER (PARTITION BY enriched.league_type ORDER BY enriched.hit_batters DESC NULLS LAST) AS rn_hbp
           FROM enriched
        )
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.era AS stat_value,
    'Earned Run Average (ERA)'::text AS stat_key,
    rate_ranked.rn_era AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_era <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.fip AS stat_value,
    'Fielding Independent Pitching (FIP)'::text AS stat_key,
    rate_ranked.rn_fip AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_fip <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.whip AS stat_value,
    'Walks and Hits per Inning Pitched (WHIP)'::text AS stat_key,
    rate_ranked.rn_whip AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_whip <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.k9 AS stat_value,
    'Strikeouts per 9 Innings (K/9)'::text AS stat_key,
    rate_ranked.rn_k9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_k9 <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.bb9 AS stat_value,
    'Walks per 9 Innings (BB/9)'::text AS stat_key,
    rate_ranked.rn_bb9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_bb9 <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.h9 AS stat_value,
    'Hits per 9 Innings (H/9)'::text AS stat_key,
    rate_ranked.rn_h9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_h9 <= 10)
UNION ALL
 SELECT rate_ranked.player_id,
    rate_ranked.first_name,
    rate_ranked.last_name,
    rate_ranked.suffix,
    rate_ranked."position",
    rate_ranked.team_name,
    rate_ranked.team_location,
    rate_ranked.team_id,
    rate_ranked.team_emoji,
    rate_ranked.league_id,
    rate_ranked.league_name,
    rate_ranked.league_type,
    rate_ranked.innings_pitched,
    rate_ranked.ip_threshold,
    rate_ranked.hr9 AS stat_value,
    'Homeruns per 9 Innings (HR/9)'::text AS stat_key,
    rate_ranked.rn_hr9 AS rank_in_league
   FROM rate_ranked
  WHERE (rate_ranked.rn_hr9 <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.innings_pitched,
    count_ranked.ip_threshold,
    count_ranked.innings_pitched AS stat_value,
    'Innings Pitched (IP)'::text AS stat_key,
    count_ranked.rn_ip AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_ip <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.innings_pitched,
    count_ranked.ip_threshold,
    count_ranked.strikeouts AS stat_value,
    'Strikeouts'::text AS stat_key,
    count_ranked.rn_k AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_k <= 10)
UNION ALL
 SELECT count_ranked.player_id,
    count_ranked.first_name,
    count_ranked.last_name,
    count_ranked.suffix,
    count_ranked."position",
    count_ranked.team_name,
    count_ranked.team_location,
    count_ranked.team_id,
    count_ranked.team_emoji,
    count_ranked.league_id,
    count_ranked.league_name,
    count_ranked.league_type,
    count_ranked.innings_pitched,
    count_ranked.ip_threshold,
    count_ranked.hit_batters AS stat_value,
    'Hit Batters'::text AS stat_key,
    count_ranked.rn_hbp AS rank_in_league
   FROM count_ranked
  WHERE (count_ranked.rn_hbp <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.era AS stat_value,
    'Earned Run Average (ERA)'::text AS stat_key,
    combined_rate_ranked.rn_era AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_era <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.fip AS stat_value,
    'Fielding Independent Pitching (FIP)'::text AS stat_key,
    combined_rate_ranked.rn_fip AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_fip <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.whip AS stat_value,
    'Walks and Hits per Inning Pitched (WHIP)'::text AS stat_key,
    combined_rate_ranked.rn_whip AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_whip <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.k9 AS stat_value,
    'Strikeouts per 9 Innings (K/9)'::text AS stat_key,
    combined_rate_ranked.rn_k9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_k9 <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.bb9 AS stat_value,
    'Walks per 9 Innings (BB/9)'::text AS stat_key,
    combined_rate_ranked.rn_bb9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_bb9 <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.h9 AS stat_value,
    'Hits per 9 Innings (H/9)'::text AS stat_key,
    combined_rate_ranked.rn_h9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_h9 <= 10)
UNION ALL
 SELECT combined_rate_ranked.player_id,
    combined_rate_ranked.first_name,
    combined_rate_ranked.last_name,
    combined_rate_ranked.suffix,
    combined_rate_ranked."position",
    combined_rate_ranked.team_name,
    combined_rate_ranked.team_location,
    combined_rate_ranked.team_id,
    combined_rate_ranked.team_emoji,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_rate_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_rate_ranked.league_type,
    combined_rate_ranked.innings_pitched,
    combined_rate_ranked.ip_threshold,
    combined_rate_ranked.hr9 AS stat_value,
    'Homeruns per 9 Innings (HR/9)'::text AS stat_key,
    combined_rate_ranked.rn_hr9 AS rank_in_league
   FROM combined_rate_ranked
  WHERE (combined_rate_ranked.rn_hr9 <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.innings_pitched,
    combined_count_ranked.ip_threshold,
    combined_count_ranked.innings_pitched AS stat_value,
    'Innings Pitched (IP)'::text AS stat_key,
    combined_count_ranked.rn_ip AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_ip <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.innings_pitched,
    combined_count_ranked.ip_threshold,
    combined_count_ranked.strikeouts AS stat_value,
    'Strikeouts'::text AS stat_key,
    combined_count_ranked.rn_k AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_k <= 10)
UNION ALL
 SELECT combined_count_ranked.player_id,
    combined_count_ranked.first_name,
    combined_count_ranked.last_name,
    combined_count_ranked.suffix,
    combined_count_ranked."position",
    combined_count_ranked.team_name,
    combined_count_ranked.team_location,
    combined_count_ranked.team_id,
    combined_count_ranked.team_emoji,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN '__lesser__'::text
            ELSE '__greater__'::text
        END AS league_id,
        CASE
            WHEN (combined_count_ranked.league_type = 'Lesser'::text) THEN 'All Lesser'::text
            ELSE 'All Greater'::text
        END AS league_name,
    combined_count_ranked.league_type,
    combined_count_ranked.innings_pitched,
    combined_count_ranked.ip_threshold,
    combined_count_ranked.hit_batters AS stat_value,
    'Hit Batters'::text AS stat_key,
    combined_count_ranked.rn_hbp AS rank_in_league
   FROM combined_count_ranked
  WHERE (combined_count_ranked.rn_hbp <= 10)
  WITH NO DATA;