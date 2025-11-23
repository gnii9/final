<#
Lightweight smoke-test script for Windows PowerShell.
1) Builds `multivsl:test-smoke` from `Dockerfile.slim` (fast: no dataset, minimal packages)
2) Runs two checks inside the container: Python version and `cv2` import
3) Prints output and exit code for each step
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)
Write-Host "Building smoke-test image 'multivsl:test-smoke' from Dockerfile.slim..."
docker build -f Dockerfile.slim -t multivsl:test-smoke .

Write-Host "Running smoke test: python version"
docker run --rm multivsl:test-smoke python -c "import sys; print('PY', sys.version)"

Write-Host "Running smoke test: import cv2"
docker run --rm multivsl:test-smoke python -c "import cv2; print('CV2', cv2.__version__)"

Write-Host "Smoke tests completed. If both commands printed version info, minimal runtime is OK."
Pop-Location
