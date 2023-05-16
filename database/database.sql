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
CREATE DATABASE ourdatabase
GO

-- Tohle uz jsem psal ja (SPRATEK) to nad tim mi napsalo rozsireni
CREATE TABLE patients
(
    uuid VARCHAR(11),
    pinCode INT(4),
    secondName VARCHAR(20),
    firstName VARCHAR(20),
    birthDate DATA,
    insuredNumber INT(10) PRIMARY KEY,
    zpCode INT(3),
)

-- recipe tables
CREATE TABLE recipe
(
    recipeID INT(4) PRIMARY KEY,
    patientInsuredNumber INT(10) PRIMARY KEY,
    medicationType VARCHAR(50),
)

CREATE TABLE medication
(
    medicationName VARCHAR(50) PRIMARY KEY,
    dosage VARCHAR(5), -- RANO-POLEDNE-VECER
    amount INT(2),
)
-- end of recipe tables