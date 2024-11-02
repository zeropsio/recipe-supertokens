#!/bin/sh

curl --location --request POST ${SUPERTOKENS_INSTANCE} \
     --header "rid: dashboard" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header 'Content-Type: application/json' \
     --data-raw "{\"email\": \"${SUPERTOKENS_ADMIN_EMAIL}\",\"password\": \"${SUPERTOKENS_ADMIN_PASSWORD}\"}"
