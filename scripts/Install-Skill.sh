#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-Project}"
PROJECT_PATH="${2:-.}"
INSTALL_LEARNING_BOOK_DEPENDENCIES="${3:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(dirname "$SCRIPT_DIR")"
SKILL_SOURCE="$PACKAGE_ROOT/skills/maui-k12-baton-workflow"
TEMPLATE_ROOT="$PACKAGE_ROOT/project-template"
COMPANION_SOURCE="$PACKAGE_ROOT/companion-skills/maui-step-guide-author/skills/maui-step-guide-author"

if [ ! -d "$SKILL_SOURCE" ]; then
    echo "Error: Cannot find skill source: $SKILL_SOURCE" >&2
    exit 1
fi

copy_file_if_missing() {
    local src="$1"
    local dest="$2"
    if [ -f "$dest" ]; then
        echo "Skipped existing file: $dest"
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        echo "Created: $dest"
    fi
}

copy_companion_skill() {
    local destination="$1"
    if [ -d "$COMPANION_SOURCE" ]; then
        mkdir -p "$destination"
        cp -R "$COMPANION_SOURCE/"* "$destination/"
        echo "Installed companion skill: maui-step-guide-author"
    fi
}

case "$TARGET" in
    Project)
        RESOLVED_PROJECT="$(cd "$PROJECT_PATH" && pwd)"

        copy_file_if_missing "$TEMPLATE_ROOT/AGENTS.md" "$RESOLVED_PROJECT/AGENTS.md"

        PROJECT_AGENTS="$RESOLVED_PROJECT/.agents"
        PROJECT_SKILL_DEST="$PROJECT_AGENTS/skills/maui-k12-baton-workflow"
        PROJECT_TEMPLATE_DEST="$PROJECT_AGENTS/templates"
        PROJECT_LEARNING_DEST="$RESOLVED_PROJECT/Learning"
        PROJECT_SCRIPTS_DEST="$RESOLVED_PROJECT/Scripts"

        mkdir -p "$PROJECT_SKILL_DEST"
        cp -R "$SKILL_SOURCE/"* "$PROJECT_SKILL_DEST/"
        copy_companion_skill "$PROJECT_AGENTS/skills/maui-step-guide-author"

        mkdir -p "$PROJECT_TEMPLATE_DEST"
        cp -R "$TEMPLATE_ROOT/.agents/templates/"* "$PROJECT_TEMPLATE_DEST/"

        mkdir -p "$PROJECT_SCRIPTS_DEST"
        for script in "$TEMPLATE_ROOT/Scripts/"*; do
            if [ -f "$script" ]; then
                copy_file_if_missing "$script" "$PROJECT_SCRIPTS_DEST/$(basename "$script")"
            fi
        done
        chmod +x "$PROJECT_SCRIPTS_DEST/"*.sh 2>/dev/null || true

        mkdir -p "$PROJECT_AGENTS"
        copy_file_if_missing "$TEMPLATE_ROOT/.agents/MAUI-Agent-Mode.json" "$PROJECT_AGENTS/MAUI-Agent-Mode.json"

        mkdir -p "$PROJECT_LEARNING_DEST"
        copy_file_if_missing "$TEMPLATE_ROOT/Learning/Current-Phase.md" "$PROJECT_LEARNING_DEST/Current-Phase.md"
        copy_file_if_missing "$TEMPLATE_ROOT/Learning/Student-Mastery.md" "$PROJECT_LEARNING_DEST/Student-Mastery.md"
        copy_file_if_missing "$TEMPLATE_ROOT/Learning/MAUI-Learning-Book.md" "$PROJECT_LEARNING_DEST/MAUI-Learning-Book.md"

        if [ -n "$INSTALL_LEARNING_BOOK_DEPENDENCIES" ] && [ "$INSTALL_LEARNING_BOOK_DEPENDENCIES" != "--install-learning-book-dependencies" ]; then
            echo "Usage: ./scripts/Install-Skill.sh Project [ProjectPath] [--install-learning-book-dependencies]" >&2
            exit 1
        fi

        if [ "$INSTALL_LEARNING_BOOK_DEPENDENCIES" = "--install-learning-book-dependencies" ]; then
            "$TEMPLATE_ROOT/Scripts/Setup-Learning-Book.sh" "$RESOLVED_PROJECT" --install-missing
        else
            "$TEMPLATE_ROOT/Scripts/Setup-Learning-Book.sh" "$RESOLVED_PROJECT"
        fi

        echo "Installed MAUI K12 Baton Workflow into project: $RESOLVED_PROJECT"
        echo "If AGENTS.md already existed, merge project-template/AGENTS.md manually into it."
        ;;
    Codex)
        DEST="$HOME/.codex/skills/maui-k12-baton-workflow"
        mkdir -p "$DEST"
        cp -R "$SKILL_SOURCE/"* "$DEST/"
        copy_companion_skill "$HOME/.codex/skills/maui-step-guide-author"
        echo "Installed Codex skill: $DEST"
        ;;
    ClaudeCode)
        DEST="$HOME/.claude/skills/maui-k12-baton-workflow"
        mkdir -p "$DEST"
        cp -R "$SKILL_SOURCE/"* "$DEST/"
        copy_companion_skill "$HOME/.claude/skills/maui-step-guide-author"
        echo "Installed Claude Code skill: $DEST"
        echo "Also copy CLAUDE.md or project-template/AGENTS.md into the target project root."
        ;;
    *)
        echo "Usage: ./scripts/Install-Skill.sh [Project|Codex|ClaudeCode] [ProjectPath] [--install-learning-book-dependencies]"
        exit 1
        ;;
esac
