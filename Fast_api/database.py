import mysql.connector

def get_db():
    try:
        db = mysql.connector.connect(
        host="192.168.1.3",
        user="root",
        password="admin",
        database="electrictree_db"
    )
        print("Connected to MySQL database")
        return db
    except mysql.connector.Error as err:
        print(f"Error connecting to MySQL: {err}")
        exit()
