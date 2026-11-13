#!/usr/bin/env bash
set -euo pipefail

resolve_root() {
  if [[ -n "${ARBITRAGE_ROOT:-}" && -d "$ARBITRAGE_ROOT" ]]; then
    cd "$ARBITRAGE_ROOT" && pwd
    return
  fi
  local sibling
  sibling="$(cd "$(dirname "$0")/../../arbitrage" 2>/dev/null && pwd || true)"
  if [[ -n "$sibling" && -d "$sibling" ]]; then
    echo "$sibling"
    return
  fi
  echo "Set ARBITRAGE_ROOT to a MarchenkoRuslan/arbitrage checkout." >&2
  exit 1
}

ROOT="$(resolve_root)"
cd "$ROOT"
echo "ARBITRAGE_ROOT=$ROOT"
git fetch origin main
TIP="$(git rev-parse origin/main)"
echo "origin/main=$TIP"
if [[ "${ARB_SYNC_DRY_RUN:-}" == "1" ]]; then
  echo "Dry-run: would run: git push upstream ${TIP}:main"
  exit 0
fi
export ARB_SKIP_PREPUSH_CHECKS=1
git push upstream "${TIP}:main"
