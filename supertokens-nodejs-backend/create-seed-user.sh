#!/bin/sh

# Default values
EMAIL=${1:-""}
PASSWORD=${2:-""}
TENANT_ID=${3:-"public"}  # Default tenant is usually "public"
SIGNUP_METHOD="passwordless"

if [ -z "$EMAIL" ] || [ -z "$PASSWORD" ]; then
    echo "Usage: $0 <email> <password> [tenant_id]"
    echo "Example: $0 user@example.com password123 public"
    exit 1
fi

# First create the user
echo "Creating user in tenant: $TENANT_ID"
RESPONSE=$(curl --location --request POST "${SUPERTOKENS_INSTANCE}/recipe/signup" \
     --header "rid: $SIGNUP_METHOD" \
     --header "api-key: ${SUPERTOKENS_API_KEY}" \
     --header "tenant-id: ${TENANT_ID}" \
     --header 'Content-Type: application/json' \
     --data-raw "{
         \"email\": \"${EMAIL}\",
         \"password\": \"${PASSWORD}\",
         \"formFields\": [{
             \"id\": \"email\",
             \"value\": \"${EMAIL}\"
         }, {
             \"id\": \"password\",
             \"value\": \"${PASSWORD}\"
         }]
     }")

# Check if the user was created successfully
if echo "$RESPONSE" | grep -q "\"status\":\"OK\""; then
    echo "User created successfully!"
    USER_ID=$(echo "$RESPONSE" | grep -o '"user":{[^}]*}' | grep -o '"id":"[^"]*"' | cut -d'"' -f4)
    echo "User ID: $USER_ID"
else
    echo "Error creating user:"
    echo "$RESPONSE"
    exit 1
fi
