# Hackathon Build Plan: Tomorrow's Mission

## Team of 5 - Role Assignments

### 1. Backend Lead (Python/ML)
**Responsibilities:**
- ML algorithms (transaction feature extraction + dosha scoring)
- Feature extraction from transaction data
- API endpoints (FastAPI)
- Data pipeline

### 2. Data Engineer
**Responsibilities:**
- Plaid/Teller integration
- Demo data generation
- Database setup
- Data preprocessing

### 3. Frontend Developer
**Responsibilities:**
- Dashboard UI (Next.js)
- Data visualization (dosha wheel, charts)
- Responsive design
- OAuth flow integration

### 4. Designer/UX
**Responsibilities:**
- Ayurvedic aesthetic design
- User flow
- Dosha wheel visualization
- Pitch deck visuals

### 5. PM/Strategist
**Responsibilities:**
- Demo script
- Pitch preparation
- Competitive research
- Documentation (README, etc.)

---

## Build Timeline (8-Hour Hackathon Day)

### Morning Session (Hours 1-4)

#### Hour 1: Setup & Alignment
**All Team:**
- Git repo setup
- Tech stack decision
- Review strategy docs
- Assign specific tasks

**Backend Lead:**
- Python environment setup
- Install scikit-learn, pandas, FastAPI
- Skeleton API structure

**Data Engineer:**
- Plaid Sandbox account setup OR
- Teller developer account setup
- Test data pull

**Frontend:**
- Next.js setup
- Recharts or Chart.js integration

**Designer:**
- Color palette (earthy: browns, golds, greens)
- Dosha wheel SVG mockup
- Component designs (Figma)

**PM:**
- Demo data requirements
- Pitch outline
- Competitor screenshots

#### Hours 2-3: Core Feature Development

**Backend Lead:**
```python
# Priority 1: Feature extraction
def extract_features(transactions):
    return {
        'late_night_ratio': calculate_late_night_purchases(),
        'spending_volatility': calculate_std_dev(),
        'impulse_score': calculate_small_frequent(),
        'merchant_diversity': count_unique_merchants(),
        'weekend_ratio': calculate_weekend_spending(),
        'subscription_count': detect_recurring()
    }

# Priority 2: Dosha classification
def classify_dosha(features):
    vata_score = (
        features['late_night_ratio'] * 0.3 +
        features['spending_volatility'] * 0.25 +
        features['impulse_score'] * 0.25 +
        features['merchant_diversity'] * 0.2
    )
    # ... calculate pitta, kapha
    return {'vata': vata_score, 'pitta': pitta_score, 'kapha': kapha_score}
```

**Data Engineer:**
```python
# Priority 1: Get transactions (Plaid Sandbox)
def get_demo_transactions():
    # Use Plaid Sandbox pre-configured user
    # OR generate synthetic transactions
    return transactions

# Priority 2: Database
# SQLite for speed (can upgrade later)
# Store: user_id, transaction_data, dosha_scores
```

**Frontend:**
```javascript
// Priority 1: Dosha wheel visualization
// Circular chart showing Vata:Pitta:Kapha percentages
// Animated, beautiful

// Priority 2: Transaction timeline
// Chart.js line graph of spending over time
// Highlight late-night purchases
```

**Designer:**
- Finalize dosha wheel design
- Create icon set (air, fire, earth elements)
- Design recommendation cards

**PM:**
- Create synthetic transactions for each dosha type
- Draft demo script (what to say)
- Gather Ayurveda reference materials

#### Hour 4: Integration & First Demo

**All Team:**
- Backend connects to frontend
- First end-to-end test
- See demo data flow through system
- Fix critical bugs

**Mini Demo:** Show each other what works

---

### Afternoon Session (Hours 5-8)

#### Hour 5-6: Polish & Enhance

**Backend:**
- Add recommendations engine
```python
def generate_recommendations(dosha_scores):
    if dosha_scores['vata'] > 0.6:
        return [
            "Your Vata energy is elevated. Try:",
            "• Automated savings (create routine)",
            "• Freeze credit card after 9pm",
            "• Weekly money check-in ritual"
        ]
```
- Add time-series analysis (spending trends)

**Data Engineer:**
- Create multiple demo datasets:
  - High Vata example (chaotic spender)
  - High Pitta example (status spender)
  - High Kapha example (risk-averse)
- Add data validation

**Frontend:**
- Beautiful dosha wheel animation
- Transaction categorization viz
- Responsive design (mobile + desktop)
- Loading states, error handling

**Designer:**
- Final visual polish
- Pitch deck (10 slides max)
- Demo video backup (if live demo fails)

**PM:**
- Practice pitch (60 seconds)
- Prepare Q&A responses
- Write README for GitHub
- Gather testimonials/research citations

#### Hour 7: Rehearsal & Refinement

**All Team:**
- Full demo run-through (3 times)
- Time the pitch (must be <60 seconds)
- Test on different computers/browsers
- Fix any remaining bugs

**Roles:**
- **Pitcher:** Practice delivery, memorize key points
- **Demo Driver:** Practice clicking through app smoothly
- **Backup:** Have synthetic data ready if API fails
- **Q&A Handler:** Prepared for tough questions
- **Tech Support:** Ready to troubleshoot

#### Hour 8: Final Prep & Submission

**All Team:**
- Deploy to production (Vercel/Heroku)
- Record demo video (backup)
- Final pitch practice
- GitHub README polish
- Prepare 2-minute extended pitch (if needed)

---

## Minimum Viable Demo (What Must Work)

### Core Flow:
1. **Welcome screen** - "Discover Your Financial Dosha"
2. **Data input** - Button: "Connect Bank" (Plaid Sandbox)
3. **Processing** - "Analyzing your financial energy..." (spinner)
4. **Results** - Beautiful dosha wheel showing percentages
5. **Insights** - Specific examples ("23 late-night purchases detected")
6. **Recommendations** - 3-5 actionable suggestions
7. **Optional** - 60‑second quiz only if no transactions or to refine confidence

### Must-Have Features:
✅ Working dosha classification
✅ Beautiful dosha wheel visualization
✅ Specific behavioral insights
✅ Personalized recommendations
✅ Smooth, polished UX

### Nice-to-Have (If Time):
- Time-series graphs
- Drill-down into specific transactions
- Multiple framework comparison
- Email/save results
- Social sharing

---

## Tech Stack (Decided)

**Backend:** FastAPI (Python 3.11) + pandas/scikit‑learn  
**Frontend:** Next.js (React) + Tailwind + Recharts  
**DB:** SQLite in dev, Postgres in prod (Supabase preferred)  
**Docker:** Optional in dev, recommended in prod

---

## Demo Data Strategy

### Approach 1: Real Connection (Impressive)
- One team member connects real bank via Plaid (if permitted)
- Use THEIR actual transactions
- **Demo:** "These are MY actual late-night Uber Eats orders"

### Approach 2: Plaid Sandbox (Safe) ✅
- Use Plaid's `user_good` test account
- Use Sandbox transactions as primary signal
- **Demo:** "Sample user with 487 transactions over 90 days"

### Approach 3: Synthetic + CSV (Backup)
- Generate realistic synthetic transactions
- Upload via CSV
- **Demo:** "Uploaded bank export showing Vata pattern"

**Recommendation:** Build all three, use whichever works best

---

## Synthetic Demo Data Generator

```python
import pandas as pd
import numpy as np
from datetime import datetime, timedelta

def generate_vata_transactions(days=90):
    """Chaotic, impulsive, late-night pattern"""
    transactions = []
    current_date = datetime.now()

    for i in range(days):
        date = current_date - timedelta(days=i)

        # Vata characteristics:
        # - Variable daily transaction count (1-8)
        # - Many late-night (10pm-2am)
        # - Small frequent purchases
        # - High merchant diversity

        num_transactions = np.random.randint(1, 9)

        for _ in range(num_transactions):
            hour = np.random.choice(
                range(24),
                p=[0.02]*8 + [0.04]*4 + [0.06]*4 + [0.12]*4 + [0.10]*4
                # Higher probability late at night
            )

            amount = np.random.choice(
                [5, 8, 12, 15, 22, 35, 50],
                p=[0.3, 0.25, 0.2, 0.15, 0.05, 0.03, 0.02]
                # Mostly small purchases
            )

            merchant = np.random.choice([
                "Uber Eats", "Amazon", "Deliveroo", "Spotify",
                "Random Online Store", "Coffee Shop", "Convenience Store"
            ])

            transactions.append({
                'date': date.replace(hour=hour),
                'amount': amount,
                'merchant': merchant,
                'category': 'Food' if merchant in ['Uber Eats', 'Deliveroo'] else 'Shopping'
            })

    return pd.DataFrame(transactions)

def generate_pitta_transactions(days=90):
    """Intense, status-driven, premium merchants"""
    # ... Similar structure but different patterns
    pass

def generate_kapha_transactions(days=90):
    """Routine, risk-averse, same merchants"""
    # ... Similar structure but different patterns
    pass
```

---

## Pitch Structure (60 Seconds)

### Script Template:

**[0-10s] Hook + Problem:**
"Who here stress-shops at midnight? [pause for hands]

Yeah, me too. Personal finance apps tell you WHAT you spend. None tell you WHY."

**[10-25s] Solution:**
"Wallet Dosha uses ML + Ayurvedic wisdom to classify your financial personality.

Are you Vata - impulsive, scattered?
Pitta - intense, competitive?
Kapha - risk-averse, stagnant?

Then personalized recommendations to balance your financial energy."

**[25-45s] Demo:**
"Let me show you. [Click to results screen]

My algorithm analyzed 487 transactions. Result: 65% Vata.

See these 23 late-night purchases? Scattered energy. The model detected my financial constitution from behavioral patterns."

**[45-55s] Why It Works:**
"Five ML models: clustering, anomaly detection, classification, NLP, recommendations.

Same data as every budgeting app. Totally different lens."

**[55-60s] Ask:**
"We're building the bridge between modern data and ancient wisdom. Looking for: ML engineer, full-stack dev, anyone fascinated by behavioral science."

---

## GitHub README (Template)

```markdown
# Wallet Dosha 💰🔮

**Your Financial Constitution Through Ancient Wisdom**

[Beautiful screenshot of dosha wheel]

## What It Does

Personal finance apps track spending. Wallet Dosha diagnoses WHY you spend the way you do - using machine learning + 5,000 years of Ayurvedic wisdom.

## The Three Financial Doshas

**Vata (Air)** - Impulsive, scattered, late-night shopping
**Pitta (Fire)** - Intense, competitive, status-driven
**Kapha (Earth)** - Risk-averse, stagnant, cash-hoarding

## Tech Stack

- Python 3.11 + Flask
- scikit-learn (ML classification)
- React + Next.js
- Chart.js (data viz)
- Plaid API (transaction data)

## How It Works

1. Connect your bank or upload transactions
2. ML algorithms extract 20+ behavioral features
3. Classification model predicts your dosha
4. Get personalized recommendations

## ML Models

- K-means clustering (spending personalities)
- Time-series anomaly detection
- Random Forest classifier (dosha prediction)
- NLP sentiment analysis (merchant patterns)

## Team

- [Names] - [Roles]

Built in 24 hours at [Hackathon Name]

## Try It

[Demo link]

---

*Modern tech meets ancient wisdom*
```

---

## Success Criteria

### Minimum Success:
✅ Working demo (doesn't crash)
✅ Clear value proposition
✅ Team stays together post-hackathon

### Good Success:
✅ Above +
✅ Judges say "this is interesting/novel"
✅ Other participants want to try it
✅ Top 10 finish

### Great Success:
✅ Above +
✅ Win or place (top 3)
✅ Investor/advisor interest
✅ Press coverage / social media buzz

---

## Backup Plans

### If API Fails:
- Use CSV upload with synthetic data
- Pre-load demo accounts

### If Frontend Breaks:
- Show backend API responses (Postman/curl)
- Show demo video

### If ML Doesn't Classify Well:
- Show the features being extracted (still impressive)
- Explain the intended algorithm
- Emphasize it's MVP/proof-of-concept

### If Demo Laptop Dies:
- Have backup laptop
- Have recorded video
- Can pitch without demo (less ideal)

---

## Post-Hackathon (If You Continue)

### Week 1:
- Clean up code
- Deploy properly
- Share on Product Hunt / HN / Reddit

### Month 1:
- Get 100 users
- Collect feedback
- Iterate on classification accuracy

### Month 3:
- Apply to Y Combinator
- Raise friends & family round
- Add wearables integration

---

## Questions Before You Build

1. **Who's pitching?** (Best presenter)
2. **What's our tech stack?** (Python + React or faster option?)
3. **Real data or synthetic?** (Someone's bank or demo data?)
4. **Primary goal?** (Win hackathon, start company, or just learn?)

**Once you answer these, you're ready to build!**

---

*Let's make ancient wisdom accessible through modern technology. Go build! 🚀*
