USE sql_store;
SELECT main.order_id,
       main.product_id, 
       sub.name,
       main.quantity,
       main.unit_price
FROM order_items main
JOIN products sub
	ON main.product_id = sub.product_id;
