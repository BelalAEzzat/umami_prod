#!/bin/bash

# Configuration
POSTGRES_CONTAINER=postgres_DB
POSTGRES_USER=umami
POSTGRES_DB=umami
BACKUP_DIR=./backups

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Generate a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup filename
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Run the backup command
docker exec -t "$POSTGRES_CONTAINER" pg_dump -h localhost -U "$POSTGRES_USER" "$POSTGRES_DB" > "$BACKUP_FILE"

