#!/bin/bash
# List all notes in a folder
# Usage: list_notes.sh [folder_name]
# Default folder: "Notes"
# Output: JSON array with note name and id

FOLDER="${1:-Notes}"

osascript -e "tell application \"Notes\"
    set output to \"[\"
    set isFirst to true
    tell default account
        try
            set notesList to every note of folder \"$FOLDER\"
            repeat with n in notesList
                set noteName to name of n
                set noteId to id of n
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
                set output to output & \"{\\\"name\\\":\\\"\" & escapedName & \"\\\",\\\"id\\\":\\\"\" & noteId & \"\\\"}\"
            end repeat
        on error errMsg
            return \"Error: \" & errMsg
        end try
    end tell
    return output & \"]\"
end tell"
