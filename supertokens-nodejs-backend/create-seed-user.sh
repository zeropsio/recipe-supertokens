#!/bin/sh

# First argument can be either email or phone number
IDENTIFIER=${1:-"$SUPERTOKENS_SEED_USER_EMAIL"}
TYPE="email"  # default to email

if [ -z "$IDENTIFIER" ]; then
    echo "Usage: $0 <email_or_phone>"
    echo "Example: $0 user@example.com"
    echo "Example: $0 +14155552671"
    exit 1
fi

# Check if the identifier is a phone number (starts with +)
if echo "$IDENTIFIER" | grep -q "^\+"; then
    TYPE="phone"
fi

echo "Generating passwordless code..."
# Step 1: Generate the code
if [ "$TYPE" = "phone" ]; then
    GENERATE_RESPONSE=$(curl --location --request POST "${SUPERTOKENS_INSTANCE}/recipe/signinup/code" \
         --header "api-key: ${SUPERTOKENS_API_KEY}" \
         --header 'Content-Type: application/json; charset=utf-8' \
         --write-out "\nHTTP_CODE:%{http_code}" \
         --data-raw "{
             \"phoneNumber\": \"${IDENTIFIER}\"
         }")
else
    GENERATE_RESPONSE=$(curl --location --request POST "${SUPERTOKENS_INSTANCE}/recipe/signinup/code" \
         --header "api-key: ${SUPERTOKENS_API_KEY}" \
         --header 'Content-Type: application/json; charset=utf-8' \
         --write-out "\nHTTP_CODE:%{http_code}" \
         --data-raw "{
             \"email\": \"${IDENTIFIER}\"
         }")
fi

HTTP_CODE=$(echo "$GENERATE_RESPONSE" | grep "HTTP_CODE" | cut -d":" -f2)
BODY=$(echo "$GENERATE_RESPONSE" | sed '$d')

if [ "$HTTP_CODE" != "200" ]; then
    echo "Error generating code. HTTP Code: $HTTP_CODE"
    echo "Response: $BODY"
    exit 1
fi

# Extract needed values from response
PRE_AUTH_SESSION_ID=$(echo "$BODY" | grep -o '"preAuthSessionId":"[^"]*"' | cut -d'"' -f4)
LINK_CODE=$(echo "$BODY" | grep -o '"linkCode":"[^"]*"' | cut -d'"' -f4)

echo "Code generated successfully!"
echo "PreAuthSessionId: $PRE_AUTH_SESSION_ID"
echo "LinkCode: $LINK_CODE"

# Step 2: Consume the code
echo "Consuming code to create user..."
CONSUME_RESPONSE=$(curl --location --request POST "${SUPERTOKENS_INSTANCE}/recipe/signinup/code/consume" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header 'Content-Type: application/json; charset=utf-8' \
     --write-out "\nHTTP_CODE:%{http_code}" \
     --data-raw "{
         \"preAuthSessionId\": \"${PRE_AUTH_SESSION_ID}\",
         \"linkCode\": \"${LINK_CODE}\"
     }")

HTTP_CODE=$(echo "$CONSUME_RESPONSE" | grep "HTTP_CODE" | cut -d":" -f2)
BODY=$(echo "$CONSUME_RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "200" ]; then
    echo "User created/signed in successfully!"
    USER_ID=$(echo "$BODY" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    echo "User ID: $USER_ID"
else
    echo "Error consuming code. HTTP Code: $HTTP_CODE"
    echo "Response: $BODY"
    exit 1
fi
