#!/bin/bash

set -e

# wait for Postgres to start
function postgres_ready() {
python << END
import sys
import psycopg2
try:
    conn = psycopg2.connect(dbname="$POSTGRES_DB", user="$POSTGRES_USER", password="$POSTGRES_PASSWORD", host="$POSTGRES_HOST")
except psycopg2.OperationalError:
    sys.exit(-1)
sys.exit(0)
END
}

until postgres_ready; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - continuing"

# Create the database if it doesn't exist.
#psql -U "$POSTGRES_USER" -h db -tc "SELECT 1 FROM pg_database WHERE datname = '$POSTGRES_DB'" | grep -q 1 || psql -U "$POSTGRES_USER" -h db -c "CREATE DATABASE $POSTGRES_DB"
#
## Run database migrations
#flask db init
#flask db migrate -m "Initial migration."
#flask db upgrade

# Run the command provided as arguments to this script
exec "$@"