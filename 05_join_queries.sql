-- Combine orders with customer details

SELECT
    o.Order_ID,
    o.Order_Date,
    o.Customer_ID,
    c.Customer_Name,
    c.City,
    c.State,
    o.Sales,
    o.Profit
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID;
    
    
    -- Combine orders with product details

SELECT
    o.Order_ID,
    o.Product_ID,
    p.Product,
    p.Category,
    p.Sub_Category,
    o.Quantity,
    o.Sales,
    o.Profit
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID;
    
    
-- Combine orders, customer, and product details

SELECT
    o.Order_ID,
    o.Order_Date,
    c.Customer_Name,
    c.City,
    c.State,
    p.Product,
    p.Category,
    o.Quantity,
    o.Sales,
    o.Profit
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID;
    
    
-- Combine orders, customer, and product details

SELECT
    o.Order_ID,
    o.Order_Date,
    c.Customer_Name,
    c.City,
    c.State,
    p.Product,
    p.Category,
    o.Quantity,
    o.Sales,
    o.Profit
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID;
    
-- Show all customers and their orders

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    o.Order_ID,
    o.Sales,
    o.Profit
FROM Customers c
LEFT JOIN Orders o
    ON c.Customer_ID = o.Customer_ID;
    
-- Show all products and their orders

SELECT
    p.Product_ID,
    p.Product,
    p.Category,
    o.Order_ID,
    o.Quantity,
    o.Sales,
    o.Profit
FROM Orders o
RIGHT JOIN Products p
    ON o.Product_ID = p.Product_ID;
    
    
-- Find products with no orders

SELECT
    p.Product_ID,
    p.Product,
    p.Category
FROM Products p
LEFT JOIN Orders o
    ON p.Product_ID = o.Product_ID
WHERE o.Order_ID IS NULL;

-- Analyze sales and profit by product

SELECT
    p.Product_ID,
    p.Product,
    p.Category,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product,
    p.Category
ORDER BY Total_Sales DESC;

-- Analyze sales and profit by customer

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.State,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    c.State
ORDER BY Total_Sales DESC;

-- Find customers with high total sales

SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING SUM(o.Sales) > 100000
ORDER BY Total_Sales DESC;

-- Analyze sales and profit by product category

SELECT
    p.Category,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
INNER JOIN Products p
    ON o.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

-- Analyze sales and profit by state

SELECT
    c.State,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY c.State
ORDER BY Total_Sales DESC;


-- Analyze sales by payment mode

SELECT
    o.Payment_Mode,
    COUNT(DISTINCT o.Customer_ID) AS Total_Customers,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
INNER JOIN Customers c
    ON o.Customer_ID = c.Customer_ID
GROUP BY o.Payment_Mode
ORDER BY Total_Sales DESC;

-- Analyze order frequency by customer

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
ORDER BY Total_Orders DESC;


-- Compare customers from the same city

SELECT
    c1.Customer_Name AS Customer_1,
    c2.Customer_Name AS Customer_2,
    c1.City
FROM Customers c1
INNER JOIN Customers c2
    ON c1.City = c2.City
   AND c1.Customer_ID < c2.Customer_ID;