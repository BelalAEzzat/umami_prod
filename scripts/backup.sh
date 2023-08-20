#!/bin/bash

# Configuration
source /home/^/umami_prod/docker_cont/.env
# Ensure the backup directory exists
BACKUP_DIR= /var/backups
LOG_FILE= /var/backuplogs
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_FILE"


# Generate a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup filename
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Run the backup command
if docker exec -t "postgres_DB" pg_dump -h localhost -U "$POSTGRES_USER" "$POSTGRES_DB" > "$BACKUP_FILE" 2>> "$LOG_FILE"; then
    echo "$(date): Backup successful" >> "$LOG_FILE"
else
    echo "$(date): Backup failed" >> "$LOG_FILE"
    # Add additional error handling here, like sending alerts
fi
