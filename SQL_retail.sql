select count(*) from sales;


-- EDA

SELECT * FROM sales
WHERE 
    sale_date IS NULL OR 
	sale_time IS NULL OR 
	customer_id IS NULL OR 
    gender IS NULL OR 
	age IS NULL OR
	category IS NULL OR 
    quantiy IS NULL OR 
	price_per_unit IS NULL OR 
	cogs IS NULL;

delete from sales
where
	sale_date IS NULL OR 
	sale_time IS NULL OR 
	customer_id IS NULL OR 
    gender IS NULL OR 
	age IS NULL OR
	category IS NULL OR 
    quantiy IS NULL OR 
	price_per_unit IS NULL OR 
	cogs IS NULL;

-- Data Exploration
-- How many sales we have

select count(*) as total_sales from sales;

-- how many customers we have
select count(distinct(customer_id)) as  total_distinct_customer from sales;

-- How many catrogies we have?
select distinct(category) as total_catrgory from sales;

-- Data Analysis and Buisness Key Problem

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from sales 
where sale_date= '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from sales
where category= 'Clothing'
and format(sale_date, 'yyyy-MM')= '2022-11'
and quantiy>=4;

-- Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as total_sale_categorywise, 
count(*) as total_orders from
sales
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age), category from sales
where category='Beauty'
group by category;

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from sales 
where total_sale>1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select count(transactions_id), gender, category from sales
group by gender, category
order by category;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = year;

-- Write a SQL query to find the top 5 customers based on the highest total sales?

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;