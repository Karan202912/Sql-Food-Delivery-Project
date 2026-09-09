# Food Delivery Sales Analysis - SQL Portfolio Project

A PostgreSQL project that analyzes food delivery order data. The project covers database design, data cleaning, and 12 SQL queries focused on revenue, customer behavior, restaurant performance, and menu items.

## Overview

This project uses a small food delivery database with four related tables:

* customers
* restaurants
* orders
* order_items

The main goal was to practice SQL using a realistic business-style dataset and answer common questions related to sales and customer behavior.

Tool used: PostgreSQL / pgAdmin

## Dataset

The project contains four related tables:

| Table       | Key columns                                                                  |
| ----------- | ---------------------------------------------------------------------------- |
| customers   | customer_id, customer_name, city, phone                                      |
| restaurants | restaurant_id, restaurant_name, cuisine_type, city, rating                   |
| orders      | order_id, customer_id, restaurant_id, order_date, order_status, total_amount |
| order_items | order_item_id, order_id, item_name, quantity, price                          |

Dataset size:

* 30 customers
* 15 restaurants
* 150 orders
* 291 order items

Order status values include Delivered, Cancelled, and Pending.

The tables are connected using primary and foreign keys. The orders table references customers and restaurants, while order_items references orders.

Because of these relationships, the CSV files should be imported in this order:

customers -> restaurants -> orders -> order_items

## Project Workflow

### 1. Database and Table Design

Created a PostgreSQL database called `food_delivery_db` and created four tables with primary and foreign key relationships.

### 2. Data Quality Check

Checked the tables for NULL values before running the analysis.

### 3. Data Cleaning

Removed incomplete records where required and checked the row counts after cleaning.

### 4. Business Analysis

Created 12 SQL queries to analyze revenue, customers, restaurants, orders, and menu items.

## SQL Concepts Used

* INNER JOIN
* LEFT JOIN
* GROUP BY
* SUM
* AVG
* COUNT
* CASE WHEN
* Subqueries
* Window functions
* RANK()
* ORDER BY
* LIMIT
* Aggregate functions

## Business Questions

The project answers the following questions:

1. What is the total revenue generated?
2. What is the average order value?
3. Who are the top 5 customers by total spend?
4. Which 5 restaurants generate the most revenue?
5. What is the revenue by city?
6. What is the revenue by cuisine type?
7. What percentage of orders are cancelled?
8. Which menu items sell the most units?
9. Which restaurants have the highest ratings?
10. How many customers are repeat customers and how many are one-time customers?
11. Which customers never placed an order?
12. How do restaurants rank based on revenue?

## Sample Results

Based on the sample dataset:

* Total revenue: ₹43,374
* Average order value: ₹390.76
* Top customer: Kabir Singh with ₹3,502 total spend
* Top restaurant by revenue: Spice 15 with ₹5,196
* Highest revenue city: Mumbai with ₹13,421
* Second highest revenue city: Delhi with ₹11,025
* Top cuisine by revenue: Fast Food with ₹15,896
* Cancellation rate: 15.33%
* Best-selling item: French Fries with 73 units
* Second best-selling item: Veg Burger with 63 units
* Highest rated restaurant: Pizza 5 with a rating of 4.9

In this sample dataset, all 30 customers placed more than one order. There were no one-time customers and no customers with zero orders.

## How to Run

1. Install PostgreSQL and pgAdmin.

2. Open `sql-food-delivery-project.sql`.

3. Run the Database Setup section.

4. Run the Table Design section.

5. Import the CSV files into their matching tables.

6. Import the files in this order:

   `customers.csv`

   `restaurants.csv`

   `orders.csv`

   `order_items.csv`

7. Run the Data Quality Check section.

8. Run the queries from Q1 to Q12.

The CSV files can be imported using the pgAdmin Import/Export option or PostgreSQL `COPY` commands.

## Possible Improvements

Some possible additions to the project:

* Add a delivery_agents table
* Add a payments table
* Add more orders and a longer date range
* Create SQL views for commonly used reports
* Add monthly revenue analysis
* Create dashboards using Excel or Looker Studio

## Files

* `sql-food-delivery-project.sql` - SQL script containing the database setup, table creation, data cleaning, and business queries
* `customers.csv` - customer data
* `restaurants.csv` - restaurant data
* `orders.csv` - order data
* `order_items.csv` - order item data

## Project Goal

The goal of this project was to practice PostgreSQL and understand how SQL can be used to answer business questions from relational data.
