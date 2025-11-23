<#
push_to_github.ps1
Helper to init git (if needed), add the three folders and support files, commit and push to GitHub.

Usage:
  .\push_to_github.ps1 -RemoteUrl https://github.com/you/repo.git

Parameters:
  -RemoteUrl: (optional) remote repository URL. If omitted, script will only create the commit locally.
  -Branch: branch name to push (default: main)
  -UseLFS: enable Git LFS tracking for `dataset/` before committing
#>

param(
    [string]$RemoteUrl = $null,
    [string]$Branch = "main",
    [switch]$UseLFS
)

function Check-Command {
    param([string]$cmd)
    try {
        & $cmd --version >$null 2>&1
        return $true
    } catch {
        return $false
    }
}

if (-not (Check-Command -cmd "git")) {
    Write-Error "git is not installed or not in PATH. Install Git before running this script."
    exit 1
}

if ($UseLFS) {
    if (-not (Check-Command -cmd "git lfs")) {
        Write-Host "Installing git-lfs..."
        git lfs install
    } else {
        git lfs install
    }
    git lfs track "dataset/**" | Out-Null
    Write-Host "Git LFS tracking added for dataset/**"
}

# Initialize repo if needed
if (-not (Test-Path ".git")) {
    Write-Host "Initializing git repository..."
    git init
}

# Files/folders to add
$toAdd = @(
    "MultiVSL",
    "VSign_AI_SudoCode2025_new",
    "frontend-react",
    ".gitignore",
    ".gitattributes",
    "README.md",
    "run_all.ps1",
    "DOCKER_RUN.md"
)

# Keep only existing paths
$existing = $toAdd | Where-Object { Test-Path $_ }

if (-not $existing) {
    Write-Error "No specified folders/files found to add. Check paths and run again."
    exit 1
}

Write-Host "Adding paths: $($existing -join ', ')"
git add -- $existing

$msg = "Add MultiVSL, VSign_AI_SudoCode2025_new and frontend-react with helper files"
git commit -m "$msg"

if ($RemoteUrl) {
    # add or update remote
    $remotes = git remote
    if ($remotes -contains 'origin') {
        git remote set-url origin $RemoteUrl
    } else {
        git remote add origin $RemoteUrl
    }

    git branch -M $Branch
    Write-Host "Pushing to $RemoteUrl on branch $Branch..."
    git push -u origin $Branch
} else {
    Write-Host "Commit created locally. Provide -RemoteUrl to push to a remote repository."
}

Write-Host "Done."
