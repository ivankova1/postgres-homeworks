-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT cu.company_name AS customer, CONCAT(e.first_name, ' ', e.last_name) AS employee
FROM ORDERS o
	LEFT JOIN shippers s
		ON o.ship_via = s.shipper_id
	LEFT JOIN employees e
		ON o.employee_id = e.employee_id
	LEFT JOIN customers cu
		ON o.customer_id = cu.customer_id  -- Соединяем с таблицей customers
WHERE o.ship_city = 'London'
AND e.city = 'London'
AND s.company_name = 'United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT a.product_name, a.units_in_stock, b.contact_name, b.phone
FROM products a
	LEFT JOIN suppliers b
		ON a.supplier_id = b.supplier_id
WHERE a.discontinued = 0
AND a.units_in_stock < 25
AND a.category_id IN (
	SELECT category_id
	FROM categories
	WHERE category_name IN ('Dairy Products', 'Condiments')
)
ORDER BY a.units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT a.company_name
FROM customers a
	LEFT JOIN orders b
		ON a.customer_id = b.customer_id
WHERE b.order_id IS NULL

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT a.product_name
FROM products a
WHERE a.product_id IN(
	SELECT b.product_id
	FROM order_details b
WHERE b.quantity = 10
)
