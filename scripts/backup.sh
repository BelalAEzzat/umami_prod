#!/bin/bash

# Configuration
# Ensure the backup directory exists
BACKUP_DIR=/var/backups
mkdir -p "$BACKUP_DIR"


# Generate a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup filename
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Run the backup command
docker exec -t "postgres_DB" pg_dump -h localhost -U "backupuser" "umami" > "$BACKUP_FILE"

