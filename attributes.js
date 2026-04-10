const BOON_EFFECTS = {
  'Navigator':       { Control: 0.5,      Rotation: -0.5 },
  'Director':        { Control: 0.5,      Accuracy: -0.5 },
  'Clockwork':       { Control: 0.5,      Stamina: -0.5 },
  'Angelic':         { Control: 0.5,      Presence: -0.5 },
  'Softballer':      { Stuff: 0.5,        Rotation: -0.5 },
  'Venomous':        { Stuff: 0.5,        Persuasion: -0.5 },
  'Hextouch':        { Stuff: 0.5,        Stamina: -0.5 },
  'Miasma':          { Stuff: 0.5,        Presence: -0.5 },
  'Meteor':          { Velocity: 0.5,     Accuracy: -0.5 },
  'Cyclist':         { Velocity: 0.5,     Deception: -0.5 },
  'Afterburner':     { Velocity: 0.5,     Stuff: -0.5 },
  'Stormrider':      { Velocity: 0.5,     Control: -0.5 },
  'Majestic':        { Presence: 0.5,     Accuracy: -0.5 },
  'Spotlight':       { Presence: 0.5,     Intuition: -0.5 },
  'Beacon':          { Presence: 0.5,     Control: -0.5 },
  'Headliner':       { Presence: 0.5,     Velocity: -0.5 },
  'Weaver':          { Deception: 0.5,    Stuff: -0.5 },
  'Disguised':       { Deception: 0.5,    Velocity: -0.5 },
  'Gambit':          { Deception: 0.5,    Rotation: -0.5 },
  'Confused':        { Deception: 0.5,    Accuracy: -0.5 },
  'Wheel':           { Rotation: 0.5,     Stuff: -0.5 },
  'Shopper':         { Rotation: 0.5,     Persuasion: -0.5 },
  'Geometry Expert': { Rotation: 0.5,     Stamina: -0.5 },
  'Cyclone':         { Rotation: 0.5,     Presence: -0.5 },
  'Battery':         { Stamina: 0.5,      Rotation: -0.5 },
  'Tireless':        { Stamina: 0.5,      Guts: -0.5 },
  'Second Wind':     { Stamina: 0.5,      Accuracy: -0.5 },
  'Hardy':           { Stamina: 0.5,      Velocity: -0.5 },
  'Lionheart':       { Guts: 0.5,         Accuracy: -0.5 },
  'Ill':             { Guts: 0.5,         Deception: -0.5 },
  'Tenacious Badger':{ Guts: 0.5,         Intuition: -0.5 },
  'Stoneskin':       { Guts: 0.5,         Control: -0.5 },
  'Accountant':      { Accuracy: 0.5,     Persuasion: -0.5 },
  'Pinpoint':        { Accuracy: 0.5,     Velocity: -0.5 },
  'Quarterback':     { Accuracy: 0.5,     Control: -0.5 },
  'ROBO':            { Accuracy: 0.5,     Deception: -0.5 },
  'Peacebroker':     { Persuasion: 0.5,   Defiance: -0.5 },
  'Ambassador':      { Persuasion: 0.5,   Guts: -0.5 },
  'Orator':          { Persuasion: 0.5,   Velocity: -0.5 },
  'Courier':         { Persuasion: 0.5,   Stuff: -0.5 },
  'Elvish':          { Intuition: 0.5,    Persuasion: -0.5 },
  'Psychic':         { Intuition: 0.5,    Rotation: -0.5 },
  'Feral Sense':     { Intuition: 0.5,    Stamina: -0.5 },
  'Seer':            { Intuition: 0.5,    Presence: -0.5 },
  'Stonewall':       { Defiance: 0.5,     Intuition: -0.5 },
  'Anchor':          { Defiance: 0.5,     Accuracy: -0.5 },
  'Wildcard':        { Defiance: 0.5,     Deception: -0.5 },
  'Demonic':         { Defiance: 0.5,     Control: -0.5 },
  'Arachnid':        { Intimidation: 0.5, Vision: -0.5 },
  'Giant':           { Intimidation: 0.5, Insight: -0.5 },
  'Ogre':            { Intimidation: 0.5, Wisdom: -0.5 },
  'Tusked':          { Intimidation: 0.5, Performance: -0.5 },
  'Bulwark':         { Determination: 0.5,Selflessness: -0.5 },
  'Ironclad':        { Determination: 0.5,Greed: -0.5 },
  'Earth Elemental': { Determination: 0.5,Stealth: -0.5 },
  'Undead':          { Determination: 0.5,Speed: -0.5 },
  'Calculated':      { Discipline: 0.5,   Cunning: -0.5 },
  'Clean':           { Discipline: 0.5,   Determination: -0.5 },
  'Metronome':       { Discipline: 0.5,   Contact: -0.5 },
  'Snowperson':      { Discipline: 0.5,   Aiming: -0.5 },
  'Fire Elemental':  { Lift: 0.5,         Selflessness: -0.5 },
  'UFO':             { Lift: 0.5,         Greed: -0.5 },
  'Kite':            { Lift: 0.5,         Stealth: -0.5 },
  'Caped':           { Lift: 0.5,         Vision: -0.5 },
  'Granite':         { Muscle: 0.5,       Determination: -0.5 },
  'Gorilla':         { Muscle: 0.5,       Cunning: -0.5 },
  'Draconic':        { Muscle: 0.5,       Aiming: -0.5 },
  'Titan':           { Muscle: 0.5,       Contact: -0.5 },
  'Deadeye':         { Aiming: 0.5,       Determination: -0.5 },
  "Archer's Mark":   { Aiming: 0.5,       Discipline: -0.5 },
  'Air Elemental':   { Aiming: 0.5,       Contact: -0.5 },
  'Eagle-eye':       { Aiming: 0.5,       Cunning: -0.5 },
  'Amphibian':       { Performance: 0.5,  Aiming: -0.5 },
  'Mischievous':     { Performance: 0.5,  Stealth: -0.5 },
  'Thoroughbred':    { Performance: 0.5,  Cunning: -0.5 },
  'Playful':         { Performance: 0.5,  Muscle: -0.5 },
  'Horizon':         { Vision: 0.5,       Wisdom: -0.5 },
  'Satellite':       { Vision: 0.5,       Muscle: -0.5 },
  'Shiny':           { Vision: 0.5,       Performance: -0.5 },
  'The Light':       { Vision: 0.5,       Speed: -0.5 },
  'Grounded':        { Contact: 0.5,      Lift: -0.5 },
  'Sweet Tooth':     { Contact: 0.5,      Aiming: -0.5 },
  'Water Elemental': { Contact: 0.5,      Intimidation: -0.5 },
  'One With All':    { Contact: 0.5,      Muscle: -0.5 },
  'Charger':         { Speed: 0.5,        Insight: -0.5 },
  'Leaf':            { Speed: 0.5,        Intimidation: -0.5 },
  'Marathoner':      { Speed: 0.5,        Lift: -0.5 },
  'Scooter':         { Speed: 0.5,        Discipline: -0.5 },
  'Wise':            { Wisdom: 0.5,       Greed: -0.5 },
  'Analyst':         { Wisdom: 0.5,       Selflessness: -0.5 },
  'Mer':             { Wisdom: 0.5,       Stealth: -0.5 },
  'Sage':            { Wisdom: 0.5,       Vision: -0.5 },
  'Observer':        { Insight: 0.5,      Muscle: -0.5 },
  'Stargazer':       { Insight: 0.5,      Discipline: -0.5 },
  'Striker':         { Insight: 0.5,      Lift: -0.5 },
  'Techie':          { Insight: 0.5,      Intimidation: -0.5 },
  'Vampiric':        { Cunning: 0.5,      Vision: -0.5 },
  'Fae':             { Cunning: 0.5,      Discipline: -0.5 },
  'Insectoid':       { Cunning: 0.5,      Determination: -0.5 },
  'Sneaky':          { Cunning: 0.5,      Intimidation: -0.5 },
  'Holey':           { Stealth: 0.5,      Greed: -0.5 },
  'Needle':          { Stealth: 0.5,      Aiming: -0.5 },
  'Night Owl':       { Stealth: 0.5,      Speed: -0.5 },
  'Spectral':        { Stealth: 0.5,      Contact: -0.5 },
  'Guardian':        { Selflessness: 0.5, Intimidation: -0.5 },
  'Kind':            { Selflessness: 0.5, Discipline: -0.5 },
  'Loyal':           { Selflessness: 0.5, Insight: -0.5 },
  'Wingmate':        { Selflessness: 0.5, Lift: -0.5 },
  'Magnetic':        { Greed: 0.5,        Performance: -0.5 },
  'Excavator':       { Greed: 0.5,        Muscle: -0.5 },
  'Thief':           { Greed: 0.5,        Wisdom: -0.5 },
  'Treasure Map':    { Greed: 0.5,        Vision: -0.5 },
};

const ALL_ATTRIBUTES = [
  'Aiming','Contact','Cunning','Determination','Discipline',
  'Insight','Intimidation','Lift','Muscle','Selflessness','Vision','Wisdom',
  'Greed','Performance','Speed','Stealth',
  'Acrobatics','Agility','Arm','Awareness','Composure','Dexterity','Patience','Reaction', 'Luck',
  'Accuracy','Control','Defiance','Deception','Guts',
  'Intuition','Persuasion','Presence','Rotation','Stamina','Stuff','Velocity',
];

export function computeAttributes(player) {
  const flatBase  = Object.fromEntries(ALL_ATTRIBUTES.map(a => [a, 0]));
  const flatEquip = Object.fromEntries(ALL_ATTRIBUTES.map(a => [a, 0]));
  const flatAugment = Object.fromEntries(ALL_ATTRIBUTES.map(a => [a, 0]));
  const multEquip = Object.fromEntries(ALL_ATTRIBUTES.map(a => [a, 0]));
  const multBoon  = Object.fromEntries(ALL_ATTRIBUTES.map(a => [a, 0]));

  // Base bonuses (generation + level ups)
  for (const bonus of (player.BaseAttributeBonuses ?? [])) {
    if (flatBase[bonus.attribute] !== undefined)
      flatBase[bonus.attribute] += bonus.amount;
  }

  // Augments
  for (const augment of (player.AugmentHistory ?? [])) {
    if (flatAugment[augment.attribute] !== undefined)
      flatAugment[augment.attribute] += augment.amount;
  }

  // Equipment
  for (const slot of Object.values(player.Equipment ?? {})) {
    if (!slot) continue;
    for (const effect of (slot.Effects ?? [])) {
      const attr = effect.Attribute;
      if (flatEquip[attr] === undefined) continue;
      if (effect.Type === 'FlatBonus')     flatEquip[attr] += effect.Value;
      else if (effect.Type === 'Multiplier') multEquip[attr] += effect.Value;
    }
  }

  // Boons
  const boons = player.LesserBoon ?? [];
  for (const boon of boons) {
    const effects = BOON_EFFECTS[boon.Name];
    if (!effects) continue;
    for (const [attr, delta] of Object.entries(effects)) {
      if (multBoon[attr] !== undefined) multBoon[attr] += delta;
    }
  }

  const results = {};

  for (const attr of ALL_ATTRIBUTES) {
    const fBase    = flatBase[attr];
    const fEquip   = flatEquip[attr];
    const fAugment = flatAugment[attr];
    const fTotal   = fBase + fEquip + fAugment;
    const mEquip   = multEquip[attr];
    const mBoon    = multBoon[attr];
    const mTotal   = mEquip + mBoon;

    const multBonus  = fTotal * mTotal;
    const equipShare = mTotal !== 0 ? mEquip / mTotal : 0;

    results[attr] = {
      baseValue:    fBase,
      augmentBonus: fAugment,
      equipBonus:   fEquip + multBonus * equipShare,
      boonBonus:    multBonus * (1 - equipShare),
      total:        fTotal + multBonus,
    };
  }

  return results;
}

// Extract just the totals for player_attributes table
// Keys lowercased to match DB column names
export function attributeTotals(computedAttributes) {
  return Object.fromEntries(
    Object.entries(computedAttributes).map(([attr, result]) => [
      attr.toLowerCase(),
      result.total,
    ])
  );
}