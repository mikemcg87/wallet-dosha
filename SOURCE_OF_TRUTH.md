# SOURCE OF TRUTH — Wallet Dosha

This file is the canonical reference for scope, stack, and positioning. If any other doc conflicts with this, **this file wins**.

## Product Definition
Wallet Dosha is a financial behavior analysis product that interprets **real transaction data** through an Ayurvedic dosha lens. The core experience is *not* a quiz; it is **transaction‑driven classification** with optional quiz calibration.

## MVP Scope (Hackathon-Ready but Real)
- **Primary flow:** Connect bank (Plaid Sandbox) → extract behavioral features → dosha scoring → insights.
- **Optional calibration:** 10‑question quiz, **under 60 seconds**, used only when transactions are unavailable or to refine confidence.
- **Output:** Dosha balance (Vata/Pitta/Kapha), specific behavioral insights, and 3–5 actionable recommendations.
- **AI/ML:** At least one ML/AI feature is required in MVP (feature extraction + scoring + narrative insight generation).

## Market Positioning
- **Beachhead TAM/SAM:** ~**$500M** (wellness‑conscious personal finance / behavioral finance apps).
- **Do not** lead with multi‑domain $1.8T claims. Those are long‑term vision only.

## Tech Stack (Decided)
**Frontend**
- Next.js (React) — shareable, SEO‑friendly, polished landing/results.

**Backend**
- FastAPI (Python) — typed contracts, clean ML/feature extraction layer.

**Database**
- **Dev default:** SQLite (fast local setup).
- **Dev parity (optional):** Postgres via Docker Compose.
- **Prod:** Postgres (Supabase preferred; VPS Postgres acceptable).

**Plaid**
- **Dev:** Sandbox environment.
- **Prod:** Production only after MVP hardening.

## AI/ML Expectations
MVP must include:
- Transaction‑based feature extraction (timing, volatility, merchant diversity, premium ratio).
- A scoring/classification method (initially weighted heuristics; upgradeable to ML).
- Optional LLM‑generated narrative insights (only if API key available).

## Design Direction
- **Default theme:** Earthy palette (browns, golds, deep greens).
- **Future:** User‑selectable themes.

## Environments (Documented)
| Layer | Dev (default) | Dev (parity) | Prod |
|------|---------------|--------------|------|
| Frontend | Next.js dev server | Same | Next.js build |
| Backend | FastAPI + SQLite | FastAPI + Postgres (Docker) | FastAPI + Postgres (Supabase/VPS) |
| Data | Plaid Sandbox | Plaid Sandbox | Plaid Production |

## Docker Policy
- **Optional in dev** (for Postgres parity and consistency).
- **Recommended for prod** deployments.

## Non‑Goals (for MVP)
- Multi‑domain data (sleep, wearables, etc.)
- Full financial planning or budgeting suite
- Multi‑framework typing (TCM, Enneagram, etc.)
