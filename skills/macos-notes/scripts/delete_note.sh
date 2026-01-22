#!/bin/bash
# Delete a note by name or ID
# Usage: delete_note.sh <note_name_or_id> [folder_name]
# Output: Success message or error

NOTE="$1"
FOLDER="${2:-Notes}"

if [ -z "$NOTE" ]; then
    echo "Error: Note name or ID required"
    exit 1
fi

# Check if it looks like an ID (contains x-coredata)
if [[ "$NOTE" == *"x-coredata"* ]]; then
    osascript -e "tell application \"Notes\"
        try
            set theNote to note id \"$NOTE\"
            delete theNote
            return \"Success: Note deleted\"
        on error errMsg
            return \"Error: \" & errMsg
        end try
    end tell"
else
    osascript -e "tell application \"Notes\"
        tell default account
            try
                set theNote to note \"$NOTE\" of folder \"$FOLDER\"
                delete theNote
                return \"Success: Note deleted\"
            on error errMsg
                return \"Error: \" & errMsg
            end try
        end tell
    end tell"
fi
