# database.py

import mysql.connector
from mysql.connector import pooling

# dbconfig = {
#     "user": "root",
#     "password": "admin",
#     "host": "192.168.1.14",
#     "database": "electrictree_db",
# }

# connection_pool = pooling.MySQLConnectionPool(pool_name="mypool", pool_size=5, **dbconfig)

# def get_db():
#     conn = connection_pool.get_connection()
#     # try:
#     #     yield conn
#     # finally:
#     #     conn.close()
#     return dbconfig


def get_db():
    try:
        db = mysql.connector.connect(
        host="192.168.1.14",
        user="root",
        password="admin",
        database="electrictree_db"
    )
        print("Connected to MySQL database")
        return db
    except mysql.connector.Error as err:
        print(f"Error connecting to MySQL: {err}")
        exit()
