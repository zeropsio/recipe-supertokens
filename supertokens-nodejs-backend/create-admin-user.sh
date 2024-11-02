#!/bin/sh

MAX_ATTEMPTS=30
SLEEP_INTERVAL=2

check_required_vars() {
    if [ -z "${SUPERTOKENS_INSTANCE}" ] || \
       [ -z "${SUPERTOKENS_API_KEY}" ] || \
       [ -z "${SUPERTOKENS_ADMIN_EMAIL}" ] || \
       [ -z "${SUPERTOKENS_ADMIN_PASSWORD}" ] || \
       [ -z "${core_zeropsSubdomainHost}" ]; then
        return 1
    fi
    return 0
}

main() {
    local attempt=1

    while [ $attempt -le $MAX_ATTEMPTS ]; do
        if check_required_vars; then
            echo "All required environment variables are set"
            break
        fi

        echo "Waiting for environment variables (attempt $attempt/$MAX_ATTEMPTS)..."
        sleep $SLEEP_INTERVAL
        attempt=$((attempt + 1))
    done

    if [ $attempt -gt $MAX_ATTEMPTS ]; then
        echo "Error: Required environment variables not set after $MAX_ATTEMPTS attempts:"
        [ -z "${SUPERTOKENS_INSTANCE}" ] && echo "- SUPERTOKENS_INSTANCE is missing"
        [ -z "${SUPERTOKENS_API_KEY}" ] && echo "- SUPERTOKENS_API_KEY is missing"
        [ -z "${SUPERTOKENS_ADMIN_EMAIL}" ] && echo "- SUPERTOKENS_ADMIN_EMAIL is missing"
        [ -z "${SUPERTOKENS_ADMIN_PASSWORD}" ] && echo "- SUPERTOKENS_ADMIN_PASSWORD is missing"
        [ -z "${core_zeropsSubdomainHost}" ] && echo "- core_zeropsSubdomainHost is missing"
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
