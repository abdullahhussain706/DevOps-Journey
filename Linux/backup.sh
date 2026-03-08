#!/bin/bash

#Backup script that takes a directory backup into compressed file

SOURCE_DIR="/home/muhammad-abdullah/Documents"
BACKUP_DIR="/media/muhammad-abdullah/New Volume/Backup"
RETENTION_DAYS=7
LOG_FILE="$BACKUP_DIR/backup.log"

# -------- CREATE BACKUP DIRECTORY IF NOT EXISTS --------
# Absolute paths
ABS_SOURCE=$(readlink -f "$SOURCE_DIR")
ABS_DEST=$(readlink -f "$BACKUP_DIR")

if [ ! -d "$ABS_DEST" ]; then
    echo "Backup directory not found!  Creating...."
    mkdir -p "$ABS_DEST"
fi

# -------- GENERATE TIMESTAMP --------
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"
BACKUP_PATH="$ABS_DEST/$BACKUP_NAME"

# -------- CREATE BACKUP --------
echo "Starting backup of $ABS_SOURCE ..."
tar -czf "$BACKUP_PATH" -C "$(dirname "$ABS_SOURCE")" "$(basename "$ABS_SOURCE")"

# -------- LOG THE BACKUP --------
if [ $? -eq 0 ]; then
    echo "[$(date)] Backup created successfully: $BACKUP_NAME" >> "$LOG_FILE"
    echo "Backup completed!"
else
    echo "[$(date)] Backup failed: $BACKUP_NAME" >> "$LOG_FILE"
    echo "Backup failed!"
fi

# -------- REMOVE OLD BACKUPS --------
find "$ABS_DEST" -name "backup_*.tar.gz" -type f -mtime +$RETENTION_DAYS -exec rm {} \;