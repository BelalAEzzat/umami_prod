#!/bin/bash

# Configuration
source ../docker_cont/.env
# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"
BACKUP_DIR=/home/$USERNAME/backups


# Generate a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup filename
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Run the backup command
docker exec -t "$POSTGRES_CONTAINER" pg_dump -h localhost -U "$POSTGRES_USER" "$POSTGRES_DB" > "$BACKUP_FILE"

