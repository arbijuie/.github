# Arbijuie

Risk-first tooling for cross-exchange perps funding arbitrage — clear operator workflows, controlled decisions, and measured rollout.

## What You Can See Publicly

- **[frontend](https://github.com/arbijuie/frontend)** — public product surface for deals, health, operations, and operator feedback  
  Live demo: [141-148-244-93.sslip.io](https://141-148-244-93.sslip.io)
- **[arbitrage](https://github.com/arbijuie/arbitrage)** — private organization mirror for collaboration, release traceability, and internal workflows (not an open-source dump of the full stack)

## Latest Public Milestone

[`frontend` release `v2026.11.15.01`](https://github.com/arbijuie/frontend/releases/tag/v2026.11.15.01) — memory-safe stop/artifact calibration (no full ~1.9M snapshot load), RecordedDataStore Phases 0–3 behind flags default off, and project-board cleanup automation.

Live trading with real money stays **off by default**. This milestone is about collector stability and storage readiness, not flipping the live switch.

## Public Release Streams

- [Frontend releases](https://github.com/arbijuie/frontend/releases) — product-facing timeline and changelog
- [Core mirror releases](https://github.com/arbijuie/arbitrage/releases) — operational milestones mirrored for organization visibility
- [Release index](../RELEASES.md) — short public index of recent tags

## Sync (operators)

How the private monorepo, public frontend, and this profile stay aligned:

- Instructions: [SYNC.md](../SYNC.md)
- Ready wrappers (call private-repo tooling): [scripts/](../scripts/)

## Why This Matters

Funding markets are fragmented and operationally noisy. Most tooling underinvests in risk-first execution. We convert that inefficiency into repeatable, controlled decision flows — reliability and controls before scale.

## Execution Principles

- Reliability before scale
- Risk controls before automation depth
- Measured rollout with audit-friendly changes
- Transparent communication through public mirrors

## Current Stage

- Soft-public phase through the frontend surface
- Mid-November cut published (`v2026.11.15.01`)
- Next gates remain explicit: RecordedDataStore host parity / Phase 4, VOOI execution canary, and distribution / go-live sign-off — not claimed as done

## Contact

Share interest, partnership ideas, or strategic context via [frontend issues](https://github.com/arbijuie/frontend/issues).
