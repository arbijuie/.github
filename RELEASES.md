# Arbijuie public release index

Canonical product notes live on **[arbijuie/frontend releases](https://github.com/arbijuie/frontend/releases)**.  
Private core milestones are mirrored on **[arbijuie/arbitrage releases](https://github.com/arbijuie/arbitrage/releases)** (org members).

Source of truth for engineering notes: `MarchenkoRuslan/arbitrage` tags (private personal fork / working tree).

## Latest

| Tag | Public frontend | Notes |
| --- | --- | --- |
| `v2026.11.13.01` | [Public Update](https://github.com/arbijuie/frontend/releases/tag/v2026.11.13.01) | Screener freshness, Telegram-only auth, VOOI MarketState flag, Nautilus removal. Monorepo tip `8478933`. Live trading still off by default. |
| `v2026.10.31` | [Public Update](https://github.com/arbijuie/frontend/releases/tag/v2026.10.31) | Trader UX, fail-closed execution, VOOI broker surface, Telegram alerts |

## How notes are published

From a checkout of `MarchenkoRuslan/arbitrage` on the release tip:

1. `python scripts/push_frontend_repo.py` — tree-sync `frontend/` → `arbijuie/frontend`
2. `gh release create <tag> --repo arbijuie/frontend ...` (if the tag is new)
3. `powershell -File scripts/normalize_frontend_releases.ps1` — rewrite titles/bodies into the public template

See [SYNC.md](SYNC.md) for the full mirror loop (private ↔ frontend ↔ this profile).
