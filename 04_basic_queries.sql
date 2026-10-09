-- View all columns from the Orders table

USE ecommerce_analytics;

SELECT *
FROM Orders;

-- View selected columns from the Orders table

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Product_ID,
    Sales,
    Profit
FROM Orders;

-- Filter orders where sales are greater than 50000

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Sales,
    Profit
FROM Orders
WHERE Sales > 50000;

-- Sort orders by sales from highest to lowest

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Sales,
    Profit
FROM Orders
ORDER BY Sales DESC;

-- Get the top 10 orders by sales

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Sales,
    Profit
FROM Orders
ORDER BY Sales DESC
LIMIT 10;

-- Find high-value orders with positive profit

SELECT
    Order_ID,
    Order_Date,
    Sales,
    Profit
FROM Orders
WHERE Sales > 50000
  AND Profit > 0;
  
  -- Analyze total sales by customer

SELECT
    Customer_ID,
    SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Customer_ID;

-- Find customers with total sales above 100000

SELECT
    Customer_ID,
    SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Customer_ID
HAVING SUM(Sales) > 100000;

-- Calculate key sales metrics

SELECT
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    AVG(Sales) AS Average_Sales,
    MIN(Sales) AS Minimum_Sales,
    MAX(Sales) AS Maximum_Sales
FROM Orders;

-- Classify orders based on sales value

SELECT
    Order_ID,
    Sales,
    CASE
        WHEN Sales >= 50000 THEN 'High Value'
        WHEN Sales >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Category
FROM Orders;

-- Count orders by payment mode

SELECT
    Payment_Mode,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Payment_Mode
ORDER BY Total_Orders DESC;

-- Analyze sales and profit by payment mode

SELECT
    Payment_Mode,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    AVG(Sales) AS Average_Sales
FROM Orders
GROUP BY Payment_Mode
ORDER BY Total_Sales DESC;

-- Analyze profitable orders by shipping mode

SELECT
    Shipping_Mode,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Orders
WHERE Profit > 0
GROUP BY Shipping_Mode
ORDER BY Total_Profit DESC;

-- Find unique payment modes

SELECT DISTINCT
    Payment_Mode
FROM Orders;

-- Find unique customer and shipping combinations

SELECT DISTINCT
    Customer_ID,
    Shipping_Mode
FROM Orders;

-- Find orders with sales between 20000 and 50000

SELECT
    Order_ID,
    Sales,
    Profit
FROM Orders
WHERE Sales BETWEEN 20000 AND 50000;

-- Find orders paid by selected payment modes

SELECT
    Order_ID,
    Payment_Mode,
    Sales,
    Profit
FROM Orders
WHERE Payment_Mode IN ('UPI', 'CARD');

-- Check all payment modes

SELECT DISTINCT
    Payment_Mode
FROM Orders;

-- Find customers whose ID starts with C01

SELECT
    Order_ID,
    Customer_ID,
    Sales
FROM Orders
WHERE Customer_ID LIKE 'C01%';

-- Find orders with missing profit

SELECT
    Order_ID,
    Sales,
    Profit
FROM Orders
WHERE Profit IS NULL;

-- Find high-sales or high-profit orders

SELECT
    Order_ID,
    Sales,
    Profit
FROM Orders
WHERE Sales > 50000
   OR Profit > 10000;
   
   -- Find orders not paid by UPI

SELECT
    Order_ID,
    Payment_Mode,
    Sales
FROM Orders
WHERE Payment_Mode <> 'UPI';

-- Find orders excluding UPI and COD

SELECT
    Order_ID,
    Payment_Mode,
    Sales,
    Profit
FROM Orders
WHERE Payment_Mode NOT IN ('UPI', 'COD');

-- Calculate average sales with two decimal places

SELECT
    ROUND(AVG(Sales), 2) AS Average_Sales
FROM Orders;

-- Replace missing profit with zero

SELECT
    Order_ID,
    Sales,
    COALESCE(Profit, 0) AS Profit
FROM Orders;

-- Find minimum and maximum sales by payment mode

SELECT
    Payment_Mode,
    MIN(Sales) AS Minimum_Sales,
    MAX(Sales) AS Maximum_Sales
FROM Orders
GROUP BY Payment_Mode
ORDER BY Maximum_Sales DESC;
