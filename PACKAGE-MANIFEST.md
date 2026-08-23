# Package Manifest

Package: MAUI K12 Baton Workflow Skill
Version: 1.0.4
Status: ready-to-install

## Purpose

Reusable agent workflow for .NET MAUI high-school student projects. It prevents coding agents from overwhelming students by splitting feature work into planning, confirmation, concept teaching, ownership negotiation, execution, and verification stages.

## Included Files

```text
README.md
PACKAGE-MANIFEST.md
AGENTS.md
CLAUDE.md
skills/maui-k12-baton-workflow/SKILL.md
skills/maui-k12-baton-workflow/references/maui-specialist-guardrails.md
skills/maui-k12-baton-workflow/references/student-capability-gates.md
project-template/AGENTS.md
project-template/.agents/MAUI-Agent-Mode.json
project-template/.agents/templates/phase-status-template.md
project-template/Learning/Current-Phase.md
project-template/Learning/MAUI-Learning-Book.md
project-template/Learning/Student-Mastery.md
project-template/Scripts/Audit-DI.ps1
project-template/Scripts/Audit-DI.sh
project-template/Scripts/Record-Learning-Change.ps1
project-template/Scripts/Record-Learning-Change.sh
project-template/Scripts/Set-Maui-Agent-Mode.ps1
project-template/Scripts/Set-Maui-Agent-Mode.sh
project-template/Scripts/Setup-Skills.ps1
project-template/Scripts/Setup-Skills.sh
project-template/Scripts/Validate-Maui-ObsoleteApis.ps1
project-template/Scripts/Validate-Maui-ObsoleteApis.sh
project-template/Scripts/Validate-Maui-Version.ps1
project-template/Scripts/Validate-Maui-Version.sh
project-template/Scripts/Validate-Maui-XamlResources.ps1
project-template/Scripts/Validate-Maui-XamlResources.sh
scripts/Install-Skill.ps1
scripts/Install-Skill.sh
```

## Skill Metadata

Name:

```text
maui-k12-baton-workflow
```

Primary trigger:

```text
Use for any .NET MAUI K12/high-school student project where the agent should teach through staged planning, concept gates, ownership negotiation, implementation hand-offs, verification, and learning documentation.
```

## Compatibility

Expected to work with:
- Antigravity project instructions using `AGENTS.md`
- Codex project-local or user-wide skills
- Claude Code project instructions using `CLAUDE.md`
- Manual agent setups that can ingest `SKILL.md`

## Required Target Project Files

Minimum install:

```text
AGENTS.md
.agents/skills/maui-k12-baton-workflow/SKILL.md
.agents/skills/maui-k12-baton-workflow/references/maui-specialist-guardrails.md
.agents/MAUI-Agent-Mode.json
.agents/templates/phase-status-template.md
Learning/Current-Phase.md
Learning/MAUI-Learning-Book.md
Learning/Student-Mastery.md
Scripts/*.ps1
```

## Included Validation Scripts

```text
Audit-DI.ps1
Record-Learning-Change.ps1
Set-Maui-Agent-Mode.ps1
Setup-Skills.ps1
Validate-Maui-ObsoleteApis.ps1
Validate-Maui-Version.ps1
Validate-Maui-XamlResources.ps1
```

## Default Mode

```json
{
  "studentCapabilityMode": true
}
```

## Baton Stages

```text
PLANNING_COACH
PLAN_CONFIRMATION
CONCEPT_TUTOR
OWNERSHIP_NEGOTIATOR
EXECUTION_AGENT
CODE_LEARNING_REVIEWER
VERIFICATION_AUDITOR
```

## Waiting Status Values

```text
PLANNING_WITH_STUDENT
PLAN_APPROVAL_PENDING
CONCEPT_GATE_PENDING
OWNERSHIP_SELECTION_PENDING
WAITING_FOR_STUDENT
READY_TO_VERIFY
COMPLETE
BLOCKED
```

## Validation Notes

The package is documentation/instruction-only. It does not contain compiled code or NuGet dependencies.

Manual validation should confirm:
- frontmatter exists in `SKILL.md`
- install script parses in PowerShell
- package paths match README instructions
- no generated project secrets are included

## 1.0.4 Hardening Notes

- Added `references/student-capability-gates.md` with explicit anti-bypass handling for "continue", "approve", "do it", "I do not know", "teacher said it is fine", and similar responses.
- Added mastery-aware concept weighting so first exposure to configuration, boilerplate, tests, DI, navigation, and core architecture requires understanding evidence before it can become routine.
- Changed Student Capability Mode ownership defaults toward student-owned core logic with agent scaffold, hints, review, and guided implementation for difficult code.
- Added practice-offer and testing-plan expectations so the agent can handle tests while teaching coverage and edge-case thinking.
- Updated project templates for current-phase needs, mastery evidence, stuck-student support, and stricter ownership negotiation.

## 1.0.3 Hardening Notes

- Added Targeted Documentation Verification (High-Friction Triggers) to `references/maui-specialist-guardrails.md` for SQLite native packages, MAUI platform controls (WebView, Camera), and Cloud SDKs (Firebase/Firestore).
- Updated `AGENTS.md` and `SKILL.md` to mandate live documentation verification at high-friction points before generating code.

## 1.0.2 Hardening Notes

- Added cross-platform POSIX Bash (`.sh`) equivalents for all PowerShell scripts under `project-template/Scripts/` and `scripts/Install-Skill.sh`.
- Updated `AGENTS.md`, `SKILL.md`, and references with cross-platform verification commands for Windows, macOS, and Linux.

## 1.0.1 Hardening Notes

- Added all project validation/support scripts under `project-template/Scripts`.
- Added `Learning/MAUI-Learning-Book.md` to the project template and installer.
- Updated `Setup-Skills.ps1` for the portable `maui-k12-baton-workflow` skill name.
- Added `references/maui-specialist-guardrails.md` so the portable workflow preserves the original specialist MAUI rules without bloating `SKILL.md`.
- Updated install docs with an `-ExecutionPolicy Bypass` command for Windows machines that block direct `.ps1` execution.

## License

No license file is included. Add one before public distribution if required by your school, district, or organization.
