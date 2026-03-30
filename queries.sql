-- 1. Общее число пользователей сервиса 
SELECT COUNT(customerid) AS number_of_customers FROM customer;
-- 2. Определение общей выручки
SELECT SUM(total) AS total_revenue FROM invoice;
-- 3. Находим общее число заказов
SELECT COUNT(*) AS number_of_orders FROM invoice;
-- 4. Выявляем минимальную сумму заказа 
SELECT MIN(total) AS min_sum_order FROM invoice;
