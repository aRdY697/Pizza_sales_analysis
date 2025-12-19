CREATE DATABASE Project;

USE Project;

SELECT * FROM pizza_sales;

--TOTAL REVENEU
SELECT
 CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Reveneu
FROM pizza_sales;

-- AVERAGE ORDER VALUE
SELECT
CAST(SUM(total_price)/ COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Average_order_value
FROM pizza_sales;

--TOTAL PIZZA SOLD
SELECT
 SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales;

--TOTAL ORDERS
SELECT
 COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales;

--AVERAGE PIZZA PER ORDER
SELECT
 CAST(SUM(quantity) * 1.0 / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Average_pizza_per_order
FROM pizza_sales;

--HOURLY TREND FOR TOTAL PIZZA SALES
SELECT
  DATEPART(HOUR, order_time) AS order_hours,
  SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

-- WEEKLY TREND FOR ORDERS
SELECT 
    DATEPART(ISO_WEEK, order_date) AS WeekNumber,
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    pizza_sales
GROUP BY 
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY 
    Year, WeekNumber;

-- PERCENTAGE SALES BY PIZZA CATEGORY
SELECT 
    pizza_category,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
    CAST(SUM(total_price) * 100.0 / SUM(SUM(total_price)) OVER() AS DECIMAL(10,2)) AS Percentage_sales
FROM pizza_sales
GROUP BY pizza_category;

-- PERCENTAGE SALES BY PIZZA SIZE
SELECT
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales,
    CAST(SUM(total_price) * 100.0 / SUM(SUM(total_price)) OVER() AS DECIMAL(10,2)) AS Percentage_sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;
    
--TOTAL PIZZA SOLD BY PIZZA CATEGORY
SELECT
    pizza_category,
    SUM(quantity) AS Total_quantity_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_quantity_sold DESC;

-- TOP 5 PIZZA BY REVENUE
SELECT
    TOP 5
    pizza_name,
    SUM(total_price) AS Total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue DESC;

-- WORST 5 REVENUE GENERATING PIZZA NAME
SELECT
    TOP 5
    pizza_name,
  CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_revenue ASC;

SELECT * FROM pizza_sales; 
-- TOP 4 PIZZA CATEGORY BY Quantity
SELECT
    TOP 4
    pizza_category,
    SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_quantity DESC;

-- TOP 5 PIZZA BY QUANTITY
SELECT
    TOP 5
    pizza_name,
    SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC;

-- WORST 5 PIZZA BY QUANTITY
SELECT
    TOP 5 
    pizza_name,
    SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity ASC;

-- TOP 5 PIZZA BY TOTAL ORDERS
SELECT
    TOP 5
    pizza_name,
   COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC;

-- BOTTOM 5 PIZZA BY TOTAL ORDERS
SELECT
    TOP 5
    pizza_name,
   COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC;

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC
