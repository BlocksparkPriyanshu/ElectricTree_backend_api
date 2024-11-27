from mysql.connector import MySQLConnection
# from schemas import BuyerCreate
# from schemas import SupplierCreate
from sqlalchemy.orm import Session
import os
import smtplib
import requests
from email.message import EmailMessage
from fastapi import HTTPException, Response
from firebase_admin import credentials, auth, initialize_app
from database import get_db
from schemas import Buyer, Supplier, Status, Status1
from dotenv import load_dotenv
import schemas
import jwt
from passlib.context import CryptContext
from datetime import datetime, date
import json



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
        return Status(status=False, status_code=400, message="Please fill in the required details")

    cursor = db.cursor()
    query = """SELECT * FROM buyer_details WHERE buyer_name = %s and buyer_password = %s """
    cursor.execute(query, (buyer_name, buyer_password))
    buyer = cursor.fetchone()

    if buyer:
        buyer_id = buyer[0]
        token = jwt.encode({'buyer_id': buyer_id, 'user_type': 'buyer'}, SECRET_KEY, algorithm=ALGORITHM)

        response_result = {
            "token": token,
            "buyer_id": buyer[0],
            "buyer_name": buyer[1],
            "buyer_password": buyer[2],
            "contact_email": buyer[3]
        }

        return Status(status=True, status_code=200, message="Buyer Login Successful", result=response_result)

    else:
        return Status(status=False, status_code=401, message="Invalid name or password")

    
#  Login api for a Supplier
async def supplier_login(db: Session, supplier: schemas.SupplierLogin):
    supplier_name = supplier.supplier_name
    supplier_password = supplier.supplier_password

    if not supplier_name or not supplier_password:
        return Status(status=False, status_code=400, message="Please fill in the required details")

    cursor = db.cursor()
    query = """SELECT * FROM supplier_details WHERE supplier_name = %s and supplier_password = %s """
    cursor.execute(query, (supplier_name, supplier_password))
    supplier = cursor.fetchone()

    if supplier:
        supplier_id = supplier[0]
        token = jwt.encode({'supplier_id': supplier_id, 'user_type': 'supplier'}, SECRET_KEY, algorithm=ALGORITHM)

        response_result = {
            "token": token,
            "supplier_id": supplier[0],
            "supplier_name": supplier[1],
            "supplier_password": supplier[2],
            "contact_email": supplier[3]
        }

        return Status(status=True, status_code=200, message="Supplier Login Successful", result=response_result)

    else:
        return Status(status=False, status_code=401, message="Invalid name or password")
    

#  Login api for a User

async def user_login(db: Session, user: schemas.UserLogin):
    username = user.username
    password = user.password

    if not username or not password:
        return Status(status=False, status_code=400, message="Please fill in the required details")

    cursor = db.cursor()
    query = """SELECT * FROM user_details WHERE username = %s and password = %s """
    cursor.execute(query, (username, password))
    user = cursor.fetchone()

    if user:
        user_id = user[0]
        token = jwt.encode({'user_id': user_id, 'user_type': 'user'}, SECRET_KEY, algorithm=ALGORITHM)

        response_result = {
            "token": token,
            "user_id": user[0],
            "username": user[1],
            "password": user[2],
            "email": user[3]
        }

        return Status(status=True, status_code=200, message="User Login Successful.", result=response_result)

    else:
        return Status(status=False, status_code=401, message="Invalid name or password")


# module to send verification links on User registered email and validate the token and Integrate Firebase email verification module to send verification email
cred = credentials.Certificate("/home/ubuntu/ElectricTree_backend_api/Fast_api/config/firebase_credentials.json")
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


# Buyer Signup API
async def buyer_signup(buyer: Buyer):
    db = get_db()
    cursor = db.cursor()

    check_query = "SELECT * FROM buyer_details WHERE contact_email = %s"
    cursor.execute(check_query, (buyer.contact_email,))
    existing_buyer = cursor.fetchone()

    if existing_buyer:
        return Status(status=False, status_code=400, message="Email already exists in database")

    try:
        user_record = auth.create_user(email=buyer.contact_email)
    except auth.EmailAlreadyExistsError:
        return Status(status=False, status_code=400, message="Email already exists in Firebase")
    except Exception as e:
        return Status(status=False, status_code=500, message=str(e))

    try:
        firebase_verifier.send_verification_email(user_record)
    except Exception as e:
        return Status(status=False, status_code=500, message="Failed to send verification email")

    query = "INSERT INTO buyer_details (buyer_name, buyer_password, contact_email) VALUES (%s,%s,%s)"
    cursor.execute(query, (buyer.buyer_name, buyer.buyer_password, buyer.contact_email))
    db.commit()
    
    # Fetch the newly inserted buyer details
    cursor.execute("SELECT * FROM buyer_details WHERE contact_email = %s", (buyer.contact_email,))
    new_buyer = cursor.fetchone()

    # Prepare response result
    response_result = {
        "buyer_id": new_buyer[0],
        "buyer_name": new_buyer[1],
        "buyer_password": new_buyer[2],
        "contact_email": new_buyer[3]
    }

    return Status(status=True, status_code=200, message="Buyer SignUp Successfully", result=response_result)

# Supplier Signup API
async def supplier_signup(supplier: Supplier):
    db = get_db()
    cursor = db.cursor()

    check_query = "SELECT * FROM supplier_details WHERE contact_email = %s"
    cursor.execute(check_query, (supplier.contact_email,))
    existing_supplier = cursor.fetchone()

    if existing_supplier:
        return Status(status=False, status_code=400, message="Email already exists in database")

    try:
        user_record = auth.create_user(email=supplier.contact_email)
    except auth.EmailAlreadyExistsError:
        return Status(status=False, status_code=400, message="Email already exists in Firebase")
    except Exception as e:
        return Status(status=False, status_code=500, message=str(e))

    try:
        firebase_verifier.send_verification_email(user_record)
    except Exception as e:
        return Status(status=False, status_code=500, message="Failed to send verification email")

    query = "INSERT INTO supplier_details (supplier_name, supplier_password, contact_email) VALUES (%s,%s,%s)"
    cursor.execute(query, (supplier.supplier_name, supplier.supplier_password, supplier.contact_email))
    db.commit()

    cursor.execute("SELECT * FROM supplier_details WHERE contact_email = %s", (supplier.contact_email,))
    new_supplier = cursor.fetchone()

    response_result = {
        "supplier_id": new_supplier[0],
        "supplier_name": new_supplier[1],
        "supplier_password": new_supplier[2],
        "contact_email": new_supplier[3]
    }

    return Status(status=True, status_code=200, message="Supplier SignUp Successfully", result=response_result)

# Email Verification API
async def verify_email(oobCode: str):
    if not oobCode:
        return Status1(status=False, status_code=400, message="oobCode is required")

    is_valid, result = firebase_verifier.verify_email(oobCode)

    if is_valid:
        return Status1(status=True, status_code=200, message=result)
    else:
        return Status1(status=False, status_code=400, message=result)
    
# Api for project details
# This api for creating project details. 
    
# Create Project Details API
async def create_project_details(db: Session, project: schemas.ProjectCreate):
    project_name = project.project_name
    project_description = project.project_description
    start_date = project.start_date
    end_date = project.end_date
    status = project.status

    if not project_name or not project_description or not start_date or not status:
        return Status1(status=False, status_code=400, message="Please fill in the required details")

    cursor = db.cursor()
    query = """INSERT INTO project_details (project_name, project_description, start_date, end_date, status) VALUES (%s,%s,%s,%s,%s)"""
    try:
        cursor.execute(query, (project_name, project_description, start_date, end_date, status))
        db.commit()
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Failed to add project details: {str(e)}")

    return Status1(status=True, status_code=200, message="Project Details Added Successfully")


# Get Project Details API
async def get_project_details(db: Session):
    cursor = db.cursor()
    query = """SELECT * FROM project_details"""
    
    try:
        cursor.execute(query)

        # Fetch column names
        key = [col[0] for col in cursor.description]

        # Fetch all rows
        rows = cursor.fetchall()

        # If no rows are found
        if not rows:
            return Status(status=False, status_code=404, message="No project details found")

        # Create a list of dictionaries, mapping column names to row values
        project_details = [dict(zip(key, value)) for value in rows]

        return Response(
            content=json.dumps({
                "status": True,
                "status_code": 200,
                "message": "Project details fetched successfully",
                "data": project_details
            }, indent=4, default=str),
            media_type='application/json'
        )

    except Exception as e:
        return Status(status=False, status_code=500, message=f"Failed to fetch project details: {str(e)}")


# Update Project Details API
async def update_project_details(db: Session, project_id: int, project: schemas.ProjectUpdate):
    project_name = project.project_name
    project_description = project.project_description
    start_date = project.start_date
    end_date = project.end_date
    status = project.status

    cursor = db.cursor()
    check_query = """SELECT * FROM project_details WHERE project_id = %s"""
    cursor.execute(check_query, (project_id,))
    existing_project = cursor.fetchone()

    if not existing_project:
        return Status1(status=False, status_code=404, message="Project not found")

    try:
        query = """UPDATE electrictree_db.project_details SET project_name = %s, project_description = %s, start_date = %s, end_date = %s, status = %s WHERE project_id = %s"""
        cursor.execute(query, (project_name, project_description, start_date, end_date, status, project_id))
        db.commit()

        return Status1(status=True, status_code=200, message="Project details updated successfully")
    
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Failed to update project details: {str(e)}")


# Delete Project Details API
async def delete_project_details(db: Session, project_id: int):
    cursor = db.cursor()
    check_query = """SELECT * FROM project_details WHERE project_id = %s"""
    cursor.execute(check_query, (project_id,))
    existing_project = cursor.fetchone()

    if not existing_project:
        return Status1(status=False, status_code=404, message="Project not found")

    try:
        query = """DELETE FROM electrictree_db.project_details WHERE project_id = %s"""
        cursor.execute(query, (project_id,))
        db.commit()

        return Status1(status=True, status_code=200, message="Project details deleted successfully")
    
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Failed to delete project details: {str(e)}")


# Api for product and stock details

# This api for creating product details. 
async def create_product_details(db:Session, product:schemas.ProductCreate):
    product_name = product.product_name
    description = product.description
    price = product.price

    if not product_name or not description or not price:
        return Status1(status=False, status_code=400, message="Please fill the required details")
    
    try:
        cursor = db.cursor()
        query = """INSERT INTO product_details (product_name, description, price) VALUES (%s,%s,%s)"""
        cursor.execute(query, (product_name, description, price))
        db.commit()
        return Status1(status=True, status_code=200, message="Product details added successfully")
    
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Error: {str(e)}")


# This api for creating stock details. 
async def create_stock_details(db: Session, stock: schemas.StockCreate):
    product_name = stock.product_name
    stock_quantity = stock.stock_quantity

    if not product_name or not stock_quantity:
        return Status1(status=False, status_code=400, message="Please fill in the required details")
    
    try:
        cursor = db.cursor()
        fetch_query = """SELECT product_id FROM product_details WHERE product_name = %s"""
        cursor.execute(fetch_query, (product_name,))
        result = cursor.fetchone()

        if not result:
            return Status1(status=False, status_code=404, message="Product not found")

        product_id = result[0]

        insert_query = """INSERT INTO stock_details (product_id, stock_quantity, product_name) VALUES (%s, %s, %s)"""
        cursor.execute(insert_query, (product_id, stock_quantity, product_name))
        db.commit()
        return Status1(status=True, status_code=200, message="Stock details added successfully")

    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Error: {str(e)}")


# This api for listing product details. 
async def get_product_details(db:Session):
    try:
        cursor = db.cursor()
        query = """SELECT * FROM product_details"""
        cursor.execute(query)
        key = [col[0] for col in cursor.description]

        rows = cursor.fetchall()
        product_details = [dict(zip(key, value)) for value in rows]

        return Response(
            content=json.dumps({
                "status": True,
                "status_code": 200,
                "message": "Product details fetched successfully",
                "data": product_details
            }, indent=4, default=str),
            media_type='application/json'
        )

    except Exception as e:
        return Status(status=False, status_code=500, message=f"Failed to fetch product details: {str(e)}")


# This api for listing stock details. 


async def get_stock_details(db:Session):
    try:
        cursor = db.cursor()
        query = """SELECT * FROM stock_details"""
        cursor.execute(query)
        key = [col[0] for col in cursor.description]

        rows = cursor.fetchall()
        stock_details = [dict(zip(key, value)) for value in rows]

        return Response(
            content=json.dumps({
                "status": True,
                "status_code": 200,
                "message": "Stock details fetched successfully",
                "data": stock_details
            }, indent=4, default=str),
            media_type='application/json'
        )

    except Exception as e:
        return Status(status=False, status_code=500, message=f"Failed to fetch stock details: {str(e)}")


# This api for updating product details. 
async def update_product_details(db: Session, product_id: int, product: schemas.ProductUpdate):
    product_name = product.product_name
    description = product.description
    price = product.price

    try:
        cursor = db.cursor()
        query = """UPDATE product_details SET product_name = %s, description = %s, price = %s WHERE product_id = %s"""
        cursor.execute(query, (product_name, description, price, product_id))
        db.commit()

        return Status1(status=True, status_code=200, message="Product details updated successfully")

    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Error: {str(e)}")


# This api for updating stock details. 
async def update_stock_details(db: Session, stock_id: int, stock: schemas.StockUpdate):
    product_name = stock.product_name
    stock_quantity = stock.stock_quantity

    if not product_name or not stock_quantity:
        return Status1(status=False, status_code=400, message="Please fill in the required details")

    cursor = db.cursor()
    
    try:
        fetch_query = """SELECT product_id FROM product_details WHERE product_name = %s"""
        cursor.execute(fetch_query, (product_name,))
        result = cursor.fetchone()

        if not result:
            return Status1(status=False, status_code=404, message="Product not found")
        
        product_id = result[0]

        update_query = """UPDATE stock_details SET product_name = %s, stock_quantity = %s, product_id = %s WHERE stock_id = %s"""
        cursor.execute(update_query, (product_name, stock_quantity, product_id, stock_id))
        db.commit()
        
        return Status1(status=True, status_code=200, message="Stock details updated successfully")
        
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Error: {str(e)}")


# This api for deleting product details.
async def delete_product_details(db: Session, product_id: int):
    try:
        cursor = db.cursor()
        query = """DELETE FROM product_details WHERE product_id = %s"""
        cursor.execute(query, (product_id,))
        db.commit()

        return Status1(status=True, status_code=200, message="Product details deleted successfully")
    
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Error: {str(e)}")

# This api for deleting stock details.
async def delete_stock_details(db: Session, stock_id: int):
    try:
        cursor = db.cursor()
        query = """DELETE FROM stock_details WHERE stock_id = %s"""
        cursor.execute(query, (stock_id,))
        db.commit()

        return Status1(status=True, status_code=200, message="Stock details deleted successfully")
    
    except Exception as e:
        return Status1(status=False, status_code=500, message=f"Error: {str(e)}")












