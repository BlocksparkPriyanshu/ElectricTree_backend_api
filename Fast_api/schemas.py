# models.py
from pydantic import BaseModel, EmailStr
from typing import Optional

class BuyerCreate(BaseModel):
    buyer_name: str
    buyer_password: str
    contact_email: EmailStr

class SupplierCreate(BaseModel):
    supplier_name: str
    supplier_password: str
    contact_email: EmailStr

class Buyer(BaseModel):
    buyer_name: str
    buyer_password: str
    contact_email: EmailStr

class Supplier(BaseModel):
    supplier_name: str
    supplier_password: str
    contact_email: EmailStr

class BuyerLogin(BaseModel):
    buyer_name: str
    buyer_password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class SupplierLogin(BaseModel):
    supplier_name: str
    supplier_password: str

class ProjectCreate(BaseModel):
    project_name: str
    project_description: str
    start_date: str
    end_date: Optional[str]= None
    status: str

class ProjectUpdate(BaseModel):
    project_name: str
    project_description: str
    start_date: str
    end_date: Optional[str]= None
    status: str

class ProductCreate(BaseModel):
    product_name: str
    description: str
    price: float
    
    

class StockCreate(BaseModel):
    stock_quantity : int
    product_name : str

class ProductUpdate(BaseModel):
    product_name: str
    description: str
    price: float
    

class StockUpdate(BaseModel):
    stock_quantity : int
    product_name : str
    