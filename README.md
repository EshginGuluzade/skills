# Skills

A collection of custom Claude skills for automation and productivity.

## Available Skills

### macos-notes

macOS Notes app integration for reading, creating, updating, and searching notes.

## Installation

Add this marketplace to Claude:

```bash
/plugin marketplace add EshginGuluzade/skills
```

Install skills:

```bash
/plugin install macos-skills@skills
```

## Creating New Skills

Use the `template/SKILL.md` as a starting point for creating new skills.

## Repository Structure

```
skills/
├── .claude-plugin/
│   └── marketplace.json    # Plugin marketplace configuration
├── skills/
│   └── macos-notes/        # macOS Notes app skill
├── template/
│   └── SKILL.md            # Skill template
└── README.md
```
