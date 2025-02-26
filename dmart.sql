SELECT * FROM dmart.`dmart.ns`;

-- Total number of records
SELECT COUNT(*) AS TotalRecords FROM dmart.`dmart.ns`;

-- Summary statistics for numeric columns
SELECT 
    MIN(Close) AS Min_Close,
    MAX(Close) AS Max_Close,
    AVG(Close) AS Avg_Close,
    SUM(Volume) AS Total_Volume
FROM dmart.`dmart.ns`;

-- Data for a specific date range

SELECT * 
FROM dmart.`dmart.ns`
WHERE Date BETWEEN '2023-07-01' AND '2023-07-31';

-- Average closing price by month
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    AVG(Close) AS Avg_Close_Price
FROM dmart.`dmart.ns`
GROUP BY Month;

-- Identify trends in stock prices over time
-- Rolling average of closing prices over a period
SELECT 
    Date,
    Close,
    AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS Rolling_Avg_Close
FROM dmart.`dmart.ns`
ORDER BY Date;

-- Days with unusually high trading volume
SELECT 
    Date,
    Volume
FROM dmart.`dmart.ns`
WHERE Volume > (SELECT AVG(Volume) * 2 FROM dmart.`dmart.ns`);

-- Total volume traded each month
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Volume) AS Total_Volume
FROM dmart.`dmart.ns`
GROUP BY Month;

-- Days with significant price range (High - Low)
SELECT 
    Date,
    High - Low AS Price_Range
FROM dmart.`dmart.ns`
ORDER BY Price_Range DESC;

-- 5-day moving average of closing prices
SELECT 
    Date,
    Close,
    AVG(Close) OVER (ORDER BY Date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS Five_Day_MA
FROM dmart.`dmart.ns`
ORDER BY Date;

-- Monthly return percentage
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    (Close - LAG(Close, 1) OVER (ORDER BY Date)) / LAG(Close, 1) OVER (ORDER BY Date) * 100 AS Monthly_Return
FROM dmart.`dmart.ns`;