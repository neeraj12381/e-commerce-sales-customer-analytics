-- Find customers whose total sales are above average customer sales

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
HAVING SUM(o.Sales) > (
    SELECT AVG(Customer_Sales)
    FROM (
        SELECT
            Customer_ID,
            SUM(Sales) AS Customer_Sales
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Sales_Table
)
ORDER BY Total_Sales DESC;


-- Find customers whose sales are above the overall average customer sales

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
HAVING SUM(o.Sales) > (
    SELECT AVG(Total_Sales)
    FROM (
        SELECT
            Customer_ID,
            SUM(Sales) AS Total_Sales
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Sales
)
ORDER BY Total_Sales DESC;

-- Find products whose total sales are above average product sales

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Sales) > (
    SELECT AVG(Total_Sales)
    FROM (
        SELECT
            Product_ID,
            SUM(Sales) AS Total_Sales
        FROM Orders
        GROUP BY Product_ID
    ) AS Product_Sales
)
ORDER BY Total_Sales DESC;


-- Find the customer with the highest total sales

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
HAVING SUM(o.Sales) = (
    SELECT MAX(Total_Sales)
    FROM (
        SELECT
            Customer_ID,
            SUM(Sales) AS Total_Sales
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Sales
);


-- Find the product with the highest total profit

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Profit) AS Total_Profit
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Profit) = (
    SELECT MAX(Total_Profit)
    FROM (
        SELECT
            Product_ID,
            SUM(Profit) AS Total_Profit
        FROM Orders
        GROUP BY Product_ID
    ) AS Product_Profit
);


-- Find customers whose order count is above the average

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(o.Order_ID) > (
    SELECT AVG(Order_Count)
    FROM (
        SELECT
            Customer_ID,
            COUNT(Order_ID) AS Order_Count
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Orders
)
ORDER BY Total_Orders DESC;


-- Find products whose total profit is above average product profit

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Profit) AS Total_Profit
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Profit) > (
    SELECT AVG(Total_Profit)
    FROM (
        SELECT
            Product_ID,
            SUM(Profit) AS Total_Profit
        FROM Orders
        GROUP BY Product_ID
    ) AS Product_Profit
)
ORDER BY Total_Profit DESC;


-- Find customers whose sales are higher than the average sales of all orders

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
HAVING SUM(o.Sales) > (
    SELECT AVG(Sales)
    FROM Orders
)
ORDER BY Total_Sales DESC;


-- Find products whose total sales are higher than the average order sales

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Sales) > (
    SELECT AVG(Sales)
    FROM Orders
)
ORDER BY Total_Sales DESC;


-- Find customers with the highest number of orders

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(o.Order_ID) = (
    SELECT MAX(Order_Count)
    FROM (
        SELECT
            Customer_ID,
            COUNT(Order_ID) AS Order_Count
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Orders
)
ORDER BY Total_Orders DESC;


-- Find the product with the highest total sales

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Sales) = (
    SELECT MAX(Product_Sales)
    FROM (
        SELECT
            Product_ID,
            SUM(Sales) AS Product_Sales
        FROM Orders
        GROUP BY Product_ID
    ) AS Product_Sales_Table
);


-- Find orders whose sales are above average order sales

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Sales,
    Profit
FROM Orders
WHERE Sales > (
    SELECT AVG(Sales)
    FROM Orders
)
ORDER BY Sales DESC;


-- Find orders whose profit is above average order profit

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Sales,
    Profit
FROM Orders
WHERE Profit > (
    SELECT AVG(Profit)
    FROM Orders
)
ORDER BY Profit DESC;


-- Find customers whose total sales are above average customer sales

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
HAVING SUM(o.Sales) > (
    SELECT AVG(Customer_Sales)
    FROM (
        SELECT
            Customer_ID,
            SUM(Sales) AS Customer_Sales
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Sales
)
ORDER BY Total_Sales DESC;


-- Find customers whose total profit is above average customer profit

SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(o.Profit) AS Total_Profit
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING SUM(o.Profit) > (
    SELECT AVG(Customer_Profit)
    FROM (
        SELECT
            Customer_ID,
            SUM(Profit) AS Customer_Profit
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Profit_Table
)
ORDER BY Total_Profit DESC;


-- Find the product with the highest average order sales

SELECT
    p.Product_ID,
    p.Product,
    ROUND(AVG(o.Sales), 2) AS Average_Order_Sales
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING AVG(o.Sales) = (
    SELECT MAX(Average_Sales)
    FROM (
        SELECT
            Product_ID,
            AVG(Sales) AS Average_Sales
        FROM Orders
        GROUP BY Product_ID
    ) AS Product_Average_Sales
);


-- Find the category with the highest total sales

SELECT
    p.Category,
    SUM(o.Sales) AS Total_Sales
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY p.Category
HAVING SUM(o.Sales) = (
    SELECT MAX(Category_Sales)
    FROM (
        SELECT
            p2.Category,
            SUM(o2.Sales) AS Category_Sales
        FROM Products p2
        INNER JOIN Orders o2
            ON p2.Product_ID = o2.Product_ID
        GROUP BY p2.Category
    ) AS Category_Sales_Table
);


-- Find the state with the highest total sales

SELECT
    c.State,
    SUM(o.Sales) AS Total_Sales
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.State
HAVING SUM(o.Sales) = (
    SELECT MAX(State_Sales)
    FROM (
        SELECT
            c2.State,
            SUM(o2.Sales) AS State_Sales
        FROM Customers c2
        INNER JOIN Orders o2
            ON c2.Customer_ID = o2.Customer_ID
        GROUP BY c2.State
    ) AS State_Sales_Table
);


-- Find the payment mode with the highest total sales

SELECT
    Payment_Mode,
    SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Payment_Mode
HAVING SUM(Sales) = (
    SELECT MAX(Payment_Sales)
    FROM (
        SELECT
            Payment_Mode,
            SUM(Sales) AS Payment_Sales
        FROM Orders
        GROUP BY Payment_Mode
    ) AS Payment_Sales_Table
);


-- Find the shipping mode with the highest total profit

SELECT
    Shipping_Mode,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Shipping_Mode
HAVING SUM(Profit) = (
    SELECT MAX(Shipping_Profit)
    FROM (
        SELECT
            Shipping_Mode,
            SUM(Profit) AS Shipping_Profit
        FROM Orders
        GROUP BY Shipping_Mode
    ) AS Shipping_Profit_Table
);


-- Find the city with the highest total sales

SELECT
    c.City,
    SUM(o.Sales) AS Total_Sales
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.City
HAVING SUM(o.Sales) = (
    SELECT MAX(City_Sales)
    FROM (
        SELECT
            c2.City,
            SUM(o2.Sales) AS City_Sales
        FROM Customers c2
        INNER JOIN Orders o2
            ON c2.Customer_ID = o2.Customer_ID
        GROUP BY c2.City
    ) AS City_Sales_Table
);


-- Find the category with the highest total profit

SELECT
    p.Category,
    SUM(o.Profit) AS Total_Profit
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY p.Category
HAVING SUM(o.Profit) = (
    SELECT MAX(Category_Profit)
    FROM (
        SELECT
            p2.Category,
            SUM(o2.Profit) AS Category_Profit
        FROM Products p2
        INNER JOIN Orders o2
            ON p2.Product_ID = o2.Product_ID
        GROUP BY p2.Category
    ) AS Category_Profit_Table
);


-- Find the customer with the highest average order value

SELECT
    c.Customer_ID,
    c.Customer_Name,
    ROUND(AVG(o.Sales), 2) AS Average_Order_Value
FROM Customers c
INNER JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING AVG(o.Sales) = (
    SELECT MAX(Customer_AOV)
    FROM (
        SELECT
            Customer_ID,
            AVG(Sales) AS Customer_AOV
        FROM Orders
        GROUP BY Customer_ID
    ) AS Customer_Average_Sales
);

-- Find products with negative total profit

SELECT
    p.Product_ID,
    p.Product,
    SUM(o.Sales) AS Total_Sales,
    SUM(o.Profit) AS Total_Profit
FROM Products p
INNER JOIN Orders o
    ON p.Product_ID = o.Product_ID
GROUP BY
    p.Product_ID,
    p.Product
HAVING SUM(o.Profit) < 0
ORDER BY Total_Profit;