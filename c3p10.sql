USE sql_invoicing;

SELECT
    main.date,
    sub.name,
    main.amount,
    subb.name
FROM payments main
JOIN clients sub
    USING (client_id)
JOIN payment_methods subb
    ON main.payment_method = subb.payment_method_id;
