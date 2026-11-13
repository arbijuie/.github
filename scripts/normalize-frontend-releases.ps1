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
$script = Join-Path $root 'scripts\normalize_frontend_releases.ps1'
if (-not (Test-Path $script)) {
    throw "Missing $script"
}

Write-Host "ARBITRAGE_ROOT=$root"
powershell -NoProfile -File $script
exit $LASTEXITCODE
