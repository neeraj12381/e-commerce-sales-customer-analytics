-- Calculate total sales for each customer using a CTE

WITH Customer_Sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    cs.Total_Sales
FROM Customers c
INNER JOIN Customer_Sales cs
    ON c.Customer_ID = cs.Customer_ID
ORDER BY cs.Total_Sales DESC;


-- Find top 10 customers by total sales using a CTE

WITH Customer_Sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    cs.Total_Sales
FROM Customers c
INNER JOIN Customer_Sales cs
    ON c.Customer_ID = cs.Customer_ID
ORDER BY cs.Total_Sales DESC
LIMIT 10;


-- Calculate order frequency for each customer using a CTE

WITH Customer_Orders AS (
    SELECT
        Customer_ID,
        COUNT(Order_ID) AS Total_Orders
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    co.Total_Orders
FROM Customers c
INNER JOIN Customer_Orders co
    ON c.Customer_ID = co.Customer_ID
ORDER BY co.Total_Orders DESC;


-- Find repeat customers using a CTE

WITH Customer_Orders AS (
    SELECT
        Customer_ID,
        COUNT(Order_ID) AS Total_Orders
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    co.Total_Orders
FROM Customers c
INNER JOIN Customer_Orders co
    ON c.Customer_ID = co.Customer_ID
WHERE co.Total_Orders > 1
ORDER BY co.Total_Orders DESC;


-- Find one-time customers using a CTE

WITH Customer_Orders AS (
    SELECT
        Customer_ID,
        COUNT(Order_ID) AS Total_Orders
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    co.Total_Orders
FROM Customers c
INNER JOIN Customer_Orders co
    ON c.Customer_ID = co.Customer_ID
WHERE co.Total_Orders = 1
ORDER BY c.Customer_ID;


-- Calculate total profit for each customer using a CTE

WITH Customer_Profit AS (
    SELECT
        Customer_ID,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    cp.Total_Profit
FROM Customers c
INNER JOIN Customer_Profit cp
    ON c.Customer_ID = cp.Customer_ID
ORDER BY cp.Total_Profit DESC;


-- Calculate sales and profit for each customer using a CTE

WITH Customer_Performance AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    cp.Total_Sales,
    cp.Total_Profit
FROM Customers c
INNER JOIN Customer_Performance cp
    ON c.Customer_ID = cp.Customer_ID
ORDER BY cp.Total_Sales DESC;


-- Calculate profit margin for each customer using a CTE

WITH Customer_Performance AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    c.Customer_ID,
    c.Customer_Name,
    cp.Total_Sales,
    cp.Total_Profit,
    ROUND(
        (cp.Total_Profit / cp.Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Customers c
INNER JOIN Customer_Performance cp
    ON c.Customer_ID = cp.Customer_ID
ORDER BY Profit_Margin_Percent DESC;


-- Calculate total sales for each product using a CTE

WITH Product_Sales AS (
    SELECT
        Product_ID,
        SUM(Sales) AS Total_Sales
    FROM Orders
    GROUP BY Product_ID
)

SELECT
    p.Product_ID,
    p.Product,
    p.Category,
    ps.Total_Sales
FROM Products p
INNER JOIN Product_Sales ps
    ON p.Product_ID = ps.Product_ID
ORDER BY ps.Total_Sales DESC;


-- Calculate total profit for each product using a CTE

WITH Product_Profit AS (
    SELECT
        Product_ID,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Product_ID
)

SELECT
    p.Product_ID,
    p.Product,
    p.Category,
    pp.Total_Profit
FROM Products p
INNER JOIN Product_Profit pp
    ON p.Product_ID = pp.Product_ID
ORDER BY pp.Total_Profit DESC;


-- Calculate sales and profit for each product using a CTE

WITH Product_Performance AS (
    SELECT
        Product_ID,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Product_ID
)

SELECT
    p.Product_ID,
    p.Product,
    p.Category,
    pp.Total_Sales,
    pp.Total_Profit
FROM Products p
INNER JOIN Product_Performance pp
    ON p.Product_ID = pp.Product_ID
ORDER BY pp.Total_Sales DESC;


-- Calculate profit margin for each product using a CTE

WITH Product_Performance AS (
    SELECT
        Product_ID,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Product_ID
)

SELECT
    p.Product_ID,
    p.Product,
    p.Category,
    pp.Total_Sales,
    pp.Total_Profit,
    ROUND(
        (pp.Total_Profit / pp.Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Products p
INNER JOIN Product_Performance pp
    ON p.Product_ID = pp.Product_ID
ORDER BY Profit_Margin_Percent DESC;


-- Analyze sales and profit by category using a CTE

WITH Category_Performance AS (
    SELECT
        p.Category,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Products p
    INNER JOIN Orders o
        ON p.Product_ID = o.Product_ID
    GROUP BY p.Category
)

SELECT
    Category,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Category_Performance
ORDER BY Total_Sales DESC;


-- Analyze sales and profit by sub-category using a CTE

WITH SubCategory_Performance AS (
    SELECT
        p.Sub_Category,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Products p
    INNER JOIN Orders o
        ON p.Product_ID = o.Product_ID
    GROUP BY p.Sub_Category
)

SELECT
    Sub_Category,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM SubCategory_Performance
ORDER BY Total_Sales DESC;


-- Analyze monthly sales and profit using a CTE

WITH Monthly_Performance AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Monthly_Performance
ORDER BY Order_Month;


-- Analyze monthly order performance using a CTE

WITH Monthly_Orders AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        SUM(Quantity) AS Total_Quantity,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Total_Orders,
    Total_Quantity,
    Total_Sales,
    Total_Profit
FROM Monthly_Orders
ORDER BY Order_Month;


-- Calculate month-over-month sales growth using a CTE

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Total_Sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Total_Sales,
    ROUND(
        (
            (Total_Sales - LAG(Total_Sales) OVER (ORDER BY Order_Month))
            / LAG(Total_Sales) OVER (ORDER BY Order_Month)
        ) * 100,
        2
    ) AS Sales_Growth_Percent
FROM Monthly_Sales
ORDER BY Order_Month;


-- Analyze sales and profit by state using a CTE

WITH State_Performance AS (
    SELECT
        c.State,
        COUNT(DISTINCT o.Order_ID) AS Total_Orders,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.State
)

SELECT
    State,
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM State_Performance
ORDER BY Total_Sales DESC;


-- CTE (Common Table Expression): Analyze sales and profit by state

WITH State_Performance AS (
    SELECT
        c.State,
        COUNT(DISTINCT o.Order_ID) AS Total_Orders,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.State
)

SELECT
    State,
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM State_Performance
ORDER BY Total_Sales DESC;


-- CTE (Common Table Expression): Analyze sales and profit by payment mode

WITH Payment_Performance AS (
    SELECT
        Payment_Mode,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Payment_Mode
)

SELECT
    Payment_Mode,
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Payment_Performance
ORDER BY Total_Sales DESC;


-- CTE (Common Table Expression): Analyze sales and profit by shipping mode

WITH Shipping_Performance AS (
    SELECT
        Shipping_Mode,
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
    GROUP BY Shipping_Mode
)

SELECT
    Shipping_Mode,
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM Shipping_Performance
ORDER BY Total_Sales DESC;


-- CTE (Common Table Expression): Analyze sales and profit by city

WITH City_Performance AS (
    SELECT
        c.City,
        COUNT(DISTINCT o.Order_ID) AS Total_Orders,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.City
)

SELECT
    City,
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND(
        (Total_Profit / Total_Sales) * 100,
        2
    ) AS Profit_Margin_Percent
FROM City_Performance
ORDER BY Total_Sales DESC;


-- CTE (Common Table Expression): Find the top 10 cities by sales

WITH City_Sales AS (
    SELECT
        c.City,
        SUM(o.Sales) AS Total_Sales
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.City
)

SELECT
    City,
    Total_Sales
FROM City_Sales
ORDER BY Total_Sales DESC
LIMIT 10;


-- CTE (Common Table Expression): Calculate customer sales contribution

WITH Customer_Sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS Total_Sales
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    Customer_ID,
    Total_Sales,
    ROUND(
        (Total_Sales / (SELECT SUM(Total_Sales) FROM Customer_Sales)) * 100,
        2
    ) AS Sales_Contribution_Percent
FROM Customer_Sales
ORDER BY Total_Sales DESC;


-- CTE (Common Table Expression): Segment customers by order frequency

WITH Customer_Orders AS (
    SELECT
        Customer_ID,
        COUNT(Order_ID) AS Total_Orders
    FROM Orders
    GROUP BY Customer_ID
)

SELECT
    Customer_ID,
    Total_Orders,
    CASE
        WHEN Total_Orders = 1 THEN 'One-Time'
        WHEN Total_Orders BETWEEN 2 AND 4 THEN 'Regular'
        ELSE 'Frequent'
    END AS Customer_Segment
FROM Customer_Orders
ORDER BY Total_Orders DESC;


-- CTE (Common Table Expression): Calculate overall business KPIs

WITH Business_KPI AS (
    SELECT
        COUNT(DISTINCT Order_ID) AS Total_Orders,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM Orders
)

SELECT
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND((Total_Profit / Total_Sales) * 100, 2) AS Profit_Margin_Percent
FROM Business_KPI;


-- CTE (Common Table Expression): Identify high-value orders

WITH Order_Value AS (
    SELECT
        Order_ID,
        Sales
    FROM Orders
)

SELECT
    Order_ID,
    Sales
FROM Order_Value
WHERE Sales > 30000
ORDER BY Sales DESC;


-- CTE (Common Table Expression): Identify low-profit orders

WITH Order_Profit AS (
    SELECT
        Order_ID,
        Sales,
        Profit
    FROM Orders
)

SELECT
    Order_ID,
    Sales,
    Profit
FROM Order_Profit
WHERE Profit < 1000
ORDER BY Profit;


-- CTE (Common Table Expression): Analyze top-performing categories

WITH Category_Performance AS (
    SELECT
        p.Category,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Orders o
    INNER JOIN Products p
        ON o.Product_ID = p.Product_ID
    GROUP BY p.Category
)

SELECT
    Category,
    Total_Sales,
    Total_Profit
FROM Category_Performance
ORDER BY Total_Sales DESC;

