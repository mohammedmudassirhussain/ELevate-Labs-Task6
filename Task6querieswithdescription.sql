CREATE DATABASE online_sales_db;
USE online_sales_db;

CREATE TABLE online_sales (
    order_id INT,
    order_date DATETIME,
    product_id VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    amount DECIMAL(15,2)
);



-- =========================================================
-- 1. Use the database for Online Sales
-- =========================================================
-- This sets the context to the database where the table resides.
USE online_sales_db;

-- =========================================================
-- 2. Create the table (optional if it doesn't exist)
-- =========================================================
-- Defines the structure of the 'online_sales' table.
-- Columns:
-- order_id     : unique ID for each order
-- order_date   : date and time of order
-- product_id   : product identifier
-- quantity     : number of items ordered
-- unit_price   : price per item
-- amount       : total amount for the order line
CREATE TABLE IF NOT EXISTS online_sales (
    order_id INT,
    order_date DATETIME,
    product_id VARCHAR(50),
    quantity INT,
    unit_price DECIMAL(10,2),
    amount DECIMAL(15,2)
);

-- =========================================================
-- 3. Load CSV data into the table
-- =========================================================
-- Loads data from 'online_sales_dataset.csv' into the table.
-- Uses LOCAL INFILE to read a local file.
-- Adjusts the date format using STR_TO_DATE.
-- Calculates the amount column on the fly.
LOAD DATA LOCAL INFILE 'C:/Users/sakin/Downloads/online_sales_dataset.csv'
INTO TABLE online_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@order_id, @stockcode, @description, @quantity, @order_date, @unit_price, @c7, @c8, @c9, @c10, @c11, @c12, @c13, @c14, @c15, @c16, @c17)
SET
    order_id = @order_id,
    product_id = @stockcode,
    quantity = @quantity,
    order_date = STR_TO_DATE(@order_date, '%Y-%m-%d %H:%i:%s'),
    unit_price = @unit_price,
    amount = @quantity * @unit_price;

-- =========================================================
-- 4. Ensure 'amount' column is correct
-- =========================================================
-- Updates the amount column in case it wasn't calculated properly during import.
UPDATE online_sales
SET amount = quantity * unit_price;

-- =========================================================
-- 5. Extract Month from order_date
-- =========================================================
-- Example query to see the month of the first 5 orders.
SELECT EXTRACT(MONTH FROM order_date) AS month
FROM online_sales
LIMIT 5;

-- =========================================================
-- 6. Extract Year and Month for grouping
-- =========================================================
-- Shows first 5 year-month combinations in the data.
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month
FROM online_sales
GROUP BY year, month
LIMIT 5;

-- =========================================================
-- 7. Calculate total revenue per month
-- =========================================================
-- Sums up 'amount' for each month to analyze sales trends.
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, month
LIMIT 5;

-- =========================================================
-- 8. Count total orders per month
-- =========================================================
-- Counts distinct orders per month.
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year, month
LIMIT 5;

-- =========================================================
-- 9. Combined Revenue and Orders per month
-- =========================================================
-- Shows total revenue and total orders together for each month.
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM online_sales
GROUP BY year, month
ORDER BY year, month;

-- =========================================================
-- 10. Top 3 months by revenue
-- =========================================================
-- Lists the top 3 months with highest total revenue.
SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS total_revenue
FROM online_sales
GROUP BY year, month
ORDER BY total_revenue DESC
LIMIT 3;
