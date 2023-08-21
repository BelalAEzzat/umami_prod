#!/bin/bash

# Configuration
env_file=/home/^/umami_prod/docker_cont/.env
source "$env_file"
# Ensure the backup directory exists
BACKUP_DIR=/var/backups
LOG_DIR=/var/backuplogs
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_FILE"
echo "$POSTGRES_USER" >> "/home/log.txt"

# Generate a timestamp for the backup file
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Define the backup filename
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"
LOG_FILE="$LOG_DIR/log_$TIMESTAMP.txt"

# Run the backup command
if docker exec -t "postgres_DB" pg_dump -h localhost -U "$POSTGRES_USER" -d "$POSTGRES_DB" > "$BACKUP_FILE" 2>> "$LOG_FILE"; then
    echo "$(date): Backup successful" >> "$LOG_FILE"
else
    echo "$(date): Backup failed" >> "$LOG_FILE"
    # Add additional error handling here, like sending alerts
fi
