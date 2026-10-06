# SQL schema for PostgreSQL

CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    telegram_user_id BIGINT UNIQUE NOT NULL,
    username TEXT,
    first_name TEXT,
    last_name TEXT,
    is_bot BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    last_seen_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS groups (
    id BIGSERIAL PRIMARY KEY,
    chat_id BIGINT UNIQUE NOT NULL,
    title TEXT,
    username TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS admins (
    id BIGSERIAL PRIMARY KEY,
    telegram_user_id BIGINT UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS moderation_settings (
    id BIGSERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    nsfw_enabled BOOLEAN DEFAULT TRUE,
    apk_enabled BOOLEAN DEFAULT TRUE,
    url_enabled BOOLEAN DEFAULT TRUE,
    spam_enabled BOOLEAN DEFAULT TRUE,
    delete_unknown BOOLEAN DEFAULT FALSE,
    delete_threshold DOUBLE PRECISION DEFAULT 0.90,
    warn_threshold DOUBLE PRECISION DEFAULT 0.75,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS violations (
    id BIGSERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    message_id BIGINT,
    violation_type TEXT NOT NULL,
    severity TEXT NOT NULL,
    confidence DOUBLE PRECISION DEFAULT 0.0,
    action TEXT NOT NULL,
    details_json JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS scan_results (
    id BIGSERIAL PRIMARY KEY,
    file_hash TEXT,
    file_type TEXT,
    scanner TEXT,
    result TEXT,
    risk TEXT,
    details_json JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_telegram_user_id ON users (telegram_user_id);
CREATE INDEX IF NOT EXISTS idx_groups_chat_id ON groups (chat_id);
CREATE INDEX IF NOT EXISTS idx_violations_chat_id ON violations (chat_id);
CREATE INDEX IF NOT EXISTS idx_scan_results_hash ON scan_results (file_hash);
