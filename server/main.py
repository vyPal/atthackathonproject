from flask import Flask, request
from flask_pymongo import PyMongo, ObjectId
import json
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

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
    mongo.db.doctors.find_one_or_404({"username": username, "password": password})
    print(uuid)
    patient = mongo.db.patients.find_one_or_404({"uuid": uuid})
    print(uuid)

    y = []
    for i in patient["receipts"]:
        print("idk")
        rec = mongo.db.recipe.find_one_or_404({"_id": ObjectId(i)})
        print("tady")
        rec.pop("_id", None)
        y.append(rec)

    x = []
    for i in patient["medicalreports"]:
        print("idk2")
        rec = mongo.db.medicalReport.find_one_or_404({"_id": ObjectId(i)})
        print("nebo tady")
        rec.pop("_id", None)
        x.append(rec)

    return {
        "ownerSecondname": patient["ownerSecondname"],
        "ownerFirstname": patient["ownerFirstname"],
        "ownerNumber": patient["ownerNumber"],
        "birthdate": patient["birthdate"],
        "AnimalType": patient["AnimalType"],
        "animalName": patient["animalName"],

        "alergies": patient["alergies"],
        "longTermIllness": patient["longTermIllnesses"],

        "injuries": patient["injuries"],
        "receipts": y,
        "medicalReports": x,;
        }