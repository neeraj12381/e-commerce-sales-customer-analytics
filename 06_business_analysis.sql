-- Find top 10 products by sales

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
ORDER BY Total_Sales DESC
LIMIT 10;

-- Find top 10 customers by sales

SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Sales) AS Total_Sales
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-- Analyze sales and profit by category

SELECT
    p.Category,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

-- Analyze monthly sales and profit

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Order_Month;

-- Analyze sales and profit by payment mode

SELECT
    Payment_Mode,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM Orders
GROUP BY Payment_Mode
ORDER BY Total_Sales DESC;

-- Analyze sales and profit by shipping mode

SELECT
    Shipping_Mode,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Average_Order_Value
FROM Orders
GROUP BY Shipping_Mode
ORDER BY Total_Sales DESC;


-- Find customers with the highest number of orders

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Orders DESC
LIMIT 10;


-- Calculate profit margin by product

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    ROUND((SUM(o.Profit) / SUM(o.Sales)) * 100, 2) AS Profit_Margin_Percent
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
ORDER BY Profit_Margin_Percent DESC;


-- Find products with high sales but relatively low profit

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    ROUND((SUM(o.Profit) / SUM(o.Sales)) * 100, 2) AS Profit_Margin_Percent
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Sales) > 100000
   AND (SUM(o.Profit) / SUM(o.Sales)) * 100 < 20
ORDER BY Total_Sales DESC;

-- Analyze sales and profit by state

SELECT
    c.State,
    COUNT(DISTINCT c.Customer_ID) AS Total_Customers,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.State
ORDER BY Total_Sales DESC;


-- Calculate average order value by customer

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    ROUND(SUM(o.Sales) / COUNT(o.Order_ID), 2) AS Average_Order_Value
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Average_Order_Value DESC;


-- Analyze sales and profit by discount level

SELECT
    Discount,
    COUNT(*) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Average_Sales
FROM Orders
GROUP BY Discount
ORDER BY Discount;


-- Find repeat customers

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(o.Order_ID) > 1
ORDER BY Total_Orders DESC;


-- Find one-time customers

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(o.Order_ID) = 1
ORDER BY Total_Sales DESC;


-- Calculate customer contribution to total sales

SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Sales) AS Customer_Sales,
    ROUND(
        (SUM(o.Sales) / (SELECT SUM(Sales) FROM Orders)) * 100,
        2
    ) AS Sales_Contribution_Percent
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Sales_Contribution_Percent DESC;


-- Analyze monthly order performance

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Order_Month;


-- Calculate profit margin by category

SELECT
    p.Category,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    ROUND(
        (SUM(o.Profit) / SUM(o.Sales)) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY p.Category
ORDER BY Profit_Margin_Percent DESC;


-- Analyze sales and profit by sub-category

SELECT
    p.Sub_Category,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    ROUND(
        (SUM(o.Profit) / SUM(o.Sales)) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY p.Sub_Category
ORDER BY Total_Sales DESC;


-- Find top cities by sales

SELECT
    c.City,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.City
ORDER BY Total_Sales DESC
LIMIT 10;


-- Classify customers by order frequency

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    CASE
        WHEN COUNT(o.Order_ID) >= 5 THEN 'High Frequency'
        WHEN COUNT(o.Order_ID) >= 2 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS Customer_Type
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Orders DESC;


-- Calculate overall business KPIs

SELECT
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    ROUND(AVG(Sales), 2) AS Average_Order_Value,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percent
FROM Orders;

-- Classify orders by sales value

SELECT
    Order_ID,
    Sales,
    CASE
        WHEN Sales >= 50000 THEN 'High Value'
        WHEN Sales >= 20000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Order_Value_Category
FROM Orders
ORDER BY Sales DESC;