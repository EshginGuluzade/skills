#!/bin/bash
# Update an existing note's content
# Usage: update_note.sh <note_name_or_id> <new_body> [folder_name]
# Output: Success message or error

NOTE="$1"
BODY="$2"
FOLDER="${3:-Notes}"

if [ -z "$NOTE" ]; then
    echo "Error: Note name or ID required"
    exit 1
fi

if [ -z "$BODY" ]; then
    echo "Error: New body content required"
    exit 1
fi

# Escape special characters for AppleScript
escape_for_applescript() {
    local str="$1"
    str="${str//\\/\\\\}"
    str="${str//\"/\\\"}"
    echo "$str"
}

ESCAPED_BODY=$(escape_for_applescript "$BODY")

# Check if it looks like an ID (contains x-coredata)
if [[ "$NOTE" == *"x-coredata"* ]]; then
    osascript -e "tell application \"Notes\"
        try
            set theNote to note id \"$NOTE\"
            set body of theNote to \"$ESCAPED_BODY\"
            return \"Success: Note updated\"
        on error errMsg
            return \"Error: \" & errMsg
        end try
    end tell"
else
    osascript -e "tell application \"Notes\"
        tell default account
            try
                set theNote to note \"$NOTE\" of folder \"$FOLDER\"
                set body of theNote to \"$ESCAPED_BODY\"
                return \"Success: Note updated\"
            on error errMsg
                return \"Error: \" & errMsg
            end try
        end tell
    end tell"
fi
