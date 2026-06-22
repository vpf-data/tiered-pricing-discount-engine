-- ============================================
-- Core Pricing Query: 06_core_pricing_query.sql
-- Calculates: List Price -> Discount -> Net Price -> Margin -> Approval Flag
-- ============================================

-- Step 1 (run once): Audit query - confirms every order line matches a pricing rule
-- before trusting INNER JOIN in the report query below.
SELECT ol.OrderID, ol.ProductID, c.Tier, ol.Quantity
FROM OrderLines ol
JOIN Orders o ON ol.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN PricingRules pr 
    ON c.Tier = pr.Tier AND ol.Quantity BETWEEN pr.MinQty AND pr.MaxQty
WHERE pr.RuleID IS NULL;
-- Expected result: 0 rows. If rows appear, investigate before running the report below.

-- Step 2: Core reporting query
SELECT 
    Ol.OrderID,
    Ol.ProductID,
    Ol.Quantity,
    Cu.CustomerID,
    Ord.OrderDate,
    Cu.CustomerName,
    Cu.Tier,
    Pr.ProductName,
    Pr.ListPrice,
    Pr.Cost,
    Prs.RuleID,
    Prs.MinQty,
    Prs.MaxQty,
    Prs.DiscountPercent,
    CAST(
        Ol.Quantity * Pr.ListPrice 
        - (Ol.Quantity * Pr.ListPrice * Prs.DiscountPercent / 100) 
    AS DECIMAL(10,2)) AS NetPrice,
    CAST(
        (Ol.Quantity * Pr.ListPrice 
        - (Ol.Quantity * Pr.ListPrice * Prs.DiscountPercent / 100))
        - (Ol.Quantity * Pr.Cost)
    AS DECIMAL(10,2)) AS Margin,
    CASE 
        WHEN Prs.DiscountPercent > 20 THEN 'Needs Approval'
        ELSE 'Auto-Approved'
    END AS ApprovalFlag
FROM OrderLines Ol
INNER JOIN Orders Ord ON Ol.OrderID = Ord.OrderID
INNER JOIN Customers Cu ON Ord.CustomerID = Cu.CustomerID
INNER JOIN Products Pr ON Ol.ProductID = Pr.ProductID
INNER JOIN PricingRules Prs 
    ON Cu.Tier = Prs.Tier 
    AND Ol.Quantity BETWEEN Prs.MinQty AND Prs.MaxQty
ORDER BY Ol.OrderID, Ol.ProductID;
