create table car (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	make VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL,
	price NUMERIC(19,2) NOT NULL
);

create table person (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(150),
	gender VARCHAR(7) NOT NULL,
	date_of_birth DATE NOT NULL,
	country_of_birth VARCHAR(50),
  car_id BIGINT REFERENCES car (id),
  UNIQUE(car_id)
);

insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Feliks', 'Prandin', 'fprandin0@amazon.co.jp', 'Male', '10/18/2012', 'Indonesia');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Gabbie', 'Scrase', null, 'Female', '6/2/1965', 'China');
insert into person (first_name, last_name, email, gender, date_of_birth, country_of_birth) values ('Alexandra', 'Ashbe', 'aashbe2@merriam-webster.com', 'Female', '12/6/1993', 'Ukraine');


insert into car (make, model, price) values ('Honda', 'CR-V', '54286.10');
insert into car (make, model, price) values ('Maybach', '57', '74847.63');
