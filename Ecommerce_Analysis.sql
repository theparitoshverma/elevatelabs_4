
-- 1. Select customers from India
SELECT * FROM Customers
WHERE country = 'India';

-- 2. Total sales per customer (JOIN + GROUP BY)
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- 3. Top-selling products (JOIN + aggregation)
SELECT p.name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 5;

-- 4. Average order value by country (JOIN + GROUP BY + AVG)
SELECT c.country, AVG(o.total_amount) AS avg_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.country;

-- 5. Subquery: Customers who ordered more than $500 total
SELECT name FROM Customers
WHERE customer_id IN (
    SELECT customer_id FROM Orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > 500
);

-- 6. Create a view for monthly sales
CREATE VIEW MonthlySales AS
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_sales
FROM Orders
GROUP BY month;

-- 7. Create an index on Orders.order_date for faster querying
CREATE INDEX idx_order_date ON Orders(order_date);
