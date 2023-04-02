# INSERT 语句详解

- [x] Column Attributes
- [x] Inserting a Row
- [x] Inserting Multiple Rows
- [x] Inserting Hierarchical Rows
- [x] Creating a Copy of a Table
- [x] Updating a Single Row
- [x] Updating multiple Rows
- [x] Using Subqueries in Updates
- [x] Deleting Rows



## 主要内容

### A INSERT 语句的使用方法

如果要在 sql_store.customers 表中插入一行新的数据，可以用如下语句。关键字为 INSERT INTO 和 VALUES (), 其中的每一个新的值的顺序都要与字段对应起来。

```SQL
-- Sample: Inserting a row
USE sql_store;

INSERT INTO customers
VALUES (
    DEFAULT,
    'John',
    'Smith',
    '1990-01-01',
    NULL,
    '24 DAJA',
    'Shanghai',
    'SH',
    2333
);
```

如果插入新的一行时只填充部分数据，那么就需要在 INSERT 语句中添加字段的名称，如下

```sql
USE sql_store;

INSERT INTO customers (
    customer_id,
	first_name,
	last_name,
	date,
	points)
VALUES (
    DEFAULT,
    'John',
    'Smith',
    '1990-01-01',
    2333
);
```

需要注意的是 VALUES 中的值的顺序也必须按照 INSERT 时的规定填写。

如果一次需要插入多行数据，那么只需要在 VALUES 子句那里添加更多的括号就可以了，格式如下

```sql
...
INSERT INTO ...
VALUES (..., ...),
	   (..., ...),
	   ...
	   (..., ...);
```



### B 复制表中的数据

通过 SELECT 返回的结果集，可以复制出一个新的表，使用的关键字为 CREATE TABLE <new_table_name> AS, 需要注意的是，如果表的名字已经存在，那么就无法复制了，而且复制的表中没有主键等信息。

```sql
-- Sample: Copy a Table

USE sql_store;

CREATE TABLE order_archived AS
SELECT * FROM orders;
```

将 SELECT 语句返回的结果集作为新建表的内容，是复制表的本质。如果表已经存在，就可以将创建表的语句改写成插入表的语句。比如说，上面已经创建了 order_archived 的数据，现在假设它的数据被清空了，并且需要将 orders 中 2019 年以前的数据都存放进去，可以使用下面的语句

```sql
INSERT INTO order_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01';
```



### C 更新数据

使用 UPDATE 和 SET 关键字来更新数据，比如说要在 invoices 表中将付款总额改为 10, 付款日期改为 NULL, 可以使用如下语句

```sql
UPDATE invoices
SET payment_total = 10, payment_date = NULL;
```

不过，这会对整张表中的数据都其作用，如果只改一部分或者一行怎么办？当然是使用 WHERE 子句进行筛选了。由于主键可以确定唯一的一行，因此 WHERE 子句可以作出任何你想要的筛选。

示例如下：

```sql
UPDATE invoices
SET payment_total = 10, payment_date = NULL
WHERE invoice_id < 10;
```

除此之外，还能用子查询来增强筛选的能力。由于子查询的返回结果是一个结果集，因此在 WHERE 子句中使用合适的格式就可以。下面是一个例子，展示了如果更新 invoice 表中的数据，并且筛选条件是 clients 表中居住在 CA 或 NY 的人员：

```sql
UPDATE invoices
SET
	payment_total = invoice_total * 0.5,
	payment_date = due_date
WHERE client_id IN
	(SELECT client_id FROM clients
     WHERE state
    	IN('CA', 'NY'));
```



### D 删除行

使用 DELETE FROM 关键字，使用 WEHERE 字句筛选。















## Problem Set

**1**  使用 sql_invoicing 数据库。创建一张名为 invoices_archive 的表，其中的数据为 invoices 表的内容。特别的，根据 client_id, 将其替换为 clients 表中的对应的客户名，并且通过筛选只选取已经支付的内容，即 payment_date 不为空的数据。

```sql
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
```

