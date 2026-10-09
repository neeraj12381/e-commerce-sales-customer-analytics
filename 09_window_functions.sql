-- Rank customers based on total sales

SELECT
    Customer_ID,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM Orders
GROUP BY Customer_ID
ORDER BY Sales_Rank;


-- Rank products based on total sales

SELECT
    Product_ID,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM Orders
GROUP BY Product_ID
ORDER BY Sales_Rank;


-- Rank products within each category by sales

SELECT
    p.Category,
    o.Product_ID,
    SUM(o.Sales) AS Total_Sales,
    RANK() OVER (
        PARTITION BY p.Category
        ORDER BY SUM(o.Sales) DESC
    ) AS Category_Rank
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category, o.Product_ID
ORDER BY p.Category, Category_Rank;


-- Rank products within each category by sales

SELECT
    p.Category,
    p.Product,
    o.Product_ID,
    SUM(o.Sales) AS Total_Sales,
    RANK() OVER (
        PARTITION BY p.Category
        ORDER BY SUM(o.Sales) DESC
    ) AS Category_Rank
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category, p.Product, o.Product_ID
ORDER BY p.Category, Category_Rank;


-- Find the top-selling product in each category

WITH Product_Ranking AS (
    SELECT
        p.Category,
        p.Product,
        SUM(o.Sales) AS Total_Sales,
        RANK() OVER (
            PARTITION BY p.Category
            ORDER BY SUM(o.Sales) DESC
        ) AS Category_Rank
    FROM Orders o
    INNER JOIN Products p
        ON o.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product
)

SELECT
    Category,
    Product,
    Total_Sales,
    Category_Rank
FROM Product_Ranking
WHERE Category_Rank = 1
ORDER BY Category;


-- Rank customers based on total number of orders

SELECT
    Customer_ID,
    COUNT(Order_ID) AS Total_Orders,
    RANK() OVER (
        ORDER BY COUNT(Order_ID) DESC
    ) AS Order_Rank
FROM Orders
GROUP BY Customer_ID
ORDER BY Order_Rank;


-- Rank customers within each state by total sales

SELECT
    c.State,
    c.Customer_ID,
    SUM(o.Sales) AS Total_Sales,
    RANK() OVER (
        PARTITION BY c.State
        ORDER BY SUM(o.Sales) DESC
    ) AS State_Rank
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.State, c.Customer_ID
ORDER BY c.State, State_Rank;


-- Calculate running total of monthly sales

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Monthly_Sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Sales,
    SUM(Monthly_Sales) OVER (
        ORDER BY Order_Month
    ) AS Running_Total_Sales
FROM Monthly_Sales
ORDER BY Order_Month;


-- Calculate month-over-month sales change

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Monthly_Sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Sales,
    LAG(Monthly_Sales) OVER (
        ORDER BY Order_Month
    ) AS Previous_Month_Sales,
    Monthly_Sales
        - LAG(Monthly_Sales) OVER (
            ORDER BY Order_Month
        ) AS Sales_Change
FROM Monthly_Sales
ORDER BY Order_Month;


-- Calculate month-over-month sales growth percentage

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Monthly_Sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Sales,
    LAG(Monthly_Sales) OVER (
        ORDER BY Order_Month
    ) AS Previous_Month_Sales,
    ROUND(
        (
            (Monthly_Sales - LAG(Monthly_Sales) OVER (
                ORDER BY Order_Month
            ))
            / LAG(Monthly_Sales) OVER (
                ORDER BY Order_Month
            )
        ) * 100,
        2
    ) AS Growth_Percent
FROM Monthly_Sales
ORDER BY Order_Month;


-- Rank products based on total profit

SELECT
    p.Product,
    SUM(o.Profit) AS Total_Profit,
    RANK() OVER (
        ORDER BY SUM(o.Profit) DESC
    ) AS Profit_Rank
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Product
ORDER BY Profit_Rank;



-- Find the top 3 products in each category by sales

WITH Product_Ranking AS (
    SELECT
        p.Category,
        p.Product,
        SUM(o.Sales) AS Total_Sales,
        RANK() OVER (
            PARTITION BY p.Category
            ORDER BY SUM(o.Sales) DESC
        ) AS Category_Rank
    FROM Orders o
    INNER JOIN Products p
        ON o.Product_ID = p.Product_ID
    GROUP BY p.Category, p.Product
)

SELECT
    Category,
    Product,
    Total_Sales,
    Category_Rank
FROM Product_Ranking
WHERE Category_Rank <= 3
ORDER BY Category, Category_Rank;


-- Calculate running total of monthly profit

WITH Monthly_Profit AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Profit) AS Monthly_Profit
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Profit,
    SUM(Monthly_Profit) OVER (
        ORDER BY Order_Month
    ) AS Running_Total_Profit
FROM Monthly_Profit
ORDER BY Order_Month;


-- Find the highest-sales customer in each state

WITH Customer_Ranking AS (
    SELECT
        c.State,
        c.Customer_ID,
        SUM(o.Sales) AS Total_Sales,
        RANK() OVER (
            PARTITION BY c.State
            ORDER BY SUM(o.Sales) DESC
        ) AS State_Rank
    FROM Orders o
    INNER JOIN Customers c
        ON o.Customer_ID = c.Customer_ID
    GROUP BY c.State, c.Customer_ID
)

SELECT
    State,
    Customer_ID,
    Total_Sales
FROM Customer_Ranking
WHERE State_Rank = 1
ORDER BY State;


-- Calculate each customer's percentage of total sales

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
        Total_Sales / SUM(Total_Sales) OVER () * 100,
        2
    ) AS Sales_Percentage
FROM Customer_Sales
ORDER BY Total_Sales DESC;


-- Rank products within each category by profit

SELECT
    p.Category,
    p.Product,
    SUM(o.Profit) AS Total_Profit,
    DENSE_RANK() OVER (
        PARTITION BY p.Category
        ORDER BY SUM(o.Profit) DESC
    ) AS Profit_Rank
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category, p.Product
ORDER BY p.Category, Profit_Rank;


-- Compare current month profit with previous month

WITH Monthly_Profit AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Profit) AS Monthly_Profit
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Profit,
    LAG(Monthly_Profit) OVER (
        ORDER BY Order_Month
    ) AS Previous_Month_Profit
FROM Monthly_Profit
ORDER BY Order_Month;


-- Rank top 3 customers in each state by sales

WITH Customer_Ranking AS (
    SELECT
        c.State,
        c.Customer_ID,
        SUM(o.Sales) AS Total_Sales,
        DENSE_RANK() OVER (
            PARTITION BY c.State
            ORDER BY SUM(o.Sales) DESC
        ) AS State_Rank
    FROM Orders o
    INNER JOIN Customers c
        ON o.Customer_ID = c.Customer_ID
    GROUP BY c.State, c.Customer_ID
)

SELECT
    State,
    Customer_ID,
    Total_Sales,
    State_Rank
FROM Customer_Ranking
WHERE State_Rank <= 3
ORDER BY State, State_Rank;


-- Calculate cumulative sales for customers

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
    SUM(Total_Sales) OVER (
        ORDER BY Total_Sales DESC
    ) AS Running_Total_Sales
FROM Customer_Sales
ORDER BY Total_Sales DESC;


-- Calculate 3-month moving average of sales

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Monthly_Sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Sales,
    ROUND(
        AVG(Monthly_Sales) OVER (
            ORDER BY Order_Month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS Moving_Average_Sales
FROM Monthly_Sales
ORDER BY Order_Month;


-- Compare sales with previous and next month

WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS Order_Month,
        SUM(Sales) AS Monthly_Sales
    FROM Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)

SELECT
    Order_Month,
    Monthly_Sales,
    LAG(Monthly_Sales) OVER (
        ORDER BY Order_Month
    ) AS Previous_Month_Sales,
    LEAD(Monthly_Sales) OVER (
        ORDER BY Order_Month
    ) AS Next_Month_Sales
FROM Monthly_Sales
ORDER BY Order_Month;

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