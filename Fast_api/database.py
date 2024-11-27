import psycopg2

def get_db():
    try:
        db = psycopg2.connect(
        host="192.168.31.194",
        database="Electrictree",  
        user="postgres",        
        password="root",
        port="5432" 
    )
        print("Connected to MySQL database")
        return db
    except psycopg2.connect.Error as err:
        print(f"Error connecting to MySQL: {err}")
        exit()
