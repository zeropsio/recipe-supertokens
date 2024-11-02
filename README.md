# Zerops x Supertokens

### Features
- uses Node.js backend and Angular frontend
- uses Postgres for database
- includes Mailpit for SMTP in development
- includes dashboard, sessions, passwordless setup

### How to use
- you can access the dashboard at `https://<nodejsbackend-subdomain>/auth/dashboard`
- the initial dashboard user is created automatically with random email, you can find it in `nodejsbackend` service environemnt variables (`SUPERTOKENS_ADMIN_EMAIL` and `SUPERTOKENS_ADMIN_PASSWORD`)
