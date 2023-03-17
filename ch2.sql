-- Enter the lab and get the basic information
SHOW databases;
USE sql_store;
SHOW tables;
-- If you want to take a look on a  certain table, run this
-- DESC <tabel_name>;


-- A select sentence will always composed in the order below:
-- SELECT <attribute or *> FROM <table_name> WHERE <expression> ORDER BY <order> LIMIT <rule>;
-- The order of the commad must correct, else always rais error.




-- Get the top three loyal customers
SELECT * FROM customers ORDER BY points DESC LIMIT 3;

