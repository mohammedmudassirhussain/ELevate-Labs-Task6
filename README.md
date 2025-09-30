# ELevate-Labs-Task6
# Online Sales Analysis

## Overview
This project analyzes an **online sales dataset** using MySQL. The goal is to extract insights such as monthly revenue trends, total orders per month, and top revenue months.

The analysis includes:
- Loading CSV data into MySQL
- Creating a structured table for sales data
- Calculating total revenue and order volume
- Aggregating data by month and year
- Identifying top revenue months

---

## Dataset
- **Source:** Online Sales CSV (`online_sales_dataset.csv`)
- **Columns:**
  - `order_id` : Unique ID for each order
  - `order_date` : Date and time of the order
  - `product_id` : Product identifier
  - `quantity` : Number of items ordered
  - `unit_price` : Price per item
  - `amount` : Total amount for the order line (calculated)

---

## SQL Queries Performed
1. Create database and table for sales data
2. Load CSV data into MySQL using `LOAD DATA LOCAL INFILE`
3. Update `amount` column as `quantity * unit_price`
4. Extract month and year from `order_date`
5. Aggregate total revenue and total orders by month
6. Sort results and identify top revenue months

