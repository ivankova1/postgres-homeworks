-- SQL-команды для создания таблиц

-- Создание таблицы employees
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    title VARCHAR(50),
    birth_date DATE,
    notes TEXT
);

-- Создание таблицы customers
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    company_name VARCHAR(50),
    contact_name VARCHAR(50)
);

-- Создание таблицы orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id VARCHAR(50) REFERENCES customers(customer_id),
    employee_id INT,
    order_date DATE,
    ship_city VARCHAR(50)
);

SELECT * FROM employees;
SELECT * FROM customers;
SELECT * FROM orders;
