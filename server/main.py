from flask import Flask, request
from flask_pymongo import PyMongo, ObjectId
import json
from flask_cors import CORS
import datetime

app = Flask(__name__)
CORS(app)

with open('creds.json') as f:
    credentials = json.loads(f.read())
app.config["MONGO_URI"] = credentials["mongouri"]
mongo = PyMongo(app)

@app.route("/")
def home():
    return "Nečum na cizí IP adresy"


@app.route("/getdoctordata", methods = ['POST'])
def getdoctordata():
    uuid = request.form["uuid"]
    patient = mongo.db.patients.find_one_or_404({"uuid": uuid})

    y = []
    for i in patient["receipts"]:
        rec = mongo.db.recipe.find_one_or_404({"_id": ObjectId(i)})
        rec.pop("_id", None)
        y.append(rec)

    x = []
    for i in patient["medicalreports"]:
        rec = mongo.db.medicalReport.find_one_or_404({"_id": ObjectId(i)})
        rec.pop("_id", None)
        x.append(rec)

    return {
        "uuid": patient["uuid"],
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
        "medicalReports": x,
    }


@app.route("/getuserdata", methods = ['POST'])
def getuserdata():
    username = request.form["username"]
    password = request.form["password"]

    doctor = mongo.db.doctors.find_one_or_404({"username": username, "password": password})

    return {
        "firstName": doctor["firstName"],
        "secondName": doctor["secondName"],
        }


@app.route("/newrecipe", methods = ['POST'])
def newrecipe():
    collection = mongo.db.recipe

    username = request.form["username"]
    patientChipNumber = request.form["uuid"]
    medicationType = request.form["obsah"]
    
    doctor = mongo.db.doctors.find_one_or_404({"username": username})

    collection.insert_one(
    {    
        "patientChipNumber": patientChipNumber,
        "medicationType": medicationType,
        "doctorID": "646381c7558c89f7b426395c", #musim udelat to blby id
    }
    )
    return None


@app.route("/newmedicalreport", methods = ['POST'])
def newmedicalreport():
    collection = mongo.db.medicalReport

    username = request.form["username"]
    patientChipNumber = request.form["uuid"]
    diagnose = request.form["obsah"]
    reportDate = request.form["date"]

    doctor = mongo.db.doctors.find_one_or_404({"username": username})
    x = datetime.datetime.now().date()

    collection.insert_one(
    {    
        "patientChipNumber": patientChipNumber,
        "reportDate": reportDate,
        "diagnose": diagnose,
        "doctorID": "646381c7558c89f7b426395c", #musim udelat to blby id
    }
    )
    return None


@app.route("/registration", methods = ['POST'])
def registration():
    collection = mongo.db.doctors

    username = request.form["username"]
    password = request.form["password1"]
    password2 = request.form["password2"]
    firstName = request.form["firstname"]
    secondName = request.form["secondname"]

    if password == password2:
        collection.insert_one(
        {    
            "username": username,
            "secondName": secondName,
            "firstName": firstName,
            "password": password,
        }
        )
    else:
        return "tady mas redscreen"
    
    return None


@app.route("/medicalreports", methods = ['POST'])
def medicalreports():
    uuid = request.form["uuid"]

    patient = mongo.db.patients.find_one_or_404({"uuid": uuid})

    x = []
    for i in patient["medicalreports"]:
        rec = mongo.db.medicalReport.find_one_or_404({"_id": ObjectId(i)})
        rec.pop("_id", None)
        x.append(rec)

    print(x)
    return None


@app.route("/recipes", methods = ['POST'])
def recipes():
    uuid = request.form["uuid"]

    patient = mongo.db.patients.find_one_or_404({"uuid": uuid})

    y = []
    for i in patient["receipts"]:
        rec = mongo.db.recipe.find_one_or_404({"_id": ObjectId(i)})
        rec.pop("_id", None)
        y.append(rec)

    print(y)
    return None