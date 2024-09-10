from mysql.connector import MySQLConnection
# from schemas import BuyerCreate
# from schemas import SupplierCreate
from sqlalchemy.orm import Session
import os
import smtplib
import requests
from email.message import EmailMessage
from fastapi import HTTPException
from firebase_admin import credentials, auth, initialize_app
from database import get_db
from schemas import Buyer, Supplier
from dotenv import load_dotenv
import schemas
import jwt
from passlib.context import CryptContext



# def get_buyer_by_email(db: MySQLConnection, contact_email: str):
#     cursor = db.cursor(dictionary=True)
#     cursor.execute("SELECT * FROM buyer_details WHERE contact_email = %s", (contact_email,))
#     buyer = cursor.fetchone()
#     cursor.close()
#     return buyer

# def create_buyer(db: MySQLConnection, buyer: BuyerCreate):
#     cursor = db.cursor()
#     query = """
#         INSERT INTO electrictree_db.buyer_details (buyer_name, buyer_password, contact_email)
#         VALUES (%s, %s, %s)
#     """
#     cursor.execute(query, (buyer.buyer_name, buyer.buyer_password, buyer.contact_email))
#     db.commit()
#     cursor.close()

# def get_supplier_by_email(db: MySQLConnection, contact_email: str):
#     cursor = db.cursor(dictionary=True)
#     cursor.execute("SELECT * FROM supplier_details WHERE contact_email = %s", (contact_email,))
#     supplier = cursor.fetchone()
#     cursor.close()
#     return supplier
    

# def create_supplier(db: MySQLConnection, supplier: SupplierCreate):
#     cursor = db.cursor()
#     query = """
#         INSERT INTO electrictree_db.supplier_details (supplier_name, supplier_password, contact_email)
#         VALUES (%s, %s, %s)
#     """
#     cursor.execute(query, (supplier.supplier_name, supplier.supplier_password, supplier.contact_email))
#     db.commit()
#     cursor.close()

# Login api for a Buyer
load_dotenv()

SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"

async def buyer_login(db: Session, buyer: schemas.BuyerLogin):
    buyer_name = buyer.buyer_name
    buyer_password = buyer.buyer_password

    if not buyer_name or not buyer_password:
        raise HTTPException(status_code=400, detail="Please fill in the required details")
    
    cursor = db.cursor()
    query = """SELECT * FROM electrictree_db.buyer_details WHERE buyer_name = %s and buyer_password = %s """
    cursor.execute(query, (buyer_name, buyer_password))
    buyer = cursor.fetchone()

    if buyer:
        buyer_id = buyer[0]  
        token = jwt.encode({'buyer_id': buyer_id}, SECRET_KEY, algorithm='HS256')
        return {"message": "Buyer Login Successful", "token": token, "buyer_id": buyer[0], "buyer_name": buyer[1], "buyer_password": buyer[2], "contact_email":buyer[3]}
    else:
        raise HTTPException(status_code=401, detail="Invalid name or password")

    
#  Login api for a Supplier
async def supplier_login(db: Session, supplier: schemas.SupplierLogin):
    supplier_name = supplier.supplier_name
    supplier_password = supplier.supplier_password

    if not supplier_name or not supplier_password:
        raise HTTPException(status_code=400, detail="Please fill in the required details")
    
    cursor = db.cursor()
    query = """SELECT * FROM electrictree_db.supplier_details WHERE supplier_name = %s and supplier_password = %s """
    cursor.execute(query, (supplier_name, supplier_password))
    supplier = cursor.fetchone()

    if supplier:
        supplier_id = supplier[0] 
        token = jwt.encode({'supplier_id': supplier_id}, SECRET_KEY, algorithm='HS256')
        return {"message": "Supplier Login Successful", "token": token, "supplier_id": supplier[0], "supplier_name": supplier[1], "supplier_password": supplier[2], "contact_email":supplier[3]}
    else:
        raise HTTPException(status_code=401, detail="Invalid name or password")
    

#  Login api for a User

async def user_login(db: Session, user: schemas.UserLogin):
    username = user.username
    password = user.password

    if not username or not password:
        raise HTTPException(status_code=400, detail="Please fill in the required details")
    
    cursor = db.cursor()
    query = """SELECT * FROM electrictree_db.user_details WHERE username = %s and password = %s """
    cursor.execute(query, (username, password))
    user = cursor.fetchone()

    if user:
        user_id = user[0] 
        token = jwt.encode({'user_id': user_id}, SECRET_KEY, algorithm='HS256')
        return {"message": "User Login Successful.", "token": token, "user_id": user[0], "username": user[1], "password": user[2], "email":user[3]}
    else:
        raise HTTPException(status_code=401, detail="Invalid name or password")







# module to send verification links on User registered email and validate the token and Integrate Firebase email verification module to send verification email
cred = credentials.Certificate("/home/ubuntu/ElectricTree_Api/config/firebase_credentials.json")
initialize_app(cred)

class FirebaseEmailVerification:
    def __init__(self):
        self.api_key = os.getenv('FIREBASE_API_KEY')
        if not self.api_key:
            raise ValueError("Firebase API key not set in environment variables")

    def send_verification_email(self, user_record):
        try:
            link = auth.generate_email_verification_link(user_record.email)
        except Exception as e:
            print(f"Error generating verification link: {str(e)}")
            raise

        try:
            msg = EmailMessage()
            msg.set_content(f"Click the link to verify your email: {link}")
            msg['Subject'] = 'Verify Your Email'
            msg['From'] = os.getenv('FROM_EMAIL')
            msg['To'] = user_record.email


            with smtplib.SMTP(os.getenv('SMTP_SERVER'), int(os.getenv('SMTP_PORT'))) as server:
                server.starttls()
                server.login(os.getenv('SMTP_USERNAME'), os.getenv('SMTP_PASSWORD'))
                server.send_message(msg)
            print("Verification email sent successfully")
        except smtplib.SMTPException as e:
            print(f"SMTP error occurred: {str(e)}")
            raise
        except Exception as e:
            print(f"Failed to send email: {str(e)}")
            raise


    def verify_email(self, oob_code):
        url = f"https://identitytoolkit.googleapis.com/v1/accounts:update?key={self.api_key}"
        payload = {"oobCode": oob_code}
        response = requests.post(url, json=payload)
        if response.status_code == 200:
            return True, "Email verified successfully"
        else:
            return False, response.json().get("error", {}).get("message", "Unknown error")

firebase_verifier = FirebaseEmailVerification()

async def buyer_signup(buyer: Buyer):
    db = get_db()
    cursor = db.cursor()
    
    check_query = "SELECT * FROM buyer_details WHERE contact_email = %s"
    cursor.execute(check_query, (buyer.contact_email,))
    existing_buyer = cursor.fetchone()

    if existing_buyer:
        raise HTTPException(status_code=400, detail="Email already exists in database")

    try:
        user_record = auth.create_user(email=buyer.contact_email)
    except auth.EmailAlreadyExistsError:
        raise HTTPException(status_code=400, detail="Email already exists in Firebase")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    try:
        firebase_verifier.send_verification_email(user_record)
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to send verification email")

    query = "INSERT INTO buyer_details (buyer_name, buyer_password, contact_email) VALUES (%s,%s,%s)"
    cursor.execute(query, (buyer.buyer_name, buyer.buyer_password, buyer.contact_email))
    db.commit()

    return {"message": "Buyer SignUp Successfully"}

async def supplier_signup(supplier: Supplier):
    db = get_db()
    cursor = db.cursor()

    check_query = "SELECT * FROM supplier_details WHERE contact_email = %s"
    cursor.execute(check_query, (supplier.contact_email,))
    existing_supplier = cursor.fetchone()

    if existing_supplier:
        raise HTTPException(status_code=400, detail="Email already exists in database")

    try:
        user_record = auth.create_user(email=supplier.contact_email)
    except auth.EmailAlreadyExistsError:
        raise HTTPException(status_code=400, detail="Email already exists in Firebase")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    try:
        firebase_verifier.send_verification_email(user_record)
    except Exception as e:
        raise HTTPException(status_code=500, detail="Failed to send verification email")

    query = "INSERT INTO supplier_details (supplier_name, supplier_password, contact_email) VALUES (%s,%s,%s)"
    cursor.execute(query, (supplier.supplier_name, supplier.supplier_password, supplier.contact_email))
    db.commit()

    return {"message": "Supplier SignUp Successfully"}

async def verify_email(oobCode: str):
    if not oobCode:
        raise HTTPException(status_code=400, detail="oobCode is required")

    is_valid, result = firebase_verifier.verify_email(oobCode)

    if is_valid:
        return {"message": result}
    else:
        raise HTTPException(status_code=400, detail=result)
    
# Api for project details
# This api for creating project details. 
    
async def create_project_details(db:Session , project:schemas.ProjectCreate):
    project_name = project.project_name
    project_description = project.project_description
    start_date = project.start_date
    end_date = project.end_date
    status = project.status

    if not project_name or not project_description or not start_date or not status:
        raise HTTPException(status_code=400, detail="Please required fill the details")
    
    cursor = db.cursor()
    query = """INSERT INTO electrictree_db.project_details (project_name, project_description, start_date, end_date, status) VALUES (%s,%s,%s,%s,%s)"""
    cursor.execute(query, (project_name, project_description, start_date, end_date, status))
    db.commit()

    return {"message": "Project Details Added Successfully"}

# This api for listing project details. 
async def get_project_details(db:Session):
    cursor = db.cursor()
    query = """SELECT * FROM electrictree_db.project_details"""
    cursor.execute(query)
    project_details = cursor.fetchall()
    db.commit()
    return {"Project_details": project_details}

# This api for updating project details.  
async def update_project_details(db: Session, project_id: int, project: schemas.ProjectUpdate):
    project_name = project.project_name
    project_description = project.project_description
    start_date = project.start_date
    end_date = project.end_date
    status = project.status

    cursor = db.cursor()
    query = """UPDATE electrictree_db.project_details SET project_name = %s, project_description = %s, start_date = %s, end_date = %s, status = %s WHERE project_id = %s"""
    cursor.execute(query, (project_name, project_description, start_date, end_date, status, project_id))
    db.commit()

    return {"message": "Project details updated successfully"}

# This api for deleting project details.
async def delete_project_details(db:Session, project_id: int):
    cursor = db.cursor()
    query = """DELETE FROM electrictree_db.project_details WHERE project_id = %s"""
    cursor.execute(query, (project_id,))
    db.commit()
    return {"message": "Project details deleted successfully"}

# Api for product and stock details

# This api for creating product details. 
async def create_product_details(db:Session, product:schemas.ProductCreate):
    product_name = product.product_name
    description = product.description
    price = product.price
    
    
    if not product_name or not description or not price:
        raise HTTPException(status_code=400, detail="Please required fill the details")
    
    cursor = db.cursor()
    query = """INSERT INTO electrictree_db.product_details (product_name, description, price) VALUES (%s,%s,%s,%s)"""
    cursor.execute(query,(product_name,description,price))
    db.commit()
    return {"message": "Product details added successfully"}

# This api for creating stock details. 
async def create_stock_details(db: Session, stock: schemas.StockCreate):
    product_name = stock.product_name
    stock_quantity = stock.stock_quantity

    if not product_name or not stock_quantity:
        raise HTTPException(status_code=400, detail="Please fill in the required details")
    
    cursor = db.cursor()
    fetch_query = """SELECT product_id FROM electrictree_db.product_details WHERE product_name = %s"""
    cursor.execute(fetch_query, (product_name,))
    result = cursor.fetchone()

    if not result:
        raise HTTPException(status_code=404, detail="Product not found")
    
    product_id = result[0]

    insert_query = """INSERT INTO electrictree_db.stock_details (product_id, stock_quantity,product_name) VALUES (%s, %s,%s)"""
    cursor.execute(insert_query, (product_id, stock_quantity,product_name))
    db.commit()
    cursor.close()

    return {"message": "Stock details added successfully"}

# This api for listing product details. 
async def get_product_details(db:Session):
    cursor = db.cursor()
    query = """SELECT * FROM electrictree_db.product_details"""
    cursor.execute(query)
    product_details = cursor.fetchall()
    db.commit()
    return {"Product_details": product_details}

# This api for listing stock details. 
async def get_stock_details(db:Session):
    cursor = db.cursor()
    query = """SELECT * FROM electrictree_db.stock_details"""
    cursor.execute(query)
    stock_details = cursor.fetchall()
    db.commit()
    return {"Stock_details": stock_details}

# This api for updating product details. 
async def update_product_details(db: Session, product_id: int, product: schemas.ProductUpdate):
    product_name = product.product_name
    description = product.description
    price = product.price
    

    cursor = db.cursor()
    query = """UPDATE electrictree_db.product_details SET product_name = %s, description = %s, price = %s WHERE product_id = %s"""
    cursor.execute(query, (product_name, description, price, product_id))
    db.commit()

    return {"message": "Product details updated successfully"}

# This api for updating stock details. 
async def update_stock_details(db: Session, stock_id: int, stock: schemas.StockUpdate):
    product_name = stock.product_name
    stock_quantity = stock.stock_quantity

    if not product_name or not stock_quantity:
        raise HTTPException(status_code=400, detail="Please fill in the required details")

    cursor = db.cursor()
    fetch_query = """SELECT product_id FROM electrictree_db.product_details WHERE product_name = %s"""
    cursor.execute(fetch_query, (product_name,))
    result = cursor.fetchone()

    if not result:
        raise HTTPException(status_code=404, detail="Product not found")
    
    product_id = result[0]

    update_query = """UPDATE electrictree_db.stock_details SET product_name = %s, stock_quantity = %s, product_id = %s WHERE stock_id = %s"""
    cursor.execute(update_query, (product_name, stock_quantity, product_id, stock_id))
    db.commit()
    cursor.close()

    return {"message": "Stock details updated successfully"}

# This api for deleting product details.
async def delete_product_details(db:Session, product_id: int):
    cursor = db.cursor()
    query = """DELETE FROM electrictree_db.product_details WHERE product_id = %s"""
    cursor.execute(query, (product_id,))
    db.commit()
    return {"message": "Product details deleted successfully"}

# This api for deleting stock details.
async def delete_stock_details(db:Session, stock_id: int):
    cursor = db.cursor()
    query = """DELETE FROM electrictree_db.stock_details WHERE stock_id = %s"""
    cursor.execute(query, (stock_id,))
    db.commit()
    return {"message": "Stock details deleted successfully"}











