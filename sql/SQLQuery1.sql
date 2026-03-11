USE [Pizza DB];
GO

Select * from pizza_sales;

--Total Revenue
Select SUM(total_price)as total_revenue from pizza_sales;

--average order value
Select SUM(total_price)/count(distinct order_id)as avg_order_value from pizza_sales;

--total pizzas sold

Select SUM(quantity)as total_pizza_sold from pizza_sales;

--total orders
Select count(distinct order_id)as total_orders from pizza_sales;


--average pizzas per order
Select cast(cast(sum(quantity)as decimal(10,2))/cast(count(distinct order_id)as decimal(10,2)) as decimal(10,2))as avg_Pizza_per_order
From pizza_sales;

--daily trend for total orders
Select DATENAME(DW,order_date) as order_day,count(distinct order_id)as total_orders
from pizza_sales
Group by DATENAME(DW,order_date);

--monthly trend for total orders
Select DATENAME(Month,order_date) as order_month,count(distinct order_id)as total_orders
from pizza_sales
Group by DATENAME(Month,order_date)
Order by 2 DESC;

--percentage of sales by pizza category
Select pizza_category,sum(total_price) as Total_sales,sum(total_price)*100/(Select sum(total_price)from pizza_sales Where MONTH(order_date)=1)as PCT
from pizza_sales 
Where MONTH(order_date)=1
Group by pizza_category;

--percentage of sales by pizza size
Select pizza_size,sum(total_price) as Total_sales,CAST(sum(total_price)*100/(Select sum(total_price)from pizza_sales Where DATEPART(Quarter,order_date)=1)as decimal(10,2))as PCT
from pizza_sales 
Where DATEPART(Quarter,order_date)=1
Group by pizza_size
Order by PCT DESC ;


--top 5 best sellers by revenue
Select TOP 5 pizza_name,SUM(total_price)as total_revenue
From pizza_sales
Group by pizza_name
Order by total_revenue DESC;

--bottom 5 best sellers by revenue
Select TOP 5 pizza_name,SUM(total_price)as total_revenue
From pizza_sales
Group by pizza_name
Order by total_revenue ;

--top 5 best sellers by quantity
Select TOP 5 pizza_name,SUM(quantity)as total_quantity
From pizza_sales
Group by pizza_name
Order by total_quantity DESC;

--bottom 5 best sellers by quantity
Select TOP 5 pizza_name,SUM(quantity)as total_quantity
From pizza_sales
Group by pizza_name
Order by total_quantity ;

--top 5 best sellers by quantity
Select TOP 5 pizza_name,COUNT(distinct order_id)as total_orders
From pizza_sales
Group by pizza_name
Order by total_orders DESC;


--bottom 5 best sellers by quantity
Select TOP 5 pizza_name,COUNT(distinct order_id)as total_orders
From pizza_sales
Group by pizza_name
Order by total_orders ;