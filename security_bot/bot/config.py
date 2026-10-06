from __future__ import annotations

import os
from pathlib import Path

from pydantic import Field
from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    BOT_TOKEN: str = Field(..., env='BOT_TOKEN')
    ADMIN_IDS: str = Field(default='123456789', env='ADMIN_IDS')
    BOT_USERNAME: str = Field(default='securitymoderatorbot', env='BOT_USERNAME')
    REDIS_URL: str = Field(default='redis://localhost:6379/0', env='REDIS_URL')
    DATABASE_URL: str = Field(default='postgresql://postgres:postgres@localhost:5432/security_bot', env='DATABASE_URL')
    LOG_LEVEL: str = Field(default='INFO', env='LOG_LEVEL')

    NSFW_DELETE_THRESHOLD: float = Field(default=0.90, env='NSFW_DELETE_THRESHOLD')
    NSFW_WARN_THRESHOLD: float = Field(default=0.75, env='NSFW_WARN_THRESHOLD')
    FLOOD_LIMIT: int = Field(default=8, env='FLOOD_LIMIT')
    FLOOD_WINDOW_SECONDS: int = Field(default=10, env='FLOOD_WINDOW_SECONDS')
    MAX_FILE_SIZE_MB: int = Field(default=25, env='MAX_FILE_SIZE_MB')
    TEMP_ROOT: str = Field(default='/tmp/security_bot', env='TEMP_ROOT')

    VIRUSTOTAL_API_KEY: str = Field(default='', env='VIRUSTOTAL_API_KEY')
    VIRUSTOTAL_UPLOAD_UNKNOWN: bool = Field(default=False, env='VIRUSTOTAL_UPLOAD_UNKNOWN')

    APP_MODE: str = Field(default='prod', env='APP_MODE')

    @property
    def admin_ids(self) -> set[int]:
        return {int(item.strip()) for item in self.ADMIN_IDS.split(',') if item.strip()}

    @property
    def temp_dir(self) -> Path:
        path = Path(self.TEMP_ROOT)
        path.mkdir(parents=True, exist_ok=True)
        return path


settings = Settings()
