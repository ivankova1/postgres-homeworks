"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import psycopg2

# Параметры подключения к базе данных
def connect_to_db():
    return psycopg2.connect(
        host="localhost",
        database="north",
        user="postgres",
        password="Qwertwer"
    )

def insert_employees(cur):
    with open('/Users/vanakoval/PycharmProjects/postgres-homeworks/homework-1/north_data/employees_data.csv', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            cur.execute(
                "INSERT INTO employees (first_name, last_name, title, birth_date, notes) VALUES (%s, %s, %s, %s, %s)",
                (row['first_name'], row['last_name'], row['title'], row['birth_date'], row['notes'])
            )

def insert_customers(cur):
    with open('/Users/vanakoval/PycharmProjects/postgres-homeworks/homework-1/north_data/customers_data.csv', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            cur.execute(
                "INSERT INTO customers (customer_id, company_name, contact_name) VALUES (%s, %s, %s)",
                (row['customer_id'], row['company_name'], row['contact_name'])
            )

def insert_orders(cur):
    with open('/Users/vanakoval/PycharmProjects/postgres-homeworks/homework-1/north_data/orders_data.csv', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            cur.execute(
                "INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) VALUES (%s, %s, %s, %s, %s)",
                (row['order_id'], row['customer_id'], row['employee_id'], row['order_date'], row['ship_city'])
            )

def main():
    try:
        conn = connect_to_db()
        with conn.cursor() as cur:
            insert_employees(cur)
            insert_customers(cur)
            insert_orders(cur)
            conn.commit()  # Зафиксировать изменения
            print("Данные успешно вставлены")
    except Exception as e:
        print(f"Произошла ошибка: {e}")
    finally:
        if conn:
            conn.close()

if __name__ == "__main__":
    main()

