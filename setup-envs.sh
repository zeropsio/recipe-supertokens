#!/bin/sh
set -e

CONFIG_FILE="supertokens-config.yml"

# Create base config
cat << EOF > $CONFIG_FILE
core_config_version: 0
postgresql_config_version: 0
host: 0.0.0.0
EOF

# Handle password file if it exists
if [ ! -z "$POSTGRESQL_PASSWORD_FILE" ]; then
    POSTGRESQL_PASSWORD=$(cat "$POSTGRESQL_PASSWORD_FILE")
fi

# Core config
[ ! -z "$SUPERTOKENS_PORT" ] && echo "port: $SUPERTOKENS_PORT" >> $CONFIG_FILE
[ ! -z "$ACCESS_TOKEN_VALIDITY" ] && echo "access_token_validity: $ACCESS_TOKEN_VALIDITY" >> $CONFIG_FILE
[ ! -z "$ACCESS_TOKEN_BLACKLISTING" ] && echo "access_token_blacklisting: $ACCESS_TOKEN_BLACKLISTING" >> $CONFIG_FILE
[ ! -z "$ACCESS_TOKEN_SIGNING_KEY_DYNAMIC" ] && echo "access_token_signing_key_dynamic: $ACCESS_TOKEN_SIGNING_KEY_DYNAMIC" >> $CONFIG_FILE
[ ! -z "$ACCESS_TOKEN_DYNAMIC_SIGNING_KEY_UPDATE_INTERVAL" ] && echo "access_token_dynamic_signing_key_update_interval: $ACCESS_TOKEN_DYNAMIC_SIGNING_KEY_UPDATE_INTERVAL" >> $CONFIG_FILE
[ ! -z "$REFRESH_TOKEN_VALIDITY" ] && echo "refresh_token_validity: $REFRESH_TOKEN_VALIDITY" >> $CONFIG_FILE
[ ! -z "$PASSWORD_RESET_TOKEN_LIFETIME" ] && echo "password_reset_token_lifetime: $PASSWORD_RESET_TOKEN_LIFETIME" >> $CONFIG_FILE
[ ! -z "$EMAIL_VERIFICATION_TOKEN_LIFETIME" ] && echo "email_verification_token_lifetime: $EMAIL_VERIFICATION_TOKEN_LIFETIME" >> $CONFIG_FILE
[ ! -z "$PASSWORDLESS_MAX_CODE_INPUT_ATTEMPTS" ] && echo "passwordless_max_code_input_attempts: $PASSWORDLESS_MAX_CODE_INPUT_ATTEMPTS" >> $CONFIG_FILE
[ ! -z "$PASSWORDLESS_CODE_LIFETIME" ] && echo "passwordless_code_lifetime: $PASSWORDLESS_CODE_LIFETIME" >> $CONFIG_FILE
[ ! -z "$TOTP_MAX_ATTEMPTS" ] && echo "totp_max_attempts: $TOTP_MAX_ATTEMPTS" >> $CONFIG_FILE
[ ! -z "$TOTP_RATE_LIMIT_COOLDOWN_SEC" ] && echo "totp_rate_limit_cooldown_sec: $TOTP_RATE_LIMIT_COOLDOWN_SEC" >> $CONFIG_FILE
[ ! -z "$INFO_LOG_PATH" ] && echo "info_log_path: $INFO_LOG_PATH" >> $CONFIG_FILE
[ ! -z "$ERROR_LOG_PATH" ] && echo "error_log_path: $ERROR_LOG_PATH" >> $CONFIG_FILE
[ ! -z "$MAX_SERVER_POOL_SIZE" ] && echo "max_server_pool_size: $MAX_SERVER_POOL_SIZE" >> $CONFIG_FILE
[ ! -z "$API_KEYS" ] && echo "api_keys: $API_KEYS" >> $CONFIG_FILE
[ ! -z "$DISABLE_TELEMETRY" ] && echo "disable_telemetry: $DISABLE_TELEMETRY" >> $CONFIG_FILE
[ ! -z "$BASE_PATH" ] && echo "base_path: $BASE_PATH" >> $CONFIG_FILE
[ ! -z "$PASSWORD_HASHING_ALG" ] && echo "password_hashing_alg: $PASSWORD_HASHING_ALG" >> $CONFIG_FILE
[ ! -z "$BCRYPT_LOG_ROUNDS" ] && echo "bcrypt_log_rounds: $BCRYPT_LOG_ROUNDS" >> $CONFIG_FILE
[ ! -z "$ARGON2_ITERATIONS" ] && echo "argon2_iterations: $ARGON2_ITERATIONS" >> $CONFIG_FILE
[ ! -z "$ARGON2_MEMORY_KB" ] && echo "argon2_memory_kb: $ARGON2_MEMORY_KB" >> $CONFIG_FILE
[ ! -z "$ARGON2_PARALLELISM" ] && echo "argon2_parallelism: $ARGON2_PARALLELISM" >> $CONFIG_FILE
[ ! -z "$ARGON2_HASHING_POOL_SIZE" ] && echo "argon2_hashing_pool_size: $ARGON2_HASHING_POOL_SIZE" >> $CONFIG_FILE
[ ! -z "$LOG_LEVEL" ] && echo "log_level: $LOG_LEVEL" >> $CONFIG_FILE
[ ! -z "$FIREBASE_PASSWORD_HASHING_SIGNER_KEY" ] && echo "firebase_password_hashing_signer_key: $FIREBASE_PASSWORD_HASHING_SIGNER_KEY" >> $CONFIG_FILE
[ ! -z "$FIREBASE_PASSWORD_HASHING_POOL_SIZE" ] && echo "firebase_password_hashing_pool_size: $FIREBASE_PASSWORD_HASHING_POOL_SIZE" >> $CONFIG_FILE
[ ! -z "$IP_ALLOW_REGEX" ] && echo "ip_allow_regex: $IP_ALLOW_REGEX" >> $CONFIG_FILE
[ ! -z "$IP_DENY_REGEX" ] && echo "ip_deny_regex: $IP_DENY_REGEX" >> $CONFIG_FILE
[ ! -z "$SUPERTOKENS_SAAS_SECRET" ] && echo "supertokens_saas_secret: $SUPERTOKENS_SAAS_SECRET" >> $CONFIG_FILE
[ ! -z "$SUPERTOKENS_MAX_CDI_VERSION" ] && echo "supertokens_max_cdi_version: $SUPERTOKENS_MAX_CDI_VERSION" >> $CONFIG_FILE
[ ! -z "$SUPERTOKENS_SAAS_LOAD_ONLY_CUD" ] && echo "supertokens_saas_load_only_cud: $SUPERTOKENS_SAAS_LOAD_ONLY_CUD" >> $CONFIG_FILE
[ ! -z "$OAUTH_PROVIDER_PUBLIC_SERVICE_URL" ] && echo "oauth_provider_public_service_url: $OAUTH_PROVIDER_PUBLIC_SERVICE_URL" >> $CONFIG_FILE
[ ! -z "$OAUTH_PROVIDER_ADMIN_SERVICE_URL" ] && echo "oauth_provider_admin_service_url: $OAUTH_PROVIDER_ADMIN_SERVICE_URL" >> $CONFIG_FILE
[ ! -z "$OAUTH_PROVIDER_CONSENT_LOGIN_BASE_URL" ] && echo "oauth_provider_consent_login_base_url: $OAUTH_PROVIDER_CONSENT_LOGIN_BASE_URL" >> $CONFIG_FILE
[ ! -z "$OAUTH_PROVIDER_URL_CONFIGURED_IN_OAUTH_PROVIDER" ] && echo "oauth_provider_url_configured_in_oauth_provider: $OAUTH_PROVIDER_URL_CONFIGURED_IN_OAUTH_PROVIDER" >> $CONFIG_FILE
[ ! -z "$OAUTH_CLIENT_SECRET_ENCRYPTION_KEY" ] && echo "oauth_client_secret_encryption_key: $OAUTH_CLIENT_SECRET_ENCRYPTION_KEY" >> $CONFIG_FILE

# PostgreSQL config
[ ! -z "$POSTGRESQL_CONNECTION_POOL_SIZE" ] && echo "postgresql_connection_pool_size: $POSTGRESQL_CONNECTION_POOL_SIZE" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_CONNECTION_URI" ] && echo "postgresql_connection_uri: $POSTGRESQL_CONNECTION_URI" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_HOST" ] && echo "postgresql_host: $POSTGRESQL_HOST" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_PORT" ] && echo "postgresql_port: $POSTGRESQL_PORT" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_USER" ] && echo "postgresql_user: $POSTGRESQL_USER" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_PASSWORD" ] && echo "postgresql_password: $POSTGRESQL_PASSWORD" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_DATABASE_NAME" ] && echo "postgresql_database_name: $POSTGRESQL_DATABASE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_TABLE_SCHEMA" ] && echo "postgresql_table_schema: $POSTGRESQL_TABLE_SCHEMA" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_TABLE_NAMES_PREFIX" ] && echo "postgresql_table_names_prefix: $POSTGRESQL_TABLE_NAMES_PREFIX" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_KEY_VALUE_TABLE_NAME" ] && echo "postgresql_key_value_table_name: $POSTGRESQL_KEY_VALUE_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_SESSION_INFO_TABLE_NAME" ] && echo "postgresql_session_info_table_name: $POSTGRESQL_SESSION_INFO_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_EMAILPASSWORD_USERS_TABLE_NAME" ] && echo "postgresql_emailpassword_users_table_name: $POSTGRESQL_EMAILPASSWORD_USERS_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_EMAILPASSWORD_PSWD_RESET_TOKENS_TABLE_NAME" ] && echo "postgresql_emailpassword_pswd_reset_tokens_table_name: $POSTGRESQL_EMAILPASSWORD_PSWD_RESET_TOKENS_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_EMAILVERIFICATION_TOKENS_TABLE_NAME" ] && echo "postgresql_emailverification_tokens_table_name: $POSTGRESQL_EMAILVERIFICATION_TOKENS_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_EMAILVERIFICATION_VERIFIED_EMAILS_TABLE_NAME" ] && echo "postgresql_emailverification_verified_emails_table_name: $POSTGRESQL_EMAILVERIFICATION_VERIFIED_EMAILS_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_THIRDPARTY_USERS_TABLE_NAME" ] && echo "postgresql_thirdparty_users_table_name: $POSTGRESQL_THIRDPARTY_USERS_TABLE_NAME" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_IDLE_CONNECTION_TIMEOUT" ] && echo "postgresql_idle_connection_timeout: $POSTGRESQL_IDLE_CONNECTION_TIMEOUT" >> $CONFIG_FILE
[ ! -z "$POSTGRESQL_MINIMUM_IDLE_CONNECTIONS" ] && echo "postgresql_minimum_idle_connections: $POSTGRESQL_MINIMUM_IDLE_CONNECTIONS" >> $CONFIG_FILE
