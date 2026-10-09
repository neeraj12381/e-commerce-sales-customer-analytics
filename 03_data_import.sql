-- Verify the number of records in each table

USE ecommerce_analytics;

SELECT 'Customers' AS Table_Name, COUNT(*) AS Record_Count
FROM Customers

UNION ALL

SELECT 'Products', COUNT(*)
FROM Products

UNION ALL

SELECT 'Orders', COUNT(*)
FROM Orders;