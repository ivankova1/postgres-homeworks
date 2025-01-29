-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK (unit_price > 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1));

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
SELECT * INTO no_products FROM products WHERE discontinued = 1;
SELECT * FROM no_products;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products
--Удаляем ограничение

DELETE FROM products WHERE discontinued = 1
-- Удаляю из products товары, снятые с продажи

SELECT DISTINCT product_id
FROM order_details
WHERE product_id NOT IN (SELECT product_id FROM products);
--Проверяю наличие записей в order_details, которые есть в order_details, но отсутствуют в products

DELETE FROM order_details
WHERE product_id NOT IN (SELECT product_id FROM products);
-- Удаляю записи в order_details, которые есть в order_details, но отсутствуют в products

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id) REFERENCES products(product_id);
--Восстанавливаю ограничение fk_order_details_products