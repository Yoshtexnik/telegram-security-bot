from __future__ import annotations

import asyncio
import logging

from aiogram import executor

from security_bot.bot.config import settings
from security_bot.bot.loader import bot, dp
from security_bot.bot.database.db import init_db
from security_bot.bot.handlers import admin, documents, messages, photos

logger = logging.getLogger("security_bot")


async def on_startup(_dp):
    await init_db()
    logger.info("Bot startup complete")


async def on_shutdown(_dp):
    logger.info("Bot shutdown complete")


def main() -> None:
    executor.start_polling(dp, on_startup=on_startup, on_shutdown=on_shutdown)


if __name__ == "__main__":
    main()
