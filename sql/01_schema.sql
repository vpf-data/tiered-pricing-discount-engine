-- ============================================
-- Tiered Pricing & Discount Rule Engine
-- Schema: 01_schema.sql
-- ============================================

CREATE TABLE Customers (
    CustomerID      INT PRIMARY KEY,
    CustomerName    VARCHAR(100) NOT NULL,
    Tier            VARCHAR(10)  NOT NULL CHECK (Tier IN ('Gold','Silver','Bronze'))
);

CREATE TABLE Products (
    ProductID       INT PRIMARY KEY,
    ProductName     VARCHAR(100) NOT NULL,
    ListPrice       DECIMAL(10,2) NOT NULL,
    Cost            DECIMAL(10,2) NOT NULL
);

CREATE TABLE PricingRules (
    RuleID          INT PRIMARY KEY,
    Tier            VARCHAR(10)  NOT NULL CHECK (Tier IN ('Gold','Silver','Bronze')),
    MinQty          INT NOT NULL,
    MaxQty          INT NOT NULL,
    DiscountPercent DECIMAL(5,2) NOT NULL
);

CREATE TABLE Orders (
    OrderID         INT PRIMARY KEY,
    CustomerID      INT NOT NULL,
    OrderDate       DATE NOT NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderLines (
    OrderID         INT NOT NULL,
    ProductID       INT NOT NULL,
    Quantity        INT NOT NULL CHECK (Quantity > 0),
    CONSTRAINT PK_OrderLines PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT FK_OrderLines_Orders   FOREIGN KEY (OrderID)   REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderLines_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
