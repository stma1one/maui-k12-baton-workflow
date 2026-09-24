# MAUI Step Guide Author

`maui-step-guide-author` turns a .NET MAUI project into a source-grounded learning book. It supports three paths:

1. A build-along book for a new project.
2. A roadmap and chapters for an existing project moving toward a user-agreed goal.
3. A UI-replication guide with labelled HTML visual-model snapshots when an emulator is unavailable.

Each chapter uses small visual and MVVM blocks connected to real project files. The final Markdown book can be compiled into HTML and PDF, with a report that rejects unresolved images, clipped/overflowing content, blank PDF pages, page-boundary text, and unreplaced placeholders.

## Companion Contents

```text
skills/maui-step-guide-author/
  SKILL.md
  references/
  scripts/generate_book_pdf.py
  scripts/capture_mockup_blocks.py
  scripts/validate_learning_book.py
  scripts/requirements-learning-book.txt
  evals/evals.json
```

The parent `maui-k12-baton-workflow` package installs this companion automatically for Project, Codex, and Claude Code targets. To use it by itself, run the matching installer from this folder.

## Project Tool Setup

```powershell
python -m pip install -r .\Scripts\Learning-Book-Requirements.txt
python -m playwright install chromium
python .\Scripts\Capture-Mockup-Blocks.py --mockup .\Learning\Mockups\Dashboard.html --screen Dashboard
python .\Scripts\Generate-Learning-Book-Pdf.py
```

The final command writes `Learning/MAUI-Learning-Book.validation.json`; treat a failing report as a blocked publication, not as success.
