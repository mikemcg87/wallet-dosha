-- =====================================================
-- WALLET DOSHA - DATABASE SCHEMA
-- PostgreSQL 14+
-- =====================================================

-- =====================================================
-- EXTENSIONS
-- =====================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- USERS & AUTHENTICATION
-- =====================================================

-- User accounts
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    email_verified BOOLEAN DEFAULT false,
    hashed_password TEXT,  -- NULL for OAuth-only users
    full_name VARCHAR(255),
    avatar_url TEXT,
    
    -- Subscription info
    subscription_tier VARCHAR(50) DEFAULT 'free',  -- 'free', 'premium', 'pro'
    subscription_status VARCHAR(50) DEFAULT 'active',  -- 'active', 'cancelled', 'past_due'
    subscription_started_at TIMESTAMP,
    subscription_expires_at TIMESTAMP,
    stripe_customer_id VARCHAR(255) UNIQUE,
    stripe_subscription_id VARCHAR(255),
    
    -- Auth metadata
    last_login_at TIMESTAMP,
    login_count INTEGER DEFAULT 0,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    deleted_at TIMESTAMP  -- Soft delete
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_stripe_customer ON users(stripe_customer_id);
CREATE INDEX idx_users_created_at ON users(created_at);

-- OAuth connections (Google, GitHub, etc.)
CREATE TABLE oauth_connections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    provider VARCHAR(50) NOT NULL,  -- 'google', 'github', 'apple'
    provider_user_id VARCHAR(255) NOT NULL,
    provider_email VARCHAR(255),
    access_token_encrypted TEXT,
    refresh_token_encrypted TEXT,
    expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(provider, provider_user_id)
);

CREATE INDEX idx_oauth_user_id ON oauth_connections(user_id);

-- Session management (for stateful sessions)
CREATE TABLE sessions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,  -- NULL for anonymous sessions
    session_token VARCHAR(255) UNIQUE NOT NULL,
    ip_address INET,
    user_agent TEXT,
    expires_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    
    -- Session data (for anonymous users before signup)
    session_data JSONB  -- Can store temp analysis results before account creation
);

CREATE INDEX idx_sessions_token ON sessions(session_token);
CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_sessions_expires ON sessions(expires_at);

-- Password reset tokens
CREATE TABLE password_reset_tokens (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token VARCHAR(255) UNIQUE NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    used_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_reset_tokens_token ON password_reset_tokens(token);
CREATE INDEX idx_reset_tokens_user_id ON password_reset_tokens(user_id);

-- =====================================================
-- FRAMEWORK SYSTEM
-- =====================================================

-- Available frameworks (Ayurveda, TCM, Enneagram, etc.)
CREATE TABLE frameworks (
    id VARCHAR(50) PRIMARY KEY,  -- 'ayurveda', 'tcm', 'enneagram'
    name VARCHAR(255) NOT NULL,
    description TEXT,
    categories JSONB NOT NULL,  -- ['vata', 'pitta', 'kapha']
    visualization_type VARCHAR(50),  -- 'radar', 'pentagram', 'enneagram_circle'
    category_details JSONB,  -- Full metadata for each category
    enabled BOOLEAN DEFAULT true,
    tier_required VARCHAR(50) DEFAULT 'free',  -- 'free', 'premium', 'pro'
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Seed initial framework
INSERT INTO frameworks (id, name, description, categories, visualization_type, tier_required) VALUES
('ayurveda', 'Ayurvedic Doshas', '5,000-year-old constitutional types', 
 '["vata", "pitta", "kapha"]', 'radar', 'free');

-- =====================================================
-- PLAID INTEGRATION
-- =====================================================

-- Plaid bank connections
CREATE TABLE plaid_connections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    access_token_encrypted TEXT NOT NULL,  -- Encrypted with app secret
    item_id VARCHAR(255) NOT NULL,  -- Plaid item ID
    institution_id VARCHAR(255),
    institution_name VARCHAR(255),
    
    -- Connection status
    status VARCHAR(50) DEFAULT 'active',  -- 'active', 'disconnected', 'error'
    error_code VARCHAR(50),
    last_sync_at TIMESTAMP,
    
    -- Metadata
    accounts_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(user_id, item_id)
);

CREATE INDEX idx_plaid_user_id ON plaid_connections(user_id);
CREATE INDEX idx_plaid_item_id ON plaid_connections(item_id);

-- Plaid accounts (checking, savings, credit card)
CREATE TABLE plaid_accounts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    connection_id UUID NOT NULL REFERENCES plaid_connections(id) ON DELETE CASCADE,
    account_id VARCHAR(255) NOT NULL,  -- Plaid account ID
    name VARCHAR(255),
    official_name VARCHAR(255),
    type VARCHAR(50),  -- 'depository', 'credit', 'loan', 'investment'
    subtype VARCHAR(50),  -- 'checking', 'savings', 'credit card'
    mask VARCHAR(10),  -- Last 4 digits
    
    -- Balance (cached from last sync)
    current_balance DECIMAL(12, 2),
    available_balance DECIMAL(12, 2),
    currency_code VARCHAR(3) DEFAULT 'USD',
    
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(connection_id, account_id)
);

CREATE INDEX idx_plaid_accounts_connection ON plaid_accounts(connection_id);

-- =====================================================
-- ANALYSIS & RESULTS
-- =====================================================

-- Dosha/framework analyses
CREATE TABLE analyses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,  -- NULL for anonymous
    session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,
    framework_id VARCHAR(50) NOT NULL REFERENCES frameworks(id),
    
    -- Input data
    transaction_count INTEGER,
    date_range_start DATE,
    date_range_end DATE,
    
    -- Results
    scores JSONB NOT NULL,  -- { "vata": 65, "pitta": 20, "kapha": 15 }
    primary_category VARCHAR(50),
    secondary_category VARCHAR(50),
    
    -- Features detected
    features JSONB,  -- { "late_night_ratio": 0.42, "merchant_diversity": 0.78, ... }
    
    -- Insights & recommendations
    insights JSONB,
    recommendations JSONB,
    
    -- AI-generated content (optional)
    ai_insights TEXT,
    ai_insights_generated_at TIMESTAMP,
    
    -- Metadata
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    shared BOOLEAN DEFAULT false,
    share_token VARCHAR(255) UNIQUE  -- For shareable results
);

CREATE INDEX idx_analyses_user_id ON analyses(user_id);
CREATE INDEX idx_analyses_framework_id ON analyses(framework_id);
CREATE INDEX idx_analyses_created_at ON analyses(created_at DESC);
CREATE INDEX idx_analyses_share_token ON analyses(share_token);

-- Historical dosha tracking (for timeline view)
CREATE TABLE dosha_snapshots (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    analysis_id UUID REFERENCES analyses(id) ON DELETE CASCADE,
    framework_id VARCHAR(50) NOT NULL REFERENCES frameworks(id),
    
    scores JSONB NOT NULL,
    primary_category VARCHAR(50),
    
    snapshot_date DATE NOT NULL,
    source VARCHAR(50),  -- 'transaction', 'quiz', 'combined'
    
    created_at TIMESTAMP DEFAULT NOW(),
    
    UNIQUE(user_id, framework_id, snapshot_date)
);

CREATE INDEX idx_snapshots_user_framework ON dosha_snapshots(user_id, framework_id);
CREATE INDEX idx_snapshots_date ON dosha_snapshots(snapshot_date DESC);

-- =====================================================
-- QUIZ & CALIBRATION (OPTIONAL)
-- =====================================================

-- Quiz responses (for calibration)
CREATE TABLE quiz_responses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,
    framework_id VARCHAR(50) NOT NULL REFERENCES frameworks(id),
    
    responses JSONB NOT NULL,  -- { "q1": "a", "q2": "c", ... }
    free_text TEXT,
    
    -- Calculated scores
    scores JSONB NOT NULL,
    primary_category VARCHAR(50),
    
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_quiz_user_id ON quiz_responses(user_id);
CREATE INDEX idx_quiz_framework_id ON quiz_responses(framework_id);

-- =====================================================
-- USAGE & ANALYTICS
-- =====================================================

-- API usage tracking (for rate limiting & billing)
CREATE TABLE api_usage (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    endpoint VARCHAR(255) NOT NULL,
    method VARCHAR(10),
    status_code INTEGER,
    response_time_ms INTEGER,
    
    -- Rate limiting
    request_date DATE NOT NULL,
    request_hour INTEGER,
    
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_usage_user_date ON api_usage(user_id, request_date);
CREATE INDEX idx_usage_endpoint ON api_usage(endpoint);

-- User events (for analytics)
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    session_id UUID REFERENCES sessions(id) ON DELETE SET NULL,
    
    event_name VARCHAR(100) NOT NULL,  -- 'bank_connected', 'analysis_completed', 'result_shared'
    event_data JSONB,
    
    -- User context
    ip_address INET,
    user_agent TEXT,
    referrer TEXT,
    
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_events_user_id ON events(user_id);
CREATE INDEX idx_events_name ON events(event_name);
CREATE INDEX idx_events_created_at ON events(created_at DESC);

-- =====================================================
-- SUBSCRIPTION & BILLING
-- =====================================================

-- Subscription plans
CREATE TABLE subscription_plans (
    id VARCHAR(50) PRIMARY KEY,  -- 'free', 'premium', 'pro'
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price_monthly DECIMAL(10, 2),
    price_yearly DECIMAL(10, 2),
    
    -- Limits
    max_analyses_per_month INTEGER,  -- NULL = unlimited
    max_bank_connections INTEGER,
    frameworks_included TEXT[],  -- ['ayurveda'] or ['ayurveda', 'tcm']
    features JSONB,  -- { "ai_insights": true, "historical_tracking": true }
    
    stripe_price_id_monthly VARCHAR(255),
    stripe_price_id_yearly VARCHAR(255),
    
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Seed plans
INSERT INTO subscription_plans (id, name, price_monthly, price_yearly, max_analyses_per_month, max_bank_connections, frameworks_included) VALUES
('free', 'Free', 0, 0, 5, 1, ARRAY['ayurveda']),
('premium', 'Premium', 7.99, 79.99, NULL, 3, ARRAY['ayurveda', 'tcm']),
('pro', 'Pro', 14.99, 149.99, NULL, NULL, ARRAY['ayurveda', 'tcm', 'enneagram']);

-- Payment transactions (Stripe webhook events)
CREATE TABLE payment_transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    stripe_payment_intent_id VARCHAR(255) UNIQUE,
    stripe_invoice_id VARCHAR(255),
    
    amount DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    status VARCHAR(50),  -- 'succeeded', 'pending', 'failed'
    
    -- Metadata
    plan_id VARCHAR(50) REFERENCES subscription_plans(id),
    billing_period VARCHAR(50),  -- 'monthly', 'yearly'
    
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_payments_user_id ON payment_transactions(user_id);
CREATE INDEX idx_payments_status ON payment_transactions(status);

-- =====================================================
-- NOTIFICATIONS & ALERTS
-- =====================================================

-- User notifications
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    
    type VARCHAR(50) NOT NULL,  -- 'dosha_shift', 'spending_alert', 'subscription_expiring'
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    
    -- Action
    action_url TEXT,
    action_label VARCHAR(100),
    
    -- Status
    read BOOLEAN DEFAULT false,
    read_at TIMESTAMP,
    dismissed BOOLEAN DEFAULT false,
    
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(user_id, read);
CREATE INDEX idx_notifications_created ON notifications(created_at DESC);

-- =====================================================
-- ADMIN & SUPPORT
-- =====================================================

-- Admin users
CREATE TABLE admin_users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) DEFAULT 'support',  -- 'support', 'admin', 'superadmin'
    permissions JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Audit log
CREATE TABLE audit_log (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    admin_user_id UUID REFERENCES admin_users(id) ON DELETE SET NULL,
    
    action VARCHAR(100) NOT NULL,  -- 'user.created', 'subscription.changed', 'data.exported'
    resource_type VARCHAR(50),  -- 'user', 'analysis', 'subscription'
    resource_id UUID,
    
    details JSONB,
    ip_address INET,
    
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_audit_user_id ON audit_log(user_id);
CREATE INDEX idx_audit_action ON audit_log(action);
CREATE INDEX idx_audit_created_at ON audit_log(created_at DESC);

-- =====================================================
-- FUNCTIONS & TRIGGERS
-- =====================================================

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to all tables with updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_oauth_updated_at BEFORE UPDATE ON oauth_connections
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_frameworks_updated_at BEFORE UPDATE ON frameworks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_plaid_connections_updated_at BEFORE UPDATE ON plaid_connections
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_plaid_accounts_updated_at BEFORE UPDATE ON plaid_accounts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_analyses_updated_at BEFORE UPDATE ON analyses
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_plans_updated_at BEFORE UPDATE ON subscription_plans
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- VIEWS (FOR COMMON QUERIES)
-- =====================================================

-- User summary view
CREATE VIEW user_summary AS
SELECT 
    u.id,
    u.email,
    u.full_name,
    u.subscription_tier,
    u.subscription_status,
    u.created_at,
    u.last_login_at,
    COUNT(DISTINCT a.id) as total_analyses,
    COUNT(DISTINCT pc.id) as connected_banks,
    MAX(a.created_at) as last_analysis_at
FROM users u
LEFT JOIN analyses a ON u.id = a.user_id
LEFT JOIN plaid_connections pc ON u.id = pc.user_id AND pc.status = 'active'
WHERE u.deleted_at IS NULL
GROUP BY u.id;

-- Monthly active users
CREATE VIEW monthly_active_users AS
SELECT 
    DATE_TRUNC('month', created_at) as month,
    COUNT(DISTINCT user_id) as active_users
FROM events
WHERE user_id IS NOT NULL
GROUP BY DATE_TRUNC('month', created_at)
ORDER BY month DESC;

-- =====================================================
-- ROW LEVEL SECURITY (RLS) - Optional but recommended
-- =====================================================

-- Enable RLS on sensitive tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE analyses ENABLE ROW LEVEL SECURITY;
ALTER TABLE plaid_connections ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Users can only see their own data
CREATE POLICY users_select_own ON users
    FOR SELECT USING (id = current_setting('app.user_id')::UUID);

CREATE POLICY analyses_select_own ON analyses
    FOR SELECT USING (user_id = current_setting('app.user_id')::UUID);

CREATE POLICY plaid_connections_select_own ON plaid_connections
    FOR SELECT USING (user_id = current_setting('app.user_id')::UUID);

CREATE POLICY notifications_select_own ON notifications
    FOR SELECT USING (user_id = current_setting('app.user_id')::UUID);

-- =====================================================
-- INDEXES FOR PERFORMANCE
-- =====================================================

-- Composite indexes for common queries
CREATE INDEX idx_analyses_user_framework_date ON analyses(user_id, framework_id, created_at DESC);
CREATE INDEX idx_events_user_name_date ON events(user_id, event_name, created_at DESC);

-- Partial indexes for active records
CREATE INDEX idx_active_plaid_connections ON plaid_connections(user_id) WHERE status = 'active';
CREATE INDEX idx_unread_notifications ON notifications(user_id, created_at DESC) WHERE read = false;

-- =====================================================
-- COMMENTS (DOCUMENTATION)
-- =====================================================

COMMENT ON TABLE users IS 'User accounts with authentication and subscription information';
COMMENT ON TABLE frameworks IS 'Available behavioral analysis frameworks (Ayurveda, TCM, etc.)';
COMMENT ON TABLE analyses IS 'Completed dosha/framework analyses with results and insights';
COMMENT ON TABLE plaid_connections IS 'Connected bank accounts via Plaid';
COMMENT ON TABLE dosha_snapshots IS 'Historical dosha tracking for timeline visualization';
COMMENT ON COLUMN users.subscription_tier IS 'Current subscription level: free, premium, or pro';
COMMENT ON COLUMN analyses.share_token IS 'Unique token for sharing results publicly';
COMMENT ON COLUMN plaid_connections.access_token_encrypted IS 'Encrypted Plaid access token (use pgcrypto)';
