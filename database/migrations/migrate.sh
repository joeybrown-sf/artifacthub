#!/bin/sh

schemaVersionTable=version_schema
functionsVersionTable=version_functions

# If TERN_CONF is not set but DATABASE_URL is, create tern.conf from DATABASE_URL
if [ -z "$TERN_CONF" ] && [ -n "$DATABASE_URL" ]; then
    # Parse DATABASE_URL (format: postgres://user:password@host:port/database)
    DB_URL="${DATABASE_URL#postgres://}"
    
    # Extract user:password@host:port/database
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
    
    # Create tern.conf file
    TERN_CONF_FILE="/tmp/tern.conf"
    cat > "$TERN_CONF_FILE" <<EOF
[database]
host = $DB_HOST
port = $DB_PORT
database = $DB_NAME
user = $DB_USER
password = $DB_PASS
EOF
    export TERN_CONF="$TERN_CONF_FILE"
    echo "Created tern.conf from DATABASE_URL"
fi

# Ensure TERN_CONF is set
if [ -z "$TERN_CONF" ]; then
    echo "Error: TERN_CONF must be set or DATABASE_URL must be provided"
    exit 1
fi

passwordOverride=""
if [ -n "$DBMIGRATOR_DB_PASSWORD" ]; then
    passwordOverride="--password $DBMIGRATOR_DB_PASSWORD"
fi

echo "- Applying schema migrations.."
cd schema
tern status --config $TERN_CONF --version-table $schemaVersionTable $passwordOverride
tern migrate --config $TERN_CONF --version-table $schemaVersionTable $passwordOverride
if [ $? -ne 0 ]; then exit 1; fi
echo "Done"
cd ..

echo "- Loading functions.."
cd functions
tern status --config $TERN_CONF --version-table $functionsVersionTable $passwordOverride | grep "version:  1 of 1"
if [ $? -eq 0 ]; then
    tern migrate --config $TERN_CONF --version-table $functionsVersionTable --destination -+1 $passwordOverride
else
    tern migrate --config $TERN_CONF --version-table $functionsVersionTable $passwordOverride
fi
if [ $? -ne 0 ]; then exit 1; fi
echo "Done"
