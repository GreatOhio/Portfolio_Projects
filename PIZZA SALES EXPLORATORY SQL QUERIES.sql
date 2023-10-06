select * from pizza_sales;

-- A. KPI’s


--1. Total Revenue:
select sum (total_price) as Total_Revenue
from pizza_sales;

--2. Average Order Value
select  sum (total_price) / COUNT(distinct order_id) as Average_Order_Value
from pizza_sales;

--3. Total Pizzas Sold
select sum (quantity) as Total_Quantity_Sold
from pizza_sales;

--4. Total Orders
select COUNT(distinct order_id) as Total_Orders_Placed
from pizza_sales;

--5. Average Pizzas Per Order
select  cast (sum (quantity) / COUNT(distinct order_id) as decimal (10, 2)) as Average_Pizza_Sold_Per_ID
from pizza_sales;


--B. Daily Trend for Total Orders


select DATENAME (DW, order_date) as Days_of_the_Week, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME (DW, order_date)
order by Days_of_the_Week desc;


--C. Monthly Trend for Orders


select DATENAME (MM, order_date) as Month_of_the_Year, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME (MM, order_date)
order by Month_of_the_Year;


--D. % of Sales by Pizza Category


select pizza_category, cast (sum (total_price) as decimal (10,2)) as Total_price , 
cast((sum (total_price) * 100 / (select sum (total_price) from pizza_sales)) as decimal (10,2))
Percentage_of_Sales_Per_Category
from pizza_sales
group by pizza_category;
 

 --E. % of Sales by Pizza Size


select pizza_size, cast (sum (total_price) as decimal (10,2)) as Total_price , 
cast((sum (total_price) * 100 / (select sum (total_price) from pizza_sales )) as decimal (10,2))
Percentage_of_Sales_Per_Category
from pizza_sales
group by pizza_size
order by Percentage_of_Sales_Per_Category;


--F. Total Pizzas Sold by Pizza Category


select top 5 pizza_name, cast (sum (total_price) as decimal (10,2)) as Total_price
from pizza_sales
group by pizza_name 
order by Total_price desc;


--G. Top 5 Pizzas by Revenue


select top 5 pizza_name, cast (sum (total_price) as decimal (10,2)) as Total_price
from pizza_sales
group by pizza_name 
order by Total_price desc;


--H. Bottom 5 Pizzas by Revenue


select top 5 pizza_name, cast (sum (total_price) as decimal (10,2)) as Total_price
from pizza_sales
group by pizza_name 
order by Total_price;


--I. Top 5 Pizzas by Quantity

select top 5 pizza_name, cast (sum (quantity) as decimal (10,2)) as Total_quantity
from pizza_sales
group by pizza_name 
order by Total_quantity desc;

--J. Bottom 5 Pizzas by Quantity

select top 5 pizza_name, cast (sum (quantity) as decimal (10,2)) as Total_quantity
from pizza_sales
group by pizza_name 
order by Total_quantity;


 



