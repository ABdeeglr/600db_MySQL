-- Sample: Copy a Table

USE sql_store;

CREATE TABLE order_archived AS
SELECT * FROM orders;
