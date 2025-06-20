# 🍕 Pizza Sales Analysis - SQL Script README

## 📑 Overview

This SQL script is used to analyze pizza sales data stored in the `pizza_sales` table under the `pizza` database. The goal is to extract meaningful business insights such as total revenue, average order value, sales trends by day and time, and best/worst performing pizza items.

---

## 🧱 Database Structure

* **Database Name:** `pizza`
* **Table Name:** `pizza_sales`
* **Key Columns:**

  * `order_id`
  * `order_date`
  * `order_time`
  * `pizza_name`
  * `pizza_category` (Classic, Supreme, Chicken, Veggie)
  * `pizza_size` (S, M, L, XL, XXL)
  * `quantity`
  * `total_price`

---

## 📊 Analysis Sections

### 1. Total Revenue

```sql
SELECT ROUND(SUM(total_price), 2) AS Total_Revenue FROM pizza_sales;
```

**Insight:** Total sales revenue is `$817,860.05`.

---

### 2. Average Order Value

```sql
SELECT ROUND((SUM(total_price) / COUNT(DISTINCT order_id)), 2) AS Avg_order_value FROM pizza_sales;
```

**Insight:** Each order, on average, generates `$38.31` in revenue.

---

### 3. Total Pizzas Sold

```sql
SELECT SUM(quantity) AS Total_Quantity_sold FROM pizza_sales;
```

**Insight:** A total of `49,574` pizzas were sold.

---

### 4. Total Orders

```sql
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;
```

**Insight:** There were `21,350` distinct orders.

---

### 5. Average Pizzas Per Order

```sql
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order FROM pizza_sales;
```

**Insight:** On average, `2.32` pizzas were sold per order.

---

### 6. Daily Orders Trend

```sql
SELECT DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS order_day, COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales GROUP BY order_day;
```

**Insight:**

* Monday: 3096
* Tuesday: 3087
* Wednesday: 3078
* Thursday: 3017
* Friday: 2990
* Saturday: 3057
* Sunday: 3025

---

### 7. Hourly Orders Trend

```sql
SELECT HOUR(order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales GROUP BY HOUR(order_time) ORDER BY HOUR(order_time);
```

**Insight:** Peak order times are **12 PM to 1 PM** and **5 PM to 8 PM**.

---

### 8. % of Sales by Pizza Category

```sql
SELECT pizza_category, SUM(total_price) AS total_revenue, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT FROM pizza_sales GROUP BY pizza_category;
```

**Insight:**

* Classic: 26.91%
* Supreme: 25.46%
* Chicken: 23.96%
* Veggie: 23.68%

---

### 9. % of Sales by Pizza Size

```sql
SELECT pizza_size, SUM(total_price) AS total_revenue, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT FROM pizza_sales GROUP BY pizza_size;
```

**Insight:**

* Large: 45.89%
* Medium: 30.49%
* Small: 21.77%
* XL: 1.72%
* XXL: 0.12%

---

### 10. Monthly Sales Trend (Example: February)

```sql
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold FROM pizza_sales WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 2 GROUP BY pizza_category;
```

**Insight (February only):**

* Classic: 1178
* Supreme: 964
* Veggie: 944
* Chicken: 875

---

### 11. Top 5 Best Selling Pizzas

```sql
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales GROUP BY pizza_name ORDER BY Total_Pizza_Sold DESC LIMIT 5;
```

**Top 5 Pizzas:**

1. The Classic Deluxe Pizza – 2453
2. The Barbecue Chicken Pizza – 2432
3. The Hawaiian Pizza – 2422
4. The Pepperoni Pizza – 2418
5. The Thai Chicken Pizza – 2371

---

### 12. Bottom 5 Worst Selling Pizzas

```sql
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales GROUP BY pizza_name ORDER BY Total_Pizza_Sold ASC LIMIT 5;
```

**Bottom 5 Pizzas:**

1. The Brie Carre Pizza – 490
2. The Mediterranean Pizza – 934
3. The Calabrese Pizza – 937
4. The Spinach Supreme Pizza – 950
5. The Soppressata Pizza – 961

---

## 📦 Additional Notes

* Make sure the date fields (`order_date`, `order_time`) are properly formatted for use with `STR_TO_DATE()` and `HOUR()` functions.
* Queries can be adapted with filters for month, category, or size as needed.

---

