-- WORKING ON 4 TABLE FOR PRACTICING JOIN , CLAUSE , CONSTRAIN , FUNCTIONS , VIEW
-- DDL DML DQL DCL TCL

-- Create Database
CREATE DATABASE Four_Table;
USE Four_Table;
SET SQL_SAFE_UPDATES = 0;
SET sql_mode = '';
-- Create customers table
CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  address VARCHAR(200),
  city VARCHAR(50),
  state VARCHAR(50),
  zip_code VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DROP TABLE customers;
-- Create products table
CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL, 
  category VARCHAR(50),
  stock_quantity INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DROP TABLE products;
-- Create orders table
CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) DEFAULT 'pending',
  total_amount DECIMAL(10, 2) NOT NULL,
  shipping_address VARCHAR(200),
  payment_method VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
DROP TABLE orders;

-- Create order_items table (junction table for orders and products)
CREATE TABLE order_items (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
DROP TABLE order_items;

-- Insert sample data into customers table
INSERT INTO customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
('John', 'Doe', 'john.doe@example.com', '555-123-4567', '123 Main St', 'New York', 'NY', '10001'),
('Jane', 'Smith', 'jane.smith@example.com', '555-987-6543', '456 Oak Ave', 'Los Angeles', 'CA', '90001'),
('Michael', 'Johnson', 'michael.j@example.com', '555-222-3333', '789 Pine Rd', 'Chicago', 'IL', '60007'),
('Emily', 'Williams', 'emily.w@example.com', '555-444-5555', '321 Cedar Ln', 'Houston', 'TX', '77001'),
('David', 'Brown', 'david.b@example.com', '555-666-7777', '654 Birch Blvd', 'Phoenix', 'AZ', '85001'),
('Sarah', 'Jones', 'sarah.j@example.com', '555-888-9999', '987 Maple Dr', 'Philadelphia', 'PA', '19019'),
('Robert', 'Miller', 'robert.m@example.com', '555-111-2222', '159 Elm St', 'San Antonio', 'TX', '78201'),
('Jennifer', 'Davis', 'jennifer.d@example.com', '555-333-4444', '753 Walnut Ave', 'San Diego', 'CA', '92101'),
('William', 'Garcia', 'william.g@example.com', '555-555-6666', '951 Spruce Rd', 'Dallas', 'TX', '75201'),
('Elizabeth', 'Rodriguez', 'elizabeth.r@example.com', '555-777-8888', '357 Pineapple Ln', 'San Jose', 'CA', '95101'),
('James', 'Wilson', 'james.w@example.com', '555-999-0000', '246 Orange Blvd', 'Austin', 'TX', '78701'),
('Patricia', 'Martinez', 'patricia.m@example.com', '555-222-1111', '135 Lemon Dr', 'Jacksonville', 'FL', '32099');

-- Insert sample data into products table
INSERT INTO products (name, description, price, category, stock_quantity) VALUES
('Smartphone X', 'Latest smartphone with advanced features', 999.99, 'Electronics', 50),
('Laptop Pro', 'High-performance laptop for professionals', 1499.99, 'Electronics', 30),
('Wireless Headphones', 'Noise-cancelling wireless headphones', 199.99, 'Electronics', 100),
('Coffee Maker', 'Programmable coffee maker with timer', 79.99, 'Kitchen', 45),
('Running Shoes', 'Lightweight running shoes for athletes', 129.99, 'Footwear', 75),
('Backpack', 'Durable backpack with multiple compartments', 59.99, 'Accessories', 120),
('Smart Watch', 'Fitness tracker and smartwatch', 249.99, 'Electronics', 60),
('Blender', 'High-speed blender for smoothies', 89.99, 'Kitchen', 40),
('Desk Chair', 'Ergonomic office chair', 199.99, 'Furniture', 25),
('Yoga Mat', 'Non-slip yoga mat for exercise', 29.99, 'Fitness', 150),
('Water Bottle', 'Insulated stainless steel water bottle', 24.99, 'Accessories', 200),
('Bluetooth Speaker', 'Portable wireless speaker', 69.99, 'Electronics', 80);

-- Insert sample data into orders table
INSERT INTO orders (customer_id, order_date, status, total_amount, shipping_address, payment_method) VALUES
(1, '2023-01-15 10:30:00', 'completed', 1199.98, '123 Main St, New York, NY 10001', 'credit_card'),
(2, '2023-01-20 14:45:00', 'completed', 199.99, '456 Oak Ave, Los Angeles, CA 90001', 'paypal'),
(3, '2023-02-05 09:15:00', 'completed', 279.98, '789 Pine Rd, Chicago, IL 60007', 'credit_card'),
(4, '2023-02-10 16:20:00', 'shipped', 1499.99, '321 Cedar Ln, Houston, TX 77001', 'credit_card'),
(5, '2023-03-01 11:00:00', 'completed', 129.99, '654 Birch Blvd, Phoenix, AZ 85001', 'paypal'),
(6, '2023-03-15 13:30:00', 'shipped', 349.98, '987 Maple Dr, Philadelphia, PA 19019', 'credit_card'),
(7, '2023-04-02 10:45:00', 'pending', 89.99, '159 Elm St, San Antonio, TX 78201', 'paypal'),
(8, '2023-04-10 15:15:00', 'shipped', 229.98, '753 Walnut Ave, San Diego, CA 92101', 'credit_card'),
(9, '2023-05-05 09:30:00', 'completed', 249.99, '951 Spruce Rd, Dallas, TX 75201', 'credit_card'),
(10, '2023-05-20 14:00:00', 'pending', 1569.98, '357 Pineapple Ln, San Jose, CA 95101', 'paypal'),
(1, '2023-06-01 11:30:00', 'shipped', 59.99, '123 Main St, New York, NY 10001', 'credit_card'),
(2, '2023-06-15 16:45:00', 'completed', 319.98, '456 Oak Ave, Los Angeles, CA 90001', 'credit_card');

-- Insert sample data into order_items table
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 999.99),
(1, 3, 1, 199.99),
(2, 3, 1, 199.99),
(3, 4, 1, 79.99),
(3, 10, 2, 29.99),
(4, 2, 1, 1499.99),
(5, 5, 1, 129.99),
(6, 7, 1, 249.99),
(6, 10, 1, 29.99),
(6, 11, 2, 24.99),
(7, 8, 1, 89.99),
(8, 11, 2, 24.99),
(8, 3, 1, 199.99),
(9, 7, 1, 249.99),
(10, 2, 1, 1499.99),
(10, 11, 1, 24.99),
(10, 10, 1, 29.99),
(11, 6, 1, 59.99),
(12, 5, 1, 129.99),
(12, 3, 1, 199.99);
SELECT * FROM order_items;
-- START QUERIES
-- Basic Queries

-- 1 **Retrieve all customers**:
SELECT * FROM customers;
-- 2 **Get all products**:
SELECT * FROM products;
-- 3 **List all orders**:
SELECT * FROM orders;
-- 4 **View specific columns from customers**:
SELECT customer_id, first_name, last_name, email FROM customers;
-- 5 **Get product names and prices**:
SELECT name, price FROM products;

-- Filtering Data

-- 6 **Find customers from a specific state**:
SELECT * FROM customers WHERE state = 'CA';
-- 7 **Get products with price greater than $100**:
SELECT * FROM products WHERE price > 100;
-- 8 **Find orders with a specific payment method**:
SELECT * FROM orders WHERE payment_method = 'paypal';
-- 9 **Get products with low stock (less than 50)**:
SELECT * FROM products WHERE stock_quantity < 50;
-- 10 **Find orders placed in a specific date range**:
SELECT * FROM orders WHERE order_date BETWEEN '2023-03-01' AND '2023-05-31';
-- 11 **Get customers with missing phone numbers**:
SELECT * FROM customers WHERE phone IS NULL;
-- 12 **Find products in specific categories**:
SELECT * FROM products WHERE category IN ('Electronics', 'Kitchen');
-- 13 **Get products with names containing specific text**:
SELECT * FROM products WHERE name LIKE '%Wireless%';

-- Sorting Results

-- 14 **Sort customers alphabetically by last name**:
SELECT * FROM customers ORDER BY last_name;
-- 15 **Get products ordered by price (highest to lowest)**:
SELECT * FROM products ORDER BY price DESC;
-- 16 **Sort orders by date (newest first)**:
SELECT * FROM orders ORDER BY ORDER_date DESC;
-- 17 **Get products sorted by category and then by price**:
SELECT * FROM products ORDER BY category , price;

-- Aggregation Functions

-- 18 **Count total number of customers**:
SELECT COUNT(customer_id) FROM customers;
-- 19 **Calculate average product price**:
SELECT AVG(price) FROM products;
-- 20 **Find the most expensive product**:
SELECT MAX(price) FROM products;
-- 21 **Calculate total value of inventory**:
SELECT SUM(price * stock_quantity) AS inventory_value FROM products;
-- 22 **Get count of orders by status**:
SELECT status, COUNT(status) FROM orders GROUP BY status;

-- Joins

-- 23 **Get customer details with their orders**:
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
-- 24 **List all products in a specific order**:
SELECT o.order_id, p.name, oi.quantity, oi.unit_price
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_id = 1;
-- 25. **Find customers who haven't placed any orders (left join)**:
SELECT c.* FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id WHERE o.customer_id IS NULL;
-- 26 **Get all products and their order history (including products never ordered)**:
SELECT p.* FROM products p JOIN order_items o ON p.product_id=o.product_id ORDER BY p.product_id;
-- 27 **Multi-table join for complete order details**:
SELECT o.order_id, o.order_date, c.first_name, c.last_name, 
       p.name AS product_name, p.category, oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS line_total
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id, p.name;

-- Group By and Having

-- 28. **Total sales by customer**:
SELECT c.customer_id,c.first_name,c.last_name , SUM(o.total_amount) AS total FROM customerS c 
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id
ORDER BY total DESC;
-- 29 **Count orders by state**:
SELECT c.state, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY order_count DESC;

-- 30 **Total sales by product category**:
SELECT p.category, SUM(oi.quantity * oi.unit_price) AS total_sales 
FROM products p 
JOIN order_items oi ON p.product_id=oi.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 31 **Find customers who spent more than $1000**:
SELECT c.customer_id,c.first_name,c.last_name,o.total_amount FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
WHERE o.total_amount > 1000
ORDER BY o.total_amount DESC;

-- 32 **Find products ordered more than 5 times**:
SELECT p.product_id,p.name,COUNT(oi.order_item_id) AS orders FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
GROUP BY p.product_id,p.name
HAVING COUNT(oi.order_item_id) > 2
ORDER BY orders DESC;

-- Subqueries

-- 33. **Find customers who ordered a specific product**:
SELECT c.* FROM customers c WHERE c.customer_id IN (
SELECT o.customer_id FROM orders o 
JOIN order_items oi ON o.order_id=oi.order_id
WHERE oi.product_id=3
);

-- 34 **Get products that have never been ordered**:
SELECT * FROM products p WHERE p.product_id NOT IN(SELECT DISTINCT o.product_id FROM order_items o);

-- 35 Find customers who spent more than average
SELECT c.customer_id,c.first_name,AVG(o.total_amount) FROM customers c JOIN orders o ON c.customer_id=o.customer_id 
GROUP BY c.customer_id HAVING AVG(o.total_amount) > (SELECT AVG(total_amount) FROM orders);

-- 36 **Get orders with more items than average**:
SELECT o.order_id, COUNT(oi.order_item_id) FROM orders o JOIN order_items oi ON o.order_id=oi.order_id 
GROUP BY o.order_id 
HAVING COUNT(oi.order_item_id)>(SELECT AVG(item_count) FROM (SELECT order_id, COUNT(order_item_id) AS item_count FROM order_items GROUP BY order_id) AS average);

-- Common Table Expressions (CTEs)

-- 37. **Calculate customer lifetime value using CTE**:  
WITH customer_orders AS (
    SELECT c.customer_id, 
           c.first_name, 
           c.last_name, 
           SUM(o.total_amount) AS total_spent, 
           COUNT(o.order_id) AS order_count, 
           MIN(o.order_date) AS first_order_date, 
           MAX(o.order_date) AS last_order_date
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT *, 
       total_spent / order_count AS avg_order_value,
       total_spent / (TIMESTAMPDIFF(MONTH, first_order_date, last_order_date) + 1) AS monthly_value
FROM customer_orders
ORDER BY total_spent DESC;

-- 38 **Find popular product combinations using CTE**:
SELECT * FROM products;
SELECT * FROM order_items;
WITH order_products AS (
SELECT oi1.order_id,p1.name AS product1 , p2.name AS product2 
	FROM order_items oi1 
    JOIN order_items oi2 
		ON oi1.order_id = oi2.order_id 
			AND oi1.product_id < oi2.product_id 
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
)
SELECT product1,product2,COUNT(*) AS combination_count FROM order_products GROUP BY product1,product2 ORDER BY combination_count DESC;

-- 39 **Recursive CTE to find customer order history with running totals**:
WITH RECURSIVE customer_order_history AS (
    SELECT c.customer_id, c.first_name, c.last_name, 
           o.order_id, o.order_date, o.total_amount,
           o.total_amount AS running_total,
           1 AS order_sequence
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.order_date = (
        SELECT MIN(order_date) 
        FROM orders 
        WHERE customer_id = c.customer_id
    )
    
    UNION ALL
    
    SELECT coh.customer_id, coh.first_name, coh.last_name,
           o.order_id, o.order_date, o.total_amount,
           coh.running_total + o.total_amount AS running_total,
           coh.order_sequence + 1 AS order_sequence
    FROM customer_order_history coh
    JOIN orders o ON coh.customer_id = o.customer_id
    WHERE o.order_date > coh.order_date
)
SELECT *
FROM customer_order_history
ORDER BY customer_id, order_date;

-- WINDOW FUNCTION

-- 40 **Rank customers by total spending**:
SELECT c.first_name,c.first_name , c.last_name,SUM(o.total_amount) 
	AS TOTAL_SPEND, 
		RANK() OVER(ORDER BY SUM(o.total_amount) DESC) AS ranking 
    FROM customers c 
    JOIN orders o 
		ON c.customer_id=o.customer_id 
			GROUP BY c.customer_id,c.first_name,c.last_name;

-- 41 **Calculate running total of order amounts by date**:
SELECT order_date,total_amount ,SUM(total_amount) 
	OVER (ORDER BY order_date DESC) AS running_total 
FROM orders;

-- 42 **Find each customer's most recent order**:
SELECT o.customer_id, c.first_name,c.last_name,o.order_id,o.order_date,o.total_amount
FROM orders o
JOIN customerS c 
	ON c.customer_id=o.customer_id
JOIN(
	SELECT customer_id,MAX(order_date) AS largest_order_date
    FROM orders 
    GROUP BY customer_id
) latest_orders
ON o.customer_id=latest_orders.customer_id AND o.order_date=latest_orders.largest_order_date;

-- 43 **Calculate month-over-month sales growth**:
WITH month_wise_total AS(
SELECT EXTRACT(MONTH FROM o.order_date) AS month_no , SUM(oi.unit_price) AS total FROM order_items oi JOIN orders o ON o.order_id = oi.order_id
 GROUP BY EXTRACT(MONTH FROM order_date)
),
month_growth AS(
	SELECT month_no,total,
		LAG(total) OVER(ORDER BY month_no) AS last_month_total,
        total - LAG(total) OVER(ORDER BY month_no) AS changes,
        CASE
			WHEN LAG(total) OVER(ORDER BY month_no) IS NULL THEN NULL
            ELSE ROUND(100 * (total - LAG(total) OVER(ORDER BY month_no)) / LAG(total) OVER(ORDER BY month_no),2)
		END AS percentage
        FROM month_wise_total
)
select * from month_growth;
select * from orders;

-- Data Modification

-- 44. **Insert a new customer**:
INSERT INTO customers(first_name,last_name,email,phone,address,city,state,zip_code)
	VALUES("Het","Maradiya","hetmardiya9@gmail.com",8128758520,"kamrej","surat","gujrat",394185);
-- 45 **Update product prices with a percentage increase**:
UPDATE products SET price = price* 1.10 WHERE category = 'Electronics';
select * from products;
-- 46 **Delete orders older than a certain date**:
DELETE FROM orders WHERE order_date < '2023-01-01';
-- 47 **Update customer address**:
UPDATE customers SET address="rajkot" WHERE first_name="Het";
-- 48 **Insert a new order with items (transaction)**:
select * from products;
START TRANSACTION;

-- Insert into orders and capture the order_id
INSERT INTO orders (customer_id, status, total_amount, shipping_address, payment_method)
VALUES (3, 'pending', 299, 'Ahmedabad', 'online');

-- Get the last inserted order ID
SET @new_order_id = LAST_INSERT_ID();

-- Insert into order_items using the captured order_id
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (@new_order_id, 7, 1, 299),
       (@new_order_id, 11, 2, 24.99);

-- Update product stock
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 7;
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 11;

COMMIT;

-- 49 **Customer segmentation by spending**:
WITH customer_spending_per_month AS(
	SELECT c.customer_id,c.first_name,c.last_name,SUM(o.total_amount) AS total_spent
    FROM customers c 
    JOIN orders o ON c.customer_id=o.customer_id
    GROUP BY c.customer_id
)
SELECT customer_id,first_name,last_name,total_spent,
	CASE 
		WHEN total_spent > 1000 THEN "High Value"
        WHEN total_spent > 500 THEN "Midium Value"
        WHEN total_spent < 500 THEN "Low Value"
	END AS customer_segement
FROM customer_spending_per_month ORDER BY total_spent DESC;

-- 50 **Calculate product profitability (assuming cost is 60% of price)**:
WITH product_profitability AS (
	SELECT p.product_id,p.name,p.price,
    SUM(oi.quantity) AS units_sold,
	SUM(oi.quantity * oi.unit_price) AS revenu,
    SUM(oi.quantity * (p.price * 0.6)) AS cost
    FROM products p 
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_id
)
SELECT product_id,name,units_sold,revenu,cost, revenu-cost AS profit,
	CASE
		WHEN revenu = 0 THEN 0
        ELSE ROUND(100.0 * (revenu-cost)/revenu, 2)
	END AS profit_margin
FROM product_profitability 
ORDER BY profit DESC;

-- 51 **RFM (Recency, Frequency, Monetary) analysis for customer segmentation**:

-- 52 **Analyze sales by day of week**:
SELECT 
	DAYNAME(order_date) AS days, 
    COUNT(order_id) AS total_orders , 
    SUM(total_amount) 
FROM orders 
	GROUP BY DAYNAME(order_date)
    ORDER BY FIELD(DAYNAME(order_date), 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    -- ORDER BY WEEKDAY(order_date);

-- 53 **Create indexes for better performance**:
-- Index for customer lookup by email
CREATE INDEX indx_customers_email ON customers(email);
DROP INDEX indx_customers_email ON customers;
-- Index for product search by category
CREATE INDEX indx_products_category ON products(category);
DROP INDEX indx_products_category ON products;
-- Index for order filtering by date
CREATE INDEX indx_orders_date ON orders(order_date);
DROP INDEX indx_orders_date ON orders;
-- Composite index for order items
CREATE INDEX indx_order_items_order_product ON order_items(order_id, product_id);
DROP INDEX indx_order_items_order_product ON order_items;

-- 54 **Analyze query performance**:
EXPLAIN ANALYZE
SELECT c.customer_id, c.first_name, c.last_name, 
       COUNT(o.order_id) AS order_count,
       SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- 55 **Create a materialized view for frequently accessed reports**:
CREATE VIEW customer_order_summary AS
SELECT c.customer_id, c.first_name, c.last_name, c.email,
       COUNT(o.order_id) AS order_count,
       SUM(o.total_amount) AS total_spent,
       AVG(o.total_amount) AS avg_order_value,
       MIN(o.order_date) AS first_order_date,
       MAX(o.order_date) AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

SELECT * FROM customer_order_summary;

-- 56 **Find customers who bought product A but not product B**:
SELECT DISTINCT c.* 
	FROM customers c 
    JOIN orders o 
		ON c.customer_id = o.customer_id
	JOIN order_items oi
		ON o.order_id = oi.order_id
	WHERE oi.product_id = 3
		AND c.customer_id NOT IN (
			SELECT c2.customer_id
            FROM customers c2
			JOIN orders o2 
				ON c2.customer_id = o2.customer_id
			JOIN order_items oi
				ON o.order_id = oi.order_id
			WHERE oi.product_id = 6
        );
        
-- 57  **Calculate average time between orders for each customer**:



WITH customer_order_dates AS (
    SELECT customer_id, order_date,
           LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date
    FROM orders
)
SELECT customer_id,
       AVG(order_date - previous_order_date) AS avg_days_between_orders
FROM customer_order_dates
WHERE previous_order_date IS NOT NULL
GROUP BY customer_id
ORDER BY avg_days_between_orders;