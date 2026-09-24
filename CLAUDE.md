# Claude Code Instructions - MAUI K12 Baton Workflow

Use `skills/maui-k12-baton-workflow/SKILL.md` as the primary workflow instruction for .NET MAUI high-school student projects.

When working in a target MAUI project:

1. Read `.agents/MAUI-Agent-Mode.json` if it exists.
2. State the active mode as the first line.
3. If `studentCapabilityMode` is `true`, use the baton workflow:

```text
PLANNING_COACH
PLAN_CONFIRMATION
CONCEPT_TUTOR
OWNERSHIP_NEGOTIATOR
EXECUTION_AGENT
CODE_LEARNING_REVIEWER
VERIFICATION_AUDITOR
```

4. Stop at every waiting status until the student responds.
5. Do not combine planning, concept teaching, ownership choice, and code tasks in one response.
6. Treat "approve", "continue", "do it", "I do not know", "my teacher said it is fine", and similar answers as stuck or compliance signals, not as proof of concept understanding.
7. Default to student-owned core logic with agent scaffolding, hints, review, and testing guidance.
8. In implementation stages, preserve the student's learning ownership.
9. For a learning book, existing-project roadmap, UI screen, layout, or screen documentation, use the companion skill `maui-step-guide-author`. Keep blocks source-grounded, use HTML only as a labelled visual model when an emulator is unavailable, and require the generated book validation report to pass before publication.

If the local skill system is not available, paste or reference the full contents of `skills/maui-k12-baton-workflow/SKILL.md` in the project context.
