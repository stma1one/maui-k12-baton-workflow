param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Project", "Codex", "ClaudeCode")]
    [string] $Target,

    [string] $ProjectPath = "."
)

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$packageRoot = Split-Path -Parent $scriptDir
$skillSource = Join-Path $packageRoot "skills\maui-k12-baton-workflow"
$templateRoot = Join-Path $packageRoot "project-template"

if (-not (Test-Path $skillSource)) {
    throw "Cannot find skill source: $skillSource"
}

function Copy-Directory($Source, $Destination) {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
    Copy-Item -Path (Join-Path $Source "*") -Destination $Destination -Recurse -Force
}

function Copy-DirectoryFilesIfMissing($Source, $Destination) {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null

    Get-ChildItem -Path $Source -File | ForEach-Object {
        Copy-FileIfMissing $_.FullName (Join-Path $Destination $_.Name)
    }
}

function Copy-FileIfMissing($Source, $Destination) {
    if (Test-Path $Destination) {
        Write-Host "Skipped existing file: $Destination"
        return
    }

    $parent = Split-Path -Parent $Destination
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    Copy-Item -Path $Source -Destination $Destination
}

if ($Target -eq "Project") {
    $resolvedProject = Resolve-Path $ProjectPath

    Copy-FileIfMissing (Join-Path $templateRoot "AGENTS.md") (Join-Path $resolvedProject "AGENTS.md")

    $projectAgents = Join-Path $resolvedProject ".agents"
    $projectSkillDest = Join-Path $projectAgents "skills\maui-k12-baton-workflow"
    $projectTemplateDest = Join-Path $projectAgents "templates"
    $projectLearningDest = Join-Path $resolvedProject "Learning"
    $projectScriptsDest = Join-Path $resolvedProject "Scripts"

    Copy-Directory $skillSource $projectSkillDest
    Copy-Directory (Join-Path $templateRoot ".agents\templates") $projectTemplateDest
    Copy-DirectoryFilesIfMissing (Join-Path $templateRoot "Scripts") $projectScriptsDest

    # Also install companion skill maui-step-guide-author if available
    $companionSource = Join-Path $packageRoot "companion-skills\maui-step-guide-author\skills\maui-step-guide-author"
    if (-not (Test-Path $companionSource)) {
        $companionSource = Join-Path (Split-Path -Parent $packageRoot) "maui-step-guide-author\skills\maui-step-guide-author"
    }
    if (Test-Path $companionSource) {
        $projectCompanionDest = Join-Path $projectAgents "skills\maui-step-guide-author"
        Copy-Directory $companionSource $projectCompanionDest
        Write-Host "Installed companion skill: maui-step-guide-author"
    }

    New-Item -ItemType Directory -Force -Path $projectAgents | Out-Null
    Copy-FileIfMissing (Join-Path $templateRoot ".agents\MAUI-Agent-Mode.json") (Join-Path $projectAgents "MAUI-Agent-Mode.json")

    New-Item -ItemType Directory -Force -Path $projectLearningDest | Out-Null
    Copy-FileIfMissing (Join-Path $templateRoot "Learning\Current-Phase.md") (Join-Path $projectLearningDest "Current-Phase.md")
    Copy-FileIfMissing (Join-Path $templateRoot "Learning\Student-Mastery.md") (Join-Path $projectLearningDest "Student-Mastery.md")
    Copy-FileIfMissing (Join-Path $templateRoot "Learning\MAUI-Learning-Book.md") (Join-Path $projectLearningDest "MAUI-Learning-Book.md")

    Write-Host "Installed MAUI K12 Baton Workflow into project: $resolvedProject"
    Write-Host "If AGENTS.md already existed, merge project-template\AGENTS.md manually into it."
    return
}

if ($Target -eq "Codex") {
    $dest = Join-Path $env:USERPROFILE ".codex\skills\maui-k12-baton-workflow"
    Copy-Directory $skillSource $dest
    Write-Host "Installed Codex skill: $dest"
    return
}

if ($Target -eq "ClaudeCode") {
    $dest = Join-Path $env:USERPROFILE ".claude\skills\maui-k12-baton-workflow"
    Copy-Directory $skillSource $dest
    Write-Host "Installed Claude Code skill: $dest"
    Write-Host "Also copy CLAUDE.md or project-template\AGENTS.md into the target project root."
    return
}
