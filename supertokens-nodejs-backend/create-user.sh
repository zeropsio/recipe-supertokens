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

wait_for_connection() {
    local attempt=1

    while [ $attempt -le $MAX_ATTEMPTS ]; do
        if nc -z $(echo "${SUPERTOKENS_CONNECTION_URI}" | sed 's|http://||' | cut -d: -f1) \
                  $(echo "${SUPERTOKENS_CONNECTION_URI}" | sed 's|http://||' | cut -d: -f2) 2>/dev/null; then
            echo "SuperTokens connection established"
            return 0
        fi

        echo "Waiting for SuperTokens connection (attempt $attempt/$MAX_ATTEMPTS)..."
        sleep $SLEEP_INTERVAL
        attempt=$((attempt + 1))
    done

    echo "Error: Could not establish connection to SuperTokens after $MAX_ATTEMPTS attempts"
    return 1
}

main() {
    if ! check_required_vars; then
        exit 1
    fi

    if ! wait_for_connection; then
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
