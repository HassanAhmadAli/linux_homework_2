#!/bin/bash

# Create alphabet folders 
for char in {a..z}; do
    mkdir $char 2>/dev/null # Ignore if folder or file exists  with the same name
done

# Move files into correct folders
for file in *; do
    # Get the last character of the file
    last_char=${file: -1}

    # Check if a folder for last char exists
    if [ -d "$last_char" ]; then
        # Move file into folder
        mv "$file" "$last_char"
    else 
        # Folder doesn't exist, check if a file exists 
        if [ -f "$last_char" ]; then
            # A file exists, move to 'old_files' folder 
            mv "$file" "old_files"
        else
            # Neither folder nor file exists, create folder and move file
            mkdir "$last_char" 
            mv "$file" "$last_char"
        fi
    fi 
done