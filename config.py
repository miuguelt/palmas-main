import os
import secrets
#from dotenv import load_dotenv
#load_dotenv()

class Config:
    DB_USER = os.environ.get("DB_USER") #"alejandrobd"
    DB_PASSWORD = os.environ.get("DB_PASS")  
    DB_HOST = os.environ.get("DB_HOST")#"38.242.137.70" 
    raw_port = os.environ.get("DB_PORT")
    if not raw_port or raw_port == "{DB_PORT}":
        DB_PORT = "3311"
    else:
        DB_PORT = raw_port
    DB_NAME = os.environ.get("DB_NAME") 

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SECRET_KEY = secrets.token_urlsafe(24)
    print(f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@38.242.137.70:{DB_PORT}/{DB_NAME}")
    SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@38.242.137.70:{DB_PORT}/{DB_NAME}"

#Comandos para descargar en instalar todas las librerias offline
#python ñ
#pip install --no-index --find-links=librerias -r requirements.txt
