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
SELECT COUNT(DISTINCT customerid) AS active_number_of_customers, billingcountry AS country
FROM invoice GROUP BY country ORDER BY country ASC;
--10. Количество заказов по странам
SELECT COUNT(invoiceid) AS number_of_orders, billingcountry AS country FROM
invoice GROUP BY country ORDER BY country;
-- 11. Находим выручку по странам 
SELECT SUM(total) AS revenue, billingcountry AS country FROM invoice
GROUP BY country ORDER BY country;
-- 12. Выявляем средний чек по странам
SELECT AVG(total) AS average_revenue, billingcountry as country FROM invoice
GROUP BY country ORDER BY country;
-- 13. Вычисляем топ 10 процентов пользователей сервиса по выручке
SELECT customerid, SUM(total) AS revenue FROM invoice GROUP BY customerid
ORDER BY revenue DESC, customerid ASC LIMIT 0.1 * 
(SELECT COUNT(DISTINCT customerid) FROM invoice);
-- 14. Вычисляем топ 10 процентов пользователей сервиса по числу заказов
SELECT customerid, COUNT(invoiceid) AS number_of_orders FROM invoice GROUP BY customerid
ORDER BY number_of_orders DESC, customerid ASC LIMIT 0.1 * 
(SELECT COUNT(DISTINCT customerid) FROM invoice);
-- 15. Считаем ARPU (среднюю выручку на каждого пользователя)
SELECT SUM(total) / COUNT(DISTINCT customerid)
AS "ARPU" FROM invoice;
-- 16. Делаем сегментацию по группам пользователей относительно количества заказов и выводим общую выручку группы, количество пользователей группы, категорию группы и среднюю выручку на пользователя в группе
WITH customer_order_info AS (SELECT SUM(total) AS total_revenue, COUNT(invoiceid) AS number_of_orders,
customerid FROM invoice GROUP BY customerid),
client_groups AS (SELECT SUM(total_revenue) AS total_group_revenue, 
COUNT(customerid) AS number_of_people_in_group,
CASE 
	WHEN number_of_orders <= 1 THEN '1 order group'
	WHEN number_of_orders >= 2 AND number_of_orders <= 5 THEN '2-5 order group'
	ELSE '6+ order group'
END AS order_group FROM customer_order_info GROUP BY order_group)
SELECT total_group_revenue, number_of_people_in_group, order_group,
total_group_revenue / number_of_people_in_group AS avg_user_revenue_in_group FROM client_groups;
