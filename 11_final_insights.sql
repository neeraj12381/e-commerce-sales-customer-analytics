-- Analyze monthly business performance

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY Month;


-- Analyze category performance using sales, profit, and margin

SELECT
    p.Category,
    ROUND(SUM(o.Sales), 2) AS Total_Sales,
    ROUND(SUM(o.Profit), 2) AS Total_Profit,
    ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Profit DESC;


-- Analyze one-time and repeat customers

SELECT
    Customer_Type,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Customer_Sales), 2) AS Average_Customer_Sales
FROM (
    SELECT
        Customer_ID,
        SUM(Sales) AS Customer_Sales,
        CASE
            WHEN COUNT(Order_ID) = 1 THEN 'One-Time Customer'
            ELSE 'Repeat Customer'
        END AS Customer_Type
    FROM Orders
    GROUP BY Customer_ID
) AS Customer_Data
GROUP BY Customer_Type;


-- Identify products with high sales but low profit margin

SELECT
    p.Product,
    ROUND(SUM(o.Sales), 2) AS Total_Sales,
    ROUND(SUM(o.Profit), 2) AS Total_Profit,
    ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product
HAVING SUM(o.Sales) > 50000
   AND (SUM(o.Profit) / SUM(o.Sales) * 100) < 30
ORDER BY Total_Sales DESC;


-- Calculate overall business performance

SELECT
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Sales), 2) AS Average_Order_Value,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM Orders;
