#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

function Resolve-ArbitrageRoot {
    if ($env:ARBITRAGE_ROOT -and (Test-Path $env:ARBITRAGE_ROOT)) {
        return (Resolve-Path $env:ARBITRAGE_ROOT).Path
    }
    $sibling = Join-Path (Split-Path $PSScriptRoot -Parent) '..\arbitrage'
    if (Test-Path $sibling) {
        return (Resolve-Path $sibling).Path
    }
    throw "Set ARBITRAGE_ROOT to a MarchenkoRuslan/arbitrage checkout (scripts/push_frontend_repo.py lives there)."
}

$root = Resolve-ArbitrageRoot
$py = Join-Path $root '.venv\Scripts\python.exe'
if (-not (Test-Path $py)) { $py = 'python' }

Push-Location $root
try {
    Write-Host "ARBITRAGE_ROOT=$root"
    Write-Host '== dry-run =='
    & $py scripts\push_frontend_repo.py --dry-run
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    if ($env:ARB_SYNC_DRY_RUN -eq '1') {
        Write-Host 'ARB_SYNC_DRY_RUN=1: stopping after dry-run'
        exit 0
    }
    Write-Host '== push =='
    & $py scripts\push_frontend_repo.py
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
