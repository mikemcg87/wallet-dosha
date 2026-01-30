# Wallet Dosha: Research Assessment & Hackathon Viability Analysis

*Research conducted January 2026 via Perplexity Deep Research across 200+ sources*

**Alignment update (Jan 2026):** The team has chosen a **transaction‑first MVP** with **Plaid Sandbox + ML/AI scoring**, and a **60‑second optional quiz** for calibration. This is more ambitious than the original 6‑hour scope; plan for **8–12 hours** or reduce surface area.

---

## Executive Summary

**Verdict: The core thesis is sound, the market gap is real, and a 6-hour AI-assisted hackathon can produce something genuinely impressive.**

However, several strategic adjustments are needed to maximise impact. This document covers:

1. [Competitive Landscape](#1-competitive-landscape) - Who's doing what, and what nobody's doing
2. [Scientific Validity](#2-scientific-validity-of-dosha-classification) - How defensible is the dosha framework?
3. [Market Opportunity](#3-market-opportunity) - Size, trends, funding signals
4. [Hackathon Feasibility](#4-hackathon-feasibility) - What's realistic in 6 hours with AI tools
5. [Critical Assessment & Risks](#5-critical-assessment--risks) - Honest problems with the plan
6. [Recommended Hackathon Scope](#6-recommended-hackathon-scope) - What to actually build

---

## 1. Competitive Landscape

### The Big Players (Post-Mint Vacuum)

| App | Funding | ARR/Users | Personality Approach |
|-----|---------|-----------|---------------------|
| **Cleo** | $175M (11 rounds) | $280M ARR (Jul 2025) | AI chatbot with "roast mode" / "hype mode" - personality via tone, not classification |
| **Monarch Money** | $75M Series B (May 2025) | $850M valuation, 20x user growth post-Mint | Comprehensive dashboard, no personality typing |
| **Rocket Money** | $45M Series D | $1B valuation, 7M+ users | Subscription cancellation focus, behavioural nudges |
| **Copilot Money** | $6M Series A | Profitable since 2023 | AI-driven spending categorisation, design-first |
| **YNAB** | Bootstrapped | Undisclosed | Zero-based budgeting *methodology* as personality alignment |
| **Empower** | N/A (wealth mgmt) | Large user base | Investment-focused, no behavioural layer |

### The Gap Wallet Dosha Fills

**No major consumer fintech app currently uses:**
- Ayurvedic doshas or any ancient wisdom framework for financial classification
- Non-Western psychological frameworks of any kind
- Wellness data (sleep, HRV, wearables) integrated with financial behaviour
- A personality-first approach where classification drives the entire UX

**Adjacent players approaching the space:**
- **Wellth** ($36M Series C) - behavioural economics + financial incentives for health actions
- **Enrich** - white-label "Money Personality" evaluation for credit unions
- **Dacadoo** - digital health engagement platform for banks (4.9% healthcare cost reduction)
- **Finasana** - financial education + yoga/wellness philosophy (early stage)
- **Calm/Headspace** - mindfulness apps adding financial wellness content

### Key Insight
The market is converging on the thesis that financial behaviour is psychological, not rational. Cleo proved this with $280M ARR. But *nobody* is using a structured classification framework from outside Western behavioural economics. The dosha framework offers genuine differentiation - not just another budgeting app with AI chat.

---

## 2. Scientific Validity of Dosha Classification

### What the Science Actually Says

**Strong evidence (genomic/molecular level):**
- CSIR-TRISUTRA programme at CSIR-IGIB: genome-wide SNP analysis of 262 individuals found **52 SNPs significantly different between Prakriti types** (p <= 1x10^-5)
- Principal component analysis of these SNPs **successfully classified individuals into Vata/Pitta/Kapha regardless of ancestral background**
- CYP2C19 drug metabolism genotypes: Pitta individuals showed 91% extensive metabolizer genotypes vs 31% poor metabolizer in Kapha - directly validating ancient descriptions of Pitta as "fast metabolizers"
- DNA methylation signatures differ across dosha types (CDH22 methylation in Kapha correlates with higher BMI)
- Metabolomics: distinct metabolic pathway signatures per dosha type

**Moderate evidence (physiological):**
- HRV study (379 subjects): Kapha showed significantly lower baseline HRV and minimal change during orthostatic stress vs Vata/Pitta
- HRV-clinical dosha assessment concordance: **Kappa coefficient of 0.78** (substantial agreement)
- Sleep study (995 participants): Vata predicted longer sleep latency (+20 min) and less refreshed waking; Kapha predicted daytime somnolence

**Moderate evidence (psychological):**
- Vata imbalance significantly predicted greater anxiety, more rumination, reduced mindfulness (F=2.25, p<=0.05)
- Pitta imbalance predicted less mindfulness, poorer mood, greater stress
- Kapha imbalance associated with increased stress but less reflection
- Brief Prakriti Inventory (BPI): test-retest reliability ICC 0.83-0.90; convergent validity r=0.78-0.84

**Weak/absent evidence (financial behaviour):**
- **Zero peer-reviewed studies directly examining dosha-financial behaviour relationships**
- Only source: a Kripalu wellness centre blog post on "spending style by dosha"
- Theoretical extrapolation from personality-finance research is plausible but unvalidated

### Honest Assessment

The biological validity of dosha classification is surprisingly well-supported at the molecular level. The psychological correlates are real but modest in effect size. The financial behaviour application is **entirely speculative** - which is both a risk and an opportunity (you're pioneering, not following).

**For a hackathon pitch:** The genomic evidence is genuinely impressive and differentiating. Lead with CSIR-TRISUTRA findings and HRV Kappa 0.78. Acknowledge the financial application is novel extrapolation, position it as the research opportunity.

### Key Limitations to Be Transparent About
- Most research conducted on Indian/South Asian populations - generalisability uncertain
- Inter-rater reliability of clinical Prakriti assessment is only "fair" (kappa 0.28)
- 64 different assessment tools exist with limited cross-validation
- No prospective studies proving dosha classification predicts health outcomes
- BPI showed minimal correlation with Big Five personality traits (r < 0.30) - doshas may be measuring something *different* from Western personality, not *better*

---

## 3. Market Opportunity

### Market Sizes

| Segment | Current Value | Projected Value | CAGR |
|---------|--------------|-----------------|------|
| Personal finance software | $1.35B (2025) | $2.57B (2034) | 7.60% |
| Behavioural analytics | $4.13B (2024) | $16.68B (2030) | 26.5% |
| Wellness apps | $11.27B (2024) | $26.19B (2030) | 14.9% |
| Financial apps (mobile) | $3.45B (2025) | $13.98B (2035) | 15.02% |

**Combined TAM exceeds $40B by 2030** across these segments.

### Funding Environment

- Global fintech VC funding: **$51.8B in 2025** (27% increase from 2024)
- Deal flow *declined* 23% (3,457 deals vs 4,486) - fewer, larger rounds
- "Flight to quality" - investors want differentiated ideas + execution + traction
- Healthcare-fintech crossover attracting significant capital (Ease: $271.5M, Wagestream: $284.4M)

### Consumer Trends Validating the Thesis

- **84% of US consumers** say wellness is a "top" or "important" priority (McKinsey)
- **43% of Cleo users** say AI makes managing money "less stressful"
- **51% of consumers** find seeking financial advice "intimidating"
- Gamification increases fintech user engagement by **48%** and positively impacts financial behaviour by **67.9%**
- Apps with data-driven personalisation show **30-50% higher retention** vs generic
- Financial personality quizzes exist across Discover, Sorted NZ, The Knot - consumers engage with them

### Regulatory Considerations
- Personality classification data is "sensitive PII" (Level 3-4)
- GDPR fines total EUR 5.65B across 2,245+ cases
- Behavioural nudges are generally permissible when transparent and non-manipulative
- Key risk: if dosha classification influences financial product access, ECOA/UDAAP compliance becomes critical
- For a hackathon MVP with no actual financial products, regulatory risk is minimal

---

## 4. Hackathon Feasibility

### What AI Tools Enable in 6 Hours

**The toolkit has transformed what's possible:**
- **v0 by Vercel**: generates production-ready full-stack Next.js apps from natural language
- **Cursor/Windsurf**: AI-native code editors with agentic multi-file generation
- **Bolt.new/Lovable**: full-stack builders with live hosting included
- **Plaid Sandbox**: production-equivalent testing without real bank connections (`user_good` / `pass_good`)
- **shadcn/ui + Tailwind**: professional UI without custom design work
- **Vercel**: free-tier deployment with git-based auto-deploy

### Recent Hackathon Evidence

- **Agent Forge Hackathon (Singapore, Jan 2026)**: 80 non-technical builders shipped functional AI apps in 7 hours. Winning projects demonstrated complete user journeys, not prototypes.
- **Ship AI Conference Hackathon**: winning project used Next.js + shadcn/ui + AI integration + custom design library
- **FinHacks 2025**: judging weighted 30% technical, 30% presentation, 30% solution effectiveness, 10% creativity

### What DOES Fit in ~8–12 Hours (Aligned Scope)

1. **Plaid Sandbox connection** (single account) + basic transaction pull
2. **Transaction feature extraction + dosha scoring** (heuristic or simple ML)
3. **Dosha wheel visualisation** (Recharts radar chart)
4. **Optional 60‑second quiz** for calibration/fallback
5. **Deployed web app** (landing → connect → results)

### What Does NOT Fit (Still)

- Full Plaid production integration (Sandbox only for MVP)
- Actual ML model training (pre-compute classifications, demonstrate the concept)
- Multiple user roles
- Real wearables/HRV integration
- Mobile app

### The 40-Second Demo Rule

Successful hackathon demos complete the core user journey in **under 40 seconds of interaction**. Your flow should be:

> Land on app -> Take dosha quiz (30 sec) -> See your financial dosha result with wheel visualisation -> Get personalised insights -> Done

---

## 5. Critical Assessment & Risks

### What's Strong About the Plan

1. **Genuine white space** - nobody is doing dosha + finance. Zero direct competitors.
2. **Surprising scientific backing** - the genomic evidence makes this more than pseudoscience
3. **Taps proven trends** - personality typing engagement, financial wellness demand, AI personalisation
4. **Viral potential** - "What's your financial dosha?" is inherently shareable (quiz mechanics)
5. **Clear expansion path** - sleep, fitness, nutrition domains all have data sources and dosha mappings
6. **Beautiful demo potential** - dosha wheel visualisation is visually distinctive

### What Needs Honest Rethinking

1. **The $1.8T TAM claim is aspirational to the point of being unhelpful.** No investor takes a 9-domain TAM seriously at seed stage. Focus on the specific niche: behavioural finance apps + wellness‑conscious consumers. A **$500M** addressable market is credible and sufficient.

2. **"Ancient wisdom" framing cuts both ways.** For a wellness-savvy audience, it's compelling. For fintech investors and regulators, it could read as unscientific. **Recommendation:** Lead with "behavioural science meets personality typing" and use dosha as the *implementation* of a broader framework, not the headline pitch.

3. **The dosha-to-financial-behaviour mapping is the weakest link.** The genomic evidence validates doshas as biological types. But the leap from "Vata has higher anxiety and variable sleep" to "Vata is a late-night impulse shopper with subscription chaos" is creative interpretation, not research. Be transparent about this.

4. **Team size assumption (5 people) may be wrong for a 6-hour AI-assisted build.** With Claude Code / Cursor, 1-2 skilled developers with AI can outpace a 5-person team that needs to coordinate. Fewer people, faster decisions.

5. **The HACKATHON_PLAN.md is over-scoped.** It tries to build ML classification, Plaid integration, and a full frontend in 8 hours. The research shows winning hackathon projects are narrowly scoped with complete user journeys, not ambitious with partial features.

6. **The revenue projections ($3.81M ARR by Year 3) lack justification.** They assume conversion rates and user growth without benchmarking against comparable apps. Cleo took years to reach significant ARR with massive marketing spend.

### Risk Matrix

| Risk | Severity | Mitigation |
|------|----------|------------|
| Cultural appropriation concerns | High | Collaborate with Ayurvedic practitioners, acknowledge origins respectfully |
| Scientific credibility challenged | Medium | Lead with peer-reviewed research, position financial mapping as "inspired by" not "validated by" |
| Investor scepticism of non-Western framework | Medium | Dual-frame as behavioural personality typing; dosha is the implementation detail |
| Regulatory scrutiny if influencing financial decisions | Low (at MVP) | MVP is informational/educational only, no financial products |
| User engagement drops after initial quiz novelty | Medium | Design for ongoing insights, not one-time classification |

---

## 6. Recommended Hackathon Scope

### The One Thing to Nail

**A transaction‑driven dosha diagnosis that feels real**, with a fast, beautiful reveal and specific, behavior‑level insights.

This is **not** a budget app, and it is **not** a quiz‑only product. The quiz exists only to calibrate or fill gaps.

### Proposed Feature Set (6 Hours)

**Must-have (Hours 1-6):**
- Landing page explaining the concept (1 compelling paragraph + visual)
- Plaid Sandbox connection + transaction pull
- Transaction feature extraction + dosha scoring
- Dosha result page with:
  - Primary + secondary dosha identification
  - Radar/wheel visualisation of your dosha balance
  - 3-5 personalised financial insights
  - 2-3 specific recommendations per dosha type
- Mobile-responsive, deployed

**Should-have (Hours 6-8):**
- Optional 60‑second quiz for calibration/fallback
- Social share card ("I'm a Pitta-Vata - find your financial dosha!")

**Nice-to-have (Hours 8-10):**
- Email capture for "full report"
- Brief mindfulness suggestion per dosha type (wellness crossover)
- Demo of how future wearables data could refine classification

### Tech Stack

| Layer | Choice | Rationale |
|-------|--------|-----------|
| Framework | Next.js 15 + React 19 | Best AI tool support, Vercel native |
| Styling | Tailwind CSS + shadcn/ui | Professional look with zero design time |
| Visualisation | Recharts (radar chart) | Fastest path to dosha wheel, React-native |
| Database | None needed for MVP | Quiz logic is client-side, results are computed |
| Hosting | Vercel (free tier) | Git-push deploy, HTTPS, preview URLs |
| AI Tooling | Claude Code for implementation | Full-stack generation from PRP |

### What to Prepare Before the Hackathon

- [ ] Dosha quiz questions finalised (10-15 questions with scoring weights)
- [ ] Dosha-to-financial-behaviour mapping document (the "answer key")
- [ ] Copy for each dosha result (insights, recommendations, tone)
- [ ] Visual references for the dosha wheel design
- [ ] Landing page copy and value proposition
- [ ] PRP (Product Requirements Prompt) ready for Claude Code execution

---

## Key Research Sources

### Competitive Landscape
- Sacra: Cleo analysis ($280M ARR) - sacra.com/c/cleo
- Monarch Money Series B ($75M at $850M) - monarch.com/blog/series-b
- Copilot Money Series A ($6M) - copilot.money/series-a
- Crunchbase: 2025 fintech funding ($51.8B) - news.crunchbase.com
- Plaid 2025 Year in Review (12,000+ institutions, 50% downtime reduction)

### Scientific Validity
- CSIR-IGIB Ayurgenomics: csir.res.in (genome-wide SNP study, 262 individuals)
- Govindaraj et al. (2015) Scientific Reports: 52 SNPs, PGM1 correlation
- HRV-dosha concordance (Kappa 0.78): PMC6033724
- Sleep-dosha study (995 participants): PMC4448595
- Dosha-psychological states (Vikruti): PMC6822152
- Brief Prakriti Inventory (N=1,857): PMC12780516
- Prakriti assessment tools review (64 tools): Frontiers in Medicine 2025

### Market Data
- Personal finance software: Fortune Business Insights ($1.35B -> $2.57B)
- Behavioural analytics: Grand View Research ($4.13B -> $16.68B, 26.5% CAGR)
- Wellness apps: Grand View Research ($11.27B -> $26.19B, 14.9% CAGR)
- McKinsey: 84% of US consumers prioritise wellness

### Hackathon Feasibility
- Agent Forge Hackathon Singapore (Jan 2026): non-technical builders shipping in 7 hours
- Plaid Sandbox documentation: plaid.com/docs/sandbox
- shadcn/ui ecosystem: 100K+ weekly NPM downloads
