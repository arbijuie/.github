# Org sync wrappers

These scripts are **thin entrypoints**. Sync logic stays in the private monorepo:

- `scripts/push_frontend_repo.py`
- `scripts/normalize_frontend_releases.ps1`
- `scripts/open_org_pr.py`

Set `ARBITRAGE_ROOT` to a checkout of `MarchenkoRuslan/arbitrage` (or `arbijuie/arbitrage`), or place that checkout next to this clone as `../arbitrage`.

| Script | Purpose |
| --- | --- |
| `sync-frontend.ps1` / `sync-frontend.sh` | Dry-run then push `frontend/` → `arbijuie/frontend` |
| `normalize-frontend-releases.ps1` | Refresh public release notes on `arbijuie/frontend` |
| `sync-org-mirror.ps1` / `sync-org-mirror.sh` | Fast-forward `arbijuie/arbitrage` `main` from `origin/main` |

See [../SYNC.md](../SYNC.md) for the full procedure.
