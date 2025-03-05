#!/bin/bash

# Path to the trash directory
TRASH_DIR="$HOME/trash"

# Create the trash directory if it doesn't exist
mkdir -p "$TRASH_DIR"

# Function to move a file or directory to the trash
move_to_trash() {
    FILE="$1"
    if [ -f "$FILE" ] || [ -d "$FILE" ]; then
        # Generate a timestamp for the archive name
        TIMESTAMP=$(date +"%Y%m%d%H%M%S")
        ARCHIVE_NAME="${FILE##*/}.$TIMESTAMP.tar.gz"
        
        # Archive the file/directory and move it to the trash directory
        tar -czf "$TRASH_DIR/$ARCHIVE_NAME" "$FILE" >> /dev/null 2>&1
        rm -rf "$FILE"
        echo "File '$FILE' has been moved to the trash ($TRASH_DIR/$ARCHIVE_NAME)"
    else
        echo "Error: File '$FILE' does not exist or is not a regular file/directory."
    fi
}

# Function to clean the trash by removing files older than 3 days
clean_trash() {
    echo "Cleaning the trash from files older than 3 days..."
    find "$TRASH_DIR" -type f -name "*.tar.gz" -mtime +3 -exec rm -f {} \;
}

# Function to list the contents of the trash
list_trash() {
    echo "Contents of the trash:"
    if ls -l "$TRASH_DIR" | grep -q '^-' ; then
        ls -l "$TRASH_DIR"
    else
        echo "Trash is empty."
    fi
}

# Function to restore a file from the trash
restore_file() {
    ARCHIVE="$1"
    if [ -f "$ARCHIVE" ]; then
        # Extract the archive to the home directory
        tar -xzf "$ARCHIVE" -C "$HOME"
        echo "File '$ARCHIVE' has been restored."
    else
        echo "Error: Archive '$ARCHIVE' not found."
    fi
}

# Main script logic
if [ "$#" -eq 0 ]; then
    # If no arguments are provided, clean the trash
    clean_trash
elif [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
    # If --list or -l is provided, list the contents of the trash
    list_trash
elif [ "$1" = "--restore" ] || [ "$1" = "-r" ]; then
    # If --restore or -r is provided, restore the specified file
    if [ "$#" -ne 2 ]; then
        echo "Error: You must specify exactly one archive to restore."
        echo "Usage: $0 --restore <archive_name>"
        exit 1
    fi
    RESTORE_ARCHIVE="$TRASH_DIR/$2"
    restore_file "$RESTORE_ARCHIVE"
elif [ "$#" -eq 1 ]; then
    # If one argument is provided, move it to the trash
    ITEM="$1"
    if [ -f "$ITEM" ] || [ -d "$ITEM" ]; then
        move_to_trash "$ITEM"
    else
        echo "Error: Item '$ITEM' does not exist or is not a valid file/directory."
    fi
else
    # If more than one argument is provided, show an error message
    echo "Error: Invalid usage."
    echo "Usage: $0 <file_or_directory> | --list | --restore <archive_name>"
    exit 1
fi

# Display completion message
echo "Operation completed."