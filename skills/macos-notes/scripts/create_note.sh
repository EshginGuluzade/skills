#!/bin/bash
# Create a new note
# Usage: create_note.sh <title> <body> [folder_name]
# Body can be plain text or HTML
# Output: Note ID of created note

TITLE="$1"
BODY="$2"
FOLDER="${3:-Notes}"

if [ -z "$TITLE" ]; then
    echo "Error: Title required"
    exit 1
fi

if [ -z "$BODY" ]; then
    BODY=""
fi

# Escape special characters for AppleScript
escape_for_applescript() {
    local str="$1"
    str="${str//\\/\\\\}"
    str="${str//\"/\\\"}"
    echo "$str"
}

ESCAPED_TITLE=$(escape_for_applescript "$TITLE")
ESCAPED_BODY=$(escape_for_applescript "$BODY")

# Wrap in HTML if plain text
if [[ "$ESCAPED_BODY" != *"<"* ]]; then
    ESCAPED_BODY="<div><h1>$ESCAPED_TITLE</h1></div><div>$ESCAPED_BODY</div>"
fi

osascript -e "tell application \"Notes\"
    tell default account
        try
            set newNote to make new note at folder \"$FOLDER\" with properties {name:\"$ESCAPED_TITLE\", body:\"$ESCAPED_BODY\"}
            return id of newNote
        on error errMsg
            return \"Error: \" & errMsg
        end try
    end tell
end tell"
