# Sync: private monorepo ↔ org mirrors

This org keeps three related GitHub repositories:

| Repo | Visibility | Role |
| --- | --- | --- |
| `MarchenkoRuslan/arbitrage` | private | Working tree / CI / production source of truth |
| `arbijuie/arbitrage` | private | Org mirror of the same git history (`upstream`) |
| `arbijuie/frontend` | **public** | Standalone `frontend/` tree for the demo product surface |
| `arbijuie/.github` | **public** | Org profile, release index, sync docs/wrappers |

Do **not** push production secrets, host paths under `/home/…`, or live credentials into public repos.

## One-time remotes (workstation)

In a `MarchenkoRuslan/arbitrage` checkout:

```bash
git remote add origin https://github.com/MarchenkoRuslan/arbitrage.git   # if missing
git remote add upstream https://github.com/arbijuie/arbitrage.git
git remote add frontend https://github.com/arbijuie/frontend.git
```

Docs in the private monorepo:

- `docs/operations/git-collaboration.md` — `origin` / `upstream` model
- `docs/operations/open-pr-automation.md` — frontend tree sync
- `docs/operations/index.md` — operations hub links

## After a release tip lands on `main`

Assume tip SHA matches the published tag (example: `v2026.11.13.01` @ `8478933`).

### A) Private org mirror (`arbijuie/arbitrage`)

Fast-forward only — same commits as the personal repo:

```bash
git fetch origin main
git push upstream origin/main:main
# or: git push upstream <release-sha>:main
```

Optional: mirror the GitHub Release on `arbijuie/arbitrage` with the same tag/notes (org members only).

### B) Public frontend (`arbijuie/frontend`)

**Canonical tooling lives in the private monorepo** (do not reimplement):

```bash
# Windows
.\.venv\Scripts\python.exe scripts\push_frontend_repo.py --dry-run
.\.venv\Scripts\python.exe scripts\push_frontend_repo.py

# POSIX
./.venv/bin/python scripts/push_frontend_repo.py --dry-run
./.venv/bin/python scripts/push_frontend_repo.py
```

Then publish / refresh public release notes:

```powershell
# Create the tag on arbijuie/frontend once (targets frontend main tip), then:
powershell -NoProfile -File scripts/normalize_frontend_releases.ps1
```

`normalize_frontend_releases.ps1` rewrites every `arbijuie/frontend` release into the **Public Update** template from `MarchenkoRuslan/arbitrage` notes.

### C) Org profile (`arbijuie/.github`)

Update when the public milestone changes:

- `profile/README.md` — Latest Public Milestone
- `RELEASES.md` — short index

No code tree sync is required here.

### D) PR into org `main` (optional)

Only when developing on a fork branch that must land via PR:

```bash
python scripts/open_org_pr.py
# or: python scripts/open_org_pr.py --branch <name>
```

Direct tip sync (A/B above) does **not** need `open_org_pr.py`.

## Ready wrappers in this repo

Thin wrappers under [`scripts/`](scripts/) call the private monorepo scripts when `ARBITRAGE_ROOT` (or a sibling `../arbitrage` checkout) is available. They do not duplicate sync logic.

## Safety

- Prefer `ARB_SKIP_PREPUSH_CHECKS=1` only when pushing an **already CI-validated** release tip to mirrors.
- Never force-push `upstream` / `origin` `main` except recovery procedures documented privately.
- Frontend standalone push uses `--force-with-lease` by design (tree sync); do not use that against the private monorepo.
