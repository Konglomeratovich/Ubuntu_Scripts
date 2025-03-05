#!/bin/bash

# Create a BackUp

BACKUP_DIR="$HOME/backup"
SOURCE_DIR="$HOME"  # All Home Dir
EXCLUDE_DIR="$HOME/downloads"  # Exclude Downloads Dir
DATE=$(date +"%Y-%m-%d")
BACKUP_FILE="$BACKUP_DIR/backup-$DATE.tar.gz"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist!"
    exit 1
fi

# Check if exclude directory exists
if [ -d "$EXCLUDE_DIR" ]; then
    echo "Excluding directory: $EXCLUDE_DIR"
else
    echo "Warning: Directory to exclude ($EXCLUDE_DIR) does not exist."
fi

# Create backup directory if it does not exist
mkdir -p "$BACKUP_DIR"

# Remove old backups (older than 7 days)
find "$BACKUP_DIR" -type f -name "backup-*.tar.gz" -mtime +7 -exec rm -f {} \;

# Create an archive
echo "Creating backup..."
tar -czf "$BACKUP_FILE" --exclude="$EXCLUDE_DIR" "$SOURCE_DIR" >> backup.log 2>&1

# Notify user
echo "A backup copy has been created: $BACKUP_FILE"
