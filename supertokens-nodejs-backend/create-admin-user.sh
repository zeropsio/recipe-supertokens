#!/bin/sh

MAX_ATTEMPTS=30
SLEEP_INTERVAL=2

check_required_vars() {
    local missing_vars=0

    if [ -z "${SUPERTOKENS_INSTANCE}" ]; then
        echo "Error: SUPERTOKENS_INSTANCE is not set"
        missing_vars=1
    fi

    if [ -z "${SUPERTOKENS_API_KEY}" ]; then
        echo "Error: SUPERTOKENS_API_KEY is not set"
        missing_vars=1
    fi

    if [ -z "${SUPERTOKENS_ADMIN_EMAIL}" ]; then
        echo "Error: SUPERTOKENS_ADMIN_EMAIL is not set"
        missing_vars=1
    fi

    if [ -z "${SUPERTOKENS_ADMIN_PASSWORD}" ]; then
        echo "Error: SUPERTOKENS_ADMIN_PASSWORD is not set"
        missing_vars=1
    fi

    if [ -z "${SUPERTOKENS_CONNECTION_URI}" ]; then
        echo "Error: SUPERTOKENS_CONNECTION_URI is not set"
        missing_vars=1
    fi

    return $missing_vars
}

main() {
    if ! check_required_vars; then
        exit 1
    fi

    # Execute the curl command
    curl --location --request POST "${SUPERTOKENS_INSTANCE}" \
         --header "rid: dashboard" \
         --header "api-key: ${SUPERTOKENS_API_KEY}" \
         --header 'Content-Type: application/json' \
         --data-raw "{\"email\": \"${SUPERTOKENS_ADMIN_EMAIL}\",\"password\": \"${SUPERTOKENS_ADMIN_PASSWORD}\"}"
}

main
