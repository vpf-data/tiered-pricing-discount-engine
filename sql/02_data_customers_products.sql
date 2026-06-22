-- ============================================
-- Mock Data: 02_data_customers_products.sql
-- ============================================

-- 10 Customers: 4 Gold, 3 Silver, 3 Bronze
INSERT INTO Customers (CustomerID, CustomerName, Tier) VALUES
(1, 'Apex Manufacturing Co',   'Gold'),
(2, 'Blue Ridge Industrial',   'Gold'),
(3, 'Summit Logistics Group',  'Gold'),
(4, 'Northgate Equipment',     'Gold'),
(5, 'Riverside Hardware Ltd',  'Silver'),
(6, 'Coastal Supply Partners', 'Silver'),
(7, 'Midwest Fabricators',     'Silver'),
(8, 'Daybreak Tools Inc',      'Bronze'),
(9, 'Garrison Components',     'Bronze'),
(10,'Trailhead Equipment Co',  'Bronze');

-- 10 Products: varied price points, ~30-45% cost-to-list ratio (realistic B2B margin range)
INSERT INTO Products (ProductID, ProductName, ListPrice, Cost) VALUES
(101, 'Hydraulic Pump Unit',        1200.00, 720.00),
(102, 'Industrial Valve Assembly',   450.00, 270.00),
(103, 'Steel Bearing Set',           85.00,  48.00),
(104, 'Conveyor Belt Motor',        980.00, 610.00),
(105, 'Pressure Sensor Module',     210.00, 115.00),
(106, 'Safety Relay Switch',         65.00,  34.00),
(107, 'Heavy-Duty Gearbox',        1550.00, 990.00),
(108, 'Control Panel Enclosure',    320.00, 175.00),
(109, 'Pneumatic Cylinder',         275.00, 150.00),
(110, 'Lubrication Dispenser Kit',  140.00,  78.00);
