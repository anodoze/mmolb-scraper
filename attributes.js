const BOON_EFFECTS = {
  'Navigator':       { Control: 0.25,      Rotation: -0.1 },
  'Director':        { Control: 0.25,      Accuracy: -0.1 },
  'Clockwork':       { Control: 0.25,      Stamina: -0.1 },
  'Angelic':         { Control: 0.25,      Presence: -0.1 },
  'Softballer':      { Stuff: 0.25,        Rotation: -0.1 },
  'Venomous':        { Stuff: 0.25,        Persuasion: -0.1 },
  'Hextouch':        { Stuff: 0.25,        Stamina: -0.1 },
  'Miasma':          { Stuff: 0.25,        Presence: -0.1 },
  'Meteor':          { Velocity: 0.25,     Accuracy: -0.1 },
  'Cyclist':         { Velocity: 0.25,     Deception: -0.1 },
  'Afterburner':     { Velocity: 0.25,     Stuff: -0.1 },
  'Stormrider':      { Velocity: 0.25,     Control: -0.1 },
  'Majestic':        { Presence: 0.25,     Accuracy: -0.1 },
  'Spotlight':       { Presence: 0.25,     Intuition: -0.1 },
  'Beacon':          { Presence: 0.25,     Control: -0.1 },
  'Headliner':       { Presence: 0.25,     Velocity: -0.1 },
  'Weaver':          { Deception: 0.25,    Stuff: -0.1 },
  'Disguised':       { Deception: 0.25,    Velocity: -0.1 },
  'Gambit':          { Deception: 0.25,    Rotation: -0.1 },
  'Confused':        { Deception: 0.25,    Accuracy: -0.1 },
  'Wheel':           { Rotation: 0.25,     Stuff: -0.1 },
  'Shopper':         { Rotation: 0.25,     Persuasion: -0.1 },
  'Geometry Expert': { Rotation: 0.25,     Stamina: -0.1 },
  'Cyclone':         { Rotation: 0.25,     Presence: -0.1 },
  'Battery':         { Stamina: 0.25,      Rotation: -0.1 },
  'Tireless':        { Stamina: 0.25,      Guts: -0.1 },
  'Second Wind':     { Stamina: 0.25,      Accuracy: -0.1 },
  'Hardy':           { Stamina: 0.25,      Velocity: -0.1 },
  'Lionheart':       { Guts: 0.25,         Accuracy: -0.1 },
  'Ill':             { Guts: 0.25,         Deception: -0.1 },
  'Tenacious Badger':{ Guts: 0.25,         Intuition: -0.1 },
  'Stoneskin':       { Guts: 0.25,         Control: -0.1 },
  'Accountant':      { Accuracy: 0.25,     Persuasion: -0.1 },
  'Pinpoint':        { Accuracy: 0.25,     Velocity: -0.1 },
  'Quarterback':     { Accuracy: 0.25,     Control: -0.1 },
  'ROBO':            { Accuracy: 0.25,     Deception: -0.1 },
  'Peacebroker':     { Persuasion: 0.25,   Defiance: -0.1 },
  'Ambassador':      { Persuasion: 0.25,   Guts: -0.1 },
  'Orator':          { Persuasion: 0.25,   Velocity: -0.1 },
  'Courier':         { Persuasion: 0.25,   Stuff: -0.1 },
  'Elvish':          { Intuition: 0.25,    Persuasion: -0.1 },
  'Psychic':         { Intuition: 0.25,    Rotation: -0.1 },
  'Feral Sense':     { Intuition: 0.25,    Stamina: -0.1 },
  'Seer':            { Intuition: 0.25,    Presence: -0.1 },
  'Stonewall':       { Defiance: 0.25,     Intuition: -0.1 },
  'Anchor':          { Defiance: 0.25,     Accuracy: -0.1 },
  'Wildcard':        { Defiance: 0.25,     Deception: -0.1 },
  'Demonic':         { Defiance: 0.25,     Control: -0.1 },
  'Arachnid':        { Intimidation: 0.25, Vision: -0.1 },
  'Giant':           { Intimidation: 0.25, Insight: -0.1 },
  'Ogre':            { Intimidation: 0.25, Wisdom: -0.1 },
  'Tusked':          { Intimidation: 0.25, Performance: -0.1 },
  'Bulwark':         { Determination: 0.25,Selflessness: -0.1 },
  'Ironclad':        { Determination: 0.25,Greed: -0.1 },
  'Earth Elemental': { Determination: 0.25,Stealth: -0.1 },
  'Undead':          { Determination: 0.25,Speed: -0.1 },
  'Calculated':      { Discipline: 0.25,   Cunning: -0.1 },
  'Clean':           { Discipline: 0.25,   Determination: -0.1 },
  'Metronome':       { Discipline: 0.25,   Contact: -0.1 },
  'Snowperson':      { Discipline: 0.25,   Aiming: -0.1 },
  'Fire Elemental':  { Lift: 0.25,         Selflessness: -0.1 },
  'UFO':             { Lift: 0.25,         Greed: -0.1 },
  'Kite':            { Lift: 0.25,         Stealth: -0.1 },
  'Caped':           { Lift: 0.25,         Vision: -0.1 },
  'Granite':         { Muscle: 0.25,       Determination: -0.1 },
  'Gorilla':         { Muscle: 0.25,       Cunning: -0.1 },
  'Draconic':        { Muscle: 0.25,       Aiming: -0.1 },
  'Titan':           { Muscle: 0.25,       Contact: -0.1 },
  'Deadeye':         { Aiming: 0.25,       Determination: -0.1 },
  "Archer's Mark":   { Aiming: 0.25,       Discipline: -0.1 },
  'Air Elemental':   { Aiming: 0.25,       Contact: -0.1 },
  'Eagle-eye':       { Aiming: 0.25,       Cunning: -0.1 },
  'Amphibian':       { Performance: 0.25,  Aiming: -0.1 },
  'Mischievous':     { Performance: 0.25,  Stealth: -0.1 },
  'Thoroughbred':    { Performance: 0.25,  Cunning: -0.1 },
  'Playful':         { Performance: 0.25,  Muscle: -0.1 },
  'Horizon':         { Vision: 0.25,       Wisdom: -0.1 },
  'Satellite':       { Vision: 0.25,       Muscle: -0.1 },
  'Shiny':           { Vision: 0.25,       Performance: -0.1 },
  'The Light':       { Vision: 0.25,       Speed: -0.1 },
  'Grounded':        { Contact: 0.25,      Lift: -0.1 },
  'Sweet Tooth':     { Contact: 0.25,      Aiming: -0.1 },
  'Water Elemental': { Contact: 0.25,      Intimidation: -0.1 },
  'One With All':    { Contact: 0.25,      Muscle: -0.1 },
  'Charger':         { Speed: 0.25,        Insight: -0.1 },
  'Leaf':            { Speed: 0.25,        Intimidation: -0.1 },
  'Marathoner':      { Speed: 0.25,        Lift: -0.1 },
  'Scooter':         { Speed: 0.25,        Discipline: -0.1 },
  'Wise':            { Wisdom: 0.25,       Greed: -0.1 },
  'Analyst':         { Wisdom: 0.25,       Selflessness: -0.1 },
  'Mer':             { Wisdom: 0.25,       Stealth: -0.1 },
  'Sage':            { Wisdom: 0.25,       Vision: -0.1 },
  'Observer':        { Insight: 0.25,      Muscle: -0.1 },
  'Stargazer':       { Insight: 0.25,      Discipline: -0.1 },
  'Striker':         { Insight: 0.25,      Lift: -0.1 },
  'Techie':          { Insight: 0.25,      Intimidation: -0.1 },
  'Vampiric':        { Cunning: 0.25,      Vision: -0.1 },
  'Fae':             { Cunning: 0.25,      Discipline: -0.1 },
  'Insectoid':       { Cunning: 0.25,      Determination: -0.1 },
  'Sneaky':          { Cunning: 0.25,      Intimidation: -0.1 },
  'Holey':           { Stealth: 0.25,      Greed: -0.1 },
  'Needle':          { Stealth: 0.25,      Aiming: -0.1 },
  'Night Owl':       { Stealth: 0.25,      Speed: -0.1 },
  'Spectral':        { Stealth: 0.25,      Contact: -0.1 },
  'Guardian':        { Selflessness: 0.25, Intimidation: -0.1 },
  'Kind':            { Selflessness: 0.25, Discipline: -0.1 },
  'Loyal':           { Selflessness: 0.25, Insight: -0.1 },
  'Wingmate':        { Selflessness: 0.25, Lift: -0.1 },
  'Magnetic':        { Greed: 0.25,        Performance: -0.1 },
  'Excavator':       { Greed: 0.25,        Muscle: -0.1 },
  'Thief':           { Greed: 0.25,        Wisdom: -0.1 },
  'Treasure Map':    { Greed: 0.25,        Vision: -0.1 },
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