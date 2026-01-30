# PRP: Wallet Dosha MVP v2 - Framework-Agnostic Architecture

**Last Updated:** 2026-01-30  
**Status:** Active  
**Supersedes:** wallet-dosha-hackathon-mvp.md

---

## Overview

Build a **framework-agnostic behavioral analysis platform** with Ayurvedic doshas as the first implementation. The architecture allows adding new frameworks (TCM Five Elements, Enneagram, etc.) without touching core logic.

---

## Goals

1. **Conceptually Interesting**: Transaction-driven personality classification through ancient wisdom frameworks
2. **Serious Structure**: Clean separation of concerns, professional backend/frontend architecture
3. **Extensible**: Plugin-based framework system - add TCM, Enneagram, or custom frameworks later

---

## Success Criteria

**MVP (Phase 1-3):**
- [ ] Connect Plaid Sandbox → analyze transactions → display dosha scores
- [ ] Beautiful radar chart visualization
- [ ] Framework plugin architecture in place
- [ ] Deployed and working on real URLs
- [ ] Mobile responsive

**Extended (Phase 4+):**
- [ ] Add second framework (TCM Five Elements) using existing plugin interface
- [ ] Compare multiple frameworks side-by-side
- [ ] Optional quiz calibration

---

## Architecture Overview

### Core Concept: Framework Plugins

```
Transaction Data (generic)
    ↓
Feature Extraction (generic behavioral patterns)
    ↓
Framework Plugin (Ayurveda, TCM, Enneagram...)
    ↓
Classification Result (framework-specific)
    ↓
Visualization (adapts to framework)
```

**Key Insight:** Separate "what we observe" (late-night spending) from "how we interpret it" (Vata energy).

---

## System Architecture

### Backend: FastAPI + Plugin System

```
backend/
├── app/
│   ├── main.py                          # FastAPI app
│   ├── core/
│   │   ├── framework.py                 # Abstract base class for frameworks
│   │   ├── feature_extractor.py        # Generic transaction analysis
│   │   └── registry.py                  # Framework registry/discovery
│   ├── frameworks/
│   │   ├── ayurveda/
│   │   │   ├── __init__.py
│   │   │   ├── framework.py             # AyurvedaDoshaFramework implementation
│   │   │   ├── scoring.py               # Dosha scoring logic
│   │   │   └── content.py               # Dosha profiles, recommendations
│   │   └── (future: tcm/, enneagram/)
│   ├── api/
│   │   ├── plaid.py                     # Plaid integration endpoints
│   │   ├── analyze.py                   # Main analysis endpoint
│   │   └── frameworks.py                # Framework metadata endpoint
│   ├── models/
│   │   ├── schemas.py                   # Pydantic models
│   │   └── database.py                  # SQLAlchemy models
│   └── services/
│       └── llm.py                       # Optional Claude insights
├── requirements.txt
└── .env
```

### Frontend: Next.js (Transaction-First Flow)

```
frontend/
├── app/
│   ├── layout.tsx
│   ├── page.tsx                         # Landing page
│   ├── connect/
│   │   └── page.tsx                     # Plaid connection flow
│   ├── results/
│   │   └── page.tsx                     # Results with framework-agnostic viz
│   └── api/                             # (NO backend logic here - calls FastAPI)
├── components/
│   ├── ui/                              # shadcn/ui components
│   ├── plaid/
│   │   └── PlaidLinkButton.tsx
│   ├── viz/
│   │   ├── RadarChart.tsx               # For 3-5 category frameworks
│   │   ├── EnneagramCircle.tsx          # For 9-point frameworks (future)
│   │   └── FrameworkViz.tsx             # Auto-selects based on framework metadata
│   └── results/
│       ├── ScoreDisplay.tsx
│       └── InsightsCard.tsx
├── lib/
│   ├── api.ts                           # FastAPI client
│   └── types.ts                         # TypeScript types
└── package.json
```

---

## API Contracts

### 1. Get Available Frameworks

```http
GET /api/frameworks

Response:
{
  "frameworks": [
    {
      "id": "ayurveda",
      "name": "Ayurvedic Doshas",
      "description": "5,000-year-old constitutional types",
      "categories": ["vata", "pitta", "kapha"],
      "visualization_type": "radar",
      "category_details": {
        "vata": { "name": "Vata", "element": "Air & Ether", "emoji": "🌪️" },
        "pitta": { "name": "Pitta", "element": "Fire & Water", "emoji": "🔥" },
        "kapha": { "name": "Kapha", "element": "Water & Earth", "emoji": "🏔️" }
      }
    }
  ]
}
```

### 2. Analyze Transactions

```http
POST /api/analyze

Request:
{
  "framework_id": "ayurveda",
  "transactions": [
    {
      "date": "2026-01-15",
      "merchant": "Amazon",
      "amount": 47.99,
      "category": ["Shopping", "Online"],
      "time": "23:45"
    }
  ]
}

Response:
{
  "analysis_id": "uuid",
  "framework": "ayurveda",
  "scores": {
    "vata": 65,
    "pitta": 20,
    "kapha": 15
  },
  "primary_category": "vata",
  "secondary_category": "pitta",
  "features_detected": {
    "late_night_ratio": 0.42,
    "merchant_diversity": 0.78,
    "spending_volatility": 0.65,
    "premium_ratio": 0.15
  },
  "insights": [
    {
      "type": "pattern",
      "title": "Late-night spending spike",
      "description": "42% of transactions between 10pm-2am",
      "category_alignment": "vata"
    }
  ],
  "recommendations": [
    "Set up automated savings to create routine",
    "Implement 24-hour rule for purchases over $50",
    "Schedule weekly money check-in (same day, same time)"
  ]
}
```

### 3. Plaid Integration

```http
POST /api/plaid/create-link-token
Response: { "link_token": "..." }

POST /api/plaid/exchange-token
Request: { "public_token": "..." }
Response: { "access_token": "..." }

POST /api/plaid/get-transactions
Request: { "access_token": "..." }
Response: { "transactions": [...] }
```

---

## Database Schema

```sql
-- analyses table
CREATE TABLE analyses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    framework_id VARCHAR(50) NOT NULL,
    scores JSONB NOT NULL,
    features JSONB NOT NULL,
    insights JSONB,
    recommendations JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- plaid_connections (optional - for multi-session)
CREATE TABLE plaid_connections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_identifier VARCHAR(255),  -- Could be session ID for MVP
    access_token_encrypted TEXT NOT NULL,
    institution_name VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- framework_metadata (cached)
CREATE TABLE frameworks (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    categories JSONB NOT NULL,
    visualization_type VARCHAR(50),
    enabled BOOLEAN DEFAULT true
);
```

---

## Plugin Interface Definition

```python
# backend/app/core/framework.py

from abc import ABC, abstractmethod
from typing import Dict, List, Any
from pydantic import BaseModel

class FeatureSet(BaseModel):
    """Generic behavioral features extracted from transactions"""
    late_night_ratio: float
    merchant_diversity: float
    spending_volatility: float
    premium_ratio: float
    transaction_frequency: float
    time_of_day_distribution: Dict[str, float]
    category_distribution: Dict[str, float]
    # ... extensible

class ClassificationResult(BaseModel):
    """Framework-specific classification output"""
    scores: Dict[str, float]  # category_id -> score (0-100)
    primary_category: str
    secondary_category: str | None
    insights: List[Dict[str, Any]]
    recommendations: List[str]

class FrameworkMetadata(BaseModel):
    """Framework self-description"""
    id: str
    name: str
    description: str
    categories: List[str]
    visualization_type: str  # 'radar', 'enneagram_circle', 'pentagram'
    category_details: Dict[str, Dict[str, Any]]

class BehavioralFramework(ABC):
    """Base class for all framework plugins"""
    
    @abstractmethod
    def get_metadata(self) -> FrameworkMetadata:
        """Return framework metadata for frontend"""
        pass
    
    @abstractmethod
    def classify(self, features: FeatureSet) -> ClassificationResult:
        """
        Take generic features and produce framework-specific classification.
        This is where Ayurveda-specific logic lives.
        """
        pass
    
    @abstractmethod
    def generate_insights(
        self, 
        features: FeatureSet,
        classification: ClassificationResult
    ) -> List[Dict[str, Any]]:
        """Generate insights based on patterns detected"""
        pass
```

---

## Implementation Phases

### **Phase 1: Core Architecture (2-3 hours)**

**Build the foundation that makes everything else easy.**

1. **Backend Setup**
   - [ ] Initialize FastAPI project structure
   - [ ] Define `BehavioralFramework` abstract class (`core/framework.py`)
   - [ ] Create `FeatureExtractor` class (`core/feature_extractor.py`)
     - Generic transaction analysis (timing, diversity, volatility)
     - Returns `FeatureSet` object
   - [ ] Create `FrameworkRegistry` (`core/registry.py`)
     - Discovers and registers frameworks
     - `get_framework(framework_id)` method
   - [ ] Implement `/api/frameworks` endpoint
     - Returns list of available frameworks with metadata

2. **Database Setup**
   - [ ] SQLite for dev (quick start)
   - [ ] Define SQLAlchemy models (`models/database.py`)
   - [ ] Create migration script or init script

3. **API Contract Validation**
   - [ ] Create Pydantic schemas (`models/schemas.py`)
   - [ ] Ensure request/response types match API contracts above

**Validation:** Can start server, hit `/api/frameworks`, get empty list (no frameworks registered yet).

---

### **Phase 2: Ayurveda Framework Plugin (3-4 hours)**

**Implement first framework using the plugin interface.**

1. **Ayurveda Plugin Implementation**
   - [ ] Create `frameworks/ayurveda/framework.py`
   - [ ] Implement `AyurvedaDoshaFramework(BehavioralFramework)`
   - [ ] Implement `get_metadata()`:
     ```python
     return FrameworkMetadata(
         id="ayurveda",
         name="Ayurvedic Doshas",
         description="5,000-year-old constitutional types",
         categories=["vata", "pitta", "kapha"],
         visualization_type="radar",
         category_details={
             "vata": {"name": "Vata", "element": "Air & Ether", "emoji": "🌪️"},
             "pitta": {"name": "Pitta", "element": "Fire & Water", "emoji": "🔥"},
             "kapha": {"name": "Kapha", "element": "Water & Earth", "emoji": "🏔️"}
         }
     )
     ```
   - [ ] Implement `classify()`:
     - Weighted scoring: `vata_score = f(late_night_ratio, merchant_diversity, ...)`
     - Normalize scores to sum to 100
     - Determine primary/secondary
   - [ ] Implement `generate_insights()`:
     - Pattern detection (e.g., "42% late-night transactions → Vata pattern")
   - [ ] Create `frameworks/ayurveda/content.py`:
     - Dosha profiles (descriptions, strengths, challenges)
     - Recommendations per dosha type

2. **Plaid Integration**
   - [ ] Implement Plaid endpoints (`api/plaid.py`)
   - [ ] Use Plaid Sandbox environment
   - [ ] Test with `user_good` / `pass_good`

3. **Analysis Endpoint**
   - [ ] Implement `/api/analyze` (`api/analyze.py`)
   - [ ] Flow:
     ```python
     # 1. Extract features (generic)
     features = feature_extractor.extract(transactions)
     
     # 2. Get framework plugin
     framework = registry.get_framework(framework_id)
     
     # 3. Classify
     result = framework.classify(features)
     
     # 4. Generate insights
     insights = framework.generate_insights(features, result)
     
     # 5. Save to DB
     save_analysis(...)
     
     # 6. Return result
     return result
     ```

**Validation:** 
- POST transactions to `/api/analyze?framework=ayurveda`
- Get back dosha scores + insights
- Verify scores sum to ~100

---

### **Phase 3: Frontend & Polish (3-4 hours)**

**Build the user-facing experience.**

1. **Next.js Setup**
   - [ ] Initialize Next.js with TypeScript
   - [ ] Install shadcn/ui + Tailwind
   - [ ] Configure environment variables (NEXT_PUBLIC_BACKEND_URL)

2. **Landing Page**
   - [ ] Hero section explaining the concept
   - [ ] Fetch frameworks from `/api/frameworks`
   - [ ] Display dosha overview (Vata/Pitta/Kapha cards)
   - [ ] CTA: "Connect Your Bank to Discover Your Dosha"

3. **Plaid Connection Flow**
   - [ ] PlaidLinkButton component
   - [ ] Handle OAuth callback
   - [ ] Fetch transactions via backend
   - [ ] Navigate to results with loading state

4. **Results Page**
   - [ ] Framework-agnostic `FrameworkViz` component
     - Checks `visualization_type` from metadata
     - Renders `RadarChart` for 3-5 categories
     - (Future: renders `EnneagramCircle` for 9 categories)
   - [ ] Score display with primary/secondary
   - [ ] Insights cards (pattern detections)
   - [ ] Recommendations list
   - [ ] Share button (copy link)

5. **Visualization**
   - [ ] Implement `RadarChart.tsx` with Recharts
   - [ ] Use framework metadata for labels/colors
   - [ ] Responsive container
   - [ ] Animations (Framer Motion)

6. **Mobile Responsive**
   - [ ] Test at 375px, 768px, 1280px
   - [ ] Touch-friendly tap targets
   - [ ] Readable typography on small screens

**Validation:**
- Connect Plaid → see dosha scores → beautiful radar chart
- All on mobile and desktop
- Share link works

---

### **Phase 4: Deployment (1 hour)**

1. **Backend Deployment**
   - [ ] Dockerize FastAPI app
   - [ ] Deploy to Railway / Render / VPS
   - [ ] Set environment variables (PLAID_CLIENT_ID, PLAID_SECRET, PLAID_ENV=sandbox)
   - [ ] Verify CORS allows frontend origin

2. **Frontend Deployment**
   - [ ] Deploy to Vercel
   - [ ] Set NEXT_PUBLIC_BACKEND_URL
   - [ ] Test production build locally first

3. **End-to-End Test**
   - [ ] Full flow on production URLs
   - [ ] Plaid Sandbox works in production
   - [ ] OG tags for social sharing

---

## Phase 5+ (Future Extensions)

### Add TCM Five Elements Framework

**Effort: 2-3 hours** (because architecture is in place)

```python
# backend/app/frameworks/tcm/framework.py

class TCMFiveElementsFramework(BehavioralFramework):
    def get_metadata(self):
        return FrameworkMetadata(
            id="tcm",
            name="TCM Five Elements",
            description="Traditional Chinese Medicine elements",
            categories=["wood", "fire", "earth", "metal", "water"],
            visualization_type="pentagram",  # Frontend auto-adapts
            category_details={...}
        )
    
    def classify(self, features: FeatureSet):
        # Different interpretation of same features
        # Wood: Growth-oriented, expansive spending
        # Fire: Passionate, impulsive
        # Earth: Nurturing, stable
        # Metal: Disciplined, minimalist
        # Water: Flowing, adaptive
        
        wood_score = calculate_wood(features)
        fire_score = calculate_fire(features)
        # ...
        
        return ClassificationResult(...)
```

**Frontend needs ZERO changes** - it fetches metadata, adapts visualization automatically.

### Add Framework Comparison View

- User connects bank once
- Analyze with multiple frameworks
- Display side-by-side:
  - Ayurveda says: 65% Vata
  - TCM says: 40% Fire, 35% Wood
  - Enneagram says: Type 7 (Enthusiast)

### Add Optional Quiz Calibration

- Separate `/quiz` route (not in main flow)
- Returns confidence score: "85% confident you're Vata based on quiz + transactions"
- Uses both signals to refine classification

---

## Tech Stack

**Backend:**
- FastAPI (Python 3.11+)
- SQLAlchemy (ORM)
- Pydantic (validation)
- Plaid Python SDK
- SQLite (dev), Postgres (prod)

**Frontend:**
- Next.js 15 (App Router)
- TypeScript
- Tailwind CSS + shadcn/ui
- Recharts (visualization)
- Framer Motion (animations)
- react-plaid-link

**Deployment:**
- Backend: Railway / Render / Docker on VPS
- Frontend: Vercel
- Database: Supabase (Postgres) or Railway

---

## Key Design Decisions

### 1. Why Plugin Architecture?

**Without plugins:** Adding TCM means rewriting feature extraction, creating new endpoints, new frontend components, duplicating logic.

**With plugins:** Adding TCM means implementing one class (`TCMFramework`). Frontend adapts automatically via metadata.

### 2. Why Transaction-First?

**Quiz-first** = engagement ceiling. People take it once, never return.

**Transaction-first** = ongoing value. Connect bank once, get new insights over time as spending patterns change. Can add monthly "dosha drift" notifications.

### 3. Why Separate Backend/Frontend?

- **Backend in Python:** ML libraries (scikit-learn), data processing (pandas) are Python-native
- **Frontend in Next.js:** Best React framework, excellent deployment story (Vercel)
- **Clean API contract:** Can swap implementations, add mobile app later, open-source the plugin system

### 4. Why SQLite → Postgres?

- **SQLite for dev:** Zero config, fast iteration
- **Postgres for prod:** Better concurrency, JSON support (for storing flexible scores/insights)

---

## Anti-Patterns to Avoid

1. **Don't put business logic in the frontend** - All scoring stays in backend plugins
2. **Don't hardcode framework IDs everywhere** - Use registry pattern
3. **Don't skip the metadata endpoint** - Frontend needs to discover frameworks dynamically
4. **Don't skip database migrations** - Use Alembic or explicit migration scripts
5. **Don't store Plaid access tokens in localStorage** - Backend only, encrypted at rest

---

## Success Metrics

**Technical:**
- Plugin architecture allows adding TCM in <4 hours (test this!)
- API contracts are framework-agnostic (no `vata` or `pitta` in generic routes)
- Frontend adapts to new frameworks without code changes

**Product:**
- Transaction analysis → results in <10 seconds
- Dosha classification "feels accurate" to test users
- Visualization is beautiful and shareable

---

## File Checklist

**To Create (Backend):**
- [ ] `backend/app/core/framework.py` (abstract base class)
- [ ] `backend/app/core/feature_extractor.py` (generic transaction analysis)
- [ ] `backend/app/core/registry.py` (framework discovery)
- [ ] `backend/app/frameworks/ayurveda/framework.py` (plugin implementation)
- [ ] `backend/app/frameworks/ayurveda/scoring.py` (dosha math)
- [ ] `backend/app/frameworks/ayurveda/content.py` (profiles, recommendations)
- [ ] `backend/app/api/analyze.py` (main endpoint)
- [ ] `backend/app/api/plaid.py` (Plaid integration)
- [ ] `backend/app/api/frameworks.py` (metadata endpoint)
- [ ] `backend/app/models/schemas.py` (Pydantic models)
- [ ] `backend/app/models/database.py` (SQLAlchemy models)

**To Create (Frontend):**
- [ ] `frontend/lib/api.ts` (FastAPI client)
- [ ] `frontend/lib/types.ts` (TypeScript types matching backend)
- [ ] `frontend/components/plaid/PlaidLinkButton.tsx`
- [ ] `frontend/components/viz/FrameworkViz.tsx` (auto-selects based on metadata)
- [ ] `frontend/components/viz/RadarChart.tsx` (Recharts implementation)
- [ ] `frontend/app/page.tsx` (landing)
- [ ] `frontend/app/connect/page.tsx` (Plaid flow)
- [ ] `frontend/app/results/page.tsx` (results display)

---

## Getting Started

### Prerequisites
```bash
# Backend
python3.11 -m venv backend/venv
source backend/venv/bin/activate
pip install fastapi uvicorn sqlalchemy pydantic plaid-python

# Frontend
npx create-next-app@latest frontend --typescript --tailwind --app
cd frontend && npm install recharts framer-motion react-plaid-link
```

### Development Flow
```bash
# Terminal 1: Backend
cd backend
uvicorn app.main:app --reload --port 8000

# Terminal 2: Frontend
cd frontend
npm run dev

# Backend runs on http://localhost:8000
# Frontend runs on http://localhost:3000
```

### First Steps
1. Implement `BehavioralFramework` abstract class
2. Create `FeatureExtractor` with generic transaction analysis
3. Implement `AyurvedaDoshaFramework` plugin
4. Test `/api/analyze` endpoint with mock transactions
5. Build frontend to call backend

---

## Questions to Answer Before Building

1. **Do we need user accounts for MVP?** → No, session-based is fine
2. **Do we need to store transaction data long-term?** → No, analyze and discard (privacy-first)
3. **Do we need real-time updates?** → No, batch analysis is fine
4. **Do we need LLM insights?** → Optional, fallback to static content works
5. **Do we need the quiz?** → Phase 5+, transaction-first for MVP

---

## Estimated Timeline

- **Phase 1** (Architecture): 2-3 hours
- **Phase 2** (Ayurveda Plugin): 3-4 hours
- **Phase 3** (Frontend): 3-4 hours
- **Phase 4** (Deploy): 1 hour
- **Total: 9-12 hours** for complete MVP

**With 4 people working in parallel:**
- Person 1: Backend architecture + plugin interface
- Person 2: Ayurveda plugin + Plaid integration
- Person 3: Frontend landing + connection flow
- Person 4: Results page + visualization

**Timeline: 4-6 hours to working demo.**

---

## Confidence Score: 9/10

**Why 9:**
- ✅ Clean architecture with clear separation of concerns
- ✅ Extensible by design (adding frameworks is easy)
- ✅ Transaction-first focus (aligned with SOURCE_OF_TRUTH)
- ✅ Realistic scope (can actually build in 9-12 hours)
- ✅ Clear phases with validation checkpoints
- ✅ Well-defined API contracts and database schema

**Remaining 1 point risk:**
- Plugin abstraction adds upfront complexity
- Team needs to understand the architecture before coding
- But: pays off immediately when adding second framework

**Mitigation:** Start with Phase 1 architecture. If it feels too abstract after 2 hours, can pivot to simpler hardcoded version. But I believe this is the right approach for your goals.

---

**Ready to build.** 🚀
