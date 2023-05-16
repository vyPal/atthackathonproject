-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'ourdatabase'
)
CREATE DATABASE medicaldb
GO

-- Tohle uz jsem psal ja (SPRATEK) to nad tim mi napsalo rozsireni

-- lide tables
CREATE TABLE patients
(
    uuid VARCHAR(11),
    pinCode INT(4),
    secondName VARCHAR(20),
    firstName VARCHAR(20),
    birthDate DATE,
    insuredNumber INT(10) PRIMARY KEY,
    zpCode INT(3),
    -- basic information
    bloodType VARCHAR(2),
    alergiesList VARCHAR(4096),
    longTermIllnesList VARCHAR(4096),
    injuriesList VARCHAR(4096),
    -- documents
    recipeList VARCHAR(4096),
    medicalReportList VARCHAR(4096),
    medicationList VARCHAR(4096)
)

CREATE TABLE doctors
(
    doctorID INT(4) PRIMARY KEY,
    userName VARCHAR(10),
    pasword VARCHAR(10),
    secondName VARCHAR(20),
    firstName VARCHAR(20),
    phoneNumber INT(9)
)

-- recipe tables
CREATE TABLE recipe
(
    recipeID INT(4) PRIMARY KEY,
    patientInsuredNumber INT(10),
    medicationType VARCHAR(50), -- bude z tabulky medication
    doctorID INT(4) -- bude z tabulky doctors
)
-- end of recipe tables

CREATE TABLE medicalReport
(
    medicalReportID INT(4) PRIMARY KEY,
    patientInsuredNumber INT(10),
    reportDate DATE,
    diagnose VARCHAR(4096)
)