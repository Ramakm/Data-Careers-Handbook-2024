-- DDL

-- Create a DataBase

create database demonstration;

use demonstration;

-- Create a Table

create table Customer( 
ID int not null,
name varchar(50) not null,
phone int,
time timestamp default current_timestamp not null,
age int,
address varchar(50),
salary int
);
desc Customer;

-- Alter Table

-- Add primary key

alter table Customer add constraint primary key(ID);

desc customer;

-- ADD a New Column

alter table Customer add column Epmloyer varchar(30);
desc Customer;

-- Drop a column

alter table Customer drop column Epmloyer;
desc Customer


-- DDL




