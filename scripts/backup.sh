#!/bin/bash

env_file=/home/^/umami_prod/docker_cont/.env
source "$env_file"

BACKUP_DIR=/var/backups
LOG_DIR=/var/backuplogs
mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"  
echo "$POSTGRES_USER" >> "/home/log.txt"


TIMESTAMP=$(date +%Y%m%d%H%M%S)

BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"
LOG_FILE="$LOG_DIR/log_$TIMESTAMP.txt"

if docker exec -t pg_dump "host=localhost dbname='$POSTGRES_DB' user='$POSTGRES_USER' password='$POSTGRES_PASSWORD'" > "$BACKUP_FILE" 2>> "$LOG_FILE"; then
    echo "$(date): Backup successful" >> "$LOG_FILE"
else
    echo "$(date): Backup failed" >> "$LOG_FILE"
   
fi
