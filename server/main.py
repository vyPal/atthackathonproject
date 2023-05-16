from flask import Flask
from flask_pymongo import PyMongo
import random

app = Flask(__name__)

app.config["MONGO_URI"] = "mongodb://localhost:27017/myDatabase"
mongo = PyMongo(app)

@app.route("/")

def domov():
    return

@app.route("/device/assign")
def assign():
    return random.randint()

@app.route("/device/read")
