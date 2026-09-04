-- ============================================================
-- FOOD DELIVERY ANALYSIS - PostgreSQL
-- Portfolio Project
-- ============================================================

-- 1. DATABASE SETUP
CREATE DATABASE food_delivery_db;

-- Connect to food_delivery_db in pgAdmin (or your client) before
-- running the remaining statements.

-- 2. TABLE DESIGN

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(50),
    phone         VARCHAR(15)
);

CREATE TABLE restaurants (
    restaurant_id   INT PRIMARY KEY,
    restaurant_name VARCHAR(100),
    cuisine_type    VARCHAR(50),
    city            VARCHAR(50),
    rating          DECIMAL(2,1)
);

CREATE TABLE orders (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    restaurant_id INT,
    order_date    TIMESTAMP,
    order_status  VARCHAR(20),   -- Delivered / Cancelled / Pending
    total_amount  DECIMAL(8,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id      INT,
    item_name     VARCHAR(100),
    quantity      INT,
    price         DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- ============================================================
-- 3. DATA QUALITY CHECK
-- ============================================================

-- Check for missing/NULL values before analysis
SELECT * FROM customers
WHERE customer_id IS NULL OR customer_name IS NULL OR city IS NULL OR phone IS NULL;

SELECT * FROM restaurants
WHERE restaurant_id IS NULL OR restaurant_name IS NULL OR cuisine_type IS NULL
   OR city IS NULL OR rating IS NULL;

SELECT * FROM orders
WHERE order_id IS NULL OR customer_id IS NULL OR restaurant_id IS NULL
   OR order_date IS NULL OR order_status IS NULL OR total_amount IS NULL;

SELECT * FROM order_items
WHERE order_item_id IS NULL OR order_id IS NULL OR item_name IS NULL
   OR quantity IS NULL OR price IS NULL;

-- If incomplete records are found, remove them:
DELETE FROM customers
WHERE customer_id IS NULL OR customer_name IS NULL OR city IS NULL OR phone IS NULL;

DELETE FROM restaurants
WHERE restaurant_id IS NULL OR restaurant_name IS NULL OR cuisine_type IS NULL
   OR city IS NULL OR rating IS NULL;

DELETE FROM orders
WHERE order_id IS NULL OR customer_id IS NULL OR restaurant_id IS NULL
   OR order_date IS NULL OR order_status IS NULL OR total_amount IS NULL;

DELETE FROM order_items
WHERE order_item_id IS NULL OR order_id IS NULL OR item_name IS NULL
   OR quantity IS NULL OR price IS NULL;

-- Verify row counts after cleaning
SELECT COUNT(*) AS customers_count FROM customers;
SELECT COUNT(*) AS restaurants_count FROM restaurants;
SELECT COUNT(*) AS orders_count FROM orders;
SELECT COUNT(*) AS order_items_count FROM order_items;


-- ============================================================
-- 4. BUSINESS ANALYSIS
-- ============================================================

-- Q1. What is the total revenue generated?
SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status = 'Delivered';

-- Q2. What is the average order value?
SELECT ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders
WHERE order_status = 'Delivered';

-- Q3. Who are the top 5 customers by total spend?
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

-- Q4. Which 5 restaurants generate the most revenue?
SELECT r.restaurant_name, SUM(o.total_amount) AS revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.restaurant_name
ORDER BY revenue DESC
LIMIT 5;

-- Q5. What is the revenue by city?
SELECT c.city, SUM(o.total_amount) AS revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.city
ORDER BY revenue DESC;

-- Q6. What is the revenue by cuisine type?
SELECT r.cuisine_type, SUM(o.total_amount) AS revenue
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
WHERE o.order_status = 'Delivered'
GROUP BY r.cuisine_type
ORDER BY revenue DESC;

-- Q7. What percentage of orders get cancelled?
SELECT
    ROUND(
        SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM orders;

-- Q8. Which menu items sell the most units?
SELECT item_name, SUM(quantity) AS units_sold
FROM order_items
GROUP BY item_name
ORDER BY units_sold DESC
LIMIT 5;

-- Q9. Which restaurants have the highest ratings?
SELECT restaurant_name, cuisine_type, rating
FROM restaurants
ORDER BY rating DESC
LIMIT 5;

-- Q10. How many customers are repeat vs one-time?
SELECT
    CASE WHEN order_count = 1 THEN 'One-time customer' ELSE 'Repeat customer' END AS customer_type,
    COUNT(*) AS num_customers
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    GROUP BY customer_id
) t
GROUP BY customer_type;

-- Q11. Which customers never placed an order?
SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q12. Rank restaurants by revenue.
SELECT restaurant_name, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS rank_by_revenue
FROM (
    SELECT r.restaurant_name, SUM(o.total_amount) AS revenue
    FROM orders o
    JOIN restaurants r ON o.restaurant_id = r.restaurant_id
    WHERE o.order_status = 'Delivered'
    GROUP BY r.restaurant_name
) t
LIMIT 5;

-- ============================================================
-- END OF FOOD DELIVERY ANALYSIS
-- ============================================================