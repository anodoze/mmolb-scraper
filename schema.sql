-- =====================
-- TABLES
-- =====================

CREATE TABLE leagues (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  color TEXT,
  emoji TEXT,
  league_type TEXT
);

CREATE TABLE teams (
  id TEXT PRIMARY KEY,
  league_id TEXT REFERENCES leagues(id),
  name TEXT NOT NULL,
  location TEXT,
  emoji TEXT,
  color TEXT,
  wins INTEGER,
  losses INTEGER,
  rundiff INTEGER,
  last_updated TIMESTAMPTZ
);

CREATE TABLE players (
  id TEXT PRIMARY KEY,
  team_id TEXT REFERENCES teams(id),
  first_name TEXT,
  last_name TEXT,
  suffix TEXT,
  number INTEGER,
  position TEXT,
  position_type TEXT,
  slot TEXT,
  level INTEGER,
  last_updated TIMESTAMPTZ
);

CREATE TABLE player_stats (
  player_id TEXT PRIMARY KEY REFERENCES players(id),
  -- Batting
  plate_appearances INTEGER,
  at_bats INTEGER,
  runs INTEGER,
  singles INTEGER,
  doubles INTEGER,
  triples INTEGER,
  home_runs INTEGER,
  runs_batted_in INTEGER,
  walked INTEGER,
  struck_out INTEGER,
  hit_by_pitch INTEGER,
  stolen_bases INTEGER,
  caught_stealing INTEGER,
  left_on_base INTEGER,
  sac_flies INTEGER,
  reached_on_error INTEGER,
  grounded_into_double_play INTEGER,
  -- Batting generated
  hits FLOAT GENERATED ALWAYS AS (
    CASE WHEN at_bats > 0
    THEN (singles + doubles + triples + home_runs)::float
    ELSE NULL END
  ) STORED,
  ba FLOAT GENERATED ALWAYS AS (
    CASE WHEN at_bats > 0
    THEN (singles + doubles + triples + home_runs)::float / at_bats
    ELSE NULL END
  ) STORED,
  obp FLOAT GENERATED ALWAYS AS (
    CASE WHEN (at_bats + walked + hit_by_pitch + sac_flies) > 0
    THEN (singles + doubles + triples + home_runs + walked + hit_by_pitch)::float
         / (at_bats + walked + hit_by_pitch + sac_flies)
    ELSE NULL END
  ) STORED,
  slg FLOAT GENERATED ALWAYS AS (
    CASE WHEN at_bats > 0
    THEN (singles + 2*doubles + 3*triples + 4*home_runs)::float / at_bats
    ELSE NULL END
  ) STORED,
  ops FLOAT GENERATED ALWAYS AS (
    CASE WHEN at_bats > 0 AND (at_bats + walked + hit_by_pitch + sac_flies) > 0
    THEN (singles + doubles + triples + home_runs + walked + hit_by_pitch)::float
         / (at_bats + walked + hit_by_pitch + sac_flies)
       + (singles + 2*doubles + 3*triples + 4*home_runs)::float / at_bats
    ELSE NULL END
  ) STORED,
  babip FLOAT GENERATED ALWAYS AS (
    CASE WHEN (at_bats - struck_out - home_runs + sac_flies) > 0
    THEN (singles + doubles + triples)::float
         / (at_bats - struck_out - home_runs + sac_flies)
    ELSE NULL END
  ) STORED,
  -- Fielding
  putouts INTEGER,
  assists INTEGER,
  errors INTEGER,
  double_plays INTEGER,
  force_outs INTEGER,
  runners_caught_stealing INTEGER,
  allowed_stolen_bases INTEGER,
  -- Fielding generated
  rcs_pct FLOAT GENERATED ALWAYS AS (
    CASE WHEN (runners_caught_stealing + allowed_stolen_bases) > 0
    THEN runners_caught_stealing::float
         / (runners_caught_stealing + allowed_stolen_bases)
    ELSE NULL END
  ) STORED,
  -- Pitching
  appearances INTEGER,
  starts INTEGER,
  wins INTEGER,
  losses INTEGER,
  saves INTEGER,
  holds INTEGER,
  outs INTEGER,
  batters_faced INTEGER,
  hits_allowed INTEGER,
  home_runs_allowed INTEGER,
  earned_runs INTEGER,
  walks INTEGER,
  strikeouts INTEGER,
  pitches_thrown INTEGER,
  complete_games INTEGER,
  shutouts INTEGER,
  no_hitters INTEGER,
  quality_starts INTEGER,
  hit_batters INTEGER,
  mound_visits INTEGER,
  inherited_runners INTEGER,
  inherited_runs_allowed INTEGER,
  games_finished INTEGER,
  -- Pitching generated
  innings_pitched FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN outs::float / 3
    ELSE NULL END
  ) STORED,
  era FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN (earned_runs::float / outs) * 27
    ELSE NULL END
  ) STORED,
  whip FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN (walks + hits_allowed)::float / (outs::float / 3)
    ELSE NULL END
  ) STORED,
  k9 FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN (strikeouts::float / outs) * 27
    ELSE NULL END
  ) STORED,
  bb9 FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN (walks::float / outs) * 27
    ELSE NULL END
  ) STORED,
  h9 FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN (hits_allowed::float / outs) * 27
    ELSE NULL END
  ) STORED,
  hr9 FLOAT GENERATED ALWAYS AS (
    CASE WHEN outs > 0
    THEN (home_runs_allowed::float / outs) * 27
    ELSE NULL END
  ) STORED,
  last_updated TIMESTAMPTZ
);

CREATE TABLE player_attributes (
  player_id TEXT PRIMARY KEY REFERENCES players(id),
  -- Batting
  discipline FLOAT, vision FLOAT, intimidation FLOAT, muscle FLOAT,
  contact FLOAT, cunning FLOAT, selflessness FLOAT, determination FLOAT,
  wisdom FLOAT, insight FLOAT, aiming FLOAT, lift FLOAT,
  -- Pitching
  control FLOAT, velocity FLOAT, rotation FLOAT, stuff FLOAT,
  deception FLOAT, intuition FLOAT, persuasion FLOAT, presence FLOAT,
  defiance FLOAT, accuracy FLOAT, stamina FLOAT, guts FLOAT,
  -- Baserunning
  performance FLOAT, speed FLOAT, greed FLOAT, stealth FLOAT,
  -- Defense
  arm FLOAT, dexterity FLOAT, reaction FLOAT, acrobatics FLOAT,
  agility FLOAT, patience FLOAT, awareness FLOAT, composure FLOAT,
  -- Other
  luck FLOAT
);

CREATE TABLE player_details (
  player_id TEXT PRIMARY KEY REFERENCES players(id),
  details JSONB,
  last_updated TIMESTAMPTZ
);

CREATE TABLE scrape_runs (
  id SERIAL PRIMARY KEY,
  started_at TIMESTAMPTZ,
  finished_at TIMESTAMPTZ,
  teams_scraped INTEGER,
  errors INTEGER,
  notes TEXT
);

-- =====================
-- RLS
-- =====================

ALTER TABLE leagues ENABLE ROW LEVEL SECURITY;
ALTER TABLE teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_attributes ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_details ENABLE ROW LEVEL SECURITY;
ALTER TABLE scrape_runs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public read" ON leagues FOR SELECT USING (true);
CREATE POLICY "public read" ON teams FOR SELECT USING (true);
CREATE POLICY "public read" ON players FOR SELECT USING (true);
CREATE POLICY "public read" ON player_stats FOR SELECT USING (true);
CREATE POLICY "public read" ON player_attributes FOR SELECT USING (true);
CREATE POLICY "public read" ON player_details FOR SELECT USING (true);
CREATE POLICY "public read" ON scrape_runs FOR SELECT USING (true);

-- =====================
-- INDEXES
-- =====================

-- Foreign keys
CREATE INDEX ON players(team_id);
CREATE INDEX ON player_stats(player_id);
CREATE INDEX ON player_attributes(player_id);
CREATE INDEX ON player_details(player_id);
CREATE INDEX ON teams(league_id);

-- Batting counting stats
CREATE INDEX ON player_stats(plate_appearances);
CREATE INDEX ON player_stats(hits);
CREATE INDEX ON player_stats(singles);
CREATE INDEX ON player_stats(doubles);
CREATE INDEX ON player_stats(triples);
CREATE INDEX ON player_stats(home_runs);
CREATE INDEX ON player_stats(runs_batted_in);
CREATE INDEX ON player_stats(walked);
CREATE INDEX ON player_stats(struck_out);
CREATE INDEX ON player_stats(hit_by_pitch);
CREATE INDEX ON player_stats(stolen_bases);
CREATE INDEX ON player_stats(caught_stealing);

-- Batting derived
CREATE INDEX ON player_stats(ba);
CREATE INDEX ON player_stats(obp);
CREATE INDEX ON player_stats(slg);
CREATE INDEX ON player_stats(ops);
CREATE INDEX ON player_stats(babip);

-- Pitching counting stats
CREATE INDEX ON player_stats(wins);
CREATE INDEX ON player_stats(losses);
CREATE INDEX ON player_stats(strikeouts);
CREATE INDEX ON player_stats(walks);
CREATE INDEX ON player_stats(hit_batters);
CREATE INDEX ON player_stats(shutouts);
CREATE INDEX ON player_stats(quality_starts);
CREATE INDEX ON player_stats(saves);
CREATE INDEX ON player_stats(innings_pitched);

-- Pitching derived
CREATE INDEX ON player_stats(era);
CREATE INDEX ON player_stats(whip);
CREATE INDEX ON player_stats(k9);
CREATE INDEX ON player_stats(bb9);
CREATE INDEX ON player_stats(h9);
CREATE INDEX ON player_stats(hr9);

-- Defense
CREATE INDEX ON player_stats(rcs_pct);

-- Attributes (all of them, for the selflessness sickos)
CREATE INDEX ON player_attributes(discipline);
CREATE INDEX ON player_attributes(vision);
CREATE INDEX ON player_attributes(intimidation);
CREATE INDEX ON player_attributes(muscle);
CREATE INDEX ON player_attributes(contact);
CREATE INDEX ON player_attributes(cunning);
CREATE INDEX ON player_attributes(selflessness);
CREATE INDEX ON player_attributes(determination);
CREATE INDEX ON player_attributes(wisdom);
CREATE INDEX ON player_attributes(insight);
CREATE INDEX ON player_attributes(aiming);
CREATE INDEX ON player_attributes(lift);
CREATE INDEX ON player_attributes(control);
CREATE INDEX ON player_attributes(velocity);
CREATE INDEX ON player_attributes(rotation);
CREATE INDEX ON player_attributes(stuff);
CREATE INDEX ON player_attributes(deception);
CREATE INDEX ON player_attributes(intuition);
CREATE INDEX ON player_attributes(persuasion);
CREATE INDEX ON player_attributes(presence);
CREATE INDEX ON player_attributes(defiance);
CREATE INDEX ON player_attributes(accuracy);
CREATE INDEX ON player_attributes(stamina);
CREATE INDEX ON player_attributes(guts);
CREATE INDEX ON player_attributes(performance);
CREATE INDEX ON player_attributes(speed);
CREATE INDEX ON player_attributes(greed);
CREATE INDEX ON player_attributes(stealth);
CREATE INDEX ON player_attributes(arm);
CREATE INDEX ON player_attributes(dexterity);
CREATE INDEX ON player_attributes(reaction);
CREATE INDEX ON player_attributes(acrobatics);
CREATE INDEX ON player_attributes(agility);
CREATE INDEX ON player_attributes(patience);
CREATE INDEX ON player_attributes(awareness);
CREATE INDEX ON player_attributes(composure);
CREATE INDEX ON player_attributes(luck);