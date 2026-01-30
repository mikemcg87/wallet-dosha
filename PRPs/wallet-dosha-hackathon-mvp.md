# PRP: Wallet Dosha - Financial Dosha Discovery Web App (Hackathon MVP)

---

## Goal

**Feature Goal**: Build a complete, deployed **transaction‑first** "Financial Dosha" web application that classifies users' financial personality using the Ayurvedic dosha framework (Vata/Pitta/Kapha). The primary signal is **Plaid transaction data** with ML/heuristic scoring; the quiz is **optional** and under 60 seconds.

**Deliverable**: A production‑ready system with **Next.js frontend + FastAPI backend + Postgres (prod)** that includes: landing page, Plaid Sandbox bank connection, transaction‑based dosha scoring, Recharts radar visualisation, AI‑generated personalised insights (LLM optional), and a results dashboard. Optional: 10‑question quiz + free‑text prompt as calibration/fallback.

**Success Definition**:
- App loads and runs without errors
- **Transaction‑based** dosha scoring completes end‑to‑end
- Optional quiz completes in **under 60 seconds**
- AI-generated insights feel specific and accurate (not generic)
- Dosha radar chart renders correctly for all dosha combinations
- Mobile responsive and visually polished

---

## User Persona

**Target User**: Wellness-conscious millennials/Gen Z interested in both financial health and holistic wellbeing. People who would take a BuzzFeed personality quiz but want something with genuine depth.

**Use Case**: User discovers Wallet Dosha via social share or landing page, takes a 2-minute financial personality quiz, receives their financial dosha classification with a beautiful radar chart visualisation, reads AI-generated personalised insights about their money habits, and shares their result.

**User Journey**:
1. Land on homepage - read the value proposition (5 seconds)
2. Click "Connect Your Bank" CTA (Plaid Sandbox)
3. Optionally complete a **<60s quiz** if no transactions or to refine confidence
4. See loading/processing animation ("Analysing your financial energy...")
5. View results: dosha radar chart + primary/secondary dosha + AI insights
6. Read personalised recommendations
7. Share result via social card or copy link

**Pain Points Addressed**:
- Finance apps tell you WHAT you spend, not WHY
- Generic financial advice doesn't account for personality
- No existing app bridges wellness/ancient wisdom with financial behaviour

---

## Why

- **Zero direct competitors** - No fintech app uses dosha or any non-Western personality framework
- **Proven engagement model** - Financial personality quizzes (Discover, Sorted NZ, The Knot) show high consumer engagement
- **Market timing** - 84% of US consumers prioritise wellness (McKinsey); $51.8B fintech VC funding in 2025
- **Viral mechanics** - "What's your financial dosha?" is inherently shareable
- **Scientific backing** - CSIR-TRISUTRA genomic studies validate dosha types as biologically real (52 SNPs, Kappa 0.78 HRV concordance)

---

## What

### Core Features

1. **Landing Page** - Explains the concept, shows the three doshas, has a clear CTA
2. **Plaid Sandbox Bank Connection** - "Connect Your Bank" flow using Plaid Sandbox to pull test transaction data
3. **Transaction‑Based Dosha Scoring** - Feature extraction + weighted scoring (ML‑upgrade path)
4. **Financial Dosha Quiz (Optional)** - 10‑question calibration/fallback (<60s)
5. **Free‑Text Analysis (Optional)** - "Describe your relationship with money in a few sentences"
6. **LLM‑Powered Insight Generation** - Uses AI to generate personalised financial insights based on transactions + optional quiz
7. **Dosha Radar Chart** - Recharts radar/polar visualisation showing Vata/Pitta/Kapha balance
8. **Results Dashboard** - Primary dosha, secondary dosha, personalised insights, recommendations
9. **Social Sharing** - Share card with dosha result

### Success Criteria

- [ ] Landing page loads in < 2 seconds on mobile
- [ ] Plaid Sandbox connection works with test credentials (user_good/pass_good)
- [ ] Transaction analysis generates dosha classification from spending data
- [ ] Optional quiz flow works end‑to‑end in < 60 seconds
- [ ] Radar chart renders for all possible score combinations
- [ ] AI-generated insights are specific to the user's dosha profile (not generic)
- [ ] Results page is beautiful and shareable
- [ ] Frontend + backend are deployed and accessible (separate services)
- [ ] Mobile responsive across all pages

---

## All Needed Context

### Documentation & References

```yaml
# MUST READ - Critical for implementation

# Canonical decisions
- file: SOURCE_OF_TRUTH.md
  why: Stack, scope, TAM, and environment decisions

# Next.js (Frontend)
- url: https://nextjs.org/docs/app
  why: App Router conventions, file-based routing, server components
  critical: Use app/ directory structure, not pages/

# shadcn/ui Installation & Components
- url: https://ui.shadcn.com/docs/installation/next
  why: Component installation with Next.js 15
  critical: Use `npx shadcn@latest init` then add components individually

# shadcn/ui Components to use
- url: https://ui.shadcn.com/docs/components/button
  why: Button, Card, Progress, RadioGroup, Textarea, Badge components
  critical: These are copy-paste components, not npm packages

# Recharts Radar Chart
- url: https://recharts.org/en-US/api/RadarChart
  why: Primary visualisation for dosha balance wheel
  critical: Use RadarChart with PolarGrid, PolarAngleAxis, Radar components

# Recharts Responsive Container
- url: https://recharts.org/en-US/api/ResponsiveContainer
  why: Must wrap all charts in ResponsiveContainer for mobile
  critical: Set width="100%" height={300} minimum

# Tailwind CSS (v3 recommended for shadcn/ui)
- url: https://tailwindcss.com/docs/installation/framework-guides/nextjs
  why: Utility-first CSS framework
  critical: Use Tailwind v3 for shadcn/ui compatibility

# Framer Motion (for animations)
- url: https://motion.dev/docs/react-quick-start
  why: Page transitions, loading animations, reveal effects
  critical: Use motion.div for animated containers

# Anthropic Claude API
- url: https://docs.anthropic.com/en/api/messages
  why: LLM backend for generating personalised insights
  critical: Use claude-3-5-haiku for fast, cheap responses; system prompt controls output format

# Plaid Sandbox Integration
- url: https://plaid.com/docs/sandbox/
  why: Test environment with fake bank data, no real credentials needed
  critical: Use Sandbox environment (not Development/Production)

# Plaid Link (React)
- url: https://plaid.com/docs/link/web/
  why: Drop-in bank connection UI widget
  critical: Use react-plaid-link package, Sandbox institution is "First Platypus Bank"

# Plaid Transactions API
- url: https://plaid.com/docs/api/products/transactions/
  why: Pull transaction history from connected bank accounts
  critical: In Sandbox, transactions/get returns realistic test data automatically

# Plaid Sandbox Public Token
- url: https://plaid.com/docs/api/sandbox/#sandboxpublic_tokencreate
  why: Can bypass Link UI entirely for testing by creating tokens programmatically
  critical: POST /sandbox/public_token/create with institution_id and initial_products

# Project context documents (already in repo)
- file: RESEARCH_ASSESSMENT.md
  why: Competitive landscape, scientific validity, market data
  section: Section 6 - Recommended Hackathon Scope

- file: FRAMEWORKS.md
  why: Dosha definitions, financial behaviour mappings
  section: Ayurveda section - Vata/Pitta/Kapha financial types

- file: VISION.md
  why: Overall product vision and positioning
  section: Core Concept + Initial Focus
```

### Current Codebase Tree

```bash
wallet-dosha/
├── .claude/
│   └── settings.local.json
├── COMMERCIAL.md
├── DOMAINS.md
├── FRAMEWORKS.md
├── HACKATHON_PLAN.md
├── README.md
├── RESEARCH_ASSESSMENT.md
├── SOURCE_OF_TRUTH.md
├── START_HERE.md
├── VISION.md
└── PRPs/
    └── wallet-dosha-hackathon-mvp.md  # This file
```

### Desired Codebase Tree (Next.js + FastAPI)

```bash
wallet-dosha/
├── backend/
│   ├── app/
│   │   ├── main.py             # FastAPI app
│   │   ├── api/
│   │   │   ├── plaid.py         # Plaid token exchange + transactions
│   │   │   ├── scoring.py       # Transaction scoring endpoint
│   │   │   └── insights.py      # LLM insights (optional)
│   │   ├── services/
│   │   │   ├── feature_extract.py
│   │   │   ├── dosha_scoring.py
│   │   │   └── recommendations.py
│   │   ├── models/             # Pydantic models
│   │   └── db/                 # DB session + models
│   ├── requirements.txt
│   └── .env
├── frontend/
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx            # Landing
│   │   ├── quiz/page.tsx
│   │   ├── results/page.tsx
│   │   └── dashboard/page.tsx
│   ├── components/
│   ├── lib/
│   ├── public/
│   ├── package.json
│   └── .env.local
├── docker-compose.yml          # Optional dev parity (Postgres)
├── README.md
└── # Existing docs remain in root
```

### Known Gotchas & Library Quirks

```typescript
// CRITICAL: Next.js App Router
// - All components in app/ are Server Components by default
// - Client components need "use client" directive at top of file
// - Quiz state, charts, and animations MUST be client components
// - API routes live in FastAPI (backend/), not in app/api

// CRITICAL: Recharts in Next.js
// - Recharts components are client-side only
// - MUST add "use client" to any file importing Recharts
// - MUST wrap charts in <ResponsiveContainer width="100%" height={300}>
// - RadarChart needs: RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar
// - Import from 'recharts' (not individual packages)

// CRITICAL: shadcn/ui setup
// - Run: npx shadcn@latest init (choose New York style, Zinc colour)
// - Then: npx shadcn@latest add button card radio-group progress textarea badge
// - Components are added to components/ui/ directory
// - They use @/lib/utils for cn() classname merging

// CRITICAL: FastAPI backend
// - Use Pydantic models for request/response validation
// - Enable CORS for the Next.js origin
// - Keep Plaid + LLM keys ONLY on the backend

// CRITICAL: Tailwind + theme
// - Use Tailwind v3 for shadcn/ui compatibility
// - Default palette should be earthy (browns, golds, deep greens)
// - Theme switching is future scope, not MVP

// CRITICAL: Plaid Sandbox Integration
// - Frontend: npm install react-plaid-link
// - Backend: use plaid-python SDK
// - Sandbox credentials: institution_id = "ins_109508" (First Platypus Bank)
// - Test login: username = "user_good", password = "pass_good"
// - Sandbox auto-generates realistic transaction history (no seeding needed)
// - FLOW: Create link token (server) -> Open Plaid Link (client) -> Exchange public token (server) -> Fetch transactions (server)
// - Plaid Link handles all bank UI - you just embed the button
// - In Sandbox, transactions/sync or transactions/get both work
// - Access token can live in DB or short-lived session for MVP

// CRITICAL: Environment variables
// - Backend: ANTHROPIC_API_KEY, PLAID_CLIENT_ID, PLAID_SECRET, PLAID_ENV=sandbox
// - Frontend: NEXT_PUBLIC_BACKEND_URL (API base URL)
// - PLAID_ENV=sandbox (never use development/production for hackathon)
// - Add backend env vars to server deployment (VPS/Supabase)
// - Never expose API keys to client
```

---

## Implementation Blueprint

### Data Models & Types

```typescript
// lib/types.ts

export type DoshaType = 'vata' | 'pitta' | 'kapha';

export interface DoshaScores {
  vata: number;   // 0-100
  pitta: number;  // 0-100
  kapha: number;  // 0-100
}

export interface QuizOption {
  label: string;
  value: string;
  scores: DoshaScores; // How much this answer contributes to each dosha
}

export interface QuizQuestion {
  id: number;
  question: string;
  description?: string; // Optional helper text
  options: QuizOption[];
}

export interface QuizResult {
  scores: DoshaScores;
  primaryDosha: DoshaType;
  secondaryDosha: DoshaType;
  freeText?: string;
}

export interface DoshaProfile {
  type: DoshaType;
  name: string;          // "Vata" | "Pitta" | "Kapha"
  element: string;       // "Air & Ether" | "Fire & Water" | "Water & Earth"
  emoji: string;         // Wind, Fire, Mountain emoji
  tagline: string;       // "The Creative Spender"
  color: string;         // Tailwind color class
  description: string;
  financialTraits: string[];
  strengths: string[];
  challenges: string[];
  recommendations: string[];
}

export interface AnalysisRequest {
  scores: DoshaScores;
  primaryDosha: DoshaType;
  secondaryDosha: DoshaType;
  freeText?: string;
  transactionAnalysis?: TransactionDoshaAnalysis; // From Plaid data if connected
}

export interface AnalysisResponse {
  personalitySnapshot: string;    // 2-3 sentence personality summary
  spendingPatterns: string[];     // 3-4 specific spending pattern insights
  blindSpots: string[];           // 2-3 financial blind spots
  actionSteps: string[];          // 3 specific action steps
  doshaBalance: string;           // Interpretation of their specific ratio
}

export interface SyntheticTransaction {
  date: string;
  merchant: string;
  amount: number;
  category: string;
  timeOfDay: 'morning' | 'afternoon' | 'evening' | 'latenight';
}

// Plaid Integration Types
export interface PlaidTransaction {
  transaction_id: string;
  date: string;
  name: string;           // Merchant name
  amount: number;
  category: string[];     // Plaid category hierarchy
  merchant_name?: string;
  payment_channel: 'online' | 'in store' | 'other';
}

export interface TransactionDoshaAnalysis {
  scores: DoshaScores;             // Dosha scores derived from transaction patterns
  patterns: TransactionPattern[];   // Detected spending patterns
  merchantDiversity: number;        // 0-100 (high = more Vata)
  spendingConsistency: number;      // 0-100 (high = more Kapha)
  premiumRatio: number;             // 0-100 (high = more Pitta)
  timeOfDayDistribution: Record<string, number>;
}

export interface TransactionPattern {
  label: string;         // e.g. "Late-night spending spike"
  doshaAlignment: DoshaType;
  confidence: number;    // 0-1
  detail: string;        // Human-readable explanation
}

// Dashboard / Ongoing Engagement Types
export interface DoshaSnapshot {
  date: string;
  scores: DoshaScores;
  source: 'quiz' | 'transaction' | 'combined';
}

export interface DashboardData {
  currentDosha: QuizResult;
  transactionAnalysis?: TransactionDoshaAnalysis;
  history: DoshaSnapshot[];          // For tracking over time
  weeklyInsight?: string;            // AI-generated weekly nudge
  doshaAlerts: DoshaAlert[];         // Pattern-based notifications
}

export interface DoshaAlert {
  id: string;
  type: 'pattern_shift' | 'spending_spike' | 'balance_tip' | 'milestone';
  title: string;
  message: string;
  doshaType: DoshaType;
  timestamp: string;
  dismissed: boolean;
}
```

### Quiz Questions & Scoring

```typescript
// lib/quiz-data.ts
// 10 questions, each with 3 options mapping to Vata/Pitta/Kapha
// Scoring: each option adds points to one or more doshas

export const quizQuestions: QuizQuestion[] = [
  {
    id: 1,
    question: "It's Friday night. What's your money move?",
    options: [
      {
        label: "Spontaneous online shopping spree at 11pm",
        value: "a",
        scores: { vata: 30, pitta: 5, kapha: 0 }
      },
      {
        label: "Dinner at that new restaurant everyone's talking about",
        value: "b",
        scores: { vata: 5, pitta: 30, kapha: 0 }
      },
      {
        label: "Cook at home, transfer the savings to my emergency fund",
        value: "c",
        scores: { vata: 0, pitta: 5, kapha: 30 }
      }
    ]
  },
  {
    id: 2,
    question: "You get an unexpected bonus. What happens?",
    options: [
      {
        label: "It's spent before I even decide where - lots of little things",
        value: "a",
        scores: { vata: 30, pitta: 5, kapha: 0 }
      },
      {
        label: "Invest it aggressively or buy something I've been eyeing",
        value: "b",
        scores: { vata: 0, pitta: 30, kapha: 5 }
      },
      {
        label: "Straight into savings. I'll decide later (probably never)",
        value: "c",
        scores: { vata: 0, pitta: 0, kapha: 35 }
      }
    ]
  },
  {
    id: 3,
    question: "How many active subscriptions do you have?",
    options: [
      {
        label: "Honestly? I've lost count. Probably 8-15",
        value: "a",
        scores: { vata: 35, pitta: 0, kapha: 0 }
      },
      {
        label: "Several premium ones - I pay for quality",
        value: "b",
        scores: { vata: 5, pitta: 30, kapha: 0 }
      },
      {
        label: "2-3 max. I audit them regularly",
        value: "c",
        scores: { vata: 0, pitta: 5, kapha: 30 }
      }
    ]
  },
  {
    id: 4,
    question: "Your friend asks you to split a fancy meal bill equally (you had the salad).",
    options: [
      {
        label: "Sure, whatever! I'll forget about it by tomorrow anyway",
        value: "a",
        scores: { vata: 25, pitta: 5, kapha: 5 }
      },
      {
        label: "I suggest splitting by what we ordered - fair is fair",
        value: "b",
        scores: { vata: 0, pitta: 30, kapha: 5 }
      },
      {
        label: "I pay but internally track it and feel a bit resentful",
        value: "c",
        scores: { vata: 0, pitta: 5, kapha: 30 }
      }
    ]
  },
  {
    id: 5,
    question: "What does your investment strategy look like?",
    options: [
      {
        label: "I keep meaning to start but haven't gotten around to it",
        value: "a",
        scores: { vata: 30, pitta: 0, kapha: 5 }
      },
      {
        label: "Aggressive - crypto, individual stocks, I research obsessively",
        value: "b",
        scores: { vata: 5, pitta: 35, kapha: 0 }
      },
      {
        label: "Safe index funds or high-yield savings. Slow and steady",
        value: "c",
        scores: { vata: 0, pitta: 0, kapha: 35 }
      }
    ]
  },
  {
    id: 6,
    question: "How do you feel about checking your bank balance?",
    options: [
      {
        label: "I avoid it. Ignorance is bliss until it isn't",
        value: "a",
        scores: { vata: 30, pitta: 0, kapha: 5 }
      },
      {
        label: "I check it frequently - I like knowing my exact position",
        value: "b",
        scores: { vata: 0, pitta: 30, kapha: 5 }
      },
      {
        label: "I check it but rarely spend, so it doesn't change much",
        value: "c",
        scores: { vata: 0, pitta: 5, kapha: 30 }
      }
    ]
  },
  {
    id: 7,
    question: "A sale is on. There's 70% off something you don't really need. You...",
    options: [
      {
        label: "Buy it. It's 70% off! That's basically free money",
        value: "a",
        scores: { vata: 30, pitta: 5, kapha: 0 }
      },
      {
        label: "Buy it if it's premium quality or enhances my lifestyle",
        value: "b",
        scores: { vata: 5, pitta: 30, kapha: 0 }
      },
      {
        label: "Walk away. I didn't need it before the sale, I don't need it now",
        value: "c",
        scores: { vata: 0, pitta: 0, kapha: 35 }
      }
    ]
  },
  {
    id: 8,
    question: "Your spending pattern over the last 3 months looks most like...",
    options: [
      {
        label: "A rollercoaster - big swings, unpredictable, lots of variety",
        value: "a",
        scores: { vata: 35, pitta: 0, kapha: 0 }
      },
      {
        label: "Peaks around experiences, dining, and self-improvement",
        value: "b",
        scores: { vata: 0, pitta: 35, kapha: 0 }
      },
      {
        label: "A flat line. Same shops, same amounts, very predictable",
        value: "c",
        scores: { vata: 0, pitta: 0, kapha: 35 }
      }
    ]
  },
  {
    id: 9,
    question: "When it comes to treating yourself, you tend to...",
    options: [
      {
        label: "Lots of small treats throughout the day (coffee, snacks, apps)",
        value: "a",
        scores: { vata: 30, pitta: 5, kapha: 0 }
      },
      {
        label: "Save up for something impressive or an unforgettable experience",
        value: "b",
        scores: { vata: 0, pitta: 30, kapha: 5 }
      },
      {
        label: "Feel guilty about spending on myself, so I rarely do",
        value: "c",
        scores: { vata: 0, pitta: 0, kapha: 35 }
      }
    ]
  },
  {
    id: 10,
    question: "Your financial anxiety mostly comes from...",
    options: [
      {
        label: "Not knowing where my money went. Again.",
        value: "a",
        scores: { vata: 35, pitta: 0, kapha: 0 }
      },
      {
        label: "Not earning/achieving enough compared to my potential",
        value: "b",
        scores: { vata: 0, pitta: 35, kapha: 0 }
      },
      {
        label: "Fear of losing what I've saved. What if something goes wrong?",
        value: "c",
        scores: { vata: 0, pitta: 0, kapha: 35 }
      }
    ]
  }
];
```

### Dosha Content & Profiles

```typescript
// lib/dosha-content.ts

export const doshaProfiles: Record<DoshaType, DoshaProfile> = {
  vata: {
    type: 'vata',
    name: 'Vata',
    element: 'Air & Ether',
    emoji: '🌪️',
    tagline: 'The Creative Spender',
    color: 'stone',     // Earthy neutral palette
    description: 'Your financial energy is like the wind - creative, changeable, and full of movement. You\'re generous and spontaneous with money, but your scattered energy can lead to financial chaos.',
    financialTraits: [
      'Late-night impulse purchases',
      'High merchant diversity - always trying something new',
      'Subscription accumulator (sign up, forget, repeat)',
      'Variable income or irregular saving patterns',
      'Small, frequent purchases that add up invisibly'
    ],
    strengths: [
      'Creative problem-solver with money',
      'Adaptable to financial change',
      'Generous and open-handed',
      'Quick to spot opportunities'
    ],
    challenges: [
      'Difficulty sticking to budgets',
      'Late-night spending when energy is scattered',
      'Forgetting about recurring charges',
      'Avoiding looking at bank statements'
    ],
    recommendations: [
      'Set up automated savings - remove the decision from your scattered energy',
      'Implement a 24-hour rule for purchases over $50',
      'Schedule a weekly 10-minute money check-in (same day, same time - routine grounds Vata)',
      'Use cash for discretionary spending to make it tangible'
    ]
  },
  pitta: {
    type: 'pitta',
    name: 'Pitta',
    element: 'Fire & Water',
    emoji: '🔥',
    tagline: 'The Strategic Achiever',
    color: 'amber',     // Earthy warm palette
    description: 'Your financial energy burns bright and focused. You\'re driven, competitive, and strategic with money. You earn well and spend deliberately - but your intensity can lead to burnout spending and status-driven purchases.',
    financialTraits: [
      'Premium merchants and quality-first purchases',
      'Investment-aggressive - always optimising returns',
      'Experience spending (dining, travel, events)',
      'Competitive upgrades (latest phone, best gym, premium tier)',
      'High earn, high burn pattern'
    ],
    strengths: [
      'Strong earning potential and drive',
      'Strategic financial planning',
      'Willing to invest in growth',
      'Decisive with money decisions'
    ],
    challenges: [
      'Status-driven spending beyond means',
      'Difficulty enjoying "enough" - always chasing more',
      'Burnout spending after intense work periods',
      'Comparing financial progress to peers'
    ],
    recommendations: [
      'Channel your competitive energy into savings goals with visible targets',
      'Set a "status spending" budget so you enjoy it guilt-free within limits',
      'Practice one "good enough" purchase per week instead of premium',
      'Track net worth growth (you\'ll love the progress chart)'
    ]
  },
  kapha: {
    type: 'kapha',
    name: 'Kapha',
    element: 'Water & Earth',
    emoji: '🏔️',
    tagline: 'The Steady Guardian',
    color: 'emerald',    // Earthy green palette
    description: 'Your financial energy is grounded and stable like the earth. You\'re cautious, consistent, and excellent at saving. But your steady nature can become stagnation - hoarding money out of fear rather than using it as a tool for the life you want.',
    financialTraits: [
      'Same merchants on repeat - loyalty and routine',
      'Low transaction frequency - every purchase considered',
      'Strong savings rate but possibly over-saving',
      'Risk-averse investing (or avoiding investing entirely)',
      'Long decision cycles before any purchase'
    ],
    strengths: [
      'Excellent natural saver',
      'Stable, predictable financial patterns',
      'Patient and consistent',
      'Low financial stress day-to-day'
    ],
    challenges: [
      'Money hoarding driven by fear, not strategy',
      'Missing opportunities due to excessive caution',
      'Difficulty spending on experiences and growth',
      'Financial stagnation - saving without purpose'
    ],
    recommendations: [
      'Set a mandatory "life enjoyment" fund - budget FOR spending on joy',
      'Try one small investment each quarter to build comfort with calculated risk',
      'Give yourself permission to upgrade one regular purchase',
      'Define what your savings are FOR - attach purpose to your patience'
    ]
  }
};
```

### LLM System Prompt for Analysis

```typescript
// Used in backend app (e.g. backend/app/api/insights.py)

const SYSTEM_PROMPT = `You are a financial wellness advisor who uses Ayurvedic dosha principles to interpret financial behaviour. You combine ancient wisdom with modern behavioural finance insights.

You will receive a user's financial dosha scores (Vata/Pitta/Kapha as percentages), their primary and secondary dosha type, optionally some free text they wrote about their relationship with money, and optionally real transaction data analysis showing their spending patterns (merchant diversity, spending consistency, premium ratio, time-of-day distribution, and detected patterns).

Generate a personalised financial personality analysis. Be specific, insightful, and warm - not generic. Reference their specific dosha combination (e.g. "As a Pitta-Vata, you combine competitive drive with scattered energy...").

IMPORTANT GUIDELINES:
- Be warm but honest. Don't sugarcoat.
- Reference specific, relatable scenarios (not abstract advice)
- If they provided free text, weave specific references to what they said into your analysis
- If transaction data is provided, reference SPECIFIC spending patterns you see (e.g. "Your 47% merchant diversity score and late-night Amazon orders are classic Vata energy")
- Keep language accessible - no jargon. This should feel like a wise friend, not a textbook.
- Frame challenges as growth opportunities, not character flaws
- Each insight should feel like "that's weirdly accurate"

Respond in this exact JSON format:
{
  "personalitySnapshot": "2-3 sentences capturing their unique financial personality based on their specific dosha ratio",
  "spendingPatterns": ["3-4 specific spending pattern observations based on their dosha combination"],
  "blindSpots": ["2-3 financial blind spots they likely don't see"],
  "actionSteps": ["3 specific, actionable steps tailored to their dosha combination"],
  "doshaBalance": "1-2 sentences interpreting what their specific Vata/Pitta/Kapha ratio means"
}`;
```

### Implementation Tasks (Ordered by Dependencies)

```yaml
Task 1: PROJECT SETUP - Split frontend/backend
  - CREATE: /frontend (Next.js) and /backend (FastAPI)
  - FRONTEND: create-next-app (TypeScript + Tailwind)
  - BACKEND: FastAPI + Uvicorn + Pydantic + plaid-python
  - OPTIONAL: docker-compose.yml for Postgres (dev parity)

Task 2: BACKEND - Core API
  - SETUP: CORS for frontend origin
  - IMPLEMENT: /plaid/link-token, /plaid/exchange-token, /plaid/transactions
  - IMPLEMENT: /analysis/score (transaction feature extraction + dosha scoring)
  - OPTIONAL: /analysis/insights (LLM narrative)

Task 3: BACKEND - Scoring
  - FEATURE EXTRACTION: late-night ratio, volatility, merchant diversity, premium ratio
  - DOSHA SCORING: weighted heuristic (upgradeable to ML)
  - RETURN: scores + detected patterns

Task 4: FRONTEND - Core Flow
  - Landing page + CTA (Connect Bank)
  - Plaid Link integration (client)
  - Results page with radar chart + insights

Task 5: FRONTEND - Optional Quiz (<60s)
  - 10-question quiz as calibration/fallback
  - Store results and merge with transaction scores

Task 6: DESIGN
  - Earthy theme (browns/golds/greens)
  - Responsive UI, shareable results

Task 7: DEPLOY
  - Frontend: Vercel
  - Backend: VPS or Supabase-hosted Postgres
  - Env vars configured (Plaid + Anthropic) on backend only
```

### Post-Hackathon Roadmap

```yaml
# Phase 1: Post-Hackathon Polish (Week 1-2)
- Add user authentication (NextAuth.js or Clerk)
- Move from localStorage to database (Supabase or PlanetScale)
- Production Plaid environment (requires Plaid approval)
- Email capture and weekly dosha reports
- More quiz questions (expand to 15-20 for better accuracy)

# Phase 2: Mobile App (Month 1-2)
- React Native / Expo migration
  - Shared TypeScript types and dosha logic (lib/ directory)
  - Expo Router for navigation (mirrors Next.js App Router patterns)
  - Native Plaid SDK (react-native-plaid-link-sdk) for bank connection
  - Push notifications for dosha alerts and weekly check-ins
  - Native charts (react-native-chart-kit or Victory Native)
- App Store / Google Play submission
- Mobile-specific features:
  - Apple Health / Google Fit integration for wellness data
  - Spending notifications in real-time (via Plaid webhooks)
  - Widget showing current dosha balance

# Phase 3: Engagement & Retention (Month 2-4)
- Daily/weekly dosha check-ins (2-minute micro-assessments)
- Dosha-aligned financial challenges ("Vata Week: No impulse purchases over $20")
- Community features (anonymous dosha distribution, shared tips)
- Wearable integration (Apple Watch, Fitbit) for HRV-based dosha validation
- Sleep data correlation with next-day spending patterns
- Gamification: dosha balance streaks, achievement badges

# Phase 4: Monetisation & Scale (Month 4-8)
- Premium tier: advanced AI insights, unlimited transaction analysis, trend forecasting
- B2B: white-label dosha assessment for banks and credit unions (à la Enrich)
- Partnerships: wellness brands, financial advisors, Ayurvedic practitioners
- Research programme: collect anonymised data to validate dosha-financial correlations
- API for third-party integrations

# Phase 5: Platform Expansion (Month 6-12)
- Additional wisdom frameworks (Enneagram, Chinese Five Elements, Human Design)
- Cross-domain dosha analysis: health spending, fitness habits, nutrition choices
- AI financial coach: ongoing conversational guidance aligned to dosha type
- Predictive analytics: "Your Vata energy is elevated this week — here's how to stay grounded financially"
```

---

## Validation Loop

### Level 1: Syntax & Build (After Each Task)

```bash
# TypeScript compilation check
npx tsc --noEmit

# ESLint
npm run lint

# Dev server runs without errors
npm run dev

# Expected: Zero errors. Fix before proceeding to next task.
```

### Level 2: Build Validation

```bash
# Full production build (catches SSR issues, missing "use client", etc.)
npm run build

# Expected: Build succeeds with no errors
# COMMON ISSUES:
# - "useState is not a function" -> Missing "use client" directive
# - "window is not defined" -> Recharts component rendered on server
# - "Module not found" -> Incorrect import path
```

### Level 3: User Journey Testing

```bash
# Start production server
npm run build && npm run start

# Manual test checklist:
# 1. Navigate to http://localhost:3000 - landing page loads
# 2. Click "Take the Quiz" - quiz page loads
# 3. Answer all 10 questions - progress bar updates correctly
# 4. Free text prompt appears after question 10
# 5. Click continue - loading animation shows
# 6. Results page loads with:
#    - Dosha radar chart (3 axes visible)
#    - Primary + secondary dosha displayed correctly
#    - AI-generated insights load (may take 2-3 seconds)
#    - Recommendations section visible
#    - Share section visible
# 7. Click "Connect Your Bank" - Plaid Link opens
# 8. Use test credentials (user_good / pass_good) - First Platypus Bank
# 9. Transaction analysis loads and shows dosha classification
# 10. AI insights regenerate with transaction data (richer insights)
# 11. Click "Go to Your Dashboard" - dashboard loads
# 12. Dashboard shows dosha timeline (single point for now)
# 13. Weekly snapshot displays current dosha
# 14. Quick actions all link correctly
# 15. Test on mobile viewport (375px width in DevTools)
# 16. Verify all scores add up to ~100% (normalised)
```

### Level 4: Deployment Validation

```bash
# Deploy frontend to Vercel
npx vercel --prod

# Deploy backend (VPS/Supabase as chosen)
# e.g. dockerized FastAPI or platform-specific deploy

# Post-deployment checks:
# 1. Visit frontend URL - page loads with HTTPS
# 2. Connect Plaid Sandbox and receive transaction scores
# 3. Verify backend endpoints return valid JSON
# 4. Test share link by pasting URL into Twitter/Slack preview
# 5. Test on actual mobile device (not just DevTools)
```

---

## Final Validation Checklist

### Technical Validation
- [ ] `npm run build` succeeds with zero errors
- [ ] `npx tsc --noEmit` passes
- [ ] `npm run lint` passes
- [ ] All pages load without console errors
- [ ] Backend API returns valid JSON response

### Feature Validation
- [ ] Landing page clearly communicates the value proposition
- [ ] Quiz flow works end-to-end (10 questions + optional free text)
- [ ] Dosha scores calculate correctly (sum normalised to percentages)
- [ ] Radar chart renders for all possible score combinations
- [ ] AI-generated insights are specific to user's dosha profile
- [ ] Static recommendations display immediately (no API wait)
- [ ] Plaid Link opens and connects with Sandbox credentials
- [ ] Transaction analysis generates dosha scores from spending data
- [ ] AI insights regenerate with transaction data (more specific)
- [ ] Dashboard loads with dosha timeline and weekly snapshot
- [ ] Dashboard alerts generate based on dosha patterns
- [ ] Dashboard redirects to /quiz if no quiz results exist
- [ ] Share functionality works (copy link at minimum)
- [ ] Results redirect to /quiz if accessed without completing quiz
- [ ] Results page has clear CTA to dashboard (ongoing engagement)

### Design Validation
- [ ] Mobile responsive (375px, 768px, 1280px)
- [ ] Dosha colours are consistent (earthy palette: stone/amber/emerald)
- [ ] Typography is readable and hierarchy is clear
- [ ] Loading states exist for quiz transition and AI generation
- [ ] Animations are smooth, not janky
- [ ] The app looks like a real product, not a hackathon prototype

### Deployment Validation
- [ ] Deployed to Vercel with HTTPS
- [ ] Backend env vars set (ANTHROPIC_API_KEY, PLAID_CLIENT_ID, PLAID_SECRET, PLAID_ENV)
- [ ] Frontend env vars set (NEXT_PUBLIC_BACKEND_URL)
- [ ] Full user journey works on production URLs (connect → results → insights)
- [ ] Plaid Sandbox works on production
- [ ] OG meta tags work for social sharing

---

## Anti-Patterns to Avoid

- **Don't over-engineer the quiz scoring** - Simple weighted sums normalised to percentages. No ML needed for the quiz itself.
- **Don't make the API call blocking** - Show static content (radar chart, dosha profile, recommendations) immediately. AI insights load async.
- **Don't use Server Components for interactive elements** - Quiz, charts, and animations MUST have "use client"
- **Don't forget the fallback** - If Claude API fails, show pre-written insights from dosha-content.ts
- **Don't store secrets client-side** - Plaid tokens and API keys stay on the backend. Store tokens server-side (DB or short-lived session) only.
- **Don't try to use Plaid Development/Production** - Sandbox is free, instant, no approval needed. Development requires Plaid approval and real bank credentials.
- **Don't over-complicate the dashboard for MVP** - localStorage is fine. The dashboard proves the concept of ongoing value. Database comes post-hackathon.
- **Don't skip mobile testing** - Over 60% of users will access on mobile
- **Don't use Recharts PieChart for the dosha wheel** - Use RadarChart. It's the correct visualisation for multi-axis personality data.
- **Don't make the quiz too long** - 10 questions maximum. Each question should take ~5 seconds to answer.
- **Don't use generic AI prompts** - The system prompt must reference doshas specifically and request the exact JSON structure

---

## Confidence Score: 8/10

**Why 8:** This PRP provides quiz content, TypeScript types, dosha content, LLM system prompt, Plaid integration flow, and a frontend/backend split. The tech stack (Next.js + FastAPI + Recharts + Plaid) is well-documented and commonly used together. The main risk factors are:
- Recharts RadarChart configuration quirks (mitigated by explicit import instructions)
- Tailwind v3 vs v4 compatibility with shadcn/ui (mitigated by recommending create-next-app defaults)
- Claude API response parsing (mitigated by fallback content strategy)
- Plaid Sandbox setup requires API key registration (mitigated by clear instructions + free tier)
- Scope is still ambitious for a single-day build (mitigated by focusing on transaction scoring + results first; quiz and dashboard are optional)

**Prioritisation guidance:** If time is tight, build Plaid → transaction scoring → results first. Add quiz calibration and dashboard only if time remains.

The quiz questions, scoring weights, dosha profiles, recommendations, transaction scoring logic, and dashboard architecture are all pre-defined, eliminating content and design decisions as bottlenecks during implementation.
