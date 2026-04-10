export const API_BASE = 'https://mmolb.com/api';

export const LESSER_LEAGUES = [
  { id: '6805db0cac48194de3cd3ff4', name: 'Amphibian',    emoji: '🐸',  color: '5b9340', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fe7', name: 'Baseball',     emoji: '⚾️',  color: '47678e', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fe8', name: 'Precision',    emoji: '🎯',  color: '507d45', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fe9', name: 'Isosceles',    emoji: '🔺',  color: '7c65a3', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fea', name: 'Liberty',      emoji: '🗽',  color: '2e768d', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3feb', name: 'Maple',        emoji: '🍁',  color: 'a13e33', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fec', name: 'Cricket',      emoji: '🦗',  color: '4a8546', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fed', name: 'Tornado',      emoji: '🌪️',  color: '5a5e6e', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fee', name: 'Coleoptera',   emoji: '🪲',  color: '3f624d', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3fef', name: 'Clean',        emoji: '🧼',  color: '88b9ba', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3ff0', name: 'Shiny',        emoji: '✨',  color: 'e0d95a', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3ff1', name: 'Psychic',      emoji: '🔮',  color: '734d92', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3ff2', name: 'Unidentified', emoji: '❓',  color: '6c6c6c', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3ff3', name: 'Ghastly',      emoji: '👻',  color: '5b4b62', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3ff5', name: 'Deep',         emoji: '🌊',  color: '1a3a4f', league_type: 'Lesser' },
  { id: '6805db0cac48194de3cd3ff6', name: 'Harmony',      emoji: '🎵',  color: '659b87', league_type: 'Lesser' },
];

export const GREATER_LEAGUES = [
  { id: '6805db0cac48194de3cd3fe4', name: 'Clover',    emoji: '☘️',  color: '39993a', league_type: 'Greater' },
  { id: '6805db0cac48194de3cd3fe5', name: 'Pineapple', emoji: '🍍',  color: 'feea63', league_type: 'Greater' },
];

export const ALL_LEAGUES = [...LESSER_LEAGUES, ...GREATER_LEAGUES];

export const MIN_GAMES_PLAYED = 1;