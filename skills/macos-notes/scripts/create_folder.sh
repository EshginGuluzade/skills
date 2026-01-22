#!/bin/bash
# Create a new folder in Notes
# Usage: create_folder.sh <folder_name>
# Output: Success message or error

FOLDER="$1"

if [ -z "$FOLDER" ]; then
    echo "Error: Folder name required"
    exit 1
fi

osascript -e "tell application \"Notes\"
    tell default account
        try
            make new folder with properties {name:\"$FOLDER\"}
            return \"Success: Folder '$FOLDER' created\"
        on error errMsg
            return \"Error: \" & errMsg
        end try
    end tell
end tell"
