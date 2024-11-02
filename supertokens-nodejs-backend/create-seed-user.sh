#!/bin/sh

# Colors for prettier logging
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_section() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

log_success() {
    echo -e "${GREEN}$1${NC}"
}

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

log_section "Configuration"
echo "SuperTokens Instance: ${SUPERTOKENS_INSTANCE}"
echo "Identifier Type: ${TYPE}"
echo "Identifier: ${IDENTIFIER}"

GENERATE_CODE_URL="${SUPERTOKENS_INSTANCE}/recipe/signinup/code"
log_section "Step 1: Generating passwordless code"

if [ "$TYPE" = "phone" ]; then
    REQUEST_BODY="{\"phoneNumber\": \"${IDENTIFIER}\"}"
else
    REQUEST_BODY="{\"email\": \"${IDENTIFIER}\"}"
fi

# Step 1: Generate the code
GENERATE_RESPONSE=$(curl -s --location --request POST "${GENERATE_CODE_URL}" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header 'Content-Type: application/json; charset=utf-8' \
     --write-out "\nHTTP_CODE:%{http_code}" \
     --data-raw "${REQUEST_BODY}")

HTTP_CODE=$(echo "$GENERATE_RESPONSE" | grep "HTTP_CODE" | cut -d":" -f2)
BODY=$(echo "$GENERATE_RESPONSE" | sed '$d')

if [ "$HTTP_CODE" != "200" ]; then
    echo "Error generating code. HTTP Code: $HTTP_CODE"
    echo "Response Body: $BODY"
    exit 1
fi

# Extract needed values from response
PRE_AUTH_SESSION_ID=$(echo "$BODY" | grep -o '"preAuthSessionId":"[^"]*"' | cut -d'"' -f4)
LINK_CODE=$(echo "$BODY" | grep -o '"linkCode":"[^"]*"' | cut -d'"' -f4)

if [ -z "$PRE_AUTH_SESSION_ID" ] || [ -z "$LINK_CODE" ]; then
    echo "Error: Could not extract required values from response"
    echo "PreAuthSessionId: ${PRE_AUTH_SESSION_ID}"
    echo "LinkCode: ${LINK_CODE}"
    exit 1
fi

log_success "Code generated successfully!"
echo "PreAuthSessionId: $PRE_AUTH_SESSION_ID"
echo "LinkCode: $LINK_CODE"

CONSUME_CODE_URL="${SUPERTOKENS_INSTANCE}/recipe/signinup/code/consume"
log_section "Step 2: Consuming code to create user"

REQUEST_BODY="{\"preAuthSessionId\": \"${PRE_AUTH_SESSION_ID}\", \"linkCode\": \"${LINK_CODE}\"}"

# Step 2: Consume the code
CONSUME_RESPONSE=$(curl -s --location --request POST "${CONSUME_CODE_URL}" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header 'Content-Type: application/json; charset=utf-8' \
     --write-out "\nHTTP_CODE:%{http_code}" \
     --data-raw "${REQUEST_BODY}")

HTTP_CODE=$(echo "$CONSUME_RESPONSE" | grep "HTTP_CODE" | cut -d":" -f2)
BODY=$(echo "$CONSUME_RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "200" ]; then
    USER_ID=$(echo "$BODY" | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    log_success "User created/signed in successfully!"
    echo "User ID: $USER_ID"
else
    echo "Error consuming code. HTTP Code: $HTTP_CODE"
    echo "Response Body: $BODY"
    exit 1
fi
