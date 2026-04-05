import { appendFile, mkdir } from 'fs/promises';
import { join } from 'path';

const LOG_DIR = './logs';
const LOG_FILE = join(LOG_DIR, 'scraper.log');

async function ensureLogDir() {
  await mkdir(LOG_DIR, { recursive: true });
}

function timestamp() {
  return new Date().toISOString();
}

function formatLine(level, message) {
  return `[${timestamp()}] [${level}] ${message}\n`;
}

async function write(level, message) {
  const line = formatLine(level, message);
  process.stdout.write(line);
  try {
    await appendFile(LOG_FILE, line);
  } catch {
    // if we can't write to the log file, at least we wrote to stdout
  }
}

await ensureLogDir();

export const logger = {
  info:  (msg) => write('INFO',  msg),
  warn:  (msg) => write('WARN',  msg),
  error: (msg) => write('ERROR', msg),
};