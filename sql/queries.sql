-- 1. Общая выручка без возвратов
SELECT ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM ecommerce_data
WHERE Quantity > 0;

-- 2. Количество заказов без возвратов
SELECT COUNT(DISTINCT InvoiceNo) AS total_orders
FROM ecommerce_data
WHERE Quantity > 0;

-- 3. Количество уникальных клиентов
SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM ecommerce_data
WHERE CustomerID IS NOT NULL;

-- 4. Выручка по месяцам
SELECT 
    DATE_TRUNC('month', InvoiceDate) AS month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM ecommerce_data
WHERE Quantity > 0
GROUP BY month
ORDER BY month;

-- 5. Топ-10 клиентов по выручке
SELECT 
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent
FROM ecommerce_data
WHERE Quantity > 0
  AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

-- 6. Средний чек
SELECT ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT 
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_total
    FROM ecommerce_data
    WHERE Quantity > 0
    GROUP BY InvoiceNo
) t;

-- 7. Топ-10 товаров по количеству продаж
SELECT 
    Description,
    SUM(Quantity) AS total_sold
FROM ecommerce_data
WHERE Quantity > 0
  AND Description IS NOT NULL
GROUP BY Description
ORDER BY total_sold DESC
LIMIT 10;

-- 8. Топ-10 стран по выручке
SELECT 
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM ecommerce_data
WHERE Quantity > 0
GROUP BY Country
ORDER BY revenue DESC
LIMIT 10;

-- 9. Накопительные траты клиента
SELECT 
    CustomerID,
    InvoiceDate,
    ROUND(SUM(Quantity * UnitPrice) OVER (
        PARTITION BY CustomerID
        ORDER BY InvoiceDate
    ), 2) AS cumulative_spent
FROM ecommerce_data
WHERE Quantity > 0
  AND CustomerID IS NOT NULL;