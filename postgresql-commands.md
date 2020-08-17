**Connect database container**
```
docker exec -it postgres psql -U postgres
[sakhtar@linux docker-compose-postgres]$ docker exec -it postgres psql -U postgres
psql (12.4)
Type "help" for help.

postgres=# 
```

**List Database**
```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 shamim    | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(4 rows)

postgres=# 

```
**Create Database**
```
postgres=# CREATE DATABASE test;
CREATE DATABASE
postgres=# 

```
**Drop Database**
```
postgres=# DROP DATABASE test;
CREATE DATABASE
postgres=# 

```
**Connect to Database test**
```
postgres=# \c test
You are now connected to database "test" as user "postgres".
test=# 
```


