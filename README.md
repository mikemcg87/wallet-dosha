# Wallet Dosha 💰🔮

An experimental financial behavior analysis tool that interprets transaction patterns through an Ayurvedic dosha framework.

**Concept:** Analyze transaction data (timing, merchant types, spending patterns) to classify financial behavior as Vata (impulsive), Pitta (competitive), or Kapha (risk-averse).

---

## 📚 Documentation

**Start Here:**
- **[SOURCE_OF_TRUTH.md](SOURCE_OF_TRUTH.md)** - Tech stack, scope, and canonical decisions
- **[HACKATHON_PLAN.md](HACKATHON_PLAN.md)** - Build timeline and team roles

**Background/Research:**
- **[FRAMEWORKS.md](FRAMEWORKS.md)** - What are doshas? Scientific validation.
- **[VISION.md](VISION.md)** - Why we're exploring this concept
- **[RESEARCH_ASSESSMENT.md](RESEARCH_ASSESSMENT.md)** - Market analysis and feasibility

---

## 🎯 What We're Building

A web app that analyzes bank transaction data and classifies financial behavior using three Ayurvedic dosha types:

### The Three Financial Doshas

🌪️ **Vata (Air)** - Impulsive, scattered spending
- Late-night purchases
- High spending volatility
- Many subscriptions
- Variable merchant patterns

🔥 **Pitta (Fire)** - Competitive, status-driven spending
- Premium merchants
- Experience-focused
- Goal-oriented purchases

🏔️ **Kapha (Earth)** - Risk-averse, routine spending
- Essential purchases only
- Same merchants repeatedly
- Low transaction frequency
- Stable patterns

### How It Works

```
1. Connect bank (Plaid Sandbox) or upload synthetic data
2. Extract features from transactions (timing, categories, amounts, patterns)
3. Calculate dosha scores using weighted heuristics
4. Display results with radar chart visualization
5. (Optional) Refine with short quiz or LLM-generated insights
```

### Technical Approach
- **Feature extraction**: Timing patterns, merchant diversity, spending volatility, premium ratio
- **Classification**: Weighted scoring algorithm (with future ML upgrade path)
- **Insights**: Pattern detection + optional AI-generated narrative

---

## 🧬 Research Foundation

**Why doshas?** Ayurvedic constitutional types have surprising scientific backing:

- **Genomic validation**: 52 SNPs differ significantly between Prakriti types (CSIR-TRISUTRA study)
- **HRV correlation**: Kappa coefficient 0.78 agreement between HRV patterns and clinical dosha assessment
- **Psychological correlates**: Vata associated with anxiety, Pitta with stress, Kapha with stability

**The gap**: Zero research exists linking doshas to financial behavior. This is exploratory.

**Our approach**: Map known dosha personality traits (impulsivity, competitiveness, risk-aversion) to observable transaction patterns. It's a hypothesis worth testing.

---

## 🛠️ Tech Stack

**Frontend**
- Next.js (React, TypeScript)
- Tailwind CSS + shadcn/ui
- Recharts (dosha wheel visualization)

**Backend**
- FastAPI (Python 3.11)
- pandas / scikit-learn (feature extraction + scoring)
- Plaid SDK (Sandbox for dev)

**Database**
- SQLite (dev)
- Postgres (prod, if needed)

---

## 👥 Team (4 people)

1. **Backend/ML** - Transaction analysis, dosha scoring, API
2. **Data/Plaid** - Bank integration, synthetic data, feature extraction
3. **Frontend** - UI, dosha wheel viz, responsive design
4. **Design/Strategy** - Aesthetics, demo flow, pitch

---

## 🎯 MVP Goals

**Hackathon/Initial Build:**
- Working transaction analysis → dosha classification
- Beautiful dosha wheel visualization
- Smooth demo (Plaid Sandbox or synthetic data)
- Clear explanation of the concept

**Post-MVP (if we continue):**
- Get 10-20 people to try it and give feedback
- Refine scoring algorithm based on user reactions
- Decide if the concept has legs or needs rethinking

**Success = Learning**
This is an experiment. If the dosha framework doesn't resonate or the classification feels arbitrary, that's valuable data. The goal is to test whether this interpretive lens adds value.

---

## 🙏 Cultural Acknowledgment

We're using Ayurvedic concepts (doshas) developed over 5,000 years in Indian traditional medicine. Key texts: Charaka Samhita, Sushruta Samhita.

**Our approach:**
- Frame as "inspired by" not "validated by" Ayurveda
- Acknowledge this is exploratory - no peer-reviewed research links doshas to financial behavior
- Respect the tradition while testing a novel application
- Not medical advice, not financial advice - it's a personality framework experiment

---

## 📂 Repo Structure

```
wallet-dosha/
├── docs/                      # Strategy/planning docs
│   ├── SOURCE_OF_TRUTH.md
│   ├── VISION.md
│   ├── FRAMEWORKS.md
│   └── ...
├── backend/                   # FastAPI (coming soon)
├── frontend/                  # Next.js (coming soon)
└── README.md                  # You are here
```

---

## 🚀 Getting Started

**For the team:**
1. Read [SOURCE_OF_TRUTH.md](SOURCE_OF_TRUTH.md) - Know what we're building
2. Read [HACKATHON_PLAN.md](HACKATHON_PLAN.md) - Build timeline
3. Set up API keys (Plaid Sandbox, optionally Anthropic)
4. Start building

**Current status:** Planning phase. No code yet.

---

## 📜 License

TBD

---

**An experiment in applying ancient frameworks to modern data.**
