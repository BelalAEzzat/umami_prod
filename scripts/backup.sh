#!/bin/bash

# Configuration
source /home/^/umami_prod/docker_cont/.env
# Ensure the backup directory exists
BACKUP_DIR=/home/^/backups
mkdir -p "$BACKUP_DIR"


# Generate a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup filename
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Run the backup command
docker exec -t "postgres_DB" pg_dump -h localhost -U "$POSTGRES_USER" "$POSTGRES_DB" > "$BACKUP_FILE"