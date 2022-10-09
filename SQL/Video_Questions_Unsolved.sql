SET SQL_SAFE_UPDATES = 0;


-- Module: Database Design and Introduction to SQL
-- Session: Database Creation in MySQL Workbench
-- DDL Statements

-- 1. Create a table shipping_mode_dimen having columns with their respective data types as the following:
--    (i) Ship_Mode VARCHAR(25)
--    (ii) Vehicle_Company VARCHAR(25)
--    (iii) Toll_Required BOOLEAN
-- 2. Make 'Ship_Mode' as the primary key in the above table.


-- -----------------------------------------------------------------------------------------------------------------
-- DML Statements

-- 1. Insert two rows in the table created above having the row-wise values:
--    (i)'DELIVERY TRUCK', 'Ashok Leyland', false
--    (ii)'REGULAR AIR', 'Air India', false

-- 2. The above entry has an error as land vehicles do require tolls to be paid. Update the ‘Toll_Required’ attribute
-- to ‘Yes’.

-- 3. Delete the entry for Air India.


-- -----------------------------------------------------------------------------------------------------------------
-- Adding and Deleting Columns

-- 1. Add another column named 'Vehicle_Number' and its data type to the created table. 

-- 2. Update its value to 'MH-05-R1234'.

-- 3. Delete the created column.


-- -----------------------------------------------------------------------------------------------------------------
-- Changing Column Names and Data Types

-- 1. Change the column name ‘Toll_Required’ to ‘Toll_Amount’. Also, change its data type to integer.

-- 2. The company decides that this additional table won’t be useful for data analysis. Remove it from the database.


-- -----------------------------------------------------------------------------------------------------------------
-- Session: Querying in SQL
-- Basic SQL Queries

-- 1. Print the entire data of all the customers.
select * from cust_dimen;
-- 2. List the names of all the customers.
select customer_name from cust_dimen;
-- 3. Print the name of all customers along with their city and state.
select customer_name, city, state from cust_dimen;
-- 4. Print the total number of customers.
select count(*) as Total_Customers
from cust_dimen;

-- 5. How many customers are from West Bengal?
select count(*) as Total_customer_from_westbengal from cust_dimen where state = "West Bengal";
-- 6. Print the names of all customers who belong to West Bengal.

select customer_name as cutomer_from_West_Bengal
 from cust_dimen where state = "West Bengal";
-- -----------------------------------------------------------------------------------------------------------------
-- Operators

-- 1. Print the names of all customers who are either corporate or belong to Mumbai.
select count(*) from cust_dimen where city = "Mumbai" or customer_segment = "corporate";
-- 2. Print the names of all corporate customers from Mumbai.
select * from cust_dimen where city = "Mumbai" and customer_segment = "corporate" ;
-- 3. List the details of all the customers from southern India: namely Tamil Nadu, Karnataka, Telangana and Kerala.
select * from cust_dimen where state in('Tamil Nadi', 'Karnataka', 'Telengana', 'Kerala');
-- 4. Print the details of all non-small-business customers.
select * from cust_dimen where customer_segment !=	'Small Business';
-- 5. List the order ids of all those orders which caused losses.
select * from market_fact_full;
select ord_id, profit from market_fact_full where profit <0;
-- 6. List the orders with '_5' in their order ids and shipping costs between 10 and 15.

select ord_id, shipping_cost from market_fact_full where ord_id like "%_5%" and shipping_cost between 10 and 15;
-- -----------------------------------------------------------------------------------------------------------------
-- Aggregate Functions

-- 1. Find the total number of sales made.

select count(sales) as Count_sales from market_fact_full; 

-- 2. What are the total numbers of customers from each city?
select * from cust_dimen;
select city, count(customer_name) as total_customer from cust_dimen group by city order by total_customer desc;

--- Additional Query 
select city, count(customer_name) as total_customer from cust_dimen group by city, customer_segment order by total_customer desc;

-- 3. Find the number of orders which have been sold at a loss.

select count(ord_id) as Ord_as_loss from market_fact_full where profit < 0;

-- 4. Find the total number of customers from Bihar in each segment.

select count(customer_name) as total_customer_from_bihar,state, customer_segment from 
	cust_dimen where state = "Bihar" group by customer_segment;

-- 5. Find the customers who incurred a shipping cost of more than 50.
select * from market_fact_full;
select cust_id, shipping_cost from market_fact_full where shipping_cost> 50;
-- -----------------------------------------------------------------------------------------------------------------
-- Ordering

-- 1. List the customer names in alphabetical order.

select distinct customer_name from cust_dimen order by customer_name;

-- 2. Print the three most ordered products.

select prod_id, sum(order_quantity) total_order_amount from market_fact_full
	group by prod_id  order by total_order_amount desc limit 3;
    
--- Adding Having clause 

select prod_id, sum(order_quantity) total_order_amount from market_fact_full
	group by prod_id having total_order_amount>20 order by total_order_amount desc limit 3;
-- 3. Print the three least ordered products.
select * from market_fact_full;
select prod_id, sum(order_quantity) total_order_amount from market_fact_full
	group by prod_id order by total_order_amount asc limit 3;

-- 4. Find the sales made by the five most profitable products.
select prod_id, sales from market_fact_full 
order by profit desc limit 5;

-- 5. Arrange the order ids in the order of their recency.
select ord_id, order_date from orders_dimen 
order by order_date desc;

-- 6. Arrange all consumers from Coimbatore in alphabetical order.
select customer_name, city from cust_dimen 
where city = "Coimbatore" 
order by customer_name asc;
-- -----------------------------------------------------------------------------------------------------------------
-- String and date-time functions

-- 1. Print the customer names in proper case.
-- select customer_name, concat(upper(substring(substring_index(lower(customer_name), ' ',1),1,1),
-- upper(substring(substring_index(lower(customer_name),' ',-1),1,1)
-- from cust_dimen;
-- 2. Print the product names in the following format: Category_Subcategory.
select product_category, product_sub_category,
concat(product_category, '_', product_sub_category) as product_name
from prod_dimen;
-- 3. In which month were the most orders shipped?
select * from shipping_dimen;
select count(ship_id) as ship_count, month(ship_date)as ship_month
	from shipping_dimen 
    group by ship_month
    order by ship_count desc;
    
-- 4. Which month and year combination saw the most number of critical orders?

select count(ord_id) as order_count, month(order_date) as order_month,
year(order_date) as order_year
from orders_dimen
where order_priority = "Critical"
group by order_year,order_month
order by order_count desc limit 10;

-- 5. Find the most commonly used mode of shipment in 2011.

select ship_mode, count(ship_mode) as ship_mode_count
from shipping_dimen 
where year(ship_date) =2011
group by ship_mode
order by ship_mode_count desc
limit 3;

-- -----------------------------------------------------------------------------------------------------------------
-- Regular Expressions

-- 1. Find the names of all customers having the substring 'car'.

select customer_name from cust_dimen where customer_name regexp 'car';

-- 2. Print customer names starting with A, B, C or D and ending with 'er'.

select customer_name from cust_dimen 
where customer_name regexp '^[abcd].*er$';

select customer_name from cust_dimen 
where customer_name regexp 'er$';
-- -----------------------------------------------------------------------------------------------------------------
-- Nested Queries

-- 1. Print the order number of the most valuable order by sales.

select ord_id , sales, round(sales) as round_sales
from market_fact_full
where sales=(
select max(sales) from market_fact_full
);

-- 2. Return the product categories and subcategories of all the products which don’t have details about the product
-- base margin.

select * from prod_dimen
where prod_id in (
select prod_id from market_fact_full where product_base_margin is Null
);
-- 3. Print the name of the most frequent customer.

select customer_name, cust_id from cust_dimen where cust_id =(
select cust_id from market_fact_full
group by cust_id order by count(cust_id) desc  limit 1
);
-- 4. Print the three most common products.
select prod_id, count(prod_id) as product_count 
from market_fact_full
group by prod_id 
order by product_count desc limit 3;
-- -----------------------------------------------------------------------------------------------------------------
--- CTEs  (Common Table Expressions)

-- 1. Find the 5 products which resulted in the least losses. Which product had the highest product base
-- margin among these?
select * from market_fact_full;
select prod_id, profit, product_base_margin
from market_fact_full
where profit <0 order by product_base_margin limit 5;

--- OR using 'with'

with least_losses as (
select prod_id, profit, product_base_margin
from market_fact_full
where profit <0  
order by profit desc
limit 5
)
select * from least_losses 
where product_base_margin = (
select max(product_base_margin) from 
least_losses
);
-- 2. Find all low-priority orders made in the month of April. Out of them, how many were made in the first half of
-- the month?

select ord_id, order_priority, order_date
 from orders_dimen where order_priority = 'Low' and month(order_date) = 04 and day(order_date) between 1 and 15
 order by 3 asc;

-- -----------------------------------------------------------------------------------------------------------------
-- Views

-- 1. Create a view to display the sales amounts, the number of orders, profits made and the shipping costs of all
-- orders. Query it to return all orders which have a profit of greater than 1000.
create view order_info 
as select ord_id, sales, order_quantity, profit, shipping_cost
from market_fact_full;

select ord_id, sales from order_info;
-- 2. Which year generated the highest profit?
select year(ship_date) as Ship_year,ship_id from shipping_dimen where ship_id =(
select ship_id , sum(profit) as total_profit from market_fact_full
group by ship_id);

-- -----------------------------------------------------------------------------------------------------------------
-- Session: Joins and Set Operations
-- Inner Join

-- 1. Print the product categories and subcategories along with the profits made for each order.
select ord_id, product_category, product_sub_category, profit 
from  prod_dimen p inner join market_fact_full m 
on p.prod_id = m.prod_id;
-- 2. Find the shipment date, mode and profit made for every single order.
select * from market_fact_full;
select * from shipping_dimen;
select * from orders_dimen;
select * from cust_dimen;

select ship_date, ship_mode, profit from shipping_dimen sd
right outer join market_fact_full mff on sd.ship_id = mff.ship_id;

--- 3 Way join
-- 3. Print the shipment mode, profit made and product category for each product.

select m.prod_id, m.profit, p.product_category, s.ship_mode
from market_fact_full m inner join prod_dimen p on
m.prod_id = p.prod_id
inner join shipping_dimen s on m.ship_id = s.ship_id; 

-- 4. Which customer ordered the most number of products?
select customer_name, sum(order_quantity) as total_order 
from cust_dimen as c inner join 
market_fact_full m on c.cust_id = m.cust_id
group by customer_name  
order by total_order
desc;

---- Alternate way 'using' keyword. The commin keyword should be same naming conevtion in both joining table.

select customer_name, sum(order_quantity) as total_order 
from cust_dimen as c inner join 
market_fact_full m using(cust_id)
group by customer_name  
order by total_order
desc;

-- 5. Selling office supplies was more profitable in Delhi as compared to Patna. True or false?

select p.prod_id, profit, product_category, city, sum(profit) as city_wise_profit
from prod_dimen p
inner join market_fact_full m
on p.prod_id = m.prod_id
inner join cust_dimen c
on m.cust_id = c.cust_id 
where product_category = "Office Supplies" and (city = 'Delhi' or city = 'Patna')
group by city;

-- 6. Print the name of the customer with the maximum number of orders.

-- 7. Print the three most common products.


-- -----------------------------------------------------------------------------------------------------------------
-- Outer Join

-- 1. Return the order ids which are present in the market facts table.

-- Execute the below queries before solving the next question.
create table manu (
	Manu_Id int primary key,
	Manu_Name varchar(30),
	Manu_City varchar(30)
);

insert into manu values
(1, 'Navneet', 'Ahemdabad'),
(2, 'Wipro', 'Hyderabad'),
(3, 'Furlanco', 'Mumbai');

alter table Prod_Dimen
add column Manu_Id int;

update Prod_Dimen
set Manu_Id = 2
where Product_Category = 'technology';

-- 2. Display the products sold by all the manufacturers using both inner and outer joins.

-- 3. Display the number of products sold by each manufacturer.

-- 4. Create a view to display the customer names, segments, sales, product categories and
-- subcategories of all orders. Use it to print the names and segments of those customers who ordered more than 20
-- pens and art supplies products.


-- -----------------------------------------------------------------------------------------------------------------
-- Union, Union all, Intersect and Minus

-- 1. Combine the order numbers for orders and order ids for all shipments in a single column.

-- 2. Return non-duplicate order numbers from the orders and shipping tables in a single column.

-- 3. Find the shipment details of products with no information on the product base margin.

-- 4. What are the two most and the two least profitable products?


-- -----------------------------------------------------------------------------------------------------------------
-- Module: Advanced SQL
-- Session: Window Functions	
-- Window Functions in Detail

-- 1. Rank the orders made by Aaron Smayling in the decreasing order of the resulting sales.

-- 2. For the above customer, rank the orders in the increasing order of the discounts provided. Also display the
-- dense ranks.

-- 3. Rank the customers in the decreasing order of the number of orders placed.

-- 4. Create a ranking of the number of orders for each mode of shipment based on the months in which they were
-- shipped. 


-- -----------------------------------------------------------------------------------------------------------------
-- Named Windows

-- 1. Rank the orders in the increasing order of the shipping costs for all orders placed by Aaron Smayling. Also
-- display the row number for each order.


-- -----------------------------------------------------------------------------------------------------------------
-- Frames

-- 1. Calculate the month-wise moving average shipping costs of all orders shipped in the year 2011.


-- -----------------------------------------------------------------------------------------------------------------
-- Session: Programming Constructs in Stored Functions and Procedures
-- IF Statements

-- 1. Classify an order as 'Profitable' or 'Not Profitable'.


-- -----------------------------------------------------------------------------------------------------------------
-- CASE Statements

-- 1. Classify each market fact in the following ways:
--    Profits less than -500: Huge loss
--    Profits between -500 and 0: Bearable loss 
--    Profits between 0 and 500: Decent profit
--    Profits greater than 500: Great profit

-- 2. Classify the customers on the following criteria (TODO)
--    Top 20% of customers: Gold
--    Next 35% of customers: Silver
--    Next 45% of customers: Bronze


-- -----------------------------------------------------------------------------------------------------------------
-- Stored Functions

-- 1. Create and use a stored function to classify each market fact in the following ways:
--    Profits less than -500: Huge loss
--    Profits between -500 and 0: Bearable loss 
--    Profits between 0 and 500: Decent profit
--    Profits greater than 500: Great profit


-- -----------------------------------------------------------------------------------------------------------------
-- Stored Procedures

-- 1. Classify each market fact in the following ways:
--    Profits less than -500: Huge loss
--    Profits between -500 and 0: Bearable loss 
--    Profits between 0 and 500: Decent profit
--    Profits greater than 500: Great profit

-- The market facts with ids '1234', '5678' and '90' belong to which categories of profits?