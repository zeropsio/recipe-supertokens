#!/bin/sh

EMAIL=${1:-"$SUPERTOKENS_SEED_USER_EMAIL"}

if [ -z "$EMAIL" ]; then
    echo "Usage: $0 <email>"
    echo "Example: $0 user@example.com"
    exit 1
fi

echo "Creating user..."
RESPONSE=$(curl --location --request POST "${SUPERTOKENS_INSTANCE}/recipe/signinup" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header 'Content-Type: application/json; charset=utf-8' \
     --write-out "\nHTTP_CODE:%{http_code}" \
     --data-raw "{
         \"thirdPartyId\": \"passwordless\",
         \"thirdPartyUserId\": \"${EMAIL}\",
         \"email\": {
             \"id\": \"${EMAIL}\",
             \"isVerified\": true
         }
     }")

HTTP_CODE=$(echo "$RESPONSE" | grep "HTTP_CODE" | cut -d":" -f2)
BODY=$(echo "$RESPONSE" | sed '$d')

echo "Response code: $HTTP_CODE"
echo "Response body: $BODY"

if [ "$HTTP_CODE" = "200" ]; then
    echo "User created successfully!"
    USER_ID=$(echo "$BODY" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    echo "User ID: $USER_ID"
else
    echo "Error creating user. HTTP Code: $HTTP_CODE"
    echo "Response: $BODY"
    exit 1
fi
