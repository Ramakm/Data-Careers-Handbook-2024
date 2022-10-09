USE market_star_schema;

-- -----------------------------------------------------------------------------------------------
--  Regular Expressions
-- -----------------------------------------------------------------------------------------------
-- 1. Find the names of all the customers that contain the substring 'son'
SELECT DISTINCT Customer_Name 
FROM cust_dimen
WHERE Customer_Name REGEXP 'son';

-- Note: REGEXP is case insensitive

-- 2. Print the customers that start with A, B, C or D and ending with 'en'
SELECT DISTINCT Customer_Name 
FROM cust_dimen
WHERE Customer_Name REGEXP '^[abcd].*en$';

--- Note: .* is similar to % in LIKE statement

-- 3. List Product Categories that don't begin with O, C or T

SELECT distinct Product_Sub_Category
FROM prod_dimen
WHERE Product_Sub_Category REGEXP '^[^OCT]';

SELECT distinct Product_Sub_Category
FROM prod_dimen;


