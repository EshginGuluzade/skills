#!/bin/bash
# List all folders in macOS Notes
# Output: One folder name per line

osascript -e 'tell application "Notes"
    set folderNames to {}
    repeat with acc in every account
        repeat with f in every folder of acc
            set end of folderNames to (name of acc) & "/" & (name of f)
        end repeat
    end repeat
    set AppleScript'\''s text item delimiters to linefeed
    return folderNames as text
end tell'
