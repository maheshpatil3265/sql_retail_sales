select * from retail_sales;


select * from retail_sales;


--Data Cleaning
select * from retail_sales
where 
	transactions_id is null
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
	quantity is null
or
 	price_per_unit is null
or
	cogs is null
or
	total_sale is null;

select Count(*) from retail_sales;

delete from retail_sales
where 
	transactions_id is null
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
	quantity is null
or
 	price_per_unit is null
or
	cogs is null
or
	total_sale is null;

select Count(*) from retail_sales;

--Data Exploration

--how many sales transaction are made?
select Count(transactions_id) from retail_sales;

--how many customers We have?
select Count(distinct(customer_id)) from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * 
from retail_sales
where sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 
--'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

select * 
from retail_sales
where category = 'Clothing' 
and 
	quantity >3
and 
	to_char(sale_date,'YYYY-MM') ='2022-11';
	

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as Total_sales
from retail_sales
group by category;

--2 method
select distinct(category),
sum(total_sale) over(partition by category) as Total_sales
from retail_sales;


-- Q.4 Write a SQL query to find the average age of customers who
--purchased items from the 'Beauty' category.

select round(avg(age),2) as avg_age
from retail_sales
where category ='Beauty';

--2
select distinct(category),
avg(age) over (partition by category) as Avg_age
from retail_sales
where category ='Beauty';

-- Q.5 Write a SQL query to find all transactions where
--the total_sale is greater than 1000.

select *
from retail_sales
where total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) 
--made by each gender in each category.
select category,gender,count(*) as Total_transactions
from retail_sales
group by category,gender;

--2
select distinct(category),
count(*) over (partition by category) as Total_transactions
from retail_sales;

-- Q.7 Write a SQL query to calculate the average sale for each month.
--Find out best selling month in each year
select * 
from (
select 
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_sale) as avg_sale ,
rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as ranking
from retail_sales
group by 1,2
order by 3 desc,1) as cte
where ranking=1;

-- Q.8 Write a SQL query to find the top 5 customers
--based on the highest total sales 
select customer_id,sum(total_sale) as Net_sales 
from 
retail_sales
group by customer_id
order by 2 desc
limit 5;


-- Q.9 Write a SQL query to find the number of 
--unique customers who purchased items from each category.
select category,
count(distinct(customer_id)) as Total_customers
from retail_sales
group by category;


-- Q.10 Write a SQL query to create each shift and number of orders 
--(Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with shift_data as (
	select *,
					case 
						when extract (hour from sale_time) <= 12 then 'Morning'
						when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
						else 'Evening' end as shift 
					from retail_sales
					)
select shift,
count(*) as total_transactions
from shift_data
group by shift;

--end of project















