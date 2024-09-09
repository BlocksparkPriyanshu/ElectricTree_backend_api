from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.responses import JSONResponse
from database import get_db
from typing import Optional
from sqlalchemy.orm import Session 
import schemas,crud
from dotenv import load_dotenv
from schemas import Buyer, Supplier
from fastapi import FastAPI, HTTPException, Depends
import schemas
from crud import buyer_signup, supplier_signup, verify_email
import os

from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from datetime import datetime, timedelta, timezone
from passlib.context import CryptContext


app = FastAPI()

# @app.post("/api/buyer_signup", status_code=status.HTTP_201_CREATED)
# def buyer_signup(buyer: BuyerCreate, db: MySQLConnection = Depends(get_db)):
#     existing_buyer = get_buyer_by_email(db, buyer.contact_email)
#     if existing_buyer:
#         raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already exists")
    
#     create_buyer(db, buyer)
#     return JSONResponse(content={"message": "Buyer SignUp Successfully"})

# @app.post("/api/supplier_signup", status_code=status.HTTP_201_CREATED)
# def supplier_signup(supplier: SupplierCreate, db: MySQLConnection = Depends(get_db)):
#     existing_supplier = get_supplier_by_email(db, supplier.contact_email)
#     if existing_supplier:
#         raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already exists")
    
#     create_supplier(db, supplier)
#     return JSONResponse(content={"message": "Supplier SignUp Successfully"})



@app.post("/api/buyer_login",tags=["Login Api For Buyer And Supplier."],description="""
    This endpoint allows a buyer to log in by providing their `buyer_name` and `buyer_password`.
    If the credentials are correct, a JWT token is returned which can be used for subsequent authenticated requests.

    Parameters:
    - db (Session): A database session used to query the buyer's details.
    - buyer_name: The name of the buyer.
    - buyer_password: The password associated with the buyer's account.

    Returns:
    - A JSON object containing a success message and a JWT token if the login is successful.
    - An HTTP 400 error if required fields are missing.
    - An HTTP 401 error if the credentials are invalid.
    """)
async def buyer_login(buyer: schemas.BuyerLogin, db: Session = Depends(get_db)):
    return await crud.buyer_login(db, buyer)


    
@app.post("/api/supplier_login",tags=["Login Api For Buyer And Supplier."],description="""
    This endpoint allows a supplier to log in by providing their `supplier_name` and `supplier_password`.
    
    **Parameters:**
    - `db (Session)`: A database session used to query the supplier's details.
    - `supplier_name`: The name of the supplier. This is a required field.
    - `supplier_password`: The password associated with the supplier's account. This is a required field.

    **Process:**
    - The API verifies that both `supplier_name` and `supplier_password` are provided. If either field is missing, it     returns an HTTP 400 error with a message indicating that the required details need to be filled.
    - The API then checks the provided credentials against the `electrictree_db.supplier_details` database table.
    - If a matching record is found, a JWT token is generated using the `supplier_id` and returned to the supplier.
    - If no matching record is found, the API returns an HTTP 401 error indicating that the supplier name or password is invalid.

    **Returns:**
    - On success: A JSON object containing a success message and a JWT token that can be used for subsequent        authenticated requests.
    - On failure: An HTTP 400 error if required fields are missing, or an HTTP 401 error if the credentials are invalid.
    """)
async def supplier_login(supplier: schemas.SupplierLogin, db: Session = Depends(get_db)):
    return await crud.supplier_login(db, supplier)


    
@app.post("/api/buyer_signup",tags=["Implement email verification using Firebase integration for user registration."], description="""
    This API endpoint handles the registration process for buyers. It integrates Firebase to create a new user in Firebase, sends a verification email, and stores buyer details in the database.
    
    **Parameters:**
    - `buyer_name`: The name of the buyer. This is a required field.
    - `buyer_password`: The password for the buyer's account. This is a required field.
    - `contact_email`: The buyer's email address where the verification link will be sent. This is a required field.

    **Process:**
    - First, the API checks if the provided email already exists in the `buyer_details` table. If it does, an HTTP 400 error is returned with a message indicating that the email already exists in the database.
    - If the email does not exist in the database, the API attempts to create a new user in Firebase using the provided email.
    - If the user creation in Firebase is successful, a verification email is sent to the provided email address using the Firebase Email Verification module.
    - If the verification email is sent successfully, the buyer's details are stored in the `buyer_details` table in the database.
    - The API returns a success message on successful registration and email verification initiation.

    **Returns:**
    - On success: A JSON object with a message indicating that the buyer has been successfully registered and the verification email has been sent.
    - On failure: An HTTP 400 error if the email already exists or the `oobCode` is invalid, or an HTTP 500 error if there is an issue with Firebase or sending the verification email.
    """)
async def create_buyer(buyer: Buyer):
    return await buyer_signup(buyer)



@app.post("/api/supplier_signup",tags=["Implement email verification using Firebase integration for user registration."], description="""
    This API endpoint handles the registration process for suppliers. It follows the same process as the buyer signup but is tailored for suppliers.
    
    **Parameters:**
    - `supplier_name`: The name of the supplier. This is a required field.
    - `supplier_password`: The password for the supplier's account. This is a required field.
    - `contact_email`: The supplier's email address where the verification link will be sent. This is a required field.

    **Process:**
    - First, the API checks if the provided email already exists in the `supplier_details` table. If it does, an HTTP 400 error is returned with a message indicating that the email already exists in the database.
    - If the email does not exist in the database, the API attempts to create a new user in Firebase using the provided email.
    - If the user creation in Firebase is successful, a verification email is sent to the provided email address using the Firebase Email Verification module.
    - If the verification email is sent successfully, the supplier's details are stored in the `supplier_details` table in the database.
    - The API returns a success message on successful registration and email verification initiation.

    **Returns:**
    - On success: A JSON object with a message indicating that the supplier has been successfully registered and the verification email has been sent.
    - On failure: An HTTP 400 error if the email already exists or the `oobCode` is invalid, or an HTTP 500 error if there is an issue with Firebase or sending the verification email.
    """)
async def create_supplier(supplier: Supplier):
    return await supplier_signup(supplier)



@app.get("/api/verify",tags=["Implement email verification using Firebase integration for user registration."], description="""
    This API endpoint validates the email verification token (oobCode) received by the user. It interacts with Firebase to confirm the verification status.

    **Parameters:**
    - `oobCode`: The one-time out-of-band code sent to the user's email for verification. This is a required field.

    **Process:**
    - The API checks if the `oobCode` is provided. If not, it returns an HTTP 400 error with a message indicating that the `oobCode` is required.
    - The API then sends the `oobCode` to Firebase for verification.
    - If the `oobCode` is valid, the API returns a success message indicating that the email has been verified successfully.
    - If the `oobCode` is invalid or expired, the API returns an HTTP 400 error with the corresponding error message.

    **Returns:**
    - On success: A JSON object with a message indicating that the email has been verified successfully.
    - On failure: An HTTP 400 error with a message explaining why the verification failed.
    """)
async def verify(oobCode: str):
    return await verify_email(oobCode)



@app.post("/api/project_details",tags=["This api for project details."],description="""
    This API allows users to create a new project by providing essential details such as the project name, description, start date, end date, and status.

    **Parameters:**
    -  db (Session): The database session used to execute the query.
          
    - **project (ProjectCreate):** A Pydantic model containing:
        - `project_name`: The name of the project.
        - `project_description`: A brief description of the project.
        - `start_date`: The start date of the project.
        - `end_date`: The expected end date of the project.
        - `status`: The current status of the project (e.g., "In Progress", "Completed").

    **Returns:**
    - **200 OK:** If the project is successfully created.
    - **400 Bad Request:** If required details are missing.
    """)
async def create_project_details(project: schemas.ProjectCreate, db: Session = Depends(get_db)):
    return await crud.create_project_details(db,project)



@app.get("/api/project_details",tags=["This api for project details."],description="""This API retrieves all project records from the database, allowing users to view a list of all projects along with their details.

    **Returns:**
    - **200 OK:** A list of project details.
    """)
async def get_project_details(db:Session = Depends(get_db)):
    return await crud.get_project_details(db)



@app.put("/api/project_details/{project_id}",tags=["This api for project details."],description="""
    This API updates an existing project's details, including the project name, description, start date, end date, and status.

    **Parameters:**
    - **db (Session):** The database session used to execute the query.
    - **project_id (int):** The ID of the project to update.
    - **project (ProjectUpdate):** A Pydantic model containing the fields to update:
        - `project_name`: The name of the project.
        - `project_description`: A brief description of the project.
        - `start_date`: The start date of the project.
        - `end_date`: The expected end date of the project.
        - `status`: The current status of the project (e.g., "In Progress", "Completed").

    **Returns:**
    - **200 OK:** If the project details are successfully updated.
    """)
async def update_project_details(project_id: int, project: schemas.ProjectUpdate, db: Session = Depends(get_db)):
    return await crud.update_project_details(db, project_id, project)



@app.delete("/api/project_details/{delete_details}",tags=["This api for project details."],description="""
    This API deletes a specific project record from the database.

    **Parameters:**
    - **db (Session):** The database session used to execute the query.
    - **project_id (int):** The ID of the project to delete.

    **Returns:**
    - **200 OK:** If the project is successfully deleted.""")
async def delete_project_details(delete_details: int, db: Session = Depends(get_db)):
    return await crud.delete_project_details(db, delete_details)



@app.post("/api/product_details",tags=["This api for product details."],description= """
    This API allows users to create a new product by providing essential details such as the product name, description, and price.

    **Parameters:**
    - **product (ProductCreate):** A Pydantic model containing:
        - `product_name`: The name of the product.
        - `description`: A brief description of the product.
        - `price`: The price of the product.

    **Returns:**
    - **200 OK:** If the product is successfully created.
    - **400 Bad Request:** If required details are missing.
    """)
async def create_product_details(product: schemas.ProductCreate, db: Session = Depends(get_db)):
    return await crud.create_product_details(db,product)



@app.post("/api/stock_details",tags=["This api for stock details."],description="""
    This API allows users to create a new stock entry for a product by providing the product name and the quantity of stock available.

    **Parameters:**
    - **stock (StockCreate):** A Pydantic model containing:
        - `product_name`: The name of the product.
        - `stock_quantity`: The quantity of stock available.

    **Returns:**
    - **200 OK:** If the stock details are successfully created.
    - **400 Bad Request:** If required details are missing.
    - **404 Not Found:** If the product name does not exist in the product details table.""")
async def create_stock_details(product: schemas.StockCreate, db: Session = Depends(get_db)):
    return await crud.create_stock_details(db,product)



@app.get("/api/product_details",tags=["This api for product details."],description= """

    This API retrieves all product records from the database, allowing users to view a list of all products along with their details.

    **Returns:**
    - **200 OK:** A list of product details.
    """)
async def get_product_details(db:Session = Depends(get_db)):
    return await crud.get_product_details(db)



@app.get("/api/stock_details",tags=["This api for stock details."],description="""

    This API retrieves all stock records from the database, allowing users to view the current stock quantities for all products.

    **Returns:**
    - **200 OK:** A list of stock details.""")
async def get_stock_details(db:Session = Depends(get_db)):
    return await crud.get_stock_details(db)



@app.put("/api/product_details/{product_id}",tags=["This api for product details."],description="""

    This API updates an existing product's details, including the product name, description, and price.

    **Parameters:**
    - **product_id (int):** The ID of the product to update.
    - **product (ProductUpdate):** A Pydantic model containing the fields to update:
        - `product_name`: The name of the product.
        - `description`: A brief description of the product.
        - `price`: The price of the product.

    **Returns:**
    - **200 OK:** If the product details are successfully updated.
    """)
async def update_product_details(product_id: int, product: schemas.ProductUpdate, db: Session = Depends(get_db)):
    return await crud.update_product_details(db, product_id, product)



@app.put("/api/stock_details/{stock_id}",tags=["This api for stock details."],description="""
         
    This API updates an existing stock record, including the product name and the quantity of stock available.

    **Parameters:**
    - **stock_id (int):** The ID of the stock record to update.
    - **stock (StockUpdate):** A Pydantic model containing the fields to update:
        - `product_name`: The name of the product.
        - `stock_quantity`: The quantity of stock available.

    **Returns:**
    - **200 OK:** If the stock details are successfully updated.
    - **400 Bad Request:** If required details are missing.
    - **404 Not Found:** If the product name does not exist in the product details table.
""")
async def update_stock_details(stock_id: int, stock: schemas.StockUpdate, db: Session = Depends(get_db)):
    return await crud.update_stock_details(db, stock_id, stock)



@app.delete("/api/product_details/{delete_details}",tags=["This api for product details."],description="""

    This API deletes a specific product record from the database.

    **Parameters:**
    - **product_id (int):** The ID of the product to delete.

    **Returns:**
    - **200 OK:** If the product is successfully deleted.
    """)
async def delete_product_details(delete_details: int, db: Session = Depends(get_db)):
    return await crud.delete_product_details(db, delete_details)



@app.delete("/api/stock_details/{delete_details}",tags=["This api for stock details."],description="""

    This API deletes a specific stock record from the database using the stock ID.

    **Parameters:**
    - **stock_id (int):** The ID of the stock record to delete.

    **Returns:**
    - **200 OK:** If the stock details are successfully deleted.""")
async def delete_stock_details(delete_details: int, db: Session = Depends(get_db)):
    return await crud.delete_stock_details(db, delete_details)

load_dotenv()

SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta 
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


@app.post("/api/user_login", response_model=schemas.Token,tags=["Login Api for User."], description="""

    This API allows users to log in by providing their username and password. If the provided credentials are valid, an access token is generated that can be used to authenticate future requests.

    **Parameters:**
    - **form_data (OAuth2PasswordRequestForm):** The credentials for logging in:
        - `username`: The username of the user.
        - `password`: The password of the user.
    -**db (Session):** The database session to use for querying the user.

    **Returns:**
    - **200 OK:** If the login is successful, returns an access token.
        - `access_token`: The generated token that can be used for authentication in subsequent requests.
        - `token_type`: The type of token (usually "bearer").
        
    - **401 Unauthorized:** If the username or password is incorrect, raises an HTTP exception with a message indicating the failure.""")
def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = crud.get_user_by_username(db=db, username=form_data.username, password=form_data.password)

    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect username or password")
   
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(data={"sub": user['username']}, expires_delta=access_token_expires)
    return {"access_token": access_token, "token_type": "bearer"}


