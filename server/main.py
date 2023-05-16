from flask import Flask, request
from flask_pymongo import PyMongo, ObjectId
import json

app = Flask(__name__)

with open('creds.json') as f:
    credentials = json.loads(f.read())
app.config["MONGO_URI"] = credentials["mongouri"]
mongo = PyMongo(app)

@app.route("/")
def home():
    return "Hello, World!"

@app.route("/getuserdata", methods = ['POST'])
def getuserdata():
    username = request.form["username"]
    password = request.form["password"]
    uuid = request.form["uuid"]

    doctor = mongo.db.doctors.find_one_or_404({"username": username, "password": password})
    patient = mongo.db.patients.find_one_or_404({"uuid": uuid})

    if doctor["type"] == "paramedic" or doctor["type"] == "doctor":
        return {
            "firstname": patient["firstname"],
            "secondname": patient["secondname"],
            "birthdate": patient["birthdate"],
            "insurednumber": patient["insuredNumber"],
            "zpcode": patient["zpcode"],
            "bloodtype": patient["bloodtype"],
            "alergies": patient["alergies"],
            "longtermillnesses": patient["longTermIllnesses"],
            "injuries": patient["injuries"]
        }
    
@app.route("/getuserdatawpin", methods = ['POST'])
def getuserdatawpin():
    username = request.form["username"]
    password = request.form["password"]
    uuid = request.form["uuid"]
    pin = request.form["pin"]

    doctor = mongo.db.doctors.find_one_or_404({"username": username, "password": password})
    patient = mongo.db.patients.find_one_or_404({"uuid": uuid, "pin": pin})

    y = []
    for i in patient["receipts"]:
        rec = mongo.db.recipe.find_one_or_404({"_id": ObjectId(i)})
        rec.pop("_id", None)
        y.append(rec)

    x = []
    for i in patient["medicalreports"]:
        rec = mongo.db.recipe.find_one_or_404({"_id": ObjectId(i)})
        rec.pop("_id", None)
        x.append(rec)

    if doctor["type"] == "doctor":
        return {
            "firstname": patient["firstname"],
            "secondname": patient["secondname"],
            "birthdate": patient["birthdate"],
            "insurednumber": patient["insuredNumber"],
            "zpcode": patient["zpcode"],
            "bloodtype": patient["bloodtype"],
            "alergies": patient["alergies"],
            "longtermillnesses": patient["longTermIllnesses"],
            "injuries": patient["injuries"],
            "receipts": y,
            "medicalreports": x,
            "medication": patient["medication"]
        } 
    
    if doctor["type"] == "pharmacist":
        return {
            "firstname": patient["firstname"],
            "secondname": patient["secondname"],
            "birthdate": patient["birthdate"],
            "receipts": y
        }