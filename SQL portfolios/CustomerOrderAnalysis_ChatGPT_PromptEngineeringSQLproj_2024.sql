DROP DATABASE IF EXISTS customer_order_analysis;
CREATE DATABASE customer_order_analysis;
USE customer_order_analysis;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL
);

SELECT c.CustomerName, o.OrderID, o.OrderDate, p.ProductName, o.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-12-31';

SELECT CustomerID, COUNT(OrderID) AS TotalOrders, AVG(TotalAmount) AS AverageOrderValue
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) > 5;

SELECT ProductID, Quantity,
RANK() OVER (ORDER BY Quantity DESC) AS QuantityRank
FROM Orders;

SELECT OrderID, TotalAmount,
CASE
    WHEN TotalAmount > 500 THEN 'High'
    WHEN TotalAmount BETWEEN 200 AND 500 THEN 'Medium'
    ELSE 'Low'
END AS SpendingCategory
FROM Orders;

WITH CustomerOrders AS (
    SELECT CustomerID, COUNT(OrderID) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT c.CustomerName, co.TotalOrders
FROM Customers c
JOIN CustomerOrders co ON c.CustomerID = co.CustomerID
WHERE co.TotalOrders > 5;

