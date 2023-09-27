-- TASK 1 --
/*
Write a query to fetch the contact names, ‘customer spending’, and ‘customer sales potential’. The customer sales potential is an aliased column which returns 2 values based on customer buying pattern.
The conditions are:
	1. If a customer has spent above average than others, then the column should say ‘High Sales Potential’
	2. If a customer has spent lower than or equal to average amount then the column should say ‘Average Sales Potential’
*/

-- A view of all orders with paymentamount calculated by multiplying UnitPrice and Quantity
CREATE VIEW order_payments
AS
SELECT od.OrderID, c.CustomerID, c.ContactName, SUM(od.UnitPrice * od.Quantity) AS `Customer spending` FROM orderdetails od
JOIN orders o
ON od.OrderID = o.OrderID
JOIN customers c
ON o.CustomerID = c.CustomerID
GROUP BY od.OrderID;

-- Using a WITH clause to extract the customers and their sales potential
WITH totalPayments(ContactName, `Customer spending`) AS
	-- Summing up total payment for each customer
    (SELECT ContactName, SUM(`Customer spending`)
    FROM order_payments
    GROUP BY ContactName),
	ContactNameAvg(avgPayment) AS 
    -- Calculating the average payment for an order, and adding the value to the attribute avgPayment
    (SELECT AVG(`Customer spending`)
    FROM order_payments)
    SELECT ContactName, `Customer spending`,
		-- Adding a column containing sales potential based on each customer's spending
		CASE
			WHEN `Customer spending` > avgPayment THEN 'High Sales Potential'
            ELSE 'Average Sales Potential'
		END AS `Customer sales potential`
    FROM totalPayments, ContactNameAvg
    -- Ordering by each customer's spending to get an overview
    ORDER BY `Customer spending`;
-- --------------------------------------------

-- TASK 2 --
-- Write queries to fetch the productname, price and quantity along with the usage of following operators.
-- 2.1: a bitwise or with price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice | od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.2: a bitwise and with price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice & od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.3: Product of price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice * od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.4: Sum of price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice + od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.5: Modulus between price & quantity
SELECT p.ProductName, IFNULL(od.UnitPrice % od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;

-- 2.6: Division of price by quantity
SELECT p.ProductName, IFNULL(od.UnitPrice / od.Quantity, 'None') FROM orderdetails od
LEFT JOIN products p
ON od.ProductID = p.ProductID;