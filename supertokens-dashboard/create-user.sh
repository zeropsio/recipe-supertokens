#!/bin/sh

API_KEY=$API
EMAIL="<YOUR_EMAIL>"
PASSWORD="<YOUR_PASSWORD>"

curl --location --request POST ${SUPERTOKENS_INSTANCE} \
     --header "rid: dashboard" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header 'Content-Type: application/json' \
     --data-raw "{\"email\": \"${SUPERTOKENS_ADMIN_EMAIL}\",\"password\": \"${SUPERTOKENS_ADMIN_PASSWORD}\"}"
