-- 1. Общее число пользователей сервиса 
SELECT COUNT(customerid) AS number_of_customers FROM customer;
-- 2. Определение общей выручки
SELECT SUM(total) AS total_revenue FROM invoice;
-- 3. Находим общее число заказов
SELECT COUNT(*) AS number_of_orders FROM invoice;
-- 4. Определяем общий средний чек 
SELECT AVG(total) AS average_bill FROM invoice;
-- 4. Выявляем минимальную сумму заказа 
SELECT MIN(total) AS min_sum_order FROM invoice;
-- 5. Выявляем максимальную сумму заказа
SELECT MAX(total) AS max_sum_order FROM invoice;
-- 6. Считааем выручку по дням (с начала ведения записи)
SELECT SUM(total) AS day_revenue, invoicedate::date AS invoice_date FROM invoice
GROUP BY invoice_date ORDER BY invoice_date ASC;
-- 7. Считаем количество заказов по дням 
SELECT COUNT(invoiceid) AS orders_number_per_date, invoicedate::date AS invoice_date FROM invoice
GROUP BY invoice_date ORDER BY invoice_date ASC;
-- 8. Считаем cредний чек по дням
SELECT AVG(total) AS average_bill_by_day, invoicedate::date AS invoice_date FROM invoice
GROUP BY invoice_date ORDER BY invoice_date ASC;
-- 9. Количество активных клиентов по странам 
SELECT COUNT(customerid) AS active_number_of_customers, billingcountry AS country
FROM invoice GROUP BY country ORDER BY country ASC;
