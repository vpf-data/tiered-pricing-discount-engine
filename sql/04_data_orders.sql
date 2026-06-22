-- ============================================
-- Mock Data: 04_data_orders.sql
-- ============================================

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1001, 1,  '2026-01-05'),  -- Apex (Gold)
(1002, 2,  '2026-01-08'),  -- Blue Ridge (Gold)
(1003, 5,  '2026-01-10'),  -- Riverside (Silver)
(1004, 8,  '2026-01-12'),  -- Daybreak (Bronze)
(1005, 1,  '2026-01-15'),  -- Apex (Gold) - boundary qty test
(1006, 6,  '2026-01-18'),  -- Coastal (Silver) - boundary qty test
(1007, 9,  '2026-01-20'),  -- Garrison (Bronze)
(1008, 3,  '2026-01-22'),  -- Summit (Gold) - high qty, approval flag
(1009, 7,  '2026-01-25'),  -- Midwest (Silver) - high qty, just under threshold
(1010, 10, '2026-01-28'),  -- Trailhead (Bronze) - low qty, no discount
(1011, 4,  '2026-02-02'),  -- Northgate (Gold) - multi-line order
(1012, 2,  '2026-02-05'),  -- Blue Ridge (Gold)
(1013, 5,  '2026-02-08'),  -- Riverside (Silver) - multi-line order
(1014, 8,  '2026-02-10'),  -- Daybreak (Bronze)
(1015, 3,  '2026-02-14');  -- Summit (Gold) - multi-line order
