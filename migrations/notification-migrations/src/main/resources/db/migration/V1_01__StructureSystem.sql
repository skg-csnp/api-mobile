CREATE SCHEMA IF NOT EXISTS notification;

DROP TABLE IF EXISTS notification.email_logs;
CREATE TABLE notification.email_logs (
    id             BIGINT         NOT NULL,
    "to"           VARCHAR(256)   NOT NULL,
    subject        VARCHAR(500)   NOT NULL,
    body           TEXT           NOT NULL,
    sent_at        TIMESTAMPTZ(6) NOT NULL,
    is_success     BOOLEAN        NOT NULL,
    error_message  VARCHAR(1000),
    correlation_id VARCHAR(100)   NOT NULL,
    CONSTRAINT p_k_email_logs PRIMARY KEY (id)
);
