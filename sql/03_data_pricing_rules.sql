-- ============================================
-- Mock Data: 03_data_pricing_rules.sql
-- ============================================

-- 9 rules: 3 tiers x 3 quantity bands
-- MaxQty = 9999 is a deliberate convention meaning "no upper bound"
INSERT INTO PricingRules (RuleID, Tier, MinQty, MaxQty, DiscountPercent) VALUES
(1, 'Gold',   1,  9,   5.00),
(2, 'Gold',   10, 49,  15.00),
(3, 'Gold',   50, 9999,25.00),
(4, 'Silver', 1,  9,   0.00),
(5, 'Silver', 10, 49,  10.00),
(6, 'Silver', 50, 9999,18.00),
(7, 'Bronze', 1,  9,   0.00),
(8, 'Bronze', 10, 49,  5.00),
(9, 'Bronze', 50, 9999,10.00);
