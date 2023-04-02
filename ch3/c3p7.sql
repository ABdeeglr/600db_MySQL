USE sql_store;
SELECT main.customer_id,
       main.first_name,
       sub.order_id
FROM customers main
LEFT JOIN orders sub
	ON main.customer_id = sub.customer_id;
