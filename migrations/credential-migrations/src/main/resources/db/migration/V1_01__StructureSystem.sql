CREATE SCHEMA IF NOT EXISTS credential;

DROP TABLE IF EXISTS credential.users;

CREATE TABLE credential.users (
    id                     BIGINT NOT NULL,
    display_name           VARCHAR(256),
    user_name              VARCHAR(256),
    normalized_user_name   VARCHAR(256),
    email                  VARCHAR(256),
    normalized_email       VARCHAR(256),
    email_confirmed        BOOLEAN NOT NULL,
    password_hash          TEXT,
    security_stamp         TEXT,
    concurrency_stamp      TEXT,
    phone_number           TEXT,
    phone_number_confirmed BOOLEAN NOT NULL,
    two_factor_enabled     BOOLEAN NOT NULL,
    lockout_end            TIMESTAMPTZ(6),
    lockout_enabled        BOOLEAN NOT NULL,
    access_failed_count    INT4 NOT NULL,
    CONSTRAINT p_k_asp_net_users PRIMARY KEY (id)
);

-- Indexes
CREATE UNIQUE INDEX IX_users_email ON credential.users (email);
CREATE INDEX email_index ON credential.users (normalized_email);
CREATE UNIQUE INDEX user_name_index ON credential.users (normalized_user_name);
