# Skills

A collection of custom Claude skills for automation and productivity.

## Available Skills

### macos-notes

macOS Notes app integration for reading, creating, updating, and searching notes.

### gcp-architect

Expert GCP architecture guidance based on official documentation. Provides recommendations following Google Cloud Architecture Framework principles.

### docker-expert

Expert Docker and container guidance based on official documentation. Covers Dockerfiles, multi-stage builds, Compose, networking, security hardening, and troubleshooting.

## Installation

Add this marketplace to Claude:

```bash
/plugin marketplace add EshginGuluzade/skills
```

Install skills:

```bash
/plugin install macos-skills@skills
/plugin install infra-skills@skills
```

## Creating New Skills

Use the `template/SKILL.md` as a starting point for creating new skills.

## Repository Structure

```
skills/
├── .claude-plugin/
│   └── marketplace.json              # Marketplace catalog
├── plugins/
│   ├── macos-skills/                 # macOS automation plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   └── skills/
│   │       └── macos-notes/
│   │           ├── SKILL.md
│   │           └── scripts/
│   │               └── *.sh
│   └── infra-skills/                 # Infrastructure plugin
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
│           ├── gcp-architect/
│           │   └── SKILL.md
│           └── docker-expert/
│               └── SKILL.md
├── template/
│   └── SKILL.md                      # Skill template
└── README.md
```
