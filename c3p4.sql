USE sql_invoicing;

SELECT sub.name, main.amount, subb.name
FROM payments main
JOIN clients sub
	ON main.client_id = sub.client_id
JOIN payment_methods subb
	ON main.payment_method = subb.payment_method_id;
