-- Problem Set: Creating a Copy of a Table

USE sql_invoicing;

CREATE TABLE invoices_archive AS
SELECT
    main.invoice_id,
    main.number,
    sub.name,
    main.invoice_total,
    main.payment_total,
    main.invoice_date,
    main.due_date,
    main.payment_date
FROM invoices main
JOIN clients sub
    USING (client_id)
WHERE NOT (main.payment_date IS NULL);
