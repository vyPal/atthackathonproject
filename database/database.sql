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
    secondName VARCHAR(10),
    firstName VARCHAR(10),
    birthDate DATA,
    insuredNumber INT(10) PRIMARY KEY,
    zpCode int(3),
)

