import mysql.connector
def connection():
    conn = mysql.connector.connect(
        host="localhost",
        user="root",          # default XAMPP MySQL user
        password="",          # default XAMPP MySQL password is empty
        database="clinic"     # your database name
    )
    return conn