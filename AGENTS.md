# Agent Instructions - MAUI K12 Baton Workflow Package

This repository is a distributable agent-skill package, not a MAUI app.

## Editing Rules

- Keep `skills/maui-k12-baton-workflow/SKILL.md` portable and tool-agnostic.
- Keep install instructions in `README.md` synchronized with the folder layout.
- Keep `PACKAGE-MANIFEST.md` synchronized with the package contents and version.
- Keep `project-template/AGENTS.md` focused on target MAUI projects.
- Keep theory evidence, applied coding evidence, and routine-eligibility rules consistent across the workflow, references, templates, and install-time defaults.
- Do not add app-specific details from any source project to the reusable package.

## Validation

Before publishing, check:

```text
skills/maui-k12-baton-workflow/SKILL.md
skills/maui-k12-baton-workflow/references/student-capability-gates.md
skills/maui-k12-baton-workflow/references/maui-specialist-guardrails.md
skills/maui-k12-baton-workflow/evals/evals.json
companion-skills/maui-step-guide-author/skills/maui-step-guide-author/SKILL.md
companion-skills/maui-step-guide-author/skills/maui-step-guide-author/scripts/
project-template/AGENTS.md
project-template/.agents/MAUI-Agent-Mode.json
project-template/.agents/templates/phase-status-template.md
project-template/Learning/Current-Phase.md
project-template/Learning/Student-Mastery.md
project-template/Scripts/Setup-Skills.ps1
project-template/Scripts/Setup-Skills.sh
AGENTS.md
CLAUDE.md
README.md
PACKAGE-MANIFEST.md
```

The package should install cleanly into a new .NET MAUI student project.
Validate PowerShell and Bash installation paths so each installs the companion skill and learning-book tools.

## Distribution Goal

The package should help coding agents teach students gradually:

```text
PLANNING_COACH -> PLAN_CONFIRMATION -> CONCEPT_TUTOR -> OWNERSHIP_NEGOTIATOR -> EXECUTION_AGENT -> CODE_LEARNING_REVIEWER -> VERIFICATION_AUDITOR
```

Theory readiness unlocks guided practice. Only theory evidence plus student-authored coding evidence can make a concept routine-eligible for agent-owned repetition.
