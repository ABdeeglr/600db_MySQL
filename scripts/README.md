# README

There are several .sql files in this folder, but they are for two different course.

create.sql and populate.sql is for "MySQL crash course".

The others are for "Mosh MySQL online course".

## Usage

### For mysql crash course
If you are reading "MySQL carsh course", login into the mysql server, and create a new databases and run create.sql and populate.sql by

```sql
CREATE DATABASE <any_database_name>
source create.sql;
source populate.sql;
```

Make sure you are in the same folder with the .sql file above, else you must source them by absolute path.
If everything goes successfully, you will have a database named by you with six tables.


### For Mosh mysql course
If you are watching "Mosh online course", use create-databases.sql by:

```shell
mysql -u <name> -p < create-databases.sql
``` 

And then you will have four databases named by sql\_hr, sql\_store, ... 
