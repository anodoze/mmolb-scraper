CREATE MATERIALIZED VIEW mv_attribute_leaderboard AS
WITH unpivoted AS (
  SELECT
    pa.player_id,
    p.first_name, p.last_name, p.suffix, p.position,
    t.name AS team_name, t.location AS team_location, t.id AS team_id, t.emoji AS team_emoji,
    attr_name, attr_value
  FROM player_attributes pa
  JOIN players p ON pa.player_id = p.id
  JOIN teams t   ON p.team_id = t.id
  CROSS JOIN LATERAL (VALUES
    ('Discipline',    pa.discipline),
    ('Vision',        pa.vision),
    ('Intimidation',  pa.intimidation),
    ('Muscle',        pa.muscle),
    ('Contact',       pa.contact),
    ('Cunning',       pa.cunning),
    ('Selflessness',  pa.selflessness),
    ('Determination', pa.determination),
    ('Wisdom',        pa.wisdom),
    ('Insight',       pa.insight),
    ('Aiming',        pa.aiming),
    ('Lift',          pa.lift),
    ('Control',       pa.control),
    ('Velocity',      pa.velocity),
    ('Rotation',      pa.rotation),
    ('Stuff',         pa.stuff),
    ('Deception',     pa.deception),
    ('Intuition',     pa.intuition),
    ('Persuasion',    pa.persuasion),
    ('Presence',      pa.presence),
    ('Defiance',      pa.defiance),
    ('Accuracy',      pa.accuracy),
    ('Stamina',       pa.stamina),
    ('Guts',          pa.guts),
    ('Performance',   pa.performance),
    ('Speed',         pa.speed),
    ('Greed',         pa.greed),
    ('Stealth',       pa.stealth),
    ('Arm',           pa.arm),
    ('Dexterity',     pa.dexterity),
    ('Reaction',      pa.reaction),
    ('Acrobatics',    pa.acrobatics),
    ('Agility',       pa.agility),
    ('Patience',      pa.patience),
    ('Awareness',     pa.awareness),
    ('Composure',     pa.composure),
    ('Luck',          pa.luck)
  ) AS a(attr_name, attr_value)
),

ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY attr_name ORDER BY attr_value DESC NULLS LAST) AS rank_overall
  FROM unpivoted
)

SELECT * FROM ranked WHERE rank_overall <= 10;

CREATE UNIQUE INDEX ON mv_attribute_leaderboard (player_id, attr_name);

-- REFRESH MATERIALIZED VIEW CONCURRENTLY mv_attribute_leaderboard;