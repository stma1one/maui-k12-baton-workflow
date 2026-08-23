# Agent Instructions - MAUI K12 Baton Workflow Package

This repository is a distributable agent-skill package, not a MAUI app.

## Editing Rules

- Keep `skills/maui-k12-baton-workflow/SKILL.md` portable and tool-agnostic.
- Keep install instructions in `README.md` synchronized with the folder layout.
- Keep `PACKAGE-MANIFEST.md` synchronized with the package contents and version.
- Keep `project-template/AGENTS.md` focused on target MAUI projects.
- Do not add app-specific details from any source project to the reusable package.

## Validation

Before publishing, check:

```text
skills/maui-k12-baton-workflow/SKILL.md
skills/maui-k12-baton-workflow/references/student-capability-gates.md
skills/maui-k12-baton-workflow/references/maui-specialist-guardrails.md
project-template/AGENTS.md
project-template/.agents/MAUI-Agent-Mode.json
project-template/.agents/templates/phase-status-template.md
README.md
PACKAGE-MANIFEST.md
```

The package should install cleanly into a new .NET MAUI student project.

## Distribution Goal

The package should help coding agents teach students gradually:

```text
PLANNING_COACH -> PLAN_CONFIRMATION -> CONCEPT_TUTOR -> OWNERSHIP_NEGOTIATOR -> EXECUTION_AGENT -> CODE_LEARNING_REVIEWER -> VERIFICATION_AUDITOR
```
