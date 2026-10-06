# Telegram Security Bot

A production-oriented Telegram moderation bot for defensive cybersecurity scanning in group chats.

## Features

- NSFW image detection with threshold-based moderation
- APK static analysis without execution
- Dangerous executable detection
- URL phishing and malware domain heuristics
- Redis-backed spam/flood protection
- PostgreSQL storage for violations and scan results
- Admin moderation commands and security panel
- Safe file handling with temporary directories and cleanup

## Quick start

1. Copy `.env.example` to `.env` and update values.
2. Run:

   ```bash
   docker compose up --build
   ```

3. Add the bot token from BotFather and configure admin IDs.

## BotFather setup

1. Open Telegram and message @BotFather.
2. Run `/newbot`.
3. Set a bot username and receive the API token.
4. Paste the token into `BOT_TOKEN` in `.env`.
5. Configure the bot for group privacy as needed.

## Admin setup

1. Start the bot and message `/start`.
2. Use `/status` and `/settings`.
3. Add `ADMIN_IDS` in `.env` with your Telegram user IDs.
4. Set the moderation thresholds in `.env`.

## Security notes

- The bot never executes APK, EXE, BAT, MSI, JAR, or other uploaded files.
- Uploaded files are scanned only statically.
- Temporary files are removed immediately after use.
- VirusTotal uploads are disabled by default unless explicitly enabled.

## License

MIT
