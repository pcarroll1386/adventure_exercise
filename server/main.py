
from fastapi import FastAPI
import database
from models import base

base.Base.metadata.create_all(bind=database.engine)


app = FastAPI()

get_db = database.get_db()

@app.get("/")
async def root():
    return {"message": "Hello, FastAPI!"}
