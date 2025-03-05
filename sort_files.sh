#!/bin/bash
#Put the script in the user's home directory, in the script folder.
# The path to the Downloads folder
# The $HOME variable is the current user's home directory. 
DOWNLOADS_DIR="$HOME/downloads"

# Creating subfolders for different file types, if they don't exist yet.
mkdir -p "$DOWNLOADS_DIR/Images"
mkdir -p "$DOWNLOADS_DIR/Books"
mkdir -p "$DOWNLOADS_DIR/Documents"
mkdir -p "$DOWNLOADS_DIR/Music"
mkdir -p "$DOWNLOADS_DIR/Videos"
mkdir -p "$DOWNLOADS_DIR/Archives"
mkdir -p "$DOWNLOADS_DIR/Torrents"
mkdir -p "$DOWNLOADS_DIR/EXE"
mkdir -p "$DOWNLOADS_DIR/Other"

# Moving files by category
find "$DOWNLOADS_DIR" -maxdepth 1 -type f \( ! -name ".*" \) | while read -r file; do
    # Getting the file extension
    extension="${file##*.}"
    extension="${extension,,}"  # Convert to lowercase

    if [[ "$extension" =~ ^(jpg|jpeg|png|gif|bmp|svg)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Images/"
    elif [[ "$extension" =~ ^(fb2|epub|mobi|djvu)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Books/"
    elif [[ "$extension" =~ ^(pdf|doc|docx|txt|odt|rtf|csv|xls|xlsx|ppt|pptx)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Documents/"        
    elif [[ "$extension" =~ ^(mp3|wav|flac|ogg|aac|m4a|sfk)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Music/"
    elif [[ "$extension" =~ ^(mp4|mkv|avi|mov|flv|wmv)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Videos/"
    elif [[ "$extension" =~ ^(zip|tar|gz|bz2|7z|rar)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Archives/"
    elif [[ "$extension" =~ ^(tor|torr|torrent)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/Torrents/"
    elif [[ "$extension" =~ ^(exe|msi)$ ]]; then
        mv "$file" "$DOWNLOADS_DIR/EXE/"        
    else
        mv "$file" "$DOWNLOADS_DIR/Other/"
    fi
done

echo "The files have been sorted successfully!"