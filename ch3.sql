-- @file: ch3.sql
-- Usage: recording the content I learned.
-- Conte: Inner connection / Self-connection /
-- 	  Multiple connection / Compound connection /
-- 	  Join accross database / Implict connection /
--	  Outer join / Outer Join between multiple tables /
--	  Self outer join / Using clause / Natural join /
-- 	  Cross join / Union.


-- Select the data from two tables(in the same database).
-- Use keyword: `INNER JOIN` and use `AS` to assign a nickname.
-- Notice: For tables in the different database.
-- 	   Use `<database>.<table>` to connect.
SELECT 	this.customer_id,
	first_name,
	last_name,
	phone,
	city,
	points
FROM orders as this
INNER JOIN customers as that
ON this.customer_id = that.customer_id
ORDER BY points DESC;

SELECT ord.order_id, product_id, quantity, unit_price 
FROM orders AS ord 
INNER JOIN order_items AS it 
ON ord.order_id = it.order_id;


-- Self-connection is confused. The critical point is to assign the different alias to the same table.
-- But, what's indeed the meaning of `ON <table.attribute> = <table.attribute>`.
-- I get! It's each line-connection.
SELECT 	e.employee_id, 
	e.first_name, 
	e.last_name, 
	e.salary, 
	e.reports_to, 
	e.employee_id, 
	m.first_name as manager 
FROM employees AS e 
JOIN employees AS m
ON e.reports_to = m.employee_id;


-- Take a look on the database sql_invoicing.
-- 写出这句的时候我是真的觉得自己开始懂连接的意思了。
SELECT 	cli.client_id,
	cli.name,
	cli.city, 
	cli.address, 
	cli.phone, 
	pm.date, 
	pm.amount 
FROM clients AS cli 
JOIN payments AS pm 
ON cli.client_id = pm.client_id 
JOIN payment_methods AS pod 
ON pod.payment_method_id = pm.payment_method;


-- Compound Join Conditions: Sometimes it is impossible to connect two line by one attribute, so it's now to use compound join connections:
-- Use keyword `AND`
SELECT	*
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
	AND oi.product_id = oin.product_id;


-- Implicit Join Syntax: I will show two different commad to access the same data.
-- The first command used the compound join condition method above:
SELECT * 
FROM orders o 
JOIN customers c 
ON o.customer_id = c.customer_id;
-- And the second command used the implicit join syntax like that:
SELECT * 
FROM orders o, customers c 
WHERE o.customer_id = c.customer_id;
-- It's dangerous, 如果你忘记了加上 WHERE 声明，那么你就会得到一个数据行的笛卡尔积. 因此它实际上不是什么连接，而是交叉的子集。


-- Outer Join.


