#!/bin/sh
set -e

# Create .cfg directory if it doesn't exist
mkdir -p /home/hub/.cfg

# Parse DATABASE_URL if provided
if [ -n "$DATABASE_URL" ]; then
  # Remove postgres:// prefix
  DB_URL="${DATABASE_URL#postgres://}"
  
  # Extract user:password@host:port/database
  # Handle case where password might contain special characters
  DB_USER_PASS="${DB_URL%%@*}"
  DB_HOST_PATH="${DB_URL#*@}"
  
  # Split user and password
  DB_USER="${DB_USER_PASS%%:*}"
  DB_PASS="${DB_USER_PASS#*:}"
  
  # Extract host:port and database
  DB_HOST_PORT="${DB_HOST_PATH%%/*}"
  DB_NAME_PATH="${DB_HOST_PATH#*/}"
  
  # Remove query parameters from database name
  DB_NAME="${DB_NAME_PATH%%\?*}"
  
  # Split host and port
  DB_HOST="${DB_HOST_PORT%%:*}"
  DB_PORT="${DB_HOST_PORT#*:}"
  
  # Set default port if not present
  if [ "$DB_PORT" = "$DB_HOST_PORT" ]; then
    DB_PORT="5432"
  fi
fi

# Create hub.yaml config file
cat > /home/hub/.cfg/hub.yaml <<EOF
log:
  level: ${HUB_LOG_LEVEL:-info}
  pretty: ${HUB_LOG_PRETTY:-false}
db:
  host: ${DB_HOST:-localhost}
  port: "${DB_PORT:-5432}"
  database: ${DB_NAME:-hub}
  user: ${DB_USER:-postgres}
  password: ${DB_PASS:-}
server:
  addr: ${HUB_SERVER_ADDR:-0.0.0.0:8000}
  shutdownTimeout: ${HUB_SERVER_SHUTDOWN_TIMEOUT:-10s}
  webBuildPath: ./web
  widgetBuildPath: ./widget
EOF

# Execute the command
exec "$@"
