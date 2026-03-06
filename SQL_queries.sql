CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE sales (
InvoiceNo VARCHAR(20),
StockCode VARCHAR(20),
Description TEXT,
Quantity INT,
InvoiceDate DATETIME,
UnitPrice DECIMAL(10,2),
CustomerID INT,
Country VARCHAR(50)
);

SELECT * FROM sales
LIMIT 10;

SELECT SUM(Qty * UnitPrice) AS total_revenue
FROM sales;

DESCRIBE sales;

SELECT SUM(Qty * Amount) AS total_revenue
FROM sales;

SELECT Qty, Amount
FROM sales
LIMIT 10;

SELECT Category,
SUM(Amount) AS revenue
FROM sales
GROUP BY Category
ORDER BY revenue DESC;

SELECT SKU,
SUM(Qty) AS total_sold
FROM sales
GROUP BY SKU
ORDER BY total_sold DESC
LIMIT 10;

SELECT `ship-country`,
SUM(Amount) AS revenue
FROM sales
GROUP BY `ship-country`
ORDER BY revenue DESC;


SELECT 
    SKU,
    SUM(Qty) AS total_sold,
    RANK() OVER (ORDER BY SUM(Qty) DESC) AS sales_rank
FROM sales
GROUP BY SKU;

SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    SUM(Amount) AS monthly_revenue
FROM sales
GROUP BY month
ORDER BY month;


SELECT 
    `ship-country`,
    SUM(Amount) AS revenue,
    ROUND(
        SUM(Amount) / (SELECT SUM(Amount) FROM sales) * 100,
        2
    ) AS revenue_percent
FROM sales
GROUP BY `ship-country`
ORDER BY revenue DESC;

SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    SUM(Amount) AS monthly_revenue,
    
    AVG(SUM(Amount)) OVER (
        ORDER BY DATE_FORMAT(`Date`, '%Y-%m')
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_revenue
    
FROM sales
GROUP BY month
ORDER BY month;

