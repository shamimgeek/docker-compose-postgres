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
**Clear the screeen in posgres prompt**

```
\! clear
```

**Create Table person **
```
 CREATE TABLE person (
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender VARCHAR(7),
  date_of_birth DATE
);
```

**List Table**
```
postgres=# \d
 public | person | table | postgres

postgres=# 

```

**Describe Table**
```
postgres=# \d person;
 first_name    | character varying(50) |           |          | 
 last_name     | character varying(50) |           |          | 
 gender        | character varying(7)  |           |          | 
 date_of_birth | date                  |           |          | 

postgres=#
```

**Drop Table**
```
DROP TABLE person;
```

**Create Table with constraints**
```
CREATE TABLE person (
   id BIGSERIAL NOT NULL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   gender VARCHAR(5) NOT NULL,
   date_of_birth DATE NOT NULL,
   email VARCHAR(150)
);
```

**Insert into the table**
```
postgres=# INSERT INTO person (first_name, last_name, gender, date_of_birth) VALUES('Shamim', 'Akhtar', 'Male', '1987-12-02');


postgres=# INSERT INTO person (first_name, last_name, gender, date_of_birth) VALUES('Ali', 'Raza', 'Male', '1984-01-12');


postgres=# INSERT INTO person (first_name, last_name, gender, date_of_birth, email) VALUES('Amir', 'Khan', 'Male', '1986-01-12', 'amirkhan@gmail.com');


postgres=# select * from person;
  1 | Shamim     | Akhtar    | Male   | 1987-12-02    | 
  2 | Ali        | Raza      | Male   | 1984-01-12    | 
  3 | Amir       | Khan      | Male   | 1986-01-12    | amirkhan@gmail.com

postgres=# 
```

**Create mock data**

Create mock data from [here](https://www.mockaroo.com/) as given below and download person.sql
![mock_data_person](./images/mock_data_person.png)

**How to populate sql data to postgres docker container**

Find the name and id of the Docker container hosting the Postgres instance
```
[sakhtar@linux ~]$ docker ps
CONTAINER ID        IMAGE                  COMMAND                  CREATED             STATUS              PORTS                           NAMES
91865223f3e7        dpage/pgadmin4:4.24    "/entrypoint.sh"         19 seconds ago      Up 17 seconds       443/tcp, 0.0.0.0:8080->80/tcp   pgadmin
c4a425bb92c1        postgres:12.4-alpine   "docker-entrypoint.s…"   19 seconds ago      Up 17 seconds       0.0.0.0:5432->5432/tcp          postgres
```

Find the volumes available in the Docker container

```
docker inspect -f '{{ json .Mounts }}' <container_id> | python -m json.tool

[sakhtar@linux ~]$ docker inspect -f '{{ json .Mounts }}' c4a425bb92c1 | python -m json.tool
[
    {
        "Destination": "/var/lib/postgresql/data",
        "Driver": "local",
        "Mode": "rw",
        "Name": "docker-compose-postgres_postgres",
        "Propagation": "",
        "RW": true,
        "Source": "/var/lib/docker/volumes/docker-compose-postgres_postgres/_data",
        "Type": "volume"
    }
]
[sakhtar@linux ~]$
```
In this case, we have /var/lib/postgresql/data as the volume path.

Copy dump into one of the volumes

```
docker cp ./SQL/person.sql postgres:/var/lib/postgresql/data/
```

Now populate sql from postgres cli

```
postgres=# \i /var/lib/postgresql/data/person.sql;
```

