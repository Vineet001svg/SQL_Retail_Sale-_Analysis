-- SQL Retail Analysis -- 

-- Create Table

create table retail_sale
 (
	transactions_id	int primary key,
	sale_date	date,
	sale_time	time,
	customer_id	int,
	gender varchar(15),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit float,
	cogs float,	
	total_sale float
);

select * from retail_sale
limit 10;

-- to count the rows

select count(*)
from retail_sale;

-- DATA_CLEANING--
-- check null values

select * from retail_sale
where transactions_id is null;

select * from retail_sale
where sale_date is null;

/* for checking null values we use this method column wise 
or 
we can use another method by selecting one select value we can use i.e
*/
select * from retail_sale
where transactions_id is null
or 
 sale_date is null
or 
 sale_time is null
or 
 customer_id is null
or 
 gender is null
or 
 age is null
or 
 category is null
or 
 quantiy is null
or 
price_per_unit is null
or 
 cogs is null
or 
 total_sale  is null ;

 -- Deleting all Null Values

 delete from retail_sale
where transactions_id is null
or 
 sale_date is null
or 
 sale_time is null
or 
 customer_id is null
or 
 gender is null
or 
 age is null
or 
 category is null
or 
 quantiy is null
or 
price_per_unit is null
or 
 cogs is null
or 
 total_sale  is null ;

 select count(*) from retail_sale

 -- DATA_EXPLORATION--

 -- How Many Sales we Have ?

 select count(*) as total_Sale from retail_sale;

 -- How many  Customer we Have
 
 select Count(customer_id) from retail_sale;

-- How many UNIQUE Customer we Have

select Count(distinct customer_id) from retail_sale;

 -- show UNIQUE  category

 select distinct category from retail_sale;

 -- DATA_ANALYTICS & BUSINESS PROBLEMS
 
 -- Write a SQL Query to reterive all column for sales on '2022-11-05'

 select * from retail_sale
 where sale_date = '2022-11-05';
 
-- write a SQL Query to reterive all transaction where the category is 'CLOTHING ' and the Quantity is sold more then 4 in the month of NOV-2022?

select *  
from retail_sale
where category = 'Clothing'
and 
to_char(sale_date,'yyyy-mm')='2022-11'
and quantiy >=4
;

-- write a sql query to calc. the total sales for each category

select category, sum(total_sale) as total_sale
from public.retail_sale
group by category;

-- write a query to find avg age of cust who purchased items from Beauty category

select round(avg(age),2) as Average_Age
from public.retail_sale
where category='Beauty';

-- write a query to find all transcation where total sale is greater then 1000.

select *
from public.retail_sale
where total_sale>1000;

-- write a query to find  the total transaction (transaction_id) made by each gender in each category.

select gender,category,count(*)
from public.retail_sale
group by gender,category
order by 1;

-- write a query to calc the average sale for each month , find out best selling month in each year
select 
year,month,avg_sale
from
(
select 
extract (year from sale_date) as Year ,
extract (month from sale_date) as month ,
avg(total_sale) as total_sale
RANK()over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from public.retail_sale
group by 1,2
) as t1
where rank = 1


--  write a query to find  the top 5 cx based on the highest total sales

select customer_id, sum(total_sale) as total_sale
from public.retail_sale
group by customer_id
order by total_sale desc
limit 5;


-- write a query to find  the num of unique cx who purchased items from each category.

select category,count( distinct customer_id) as unique_cx
from public.retail_sale
group by category;

-- write a query to create shift and num of orders (ex- Morning <=12, Afternoon between 12 & 17 Evening >17)
with Hourly_Sale
as
(
select *,
case
when extract(hour from sale_time ) < 12 then 'Morning'
when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from public.retail_sale
)
select shift,
count (*) as total_order
from Hourly_Sale
group by shift

-- END OF THE PROJECT--