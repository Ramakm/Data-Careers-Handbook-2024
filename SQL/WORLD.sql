use world;

show tables;

select * from city;

--- How to display select the coloumns 

select name , district,	population from city;

--- Alias Column name 

select name , district,	population+1000 as new_population from city;

select * from city where id = 79;

select * from city where id not between 5 and 12;
