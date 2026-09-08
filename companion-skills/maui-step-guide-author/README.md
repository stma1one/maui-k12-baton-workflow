# MAUI Step Guide Author Skill Package

This package provides the **`maui-step-guide-author`** skill, bringing the acclaimed pedagogical methodology of **Leomaris Reyes** (creator of AskXammy.com and Telerik .NET MAUI guides) into .NET MAUI student projects.

## Key Features

1. **Interactive Pedagogical Intake (Phase 0)**: Brief, guided intake offering 3 distinct guide archetypes (Full 3-Phase Golden Path, Focused Screen Replication, Collections & Master-Detail) before authoring.
2. **Dual-Block Strategy**: Symmetrical, modular block deconstruction applied equally to both the XAML View (6 layout blocks) and the C# ViewModel (6 logical code blocks).
3. **7 Generalized Analytical Tables**: Pedagogical tabular blueprints mapping Domain Models, ViewModel State, Commands & CanExecute, XAML element-to-property bindings, Service Contracts, Loading/Feedback states, and Form Validation.
4. **Dedicated Data Loading & Feedback**: Complete guide section for `ActivityIndicator`, `IsLoading`, derived `IsNotLoading`, `CanExecute` guardrails, and mandatory `try-catch-finally` cleanup.
5. **Print-Perfect PDF Layout Standards**: Strict CSS and layout rules preventing table column clipping (tight padding, soft-wrapping code, scaled typography) and avoiding orphaned headings or blank pages.
6. **HTML/Browser Visual Mockups**: Creates responsive HTML/CSS mobile mockups captured via browser agents to produce authentic visual progression diagrams.
7. **Didactic Concept Callouts ("✏️ פינת העמקה")**: Explains tricky properties (e.g. `StringFormat` with Microsoft Learn links, negative margins, gradients, `CanExecute`) with official Microsoft Learn references.
8. **K-12 Hebrew Standard**: All teaching and explanations written in fluent Hebrew, keeping code identifiers in clean English.

## Installation

### Into Current Project

**PowerShell:**
```powershell
.\SkillPackages\maui-step-guide-author\scripts\Install-Skill.ps1 -Target Project
```

**Bash:**
```bash
./SkillPackages/maui-step-guide-author/scripts/Install-Skill.sh --target Project
```

### Global Host Installation

**Claude Code:**
```powershell
.\SkillPackages\maui-step-guide-author\scripts\Install-Skill.ps1 -Target ClaudeCode
```

**Codex:**
```powershell
.\SkillPackages\maui-step-guide-author\scripts\Install-Skill.ps1 -Target Codex
```
