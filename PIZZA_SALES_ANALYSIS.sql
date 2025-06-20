USE pizza;
SELECT * FROM pizza_sales;
SELECT COUNT(*) FROM pizza_sales;

-- 1.Total Revenue

SELECT ROUND(SUM(total_price), 2) AS Total_Revenue
FROM pizza_sales;

-- TOTAL REVENUE = 817860.05

-- 2. Average order value

SELECT round((SUM(total_price) / COUNT(DISTINCT order_id)),2) as  Avg_order_value
FROM pizza_sales;

-- Avg_order_value = 38.31

-- 3. Total pizza sold

select sum(quantity) as Total_Quantity_sold from pizza_sales;

-- Total_Quantity_sold= 49574

-- 4. Total_Orders

select count(distinct order_id) as total_orders from pizza_sales;

-- total_orders = 21350

-- 5. Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
COUNT(DISTINCT order_id) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

-- Avg_Pizzas_per_order = 2.32

SELECT 
  DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS order_day,
  COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d'));
-- Friday	2990
-- Monday	3096
-- Saturday	3057
-- Sunday	3025
-- Thursday	3017
-- Tuesday	3087
-- Wednesday	3078-- 

-- C. Hourly Trend for Orders-- 

SELECT 
  HOUR(order_time) AS order_hours, 
  COUNT(DISTINCT order_id) AS total_orders
FROM 
  pizza_sales
GROUP BY 
  HOUR(order_time)
ORDER BY 
  HOUR(order_time);
  
-- --9	1
-- 10	8
-- 11	1231
-- 12	2520
-- 13	2455
-- 14	1472
-- 15	1468
-- 16	1920
-- 17	2336
-- 18	2399
-- 19	2009
-- 20	1642
-- 21	1198
-- 22	663
-- 23	28--  

-- D. % of Sales by Pizza Category

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- Classic	220053.10	26.91
-- Veggie	193690.45	23.68
-- Supreme	208197.00	25.46
-- Chicken	195919.50	23.96

-- E. % of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- L	375318.70	45.89
-- M	249382.25	30.49
-- S	178076.50	21.77
-- XL	14076.00	1.72
-- XXL	1006.60	0.12 

-- F. Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Classic	1178
-- Supreme	964
-- Veggie	944
-- Chicken	875

-- G. Top 5 Best Sellers by Total Pizzas Sold

SELECT 
  pizza_name, 
  SUM(quantity) AS Total_Pizza_Sold
FROM 
  pizza_sales
GROUP BY 
  pizza_name
ORDER BY 
  Total_Pizza_Sold DESC
LIMIT 5;

-- The Classic Deluxe Pizza	2453
-- The Barbecue Chicken Pizza	2432
-- The Hawaiian Pizza	2422
-- The Pepperoni Pizza	2418
-- The Thai Chicken Pizza	2371

-- H. Bottom 5 Best Sellers by Total Pizzas Sold

SELECT 
  pizza_name, 
  SUM(quantity) AS Total_Pizza_Sold
FROM 
  pizza_sales
GROUP BY 
  pizza_name
ORDER BY 
  Total_Pizza_Sold ASC
LIMIT 5;

-- The Brie Carre Pizza	490
-- The Mediterranean Pizza	934
-- The Calabrese Pizza	937
-- The Spinach Supreme Pizza	950
-- The Soppressata Pizza	961 

SELECT * FROM pizza_sales;


