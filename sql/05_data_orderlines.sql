-- ============================================
-- Mock Data: 05_data_orderlines.sql
-- ============================================

INSERT INTO OrderLines (OrderID, ProductID, Quantity) VALUES
-- Order 1001: Apex (Gold), qty 5 -> low band, 5% discount
(1001, 101, 5),

-- Order 1002: Blue Ridge (Gold), qty 20 -> mid band, 15% discount
(1002, 102, 20),

-- Order 1003: Riverside (Silver), qty 7 -> low band, 0% discount
(1003, 103, 7),

-- Order 1004: Daybreak (Bronze), qty 15 -> mid band, 5% discount
(1004, 104, 15),

-- Order 1005: Apex (Gold), qty = 10 EXACT BOUNDARY -> should hit mid band (15%), not low band
(1005, 105, 10),

-- Order 1006: Coastal (Silver), qty = 49 EXACT BOUNDARY -> should hit mid band (10%), not high band
(1006, 106, 49),

-- Order 1007: Garrison (Bronze), qty 30 -> mid band, 5% discount
(1007, 107, 30),

-- Order 1008: Summit (Gold), qty 60 -> HIGH BAND, 25% discount -> SHOULD trigger approval flag
(1008, 101, 60),

-- Order 1009: Midwest (Silver), qty 55 -> HIGH BAND, 18% discount -> should NOT trigger approval flag (boundary test)
(1009, 104, 55),

-- Order 1010: Trailhead (Bronze), qty 3 -> low band, 0% discount (no discount at all)
(1010, 108, 3),

-- Order 1011: Northgate (Gold), MULTI-LINE order - 3 different products, 3 different qty bands
(1011, 101, 4),    -- low band  (5%)
(1011, 102, 25),   -- mid band  (15%)
(1011, 109, 75),   -- high band (25%) -> this line should trigger approval flag, others should not

-- Order 1012: Blue Ridge (Gold), qty 9 -> low band boundary, 5% discount
(1012, 110, 9),

-- Order 1013: Riverside (Silver), MULTI-LINE order
(1013, 103, 12),   -- mid band (10%)
(1013, 105, 2),    -- low band (0%)

-- Order 1014: Daybreak (Bronze), qty 50 -> high band exact boundary, 10% discount
(1014, 106, 50),

-- Order 1015: Summit (Gold), MULTI-LINE order, includes high qty
(1015, 107, 50),   -- high band (25%) -> should trigger approval flag
(1015, 108, 6);    -- low band (5%) -> should NOT trigger
