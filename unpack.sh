#!/bin/bash

# Checking the number of arguments
if [ "$#" -ne 1 ]; then
    echo "Error: You must specify exactly one argument."
    echo "Usage: $0 <archive_file>"
    exit 1
fi

# We check that the argument (file name) is specified
if [ -z "$1" ]; then
    echo "Usage: $0 <archive_file>"
    exit 1
fi

# Saving filename
ARCHIVE="$1"

# Checking if the file exists
if [ ! -f "$ARCHIVE" ]; then
    echo "Error: File '$ARCHIVE' does not exist!"
    exit 1
fi

# Defining the file extension
EXTENSION="${ARCHIVE##*.}"

# Checking for the availability of unpacking programs
check_program() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: The required program '$1' is not installed."
        exit 1
    fi
}

# The choice of programs for unpacking
case "$EXTENSION" in
    gz)
        check_program "gunzip"
        gunzip "$ARCHIVE"
        echo "File '$ARCHIVE' has been unpacked using gunzip."
        ;;
    bz2)
        check_program "bunzip2"
        bunzip2 "$ARCHIVE"
        echo "File '$ARCHIVE' has been unpacked using bunzip2."
        ;;
    lzma)
        check_program "unlzma"
        unlzma "$ARCHIVE"
        echo "File '$ARCHIVE' has been unpacked using unlzma."
        ;;
    zip)
        check_program "unzip"
        unzip "$ARCHIVE"
        echo "File '$ARCHIVE' has been unpacked using unzip."
        ;;
    *)
        echo "Error: Unsupported file format. Supported formats: .gz, .bz2, .lzma, .zip"
        exit 1
        ;;
esac
