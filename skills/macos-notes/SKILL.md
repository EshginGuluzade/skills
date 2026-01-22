---
name: macos-notes
description: Interact with macOS Notes app via AppleScript. Use when Claude needs to read, create, update, delete, or search notes in the macOS Notes application. Triggers on requests like "create a note", "read my notes", "add to my Notes app", "search my notes", "list my notes folders".
---

# macOS Notes

Interact with the macOS Notes app using bundled shell scripts that wrap AppleScript commands.

## Quick Start

List all notes in default folder:
```bash
scripts/list_notes.sh
```

Read a specific note:
```bash
scripts/read_note.sh "Note Title"
```

Create a new note:
```bash
scripts/create_note.sh "My Title" "Note content here"
```

## Available Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `list_folders.sh` | List all folders | `./list_folders.sh` |
| `list_notes.sh` | List notes in folder | `./list_notes.sh [folder]` |
| `read_note.sh` | Read note content | `./read_note.sh <name\|id> [folder]` |
| `create_note.sh` | Create new note | `./create_note.sh <title> <body> [folder]` |
| `update_note.sh` | Update existing note | `./update_note.sh <name\|id> <body> [folder]` |
| `delete_note.sh` | Delete a note | `./delete_note.sh <name\|id> [folder]` |
| `search_notes.sh` | Search all notes | `./search_notes.sh <term>` |
| `create_folder.sh` | Create new folder | `./create_folder.sh <name>` |

## Operations

### List Folders
```bash
scripts/list_folders.sh
# Output: account/folder per line (e.g., "iCloud/Notes")
```

### List Notes
```bash
scripts/list_notes.sh "Notes"
# Output: JSON array [{"name":"...", "id":"..."}]
```

### Read Note
By name (uses default account, specify folder):
```bash
scripts/read_note.sh "Shopping List" "Notes"
```

By ID (works across accounts):
```bash
scripts/read_note.sh "x-coredata://..."
```

Output is HTML. Extract text content by stripping tags.

### Create Note
Plain text (auto-wrapped in HTML):
```bash
scripts/create_note.sh "Meeting Notes" "Discussed project timeline"
```

With HTML formatting:
```bash
scripts/create_note.sh "Formatted" "<div><h1>Title</h1></div><div><ul><li>Item 1</li></ul></div>"
```

In specific folder:
```bash
scripts/create_note.sh "Work Note" "Content" "Work"
```

### Update Note
Replace entire note body:
```bash
scripts/update_note.sh "Shopping List" "<div><h1>Shopping List</h1></div><div>Milk, Eggs, Bread</div>"
```

### Delete Note
```bash
scripts/delete_note.sh "Old Note"
scripts/delete_note.sh "x-coredata://..." # by ID
```

### Search Notes
```bash
scripts/search_notes.sh "project"
# Output: JSON array [{"name":"...", "id":"...", "folder":"..."}]
```

### Create Folder
```bash
scripts/create_folder.sh "Projects"
```

## Notes Format

- Notes body is HTML with `<div>` wrappers
- First line becomes the note title (use `<h1>` in first div)
- Line breaks: `<br>` or separate `<div>` elements
- Lists: `<ul><li>...</li></ul>` or `<ol><li>...</li></ol>`

## Common Workflows

**Add item to existing note:**
1. Read note with `read_note.sh`
2. Append new content to HTML
3. Update with `update_note.sh`

**Backup notes to files:**
1. List notes with `list_notes.sh`
2. Read each with `read_note.sh`
3. Save content to local files

**Move note to different folder:**
1. Read note content
2. Create in new folder
3. Delete from old folder
