## Database Migration
docker run --rm -e DATABASE_URL="postgres://redacted:redacted@ec2-98-91-102-188.compute-1.amazonaws.com:5432/redacted?sslmode=require" artifacthub-db-migrator ./migrate.sh

## Tracker
docker run --platform linux/amd64 --rm -e DATABASE_URL='postgres://redacted:redacted@ec2-98-91-102-188.compute-1.amazonaws.com:5432/redacted' artifacthub-tracker

