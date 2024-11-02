#!/bin/sh
set -e

CONFIG_FILE="/tmp/supertokens-config.yml"

# Create base config
cat << EOF > $CONFIG_FILE
core_config_version: 0
postgresql_config_version: 0
host: 0.0.0.0
EOF

# Ensure we have write permissions
if [ ! -w "$CONFIG_FILE" ]; then
    echo "Cannot write to $CONFIG_FILE"
    exit 1
fi

# Handle password file if it exists
if [ ! -z "$POSTGRESQL_PASSWORD_FILE" ]; then
    if [ ! -r "$POSTGRESQL_PASSWORD_FILE" ]; then
        echo "Cannot read password file"
        exit 1
    fi
    POSTGRESQL_PASSWORD=$(cat "$POSTGRESQL_PASSWORD_FILE")
fi

# Function to safely append to config
append_config() {
    if ! echo "$1" >> "$CONFIG_FILE"; then
        echo "Failed to append to config file"
        exit 1
    fi
}

# Core config
[ ! -z "$SUPERTOKENS_PORT" ] && append_config "port: $SUPERTOKENS_PORT"
[ ! -z "$ACCESS_TOKEN_VALIDITY" ] && append_config "access_token_validity: $ACCESS_TOKEN_VALIDITY"
[ ! -z "$ACCESS_TOKEN_BLACKLISTING" ] && append_config "access_token_blacklisting: $ACCESS_TOKEN_BLACKLISTING"
[ ! -z "$ACCESS_TOKEN_SIGNING_KEY_DYNAMIC" ] && append_config "access_token_signing_key_dynamic: $ACCESS_TOKEN_SIGNING_KEY_DYNAMIC"
[ ! -z "$ACCESS_TOKEN_DYNAMIC_SIGNING_KEY_UPDATE_INTERVAL" ] && append_config "access_token_dynamic_signing_key_update_interval: $ACCESS_TOKEN_DYNAMIC_SIGNING_KEY_UPDATE_INTERVAL"
[ ! -z "$REFRESH_TOKEN_VALIDITY" ] && append_config "refresh_token_validity: $REFRESH_TOKEN_VALIDITY"
[ ! -z "$PASSWORD_RESET_TOKEN_LIFETIME" ] && append_config "password_reset_token_lifetime: $PASSWORD_RESET_TOKEN_LIFETIME"
[ ! -z "$EMAIL_VERIFICATION_TOKEN_LIFETIME" ] && append_config "email_verification_token_lifetime: $EMAIL_VERIFICATION_TOKEN_LIFETIME"
[ ! -z "$PASSWORDLESS_MAX_CODE_INPUT_ATTEMPTS" ] && append_config "passwordless_max_code_input_attempts: $PASSWORDLESS_MAX_CODE_INPUT_ATTEMPTS"
[ ! -z "$PASSWORDLESS_CODE_LIFETIME" ] && append_config "passwordless_code_lifetime: $PASSWORDLESS_CODE_LIFETIME"
[ ! -z "$TOTP_MAX_ATTEMPTS" ] && append_config "totp_max_attempts: $TOTP_MAX_ATTEMPTS"
[ ! -z "$TOTP_RATE_LIMIT_COOLDOWN_SEC" ] && append_config "totp_rate_limit_cooldown_sec: $TOTP_RATE_LIMIT_COOLDOWN_SEC"
[ ! -z "$INFO_LOG_PATH" ] && append_config "info_log_path: $INFO_LOG_PATH"
[ ! -z "$ERROR_LOG_PATH" ] && append_config "error_log_path: $ERROR_LOG_PATH"
[ ! -z "$MAX_SERVER_POOL_SIZE" ] && append_config "max_server_pool_size: $MAX_SERVER_POOL_SIZE"
[ ! -z "$API_KEYS" ] && append_config "api_keys: $API_KEYS"
[ ! -z "$DISABLE_TELEMETRY" ] && append_config "disable_telemetry: $DISABLE_TELEMETRY"
[ ! -z "$BASE_PATH" ] && append_config "base_path: $BASE_PATH"
[ ! -z "$PASSWORD_HASHING_ALG" ] && append_config "password_hashing_alg: $PASSWORD_HASHING_ALG"
[ ! -z "$BCRYPT_LOG_ROUNDS" ] && append_config "bcrypt_log_rounds: $BCRYPT_LOG_ROUNDS"
[ ! -z "$ARGON2_ITERATIONS" ] && append_config "argon2_iterations: $ARGON2_ITERATIONS"
[ ! -z "$ARGON2_MEMORY_KB" ] && append_config "argon2_memory_kb: $ARGON2_MEMORY_KB"
[ ! -z "$ARGON2_PARALLELISM" ] && append_config "argon2_parallelism: $ARGON2_PARALLELISM"
[ ! -z "$ARGON2_HASHING_POOL_SIZE" ] && append_config "argon2_hashing_pool_size: $ARGON2_HASHING_POOL_SIZE"
[ ! -z "$LOG_LEVEL" ] && append_config "log_level: $LOG_LEVEL"
[ ! -z "$FIREBASE_PASSWORD_HASHING_SIGNER_KEY" ] && append_config "firebase_password_hashing_signer_key: $FIREBASE_PASSWORD_HASHING_SIGNER_KEY"
[ ! -z "$FIREBASE_PASSWORD_HASHING_POOL_SIZE" ] && append_config "firebase_password_hashing_pool_size: $FIREBASE_PASSWORD_HASHING_POOL_SIZE"
[ ! -z "$IP_ALLOW_REGEX" ] && append_config "ip_allow_regex: $IP_ALLOW_REGEX"
[ ! -z "$IP_DENY_REGEX" ] && append_config "ip_deny_regex: $IP_DENY_REGEX"
[ ! -z "$SUPERTOKENS_SAAS_SECRET" ] && append_config "supertokens_saas_secret: $SUPERTOKENS_SAAS_SECRET"
[ ! -z "$SUPERTOKENS_MAX_CDI_VERSION" ] && append_config "supertokens_max_cdi_version: $SUPERTOKENS_MAX_CDI_VERSION"
[ ! -z "$SUPERTOKENS_SAAS_LOAD_ONLY_CUD" ] && append_config "supertokens_saas_load_only_cud: $SUPERTOKENS_SAAS_LOAD_ONLY_CUD"
[ ! -z "$OAUTH_PROVIDER_PUBLIC_SERVICE_URL" ] && append_config "oauth_provider_public_service_url: $OAUTH_PROVIDER_PUBLIC_SERVICE_URL"
[ ! -z "$OAUTH_PROVIDER_ADMIN_SERVICE_URL" ] && append_config "oauth_provider_admin_service_url: $OAUTH_PROVIDER_ADMIN_SERVICE_URL"
[ ! -z "$OAUTH_PROVIDER_CONSENT_LOGIN_BASE_URL" ] && append_config "oauth_provider_consent_login_base_url: $OAUTH_PROVIDER_CONSENT_LOGIN_BASE_URL"
[ ! -z "$OAUTH_PROVIDER_URL_CONFIGURED_IN_OAUTH_PROVIDER" ] && append_config "oauth_provider_url_configured_in_oauth_provider: $OAUTH_PROVIDER_URL_CONFIGURED_IN_OAUTH_PROVIDER"
[ ! -z "$OAUTH_CLIENT_SECRET_ENCRYPTION_KEY" ] && append_config "oauth_client_secret_encryption_key: $OAUTH_CLIENT_SECRET_ENCRYPTION_KEY"

# PostgreSQL config
[ ! -z "$POSTGRESQL_CONNECTION_POOL_SIZE" ] && append_config "postgresql_connection_pool_size: $POSTGRESQL_CONNECTION_POOL_SIZE"
[ ! -z "$POSTGRESQL_CONNECTION_URI" ] && append_config "postgresql_connection_uri: $POSTGRESQL_CONNECTION_URI"
[ ! -z "$POSTGRESQL_HOST" ] && append_config "postgresql_host: $POSTGRESQL_HOST"
[ ! -z "$POSTGRESQL_PORT" ] && append_config "postgresql_port: $POSTGRESQL_PORT"
[ ! -z "$POSTGRESQL_USER" ] && append_config "postgresql_user: $POSTGRESQL_USER"
[ ! -z "$POSTGRESQL_PASSWORD" ] && append_config "postgresql_password: $POSTGRESQL_PASSWORD"
[ ! -z "$POSTGRESQL_DATABASE_NAME" ] && append_config "postgresql_database_name: $POSTGRESQL_DATABASE_NAME"
[ ! -z "$POSTGRESQL_TABLE_SCHEMA" ] && append_config "postgresql_table_schema: $POSTGRESQL_TABLE_SCHEMA"
[ ! -z "$POSTGRESQL_TABLE_NAMES_PREFIX" ] && append_config "postgresql_table_names_prefix: $POSTGRESQL_TABLE_NAMES_PREFIX"
[ ! -z "$POSTGRESQL_KEY_VALUE_TABLE_NAME" ] && append_config "postgresql_key_value_table_name: $POSTGRESQL_KEY_VALUE_TABLE_NAME"
[ ! -z "$POSTGRESQL_SESSION_INFO_TABLE_NAME" ] && append_config "postgresql_session_info_table_name: $POSTGRESQL_SESSION_INFO_TABLE_NAME"
[ ! -z "$POSTGRESQL_EMAILPASSWORD_USERS_TABLE_NAME" ] && append_config "postgresql_emailpassword_users_table_name: $POSTGRESQL_EMAILPASSWORD_USERS_TABLE_NAME"
[ ! -z "$POSTGRESQL_EMAILPASSWORD_PSWD_RESET_TOKENS_TABLE_NAME" ] && append_config "postgresql_emailpassword_pswd_reset_tokens_table_name: $POSTGRESQL_EMAILPASSWORD_PSWD_RESET_TOKENS_TABLE_NAME"
[ ! -z "$POSTGRESQL_EMAILVERIFICATION_TOKENS_TABLE_NAME" ] && append_config "postgresql_emailverification_tokens_table_name: $POSTGRESQL_EMAILVERIFICATION_TOKENS_TABLE_NAME"
[ ! -z "$POSTGRESQL_EMAILVERIFICATION_VERIFIED_EMAILS_TABLE_NAME" ] && append_config "postgresql_emailverification_verified_emails_table_name: $POSTGRESQL_EMAILVERIFICATION_VERIFIED_EMAILS_TABLE_NAME"
[ ! -z "$POSTGRESQL_THIRDPARTY_USERS_TABLE_NAME" ] && append_config "postgresql_thirdparty_users_table_name: $POSTGRESQL_THIRDPARTY_USERS_TABLE_NAME"
[ ! -z "$POSTGRESQL_IDLE_CONNECTION_TIMEOUT" ] && append_config "postgresql_idle_connection_timeout: $POSTGRESQL_IDLE_CONNECTION_TIMEOUT"
[ ! -z "$POSTGRESQL_MINIMUM_IDLE_CONNECTIONS" ] && append_config "postgresql_minimum_idle_connections: $POSTGRESQL_MINIMUM_IDLE_CONNECTIONS"

echo "Config file created at $CONFIG_FILE"
