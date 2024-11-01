#!/bin/bash
set -eo pipefail

# Create base config
cat << EOF > config.yaml
core_config_version: 0
postgresql_config_version: 0
host: 0.0.0.0
EOF

# Core config variables
declare -A core_vars=(
    ["port"]="SUPERTOKENS_PORT"
    ["access_token_validity"]="ACCESS_TOKEN_VALIDITY"
    ["access_token_blacklisting"]="ACCESS_TOKEN_BLACKLISTING"
    ["access_token_signing_key_dynamic"]="ACCESS_TOKEN_SIGNING_KEY_DYNAMIC"
    ["access_token_dynamic_signing_key_update_interval"]="ACCESS_TOKEN_DYNAMIC_SIGNING_KEY_UPDATE_INTERVAL"
    ["refresh_token_validity"]="REFRESH_TOKEN_VALIDITY"
    ["password_reset_token_lifetime"]="PASSWORD_RESET_TOKEN_LIFETIME"
    ["email_verification_token_lifetime"]="EMAIL_VERIFICATION_TOKEN_LIFETIME"
    ["passwordless_max_code_input_attempts"]="PASSWORDLESS_MAX_CODE_INPUT_ATTEMPTS"
    ["passwordless_code_lifetime"]="PASSWORDLESS_CODE_LIFETIME"
    ["totp_max_attempts"]="TOTP_MAX_ATTEMPTS"
    ["totp_rate_limit_cooldown_sec"]="TOTP_RATE_LIMIT_COOLDOWN_SEC"
    ["info_log_path"]="INFO_LOG_PATH"
    ["error_log_path"]="ERROR_LOG_PATH"
    ["max_server_pool_size"]="MAX_SERVER_POOL_SIZE"
    ["api_keys"]="API_KEYS"
    ["disable_telemetry"]="DISABLE_TELEMETRY"
    ["base_path"]="BASE_PATH"
    ["password_hashing_alg"]="PASSWORD_HASHING_ALG"
    ["bcrypt_log_rounds"]="BCRYPT_LOG_ROUNDS"
    ["argon2_iterations"]="ARGON2_ITERATIONS"
    ["argon2_memory_kb"]="ARGON2_MEMORY_KB"
    ["argon2_parallelism"]="ARGON2_PARALLELISM"
    ["argon2_hashing_pool_size"]="ARGON2_HASHING_POOL_SIZE"
    ["log_level"]="LOG_LEVEL"
    ["firebase_password_hashing_signer_key"]="FIREBASE_PASSWORD_HASHING_SIGNER_KEY"
    ["firebase_password_hashing_pool_size"]="FIREBASE_PASSWORD_HASHING_POOL_SIZE"
    ["ip_allow_regex"]="IP_ALLOW_REGEX"
    ["ip_deny_regex"]="IP_DENY_REGEX"
    ["supertokens_saas_secret"]="SUPERTOKENS_SAAS_SECRET"
    ["supertokens_max_cdi_version"]="SUPERTOKENS_MAX_CDI_VERSION"
    ["supertokens_saas_load_only_cud"]="SUPERTOKENS_SAAS_LOAD_ONLY_CUD"
    ["oauth_provider_public_service_url"]="OAUTH_PROVIDER_PUBLIC_SERVICE_URL"
    ["oauth_provider_admin_service_url"]="OAUTH_PROVIDER_ADMIN_SERVICE_URL"
    ["oauth_provider_consent_login_base_url"]="OAUTH_PROVIDER_CONSENT_LOGIN_BASE_URL"
    ["oauth_provider_url_configured_in_oauth_provider"]="OAUTH_PROVIDER_URL_CONFIGURED_IN_OAUTH_PROVIDER"
    ["oauth_client_secret_encryption_key"]="OAUTH_CLIENT_SECRET_ENCRYPTION_KEY"
)

# PostgreSQL config variables
declare -A postgresql_vars=(
    ["postgresql_connection_pool_size"]="POSTGRESQL_CONNECTION_POOL_SIZE"
    ["postgresql_connection_uri"]="POSTGRESQL_CONNECTION_URI"
    ["postgresql_host"]="POSTGRESQL_HOST"
    ["postgresql_port"]="POSTGRESQL_PORT"
    ["postgresql_user"]="POSTGRESQL_USER"
    ["postgresql_password"]="POSTGRESQL_PASSWORD"
    ["postgresql_database_name"]="POSTGRESQL_DATABASE_NAME"
    ["postgresql_table_schema"]="POSTGRESQL_TABLE_SCHEMA"
    ["postgresql_table_names_prefix"]="POSTGRESQL_TABLE_NAMES_PREFIX"
    ["postgresql_key_value_table_name"]="POSTGRESQL_KEY_VALUE_TABLE_NAME"
    ["postgresql_session_info_table_name"]="POSTGRESQL_SESSION_INFO_TABLE_NAME"
    ["postgresql_emailpassword_users_table_name"]="POSTGRESQL_EMAILPASSWORD_USERS_TABLE_NAME"
    ["postgresql_emailpassword_pswd_reset_tokens_table_name"]="POSTGRESQL_EMAILPASSWORD_PSWD_RESET_TOKENS_TABLE_NAME"
    ["postgresql_emailverification_tokens_table_name"]="POSTGRESQL_EMAILVERIFICATION_TOKENS_TABLE_NAME"
    ["postgresql_emailverification_verified_emails_table_name"]="POSTGRESQL_EMAILVERIFICATION_VERIFIED_EMAILS_TABLE_NAME"
    ["postgresql_thirdparty_users_table_name"]="POSTGRESQL_THIRDPARTY_USERS_TABLE_NAME"
    ["postgresql_idle_connection_timeout"]="POSTGRESQL_IDLE_CONNECTION_TIMEOUT"
    ["postgresql_minimum_idle_connections"]="POSTGRESQL_MINIMUM_IDLE_CONNECTIONS"
)

# Function to add config entries
add_config_entry() {
    local config_key=$1
    local env_var=$2
    
    # Special handling for password from file
    if [ "$env_var" = "POSTGRESQL_PASSWORD" ] && [ ! -z "$POSTGRESQL_PASSWORD_FILE" ]; then
        POSTGRESQL_PASSWORD=$(cat "$POSTGRESQL_PASSWORD_FILE")
    fi
    
    # Get the value from environment variable
    local value=${!env_var}
    
    # Add to config if value exists
    if [ ! -z "$value" ]; then
        echo "$config_key: \$\$$env_var\$\$" >> config.yaml
    fi
}

# Add core configuration
for config_key in "${!core_vars[@]}"; do
    add_config_entry "$config_key" "${core_vars[$config_key]}"
done

# Add PostgreSQL configuration
for config_key in "${!postgresql_vars[@]}"; do
    add_config_entry "$config_key" "${postgresql_vars[$config_key]}"
done
