-- WORKING ON 4 TABLE FOR PRACTICING JOIN , CLAUSE , CONSTRAIN , FUNCTIONS , VIEW
-- DDL DML DQL DCL TCL

-- Create Database
CREATE DATABASE Four_Table;
USE Four_Table;

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
SELECT product1,product2,COUNT(*) AS combination_count FROM (
SELECT oi1.order_id,p1.name AS product1 , p2.name AS product2 
	FROM order_items oi1 
    JOIN order_items oi2 
		ON oi1.order_id = oi2.order_id 
			AND oi1.product_id < oi2.product_id 
JOIN products p1 ON oi1.product_id = p1.product_id
JOIN products p2 ON oi2.product_id = p2.product_id
) GROUP BY product1,product2 ORDER BY combination_count DESC;

