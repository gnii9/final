<#
Build and run the full Docker image for the project.
This script builds the main Dockerfile (multivsl:latest) and runs a sample command mounting dataset.
Requires Docker Desktop installed and running.
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

Write-Host "Building full image 'multivsl:latest' from Dockerfile... (may take long)"
docker build -t multivsl:latest .

Write-Host "Running training script (example). This mounts local dataset into /data and sets OUTPUT_DIR."
docker run --rm -it `
  -v "${PWD}:/app" `
  -v "D:\MultiVSL\MultiVSL\dataset:/data" `
  -e OUTPUT_DIR=/data/stgcn_dataset `
  -w /app `
  multivsl:latest `
  sh -c "python code/train_stgcn.py"

Pop-Location
