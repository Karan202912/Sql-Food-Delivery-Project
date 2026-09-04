# Food Delivery Sales Analysis — SQL Portfolio Project

A PostgreSQL project analyzing food delivery order data — covering
database design, data cleaning, and 12 business-driven SQL queries
around revenue, customer behavior, and restaurant performance.

## Overview

Built a small relational database for a food-delivery-style business
(think Swiggy/Zomato) and wrote queries a business analyst would
actually need — top customers, revenue by city/cuisine, cancellation
rate, best-selling items, and more.

**Tool used:** PostgreSQL / pgAdmin

## Dataset

Four related tables, one row per customer / restaurant / order / item:

| Table | Key columns |
|---|---|
| `customers` | customer_id (PK), customer_name, city, phone |
| `restaurants` | restaurant_id (PK), restaurant_name, cuisine_type, city, rating |
| `orders` | order_id (PK), customer_id (FK), restaurant_id (FK), order_date, order_status, total_amount |
| `order_items` | order_item_id (PK), order_id (FK), item_name, quantity, price |

- 30 customers, 15 restaurants
- 150 orders (Delivered / Cancelled / Pending)
- 291 order line items

`order_items` references `orders`, and `orders` references both
`customers` and `restaurants` — so tables need to be loaded in that
order (customers → restaurants → orders → order_items), otherwise the
foreign key constraints will reject the import.

## Project Workflow

1. **Database & table design** — created `food_delivery_db` and four
   tables with primary keys and foreign key relationships linking
   orders to customers and restaurants, and order_items to orders.
2. **Data quality check** — scanned every table for NULL values
   before running any analysis.
3. **Data cleaning** — removed any incomplete records and verified
   row counts.
4. **Business analysis (12 queries)** — revenue, customer behavior,
   restaurant performance, and product-level insights.

## Key SQL Concepts Used

- Multi-table `JOIN`s (customers ↔ orders ↔ restaurants ↔ order_items)
- `LEFT JOIN` to find customers with zero orders
- `GROUP BY` / aggregate functions (`SUM`, `AVG`, `COUNT`)
- `CASE WHEN` for cancellation rate and repeat-vs-one-time segmentation
- Subquery (ranking restaurants inside a derived table)
- Window function — `RANK() OVER (ORDER BY ...)`
- `ORDER BY` + `LIMIT` for top-N reporting

## Business Questions Answered

1. What is the total revenue generated?
2. What is the average order value?
3. Who are the top 5 customers by total spend?
4. Which 5 restaurants generate the most revenue?
5. What is the revenue by city?
6. What is the revenue by cuisine type?
7. What percentage of orders get cancelled?
8. Which menu items sell the most units?
9. Which restaurants have the highest ratings?
10. How many customers are repeat vs one-time?
11. Which customers never placed an order?
12. How do restaurants rank against each other by revenue?

## Sample Insights

*(Based on the sample dataset of 150 orders / 30 customers / 15 restaurants.)*

- **Total revenue:** ₹43,374 | **Average order value:** ₹390.76
- **Top customer:** Kabir Singh (₹3,502 total spend)
- **Top restaurant by revenue:** Spice 15 (₹5,196)
- **Best city by revenue:** Mumbai (₹13,421), followed by Delhi (₹11,025)
- **Top cuisine by revenue:** Fast Food (₹15,896) — well ahead of Italian
  and North Indian
- **Cancellation rate:** 15.33% of all orders
- **Best-selling item:** French Fries (73 units), followed by Veg Burger (63)
- **Highest rated restaurant:** Pizza 5 (4.9 rating, Fast Food)
- **Repeat vs one-time customers:** all 30 customers placed more than one
  order in this sample — no strictly one-time customers
- **Customers with zero orders:** 0 — every customer in this dataset has
  placed at least one order

## How to Run

1. Install PostgreSQL and pgAdmin (or use any PostgreSQL-compatible client).
2. Open `sql-food-delivery-project.sql` and run the **Database Setup**
   and **Table Design** sections first.
3. Load the CSV files into their matching tables — **in this order**:
   `customers.csv` → `restaurants.csv` → `orders.csv` → `order_items.csv`
   (via pgAdmin's Import/Export tool, or `COPY ... FROM ... CSV HEADER`).
   Loading `order_items` or `orders` before their parent tables will
   fail on the foreign key constraint.
4. Run the **Data Quality Check** section — it will remove any
   incomplete records automatically.
5. Run each numbered business question (Q1–Q12) to explore the results.

## Possible Next Steps

- Add a `delivery_agents` or `payments` table for a fuller schema.
- Visualize revenue by city/cuisine in Excel or Looker Studio.
- Wrap frequently used queries (e.g. Q3, Q4, Q7) as SQL `VIEW`s.
- Scale up the dataset (more orders, longer date range) to get a
  meaningful month-over-month trend.

## Files

- `sql-food-delivery-project.sql` — full script: schema, cleaning, and all 12 queries
- `customers.csv`, `restaurants.csv`, `orders.csv`, `order_items.csv` — sample dataset
