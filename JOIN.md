# JOIN

- [x] Inner Join 内联结
- [x] Join Across Database 跨数据库联结
- [x] Self Join 自联结
- [x] Join Multiple Tables 多表联结
- [x] Compound Join 复合联结条件
- [x] Implicit Join 隐式联结
- [x] Outer Join 外联结
- [ ] Outer Join Between Multiple Tables 多表外联结
- [ ] Self Outer Join 自外联结
- [ ] Natural Join 自然联结
- [x] Cross Join 交叉联结
- [ ] Unions 联合
- [ ] Using Cluse



## 练习语句

### A 内联结的各种使用

基本联结方式：关键词是 JOIN 和 ON.

```sql
SELECT * FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;
```

如果需要使用不同数据库的内容，则需要指定表的前缀，比如

```sql
SELECT * FROM order_items
JOIN sql_inventory.products
	ON order_items.product_id = sql_inventory.products.product_id;
```

需要注意的是，在这里用别名非常方便。

自联结，作为一种奇技淫巧，有时候可以快速理解一张表的结构。比如说下面的语句完成了这样的功能：在一张名为 employees 的表中分析出员工及其管理者。

```sql
USE sql_hr;

SELECT Concat(main.first_name, " ", main.last_name) AS staff,
       main.job_title,
       Concat(mirror.first_name, " ", mirror.last_name) AS boss
FROM employees main
JOIN employees mirror
	ON main.reports_to = mirror.employee_id;
```

继续联结，可以将更多张表联结起来

```sql
USE sql_store;

SELECT *
FROM orders main
JOIN customers sub
	ON main.customer_id = sub.customer_id
JOIN order_statuses subb
	ON main.status = subb.order_status_id;
```



在特殊情况下，比如说需要两个字段来确定需要联结的某一行是，需要使用复合联结条件。这看上去有点麻烦，实际上只是多一个关键词 AND 的事。

### B 外联结

外联结……似乎是说允许无视联结条件将某一部分联结进来。为了保持结构的清晰，在多表外联结中，只使用左联结或者右联结。（我还需要搞清楚左和右是什么意思）

```sql
USE sql_store;
SELECT main.customer_id,
       main.first_name,
       sub.order_id
FROM customers main
RIGHT JOIN orders sub
	ON main.customer_id = sub.customer_id;
```







### C 特殊联结

隐式联结是一种糟糕的使用方法，甚至可以说是糟糕的实现，因为它表明有两种方法来实现同一个功能，这是邪恶的。

对比下面两条语句，它们具有同样的功能：

```sql
SELECT *
FROM order main
JOIN customers sub
	ON main.customer_id = sub.customer_id;
```

```sql
SELECT *
FROM orders main, customers sub
WHERE main.customer_id = sub.customer_id;
```

如果此时去掉筛选条件，也就是 WHERE 字句的那一部分，就会得到一张非常庞大的表。具体来说，如果 main 表有 $x$ 行，sub 表有 $y$ 行，那么 main 表中的每一行都会和 sub 中的行联结，最终得到 $x\times y$ 行，这是 main 和 sub 的笛卡尔积。

实现表和表笛卡尔积的联结方式被称为交叉联结。









## 问题集

**1**  将 order_items 和 products 联结，每一笔订单都返回产品 id、名字以及 order_items 中的数量和单价。

```sql
USE sql_store;
SELECT main.order_id,
       main.product_id, 
       sub.name,
       main.quantity,
       main.unit_price
FROM order_items main
JOIN products sub
	ON main.product_id = sub.product_id;
```

**2**  无

**3**  无

**4**  将 sql\_invoicing 中的 payments, payments_method, clients 联结起来，并生成一份报告，显示付款、客户姓名、付款方式等详细信息。

```sql
USE sql_invoicing;

SELECT main.date,
	   sub.name,
	   main.invoice_id,
	   main.amount,
	   subb.name
FROM payments main
JOIN clients sub
	ON main.client_id = sub.client_id
JOIN payment_methods subb
	ON main.payment_method = subb.payment_method_id;
```

