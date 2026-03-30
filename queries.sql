-- 1. Общее число пользователей сервиса 
SELECT COUNT(customerid) AS number_of_customers FROM customer;
-- 2. Определение общей выручки
SELECT SUM(total) AS total_revenue FROM invoice;
