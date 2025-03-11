-- Create & Use the Employee_Database
-- CREATE DATABASE Car_Insurance;
USE Car_Insurance;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Person, Car, Accident, Owns, Participated;

-- Create the Person table
CREATE TABLE Person(
    Driver_ID INT PRIMARY KEY,
    P_Name VARCHAR(255) NOT NULL,
    P_Address VARCHAR(255) NOT NULL
);

-- Insert data into Person table
INSERT INTO Person VALUES
(12345, 'Abul Kalam', '123 Main St'),
(23454, 'Jane Doe', '456 Elm St'),
(34586, 'Jim Doe', '789 Oak St'),
(45679, 'John Doe', '100 Maple St'),
(45678, 'Jilla Doe', '101 Pine St'),
(56789, 'Jacka Doe', '112 Birch St'),
(67890, 'Jennya Doe', '131 Maple St'),
(78901, 'Jerry Doe', '415 Walnut St'),
(89012, 'Judy Doe', '161 Cherry St'),
(90123, 'Joe Doe', '171 Pineapple St'),
(18786, 'Jill Doe', '181 Banana St'),
(64536, 'Jack Doe', '191 Orange St'),
(18758, 'Jenny Doe', '202 Grape St');

-- Create the Car table
CREATE TABLE Car(
    License INT PRIMARY KEY,
    Model VARCHAR(255) NOT NULL,
    C_Year INT NOT NULL
);

-- Insert data into Car table
INSERT INTO Car VALUES
(12345, 'Toyota', 2010),
(23454, 'Honda', 2011),
(34586, 'Ford', 2012),
(45679, 'Land Rover', 2013),
(45678, 'Chevrolet', 2013),
(56789, 'Nissan', 2014),
(67890, 'BMW', 2015),
(78901, 'Mercedes', 2016),
(89012, 'Audi', 2017),
(90123, 'Lexus', 2018),
(18786, 'Tesla', 2019),
(64536, 'Volkswagen', 2020),
(18758, 'Subaru', 2021);

-- Create the Accident table
CREATE TABLE Accident(
    Report_Number INT PRIMARY KEY,
    A_Date DATE NOT NULL,
    A_Location VARCHAR(255) NOT NULL
);

-- Insert data into Accident table
INSERT INTO Accident VALUES
(12345, '2021-01-01', 'Las Vegas'),
(23454, '2021-02-02', 'Los Angeles'),
(34586, '2021-03-03', 'San Francisco'),
(45679, '2021-03-03', 'Dhaka'),
(45678, '2021-04-04', 'San Diego'),
(56789, '2021-05-05', 'San Jose'),
(67890, '2021-06-06', 'Sacramento'),
(78901, '2021-07-07', 'Fresno'),
(89012, '2021-08-08', 'Long Beach'),
(90123, '2021-09-09', 'Oakland'),
(18786, '2021-10-10', 'Bakersfield'),
(64536, '2021-11-11', 'Anaheim'),
(18758, '2021-12-12', 'Santa Ana');

-- Create the Owns table
CREATE TABLE Owns(
    Driver_ID INT,
    License INT,
    PRIMARY KEY (Driver_ID, License)
);

-- Insert data into Owns table
INSERT INTO Owns VALUES
(12345, 12345),
(23454, 23454),
(34586, 34586),
(45679, 45679),
(45678, 45678),
(56789, 56789),
(67890, 67890),
(78901, 78901),
(89012, 89012),
(90123, 90123),
(18786, 18786),
(64536, 64536),
(18758, 18758);

-- Create the Participated table
CREATE TABLE Participated(
    Driver_ID INT,
    Car VARCHAR(255),
    Report_Number INT,
    Damage_Amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Driver_ID, Car, Report_Number)
);

-- Insert data into Participated table
INSERT INTO Participated VALUES
(12345, 'Toyota', 12345, 1000.00),
(23454, 'Honda', 23454, 2000.00),
(34586, 'Ford', 34586, 3000.00),
(45679, 'Land Rover', 34586, 4000.00),
(45678, 'Chevrolet', 45678, 4000.00),
(56789, 'Nissan', 56789, 5000.00),
(67890, 'BMW', 67890, 6000.00),
(78901, 'Mercedes', 78901, 7000.00),
(89012, 'Audi', 89012, 8000.00),
(90123, 'Lexus', 90123, 9000.00),
(18786, 'Tesla', 18786, 10000.00),
(64536, 'Volkswagen', 64536, 11000.00),
(18758, 'Subaru', 18758, 12000.00);

/* --------------------------------------------------------- Query Section --------------------------------------------------------- */

-- Q1. Add a new accident to the database (assume any values for required attributes)
INSERT INTO Accident VALUES
('88888', '2025-03-12', 'Dhaka');

-- Q2. Delete the Toyota belonging to "Abul Kalam" from the database
DELETE FROM Car WHERE License = 78901;

-- Q3. Find the total number of people who owned cars that were involved in accidents 2021-03-03
SELECT COUNT(DISTINCT Owns.Driver_ID) AS Total_People
FROM Owns
JOIN Participated ON Owns.Driver_ID = Participated.Driver_ID
WHERE Participated.Report_Number = 34586;

-- Q4. Update the damage amount for the car with license number 23454 in the accident with report number 23454 to 2500.00
UPDATE Participated
SET Damage_Amount = 2500.00
WHERE Car = 'Honda' AND Report_Number = 23454;

-- Select data from Person table
SELECT * FROM Person;

-- Select data from Car table
SELECT * FROM Car;

-- Select data from Accident table
SELECT * FROM Accident;

-- Select data from Owns table
SELECT * FROM Owns;

-- Select data from Participated table
SELECT * FROM Participated;