-- Identify customers with high sales and high profit

WITH Customer_Performance AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Orders o
    INNER JOIN Customers c
        ON o.Customer_ID = c.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Sales,
    Total_Profit
FROM Customer_Performance
WHERE Total_Sales > 50000
  AND Total_Profit > 10000
ORDER BY Total_Sales DESC;



-- Calculate customer lifetime value

WITH Customer_Value AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        COUNT(o.Order_ID) AS Total_Orders,
        SUM(o.Sales) AS Total_Sales,
        SUM(o.Profit) AS Total_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Orders,
    Total_Sales,
    Total_Profit,
    ROUND(Total_Sales / Total_Orders, 2) AS Average_Order_Value
FROM Customer_Value
ORDER BY Total_Sales DESC;


-- Analyze product profitability

SELECT
    p.Product,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Profit_Margin DESC;


-- Identify products with high sales but low profit

SELECT
    p.Product,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    ROUND(SUM(o.Profit) / SUM(o.Sales) * 100, 2) AS Profit_Margin
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product
HAVING SUM(o.Sales) > 50000
   AND SUM(o.Profit) < 15000
ORDER BY Total_Sales DESC;


-- Calculate customer lifetime value using profit

WITH Customer_Value AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        COUNT(o.Order_ID) AS Total_Orders,
        SUM(o.Profit) AS Lifetime_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Orders,
    Lifetime_Profit
FROM Customer_Value
ORDER BY Lifetime_Profit DESC;


-- Segment customers based on total sales

WITH Customer_Sales AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        SUM(o.Sales) AS Total_Sales
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Sales,
    CASE
        WHEN Total_Sales >= 50000 THEN 'High Value'
        WHEN Total_Sales >= 25000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Customer_Segment
FROM Customer_Sales
ORDER BY Total_Sales DESC;


-- Identify customer-product combinations generating the highest profit

SELECT
    c.Customer_Name,
    p.Product,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit,
    COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY
    c.Customer_Name,
    p.Product
ORDER BY Total_Profit DESC
LIMIT 10;


-- Rank customers based on profit contribution

WITH Customer_Profit AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        SUM(o.Profit) AS Total_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Profit,
    DENSE_RANK() OVER (
        ORDER BY Total_Profit DESC
    ) AS Profit_Rank
FROM Customer_Profit
ORDER BY Profit_Rank;


-- Calculate each customer's contribution to total profit

WITH Customer_Profit AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,
        SUM(o.Profit) AS Total_Profit
    FROM Customers c
    INNER JOIN Orders o
        ON c.Customer_ID = o.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name
)

SELECT
    Customer_ID,
    Customer_Name,
    Total_Profit,
    ROUND(
        Total_Profit / SUM(Total_Profit) OVER () * 100,
        2
    ) AS Profit_Contribution_Percent
FROM Customer_Profit
ORDER BY Profit_Contribution_Percent DESC;


-- Find the most profitable customer-product combination

WITH Customer_Product AS (
    SELECT
        c.Customer_Name,
        p.Product,
        SUM(o.Profit) AS Total_Profit
    FROM Orders o
    INNER JOIN Customers c
        ON o.Customer_ID = c.Customer_ID
    INNER JOIN Products p
        ON o.Product_ID = p.Product_ID
    GROUP BY
        c.Customer_Name,
        p.Product
)

SELECT
    Customer_Name,
    Product,
    Total_Profit
FROM Customer_Product
ORDER BY Total_Profit DESC
LIMIT 10;
