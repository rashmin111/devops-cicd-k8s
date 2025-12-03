from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def root():
    msg = os.getenv("WELCOME_MSG", "Hello DevOps World!")
    return {"message": msg}

@app.get("/health")
def health():
    return {"status": "ok"}
