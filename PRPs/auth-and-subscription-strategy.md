# Authentication & Subscription Strategy

**Decision Point:** When to add user accounts, authentication, and subscription tiers?

---

## The Tradeoff

### Option A: Session-Based MVP (Phases 1-4)
**No user accounts, anonymous usage**

**Pros:**
- ✅ Faster to build (skip entire auth system)
- ✅ Lower friction for users (no signup required)
- ✅ Good for demos/testing
- ✅ Privacy-first (no data retention)

**Cons:**
- ❌ No returning users (can't see past results)
- ❌ No subscription revenue
- ❌ Can't track usage per user
- ❌ Can't offer "save your analysis" or "track over time"

**Use Cases:**
- Hackathon demo
- Proof of concept
- Initial user testing ("Does this resonate?")

---

### Option B: Full Auth + Subscriptions (Phase 5+)
**User accounts, login, subscription tiers**

**Pros:**
- ✅ Returning users can see history
- ✅ Subscription revenue model works
- ✅ Can track dosha changes over time
- ✅ Can offer free → premium upsells
- ✅ User data for improving algorithms

**Cons:**
- ❌ 3-5 additional hours to build
- ❌ Higher friction (must sign up)
- ❌ Privacy concerns (storing user data)
- ❌ More complex deployment (auth secrets, encryption)

**Use Cases:**
- Real product launch
- Subscription business model
- Long-term engagement

---

## Recommended Phasing

### **Phase 1-4: Session-Based MVP** ✅ Start Here

Build without authentication:

```typescript
// Frontend stores results in sessionStorage
const results = {
  analysisId: crypto.randomUUID(),
  framework: 'ayurveda',
  scores: { vata: 65, pitta: 20, kapha: 15 },
  timestamp: Date.now()
}
sessionStorage.setItem('walletDoshaResults', JSON.stringify(results))
```

**Backend:**
- `analyses` table with nullable `user_id` (for anonymous analyses)
- `sessions` table stores temporary session data
- No auth middleware

**User Flow:**
1. Land on site
2. Connect bank (or take quiz)
3. Get results
4. Results stored in browser only (sessionStorage)
5. Share link generates temporary `share_token`
6. Close browser → data gone

**What Works:**
- Demo to investors/users
- Get feedback on concept
- Test transaction analysis algorithms
- Validate that "financial dosha" resonates

**What Doesn't Work:**
- Can't see past analyses
- Can't track dosha changes over time
- Can't offer subscription tiers
- No revenue

---

### **Phase 5: Add User Accounts** (When you decide to productize)

**Signals it's time:**
- 10+ people asking "How do I see this again?"
- People want to track dosha changes monthly
- Ready to charge for premium features
- Need to store Plaid connections long-term

**Implementation:**
1. Add authentication (use existing library, don't build from scratch)
2. Migrate anonymous analyses to user accounts
3. Enable "My Analyses" dashboard
4. Enable dosha timeline tracking

**Effort:** ~4-6 hours with NextAuth.js or Clerk

---

### **Phase 6: Add Subscriptions** (When you're ready to monetize)

**Signals it's time:**
- Have 50+ regular users
- Clear demand for premium features
- Need recurring revenue to sustain development

**Implementation:**
1. Integrate Stripe
2. Define tier limits
3. Add paywall for premium features
4. Build subscription management UI

**Effort:** ~6-8 hours with Stripe Checkout

---

## Migration Path: Session → Authenticated

**How to convert anonymous users to registered users without losing data:**

```python
# When user signs up after using anonymously
@router.post("/auth/signup")
async def signup(email: str, password: str, session_id: str):
    # 1. Create user account
    user = create_user(email, password)
    
    # 2. Migrate anonymous analyses to user account
    db.execute(
        "UPDATE analyses SET user_id = ? WHERE session_id = ?",
        (user.id, session_id)
    )
    
    # 3. Migrate Plaid connections
    db.execute(
        "UPDATE plaid_connections SET user_id = ? WHERE session_id = ?",
        (user.id, session_id)
    )
    
    return {"user": user, "migrated_analyses": count}
```

**User experience:**
- Uses app anonymously
- Sees "Create account to save your results"
- Signs up → all past analyses now in their account
- Seamless transition

---

## Database Schema: Minimal vs Full

### Minimal Schema (Phase 1-4: Session-Based)

```sql
-- Just what you need for anonymous usage
CREATE TABLE sessions (
    id UUID PRIMARY KEY,
    session_token VARCHAR(255) UNIQUE,
    expires_at TIMESTAMP,
    session_data JSONB  -- Stores temp results
);

CREATE TABLE analyses (
    id UUID PRIMARY KEY,
    session_id UUID REFERENCES sessions(id),  -- No user_id yet
    framework_id VARCHAR(50),
    scores JSONB,
    features JSONB,
    insights JSONB,
    created_at TIMESTAMP,
    share_token VARCHAR(255) UNIQUE  -- For sharing
);

CREATE TABLE frameworks (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255),
    categories JSONB,
    visualization_type VARCHAR(50)
);
```

**Total: 3 tables, ~50 lines of SQL**

---

### Full Schema (Phase 5+: With Auth & Subscriptions)

See: `database-schema.sql` (726 lines)

**Adds:**
- Users & authentication (5 tables)
- Plaid integration (2 tables)
- Subscription management (2 tables)
- Usage tracking & analytics (2 tables)
- Notifications (1 table)
- Admin & audit (2 tables)

**Total: 20+ tables**

---

## Recommended Auth Stack (When You Add It)

### Option 1: NextAuth.js (Free, Open Source)
**Best for:** Self-hosted, full control

```bash
npm install next-auth
```

**Supports:**
- Email/password
- OAuth (Google, GitHub, Apple)
- Magic links
- JWT or database sessions

**Effort:** 2-3 hours to integrate

---

### Option 2: Clerk (SaaS, $25/mo)
**Best for:** Fastest implementation, polished UI

```bash
npm install @clerk/nextjs
```

**Features:**
- Drop-in auth UI
- User management dashboard
- Webhook support
- Social logins included

**Effort:** 1-2 hours to integrate

---

### Option 3: Supabase Auth (Free tier, open source)
**Best for:** Already using Supabase for database

```bash
npm install @supabase/auth-helpers-nextjs
```

**Features:**
- Integrated with Supabase database
- Row-level security
- Email/OAuth
- Magic links

**Effort:** 2-3 hours to integrate

---

## Subscription Management

### Use Stripe (Industry Standard)

```bash
npm install stripe @stripe/stripe-js
```

**Flow:**
1. User clicks "Upgrade to Premium"
2. Stripe Checkout session created
3. User completes payment
4. Webhook updates `users.subscription_tier`
5. App checks tier before showing premium features

**Effort:** 4-6 hours for full integration

---

## Feature Gating by Tier

```python
# backend/app/core/permissions.py

TIER_LIMITS = {
    "free": {
        "max_analyses_per_month": 5,
        "max_bank_connections": 1,
        "frameworks": ["ayurveda"],
        "features": {
            "ai_insights": False,
            "historical_tracking": False,
            "export_data": False
        }
    },
    "premium": {
        "max_analyses_per_month": None,  # Unlimited
        "max_bank_connections": 3,
        "frameworks": ["ayurveda", "tcm"],
        "features": {
            "ai_insights": True,
            "historical_tracking": True,
            "export_data": False
        }
    },
    "pro": {
        "max_analyses_per_month": None,
        "max_bank_connections": None,
        "frameworks": ["ayurveda", "tcm", "enneagram"],
        "features": {
            "ai_insights": True,
            "historical_tracking": True,
            "export_data": True,
            "priority_support": True
        }
    }
}

def check_permission(user, action: str) -> bool:
    tier = user.subscription_tier
    limits = TIER_LIMITS[tier]
    
    if action.startswith("framework:"):
        framework_id = action.split(":")[1]
        return framework_id in limits["frameworks"]
    
    if action in limits["features"]:
        return limits["features"][action]
    
    return False
```

---

## Usage Tracking for Rate Limits

```python
# Middleware to track API usage
@app.middleware("http")
async def track_usage(request: Request, call_next):
    user_id = request.state.user_id if hasattr(request.state, "user_id") else None
    
    # Track request
    await db.api_usage.create(
        user_id=user_id,
        endpoint=request.url.path,
        method=request.method,
        request_date=date.today(),
        request_hour=datetime.now().hour
    )
    
    # Check rate limits for free tier
    if user_id and request.url.path == "/api/analyze":
        user = await db.users.get(user_id)
        if user.subscription_tier == "free":
            count = await db.api_usage.count(
                user_id=user_id,
                endpoint="/api/analyze",
                request_date=date.today()
            )
            if count >= TIER_LIMITS["free"]["max_analyses_per_month"]:
                return JSONResponse(
                    status_code=429,
                    content={"error": "Monthly limit reached. Upgrade to continue."}
                )
    
    response = await call_next(request)
    return response
```

---

## My Recommendation

### For Initial MVP (Next 1-2 weeks):
**Skip authentication entirely.** 

Build session-based:
- Connect bank → analyze → see results
- Results stored in sessionStorage
- Share links work via `share_token`
- Get 10-20 people to try it
- Validate the concept

**Use minimal schema:**
```sql
sessions, analyses, frameworks (3 tables)
```

---

### When to Add Auth (Week 3-4 or when demand is clear):
**Add authentication when users ask for it.**

Signals:
- "How do I see my past results?"
- "Can I track my dosha over time?"
- "I'd pay for this if I could save my data"

**Implementation:**
1. Use Clerk (fastest) or NextAuth.js (free)
2. Migrate anonymous analyses to user accounts
3. Enable "My Analyses" dashboard

---

### When to Add Subscriptions (Month 2-3):
**Add subscriptions when you have 50+ regular users.**

Signals:
- Clear demand for premium features (AI insights, multiple frameworks)
- Users asking about pricing
- Need revenue to sustain development

**Implementation:**
1. Integrate Stripe
2. Define 3 tiers (Free, Premium, Pro)
3. Gate premium features
4. Add "Upgrade" CTAs

---

## Summary

**Your question:** "Will we not need this for user login, information, plan/tier type?"

**Answer:**
- **For MVP (Phases 1-4):** NO - session-based is fine
- **For real product (Phase 5+):** YES - need full auth + subscriptions

**The schema is ready** (`database-schema.sql`) for when you need it. But don't build it until demand is clear.

**Start simple. Add complexity when users demand it.**

---

## Next Steps

1. **Now:** Build session-based MVP (Phases 1-4)
2. **After 10-20 users:** Decide if auth is needed
3. **When adding auth:** Use `database-schema.sql` as reference
4. **When monetizing:** Add Stripe + subscription tiers

The architecture supports both paths. You're not locked in.
