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
  echo "Set ARBITRAGE_ROOT to a MarchenkoRuslan/arbitrage checkout (scripts/push_frontend_repo.py lives there)." >&2
  exit 1
}

ROOT="$(resolve_root)"
cd "$ROOT"
if [[ -x ./.venv/bin/python ]]; then
  PY=./.venv/bin/python
else
  PY=python3
fi

echo "ARBITRAGE_ROOT=$ROOT"
echo "== dry-run =="
"$PY" scripts/push_frontend_repo.py --dry-run
if [[ "${ARB_SYNC_DRY_RUN:-}" == "1" ]]; then
  echo "ARB_SYNC_DRY_RUN=1: stopping after dry-run"
  exit 0
fi
echo "== push =="
"$PY" scripts/push_frontend_repo.py
