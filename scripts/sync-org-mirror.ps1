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
    throw "Set ARBITRAGE_ROOT to a MarchenkoRuslan/arbitrage checkout."
}

$root = Resolve-ArbitrageRoot
Push-Location $root
try {
    Write-Host "ARBITRAGE_ROOT=$root"
    git fetch origin main
    $tip = git rev-parse origin/main
    Write-Host "origin/main=$tip"
    if ($env:ARB_SYNC_DRY_RUN -eq '1') {
        Write-Host "Dry-run: would run: git push upstream ${tip}:main"
        exit 0
    }
    $env:ARB_SKIP_PREPUSH_CHECKS = '1'
    git push upstream "${tip}:main"
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
