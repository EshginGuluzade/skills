#!/bin/bash
# Search notes by content
# Usage: search_notes.sh <search_term>
# Output: JSON array of matching notes with name, id, and snippet

SEARCH="$1"

if [ -z "$SEARCH" ]; then
    echo "Error: Search term required"
    exit 1
fi

osascript -e "tell application \"Notes\"
    set output to \"[\"
    set isFirst to true
    set searchTerm to \"$SEARCH\"

    repeat with acc in every account
        repeat with f in every folder of acc
            repeat with n in every note of f
                set noteBody to body of n as text
                set noteName to name of n

                if noteBody contains searchTerm or noteName contains searchTerm then
                    set noteId to id of n
                    set folderName to name of f

                    -- Escape quotes in name
                    set AppleScript's text item delimiters to \"\\\"\"
                    set nameItems to text items of noteName
                    set AppleScript's text item delimiters to \"\\\\\\\"\"
                    set escapedName to nameItems as text
                    set AppleScript's text item delimiters to \"\"

                    if isFirst then
                        set isFirst to false
                    else
                        set output to output & \",\"
                    end if
                    set output to output & \"{\\\"name\\\":\\\"\" & escapedName & \"\\\",\\\"id\\\":\\\"\" & noteId & \"\\\",\\\"folder\\\":\\\"\" & folderName & \"\\\"}\"
                end if
            end repeat
        end repeat
    end repeat
    return output & \"]\"
end tell"
