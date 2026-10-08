import os
import mysql.connector

# Purana local (XAMPP) wala code
# def connection():
#     conn = mysql.connector.connect(
#         host="localhost",
#         user="root",
#         password="",
#         database="clinic"
#     )
#     return conn

# Naya cloud (Aiven) wala code
def connection():
    conn = mysql.connector.connect(
        host=os.environ.get("DB_HOST"),
        user=os.environ.get("DB_USER"),
        password=os.environ.get("DB_PASSWORD"),
        database=os.environ.get("DB_NAME"),
        port=int(os.environ.get("DB_PORT", 3306)),
    )
    return conn