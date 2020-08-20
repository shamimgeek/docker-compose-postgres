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
****

**SQL Select From**


**Order by**

**Distinct**

**Where Clause and AND**


**Comparison Operators**

**Limit, Offset & Fetch**

**IN**


**Between**
```
test=# select * from person where date_of_birth between DATE '2019-01-01' AND '2019-12-31';
 id  | first_name |  last_name  |               email               | gender | date_of_birth | country_of_birth 
-----+------------+-------------+-----------------------------------+--------+---------------+------------------
 131 | Marybeth   | Coverley    | mcoverley3m@yale.edu              | Female | 2019-02-28    | Philippines
 164 | Laurianne  | Ferier      | lferier4j@de.vu                   | Female | 2019-02-17    | Portugal
 251 | Catriona   | Tatershall  | ctatershall6y@acquirethisname.com | Female | 2019-11-19    | Russia
 274 | Concettina | Nan Carrow  | cnancarrow7l@newsvine.com         | Female | 2019-06-30    | China
 296 | Marv       | MacCathay   | mmaccathay87@imageshack.us        | Male   | 2019-02-01    | Afghanistan
 316 | Eleanor    | Wasielewicz | ewasielewicz8r@usnews.com         | Female | 2019-07-08    | Indonesia
 423 | Gabe       | Tollerfield | gtollerfieldbq@java.com           | Male   | 2019-10-14    | Russia
 543 | Idelle     | Burgane     | iburganef2@skype.com              | Female | 2019-06-05    | Vietnam
 579 | Rogerio    | Daine       | rdaineg2@gizmodo.com              | Male   | 2019-04-23    | Philippines
 638 | Allayne    | Rowlstone   | arowlstonehp@hatena.ne.jp         | Male   | 2019-04-03    | Thailand
 710 | Ramona     | Kidstone    | rkidstonejp@aol.com               | Female | 2019-04-14    | South Africa
 762 | Birch      | Tebb        | btebbl5@mozilla.com               | Male   | 2019-09-16    | Indonesia
 826 | Darcie     | Verdie      | dverdiemx@bing.com                | Female | 2019-01-25    | Switzerland
 887 | Kerk       | Geraldini   | kgeraldiniom@ucoz.com             | Male   | 2019-10-29    | Ukraine
 968 | Brande     | Goulbourne  | bgoulbourneqv@un.org              | Female | 2019-12-06    | Indonesia
(15 rows)

```
**Like And iLike**

**Group By**

**Group By Having**

**Adding New Table And Data Using Mockaroo**

**Calculating Min, Max & Average**

**Sum**


**Basics of Arithmetic Operators**

 **Arithmetic Operators (ROUND)**

 **Alias**

**Coalesce**

**NULLIF**

**Timestamps And Dates Course**

 **Adding And Subtracting With Dates**

 **Extracting Fields From Timestamp**

 **Age Function**

 **What Are Primary Keys**

 **Understanding Primary Keys**

 **Adding Primary Key**

 **Unique Constraints**

 **Check Constraints**

 **How to Delete Records**

 **How to Update Records**

 **On Conflict Do Nothing**

 **Upsert**

**What Is A Relationship/Foreign Keys**

**Adding Relationship Between Tables**

**Updating Foreign Keys Columns**

**Inner Joins**

**Left Joins**

**Deleting Records With Foreign Keys**

**Exporting Query Results to CSV**

**Serial & Sequences**

**Extensions**

**Understanding UUID Data Type**

**UUID As Primary Keys**




