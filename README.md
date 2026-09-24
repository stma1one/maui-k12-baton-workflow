# MAUI K12 Baton Workflow Skill

Portable agent-skill package for teaching high-school students to build .NET MAUI projects through staged planning, concept gates, ownership negotiation, implementation, verification, and learning documentation.

The package is designed for:
- Antigravity project agents that read `AGENTS.md` and `.agents/skills`
- Codex local/project skills that read `SKILL.md`
- Claude Code setups that support project instructions and local skills
- Any coding agent where you can paste or reference an instruction file

## What This Skill Solves

Most coding agents move too quickly for students: they ask questions, propose architecture, explain concepts, generate code, and assign tasks all in one heavy response.

This skill forces a baton workflow:

```text
PLANNING_COACH
  -> PLAN_CONFIRMATION
  -> CONCEPT_TUTOR
  -> OWNERSHIP_NEGOTIATOR
  -> EXECUTION_AGENT
  -> CODE_LEARNING_REVIEWER
  -> VERIFICATION_AUDITOR
```

The student receives one cognitive step at a time.

## Package Layout

```text
maui-k12-baton-workflow/
|-- README.md
|-- PACKAGE-MANIFEST.md
|-- AGENTS.md
|-- CLAUDE.md
|-- skills/
|   `-- maui-k12-baton-workflow/
|       |-- SKILL.md
|       `-- references/
|           `-- maui-specialist-guardrails.md
|-- project-template/
|   |-- AGENTS.md
|   |-- .agents/
|   |   |-- MAUI-Agent-Mode.json
|   |   `-- templates/
|   |       `-- phase-status-template.md
|   |-- Learning/
|   |   |-- Current-Phase.md
|   |   |-- MAUI-Learning-Book.md
|   |   `-- Student-Mastery.md
|   `-- Scripts/
|       |-- Audit-DI.ps1 / .sh
|       |-- Capture-Mockup-Blocks.py
|       |-- Generate-Learning-Book-Pdf.ps1
|       |-- Generate-Learning-Book-Pdf.sh
|       |-- Generate-Learning-Book-Pdf.py
|       |-- Validate-Learning-Book.ps1 / .sh / .py
|       |-- Learning-Book-Requirements.txt
|       |-- Record-Learning-Change.ps1 / .sh
|       |-- Set-Maui-Agent-Mode.ps1 / .sh
|       |-- Setup-Skills.ps1 / .sh
|       |-- Validate-Maui-ObsoleteApis.ps1 / .sh
|       |-- Validate-Maui-Version.ps1 / .sh
|       `-- Validate-Maui-XamlResources.ps1 / .sh
`-- scripts/
    |-- Install-Skill.ps1
    `-- Install-Skill.sh

Companion Skill: `maui-step-guide-author` for source-grounded learning books, modular screen guides, generic HTML visual-model snapshots, and validated HTML/PDF book rendering.
```

## Quick Install Into A MAUI Project

### Windows (PowerShell):

From this package folder, if PowerShell script execution is allowed:

```powershell
.\scripts\Install-Skill.ps1 -Target Project -ProjectPath C:\path\to\YourMauiProject
```

Reliable Windows form when script execution is restricted:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Install-Skill.ps1 -Target Project -ProjectPath C:\path\to\YourMauiProject
```

### macOS / Linux (Bash):

From this package folder:

```bash
chmod +x ./scripts/Install-Skill.sh
./scripts/Install-Skill.sh Project /path/to/YourMauiProject
```

Then open the target project in your agent tool and ask it to read `AGENTS.md`.

The installer does not overwrite an existing `AGENTS.md`, `CLAUDE.md`, `MAUI-Agent-Mode.json`, `Current-Phase.md`, `MAUI-Learning-Book.md`, or `Student-Mastery.md`. If those files already exist, merge the template content manually.

The installer also installs `maui-step-guide-author` for Project, Codex, and Claude Code targets, and copies the learning-book scripts into a project `Scripts/` folder. Existing template scripts are skipped rather than overwritten.

### Learning-book tools

In a target project, install the declared Python dependencies before generating visual snapshots or a validated book:

```powershell
python -m pip install -r .\Scripts\Learning-Book-Requirements.txt
python -m playwright install chromium
python .\Scripts\Generate-Learning-Book-Pdf.py
```

The generator writes `Learning/MAUI-Learning-Book.validation.json`. A failed report means the book is not ready to publish.

## Manual Install: Antigravity Project

1. Copy `project-template/AGENTS.md` to the target project root as:

```text
AGENTS.md
```

2. Copy `skills/maui-k12-baton-workflow/` to:

```text
<target-project>/.agents/skills/maui-k12-baton-workflow/
```

3. Copy `project-template/.agents/MAUI-Agent-Mode.json` to:

```text
<target-project>/.agents/MAUI-Agent-Mode.json
```

4. Copy `project-template/.agents/templates/phase-status-template.md` to:

```text
<target-project>/.agents/templates/phase-status-template.md
```

5. Copy the learning templates to:

```text
<target-project>/Learning/Current-Phase.md
<target-project>/Learning/MAUI-Learning-Book.md
<target-project>/Learning/Student-Mastery.md
```

6. Copy `project-template/Scripts/` to:

```text
<target-project>/Scripts/
```

7. Start a new session and verify the first assistant line is:

```text
Mode: MAXIMIZE STUDENT CAPABILITY
```

## Manual Install: Codex

### Project-local install

Use the same Antigravity project install above. Codex sessions that load project `AGENTS.md` and `.agents/skills` will pick up the workflow from the target repository.

### User-wide install

Copy the skill folder to your Codex skills directory:

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.codex\skills"
Copy-Item -Recurse -Force ".\skills\maui-k12-baton-workflow" "$env:USERPROFILE\.codex\skills\maui-k12-baton-workflow"
```

Then place the `project-template/AGENTS.md` file in each MAUI student project where you want the workflow enforced.

## Manual Install: Claude Code

Claude Code projects usually work well with a project instruction file.

1. Copy `CLAUDE.md` to the target project root.
2. Copy `project-template/AGENTS.md` as `AGENTS.md` if your environment also reads AGENTS-style instructions.
3. If your Claude Code setup supports local skills, copy:

```text
skills/maui-k12-baton-workflow/
```

to your configured skills directory.

4. If local skills are not available, paste or reference `skills/maui-k12-baton-workflow/SKILL.md` from `CLAUDE.md`.

## Recommended First Prompt

```text
Use the MAUI K12 Baton Workflow skill.
We are building a .NET MAUI high-school student project.
Start in Student Capability Mode and begin with Planning Coach only.
```

## How To Switch Modes

The project template includes:

```text
.agents/MAUI-Agent-Mode.json
```

Default:

```json
{
  "studentCapabilityMode": true
}
```

Use `true` for teaching mode. Use `false` only when the instructor explicitly wants faster full-code generation.

## Expected Agent Behavior

In Student Capability Mode, the agent must:
- ask only 1-2 planning questions at a time
- summarize and confirm the plan before teaching concepts
- teach only the next concept needed for the approved slice
- require student reasoning before implementation, not just "approve" or "continue"
- treat "I do not know", "do it", "my teacher said it is fine", and similar answers as stuck signals that need hints, rephrasing, or a quick lesson
- classify concepts as crucial, medium, or routine based on project risk and recorded mastery
- default to student-owned core logic with agent scaffolding, hints, and review
- offer routine work as optional practice before the agent handles it
- allow full agent implementation only when unmastered crucial concepts are not being bypassed
- explain the test plan and ask the student to approve intended coverage before treating tests as complete
- run verification before declaring PASS
- update learning artifacts when meaningful changes are made

## Updating The Package

Update the workflow and companion source together:

```text
skills/maui-k12-baton-workflow/SKILL.md
skills/maui-k12-baton-workflow/references/maui-specialist-guardrails.md
project-template/AGENTS.md
project-template/.agents/templates/phase-status-template.md
project-template/Scripts/*.ps1 and *.sh
companion-skills/maui-step-guide-author/skills/maui-step-guide-author/
```

Then update `PACKAGE-MANIFEST.md` with the new version and change summary.

## Validation Checklist

Before publishing:
- `SKILL.md` has YAML frontmatter with `name` and `description`
- `student-capability-gates.md` is included in the skill references
- `AGENTS.md` tells the agent to read mode first
- mode defaults to `studentCapabilityMode: true`
- every waiting state forces a stop
- bypass answers cannot pass concept or ownership gates
- ownership negotiation happens before execution
- README install steps still match the folder layout

## Creator & Attribution

Created by **Tal Simon** (2026).

If you use, adapt, or redistribute this package in your school, organization, or project, please preserve the [NOTICE](file:///c:/Users/Owner/source/repos/MauiSkillTester/SkillPackages/maui-k12-baton-workflow/NOTICE) and [LICENSE](file:///c:/Users/Owner/source/repos/MauiSkillTester/SkillPackages/maui-k12-baton-workflow/LICENSE) files and give credit to the original creator.

## License

This package is licensed under the [Apache License 2.0](file:///c:/Users/Owner/source/repos/MauiSkillTester/SkillPackages/maui-k12-baton-workflow/LICENSE). See `LICENSE` and `NOTICE` for full terms.
