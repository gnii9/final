<#
run_all.ps1
PowerShell helper to build the `model` Docker image (contains dataset) and optionally build frontend/backend if Dockerfiles exist.

Usage: Run from repository root `d:\MultiVSL\MultiVSL`:
  .\run_all.ps1 -BuildFrontend -BuildBackend -BuildModel

Examples:
  .\run_all.ps1 -BuildModel
  .\run_all.ps1 -BuildFrontend -BuildBackend -BuildModel
#>

param(
    [switch]$BuildFrontend,
    [switch]$BuildBackend,
    [switch]$BuildModel
)

function Check-Docker {
    try {
        docker version | Out-Null
        return $true
    } catch {
        Write-Error "Docker does not appear to be available. Please install and start Docker Desktop."
        return $false
    }
}

if (-not (Check-Docker)) { exit 1 }

if ($BuildFrontend) {
    if (Test-Path "frontend-react/Dockerfile") {
        Write-Host "Building frontend image..."
        docker build -t frontend:local ./frontend-react
    } else {
        Write-Host "No Dockerfile found in frontend-react/. Skipping frontend build."
    }
}

if ($BuildBackend) {
    if (Test-Path "backend/Dockerfile") {
        Write-Host "Building backend image..."
        docker build -t backend:local ./backend
    } else {
        Write-Host "No Dockerfile found in backend/. Skipping backend build."
    }
}

if ($BuildModel) {
    if (Test-Path "Dockerfile") {
        Write-Host "Building model image (includes dataset if present in repo)..."
        docker build -t multivsl:with-data .
    } else {
        Write-Host "No Dockerfile found at repo root. Skipping model build."
    }
}

Write-Host "Done."
