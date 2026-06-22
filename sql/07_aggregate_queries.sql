-- ============================================
-- Aggregate / Business-Insight Queries: 07_aggregate_queries.sql
-- ============================================

-- Reusable CTE: row-level pricing calculation (same logic as 06_core_pricing_query.sql)
WITH cte_base AS (
    SELECT 
        Ol.OrderID,
        Ol.ProductID,
        Ol.Quantity,
        Cu.Tier,
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
)

-- Query 1: Total Net Revenue & Margin by Customer Tier
SELECT 
    Tier,
    SUM(NetPrice) AS TotalNetRevenue,
    SUM(Margin) AS TotalMargin,
    COUNT(*) AS OrderLineCount
FROM cte_base
GROUP BY Tier
ORDER BY TotalMargin DESC;


-- Query 2: Approval Routing Summary by Tier
-- (run separately - same CTE redefined since a CTE only scopes to one statement)
WITH cte_base2 AS (
    SELECT 
        Cu.Tier,
        CASE 
            WHEN Prs.DiscountPercent > 20 THEN 'Needs Approval'
            ELSE 'Auto-Approved'
        END AS ApprovalFlag
    FROM OrderLines Ol
    INNER JOIN Orders Ord ON Ol.OrderID = Ord.OrderID
    INNER JOIN Customers Cu ON Ord.CustomerID = Cu.CustomerID
    INNER JOIN PricingRules Prs 
        ON Cu.Tier = Prs.Tier 
        AND Ol.Quantity BETWEEN Prs.MinQty AND Prs.MaxQty
)
SELECT 
    Tier,
    SUM(CASE WHEN ApprovalFlag = 'Needs Approval' THEN 1 ELSE 0 END) AS NeedsApproval,
    SUM(CASE WHEN ApprovalFlag = 'Auto-Approved' THEN 1 ELSE 0 END) AS AutoApproved
FROM cte_base2
GROUP BY Tier
ORDER BY Tier;
