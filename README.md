# README

Here's a problem set to check myself.

## Self-check!



## Concept

### Join(连接)


### 数据库理论

在这里提出一个我认为的数据库理论用来拟合我在 MySQL 操作中遇到的东西。
我面对的东西是一个数据库管理系统中的命令行接口程序，通过这个接口我操作数据库，就好比我通过操作系统操作硬件，而 shell 是操作系统给我提供的接口。从这个方面来说，数据库系统的系统，和操作系统的系统，还真是一个系统。

数据库管理系统可以管理多个数据库，在 Linux 系统在，数据库被存放在 /var/lib/mysql 中，如果想要了解更多信息，可以执行 `show variables like "%dir%";`. 如果要查看当前受管理的数据库，可以使用 `show databases;`。

每一个数据库都由若干张表，使用 `show tables;` 来查看当前数据库下的表的名字，而使用`desc <table_name>;` 可以显示特定表的属性。这里给出一个示例来进行接下来的讨论。

在我进入一个数据库后，比如使用 `use sql_store;` 进入了名为 sql\_store 的数据库，使用 `DESC orders;` 获取表 `orders` 的属性，得到了如下结果：

| Field        | Type          | Null | Key | Default | Extra          |
|--------------|---------------|------|-----|---------|----------------|
| order\_id     | int           | NO   | PRI | NULL    | auto\_increment |
| customer\_id  | int           | NO   | MUL | NULL    |                |
| order\_date   | date          | NO   |     | NULL    |                |
| status       | tinyint       | NO   | MUL | 1       |                |
| comments     | varchar(2000) | YES  |     | NULL    |                |
| shipped\_date | date          | YES  |     | NULL    |                |
| shipper\_id   | smallint      | YES  | MUL | NULL    |                |

注意观察第一行，第一行的 field 表示了该表所具有的属性，直观地来说是列的名字，而行(row)代表了表中的一次记录(record), 因此我们说，每一行都是一个 order，它构成了表 orders，每一个 order 都包含若干属性。

对于任意一个表而言，其包含的属性（列）必须有一个被称为主键，在上面的样例中，`Key`所在的列说明了 order\_id 是该表的主键。主键的作用在直观上可以说成是默认排序，实际上则要求了它的每一个值都是不同的，也就是说，主键与表中的每一个记录都一一对应。

属性还具有类型，用于声明该列能够填写什么样的内容。比如说一个订单号，那就用 int 来表达。有比如说地址，就用 char 表示（这里还可以细分，但在此不展开细节），对于日期， mysql 有专有的 date 类型来表示，对于某个东西的状态或分类，由于其选项较少，因此用 tinyint 来表示。

再来讲讲样表中的 `Default` 和 `Null` 选项。

`Default` 顾名思义，是指一条记录在该属性上的默认值，假设我有一张表，这张表具有三个属性，分别是 name, status 和 time, 其中 name, time 的默认值为 NULL，而 status 的默认值为 0 . 于是当一条仅包含 name 的记录注入时，该记录的 name 属性下的值不再是 Null 了，而 time 仍然是 Null, 至于 status 则具有默认值 0.

`Null` 则是为了说明有没有空缺值，假设一章表中共有 3000 条记录，每一条记录都包含 a, b, c, d, e 五种属性。对于属性 a 而言，当且仅当每一条记录在 a 下都有具体值时，a 的 `Null` 选项才会被描述为 NO. 换言之，只要当你看到 Yes, 就意味着有一条或多条记录没有 a 属性的内容。

至于 `Extra`, 这大概是一个和主键有关的，按下不表。
