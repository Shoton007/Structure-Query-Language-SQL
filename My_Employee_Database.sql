-- Create database & use it
-- CREATE DATABASE My_Employee_Database;
USE My_Employee_Database;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Employee, Works, Company, Manager;

-- Create the Employee table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(255) NOT NULL,
    Street VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL
);

-- Insert initial data into the Employee table
INSERT INTO Employee VALUES
(12345, 'John Doe', '123 Main St', 'Las Vegas'),
(23454, 'Jane Doe', '456 Elm St', 'Los Angeles'),
(34586, 'Jim Doe', '789 Oak St', 'San Francisco'),
(45679, 'Jilla Doe', '101 Pine St', 'San Diego'),
(45678, 'Jacka Doe', '112 Birch St', 'San Jose'),
(56789, 'Jennya Doe', '131 Maple St', 'Sacramento'),
(67890, 'Jerry Doe', '415 Walnut St', 'Fresno'),
(78901, 'Judy Doe', '161 Cherry St', 'Long Beach'),
(89012, 'Joe Doe', '171 Pineapple St', 'Oakland'),
(90123, 'Jill Doe', '181 Banana St', 'Bakersfield'),
(18786, 'Jack Doe', '191 Orange St', 'Anaheim'),
(64536, 'Jenny Doe', '202 Grape St', 'Santa Ana'),
(18758, 'Shoton Ahamed', '202 Well St', 'Dhaka'),
(18759, 'Foridul Islam', '202 Not St', 'Dhaka');

-- Create the Works table
CREATE TABLE Works (
    Employee_ID INT NOT NULL,
    Company_Name VARCHAR(255) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Employee_ID)
);

-- Insert data into Works table
INSERT INTO Works VALUES
(12345, 'Google', 75000.00),
(23454, 'Facebook', 85000.00),
(34586, 'Amazon', 90000.00),
(45679, 'Apple', 78000.00),
(45678, 'Microsoft', 82000.00),
(56789, 'Netflix', 89000.00),
(67890, 'Twitter', 76000.00),
(78901, 'LinkedIn', 81000.00),
(89012, 'Uber', 84000.00),
(90123, 'Lyft', 88000.00),
(18786, 'Airbnb', 83000.00),
(64536, 'Dropbox', 86000.00),
(18758, 'Google', 100000.00),
(18759, 'Facebook', 2500000.00);

-- Create the Company table
CREATE TABLE Company (
    Company_Name VARCHAR(255) PRIMARY KEY,
    City VARCHAR(255) NOT NULL
);

-- Insert data into Company table
INSERT INTO Company VALUES
('Google', 'Mountain View'),
('Facebook', 'Menlo Park'),
('Amazon', 'Seattle'),
('Apple', 'Cupertino'),
('Microsoft', 'Redmond'),
('Netflix', 'Los Gatos'),
('Twitter', 'San Francisco'),
('LinkedIn', 'Sunnyvale'),
('Uber', 'San Francisco'),
('Lyft', 'San Francisco'),
('Airbnb', 'San Francisco'),
('Dropbox', 'San Francisco');

-- Create the Manager table
CREATE TABLE Manager (
    Employee_ID INT PRIMARY KEY,
    Manager_Name VARCHAR(255) NOT NULL
);

-- Insert data into Manager table
INSERT INTO Manager VALUES
(12345, 'John Doe'),
(23454, 'Jane Doe'),
(34586, 'Jim Doe'),
(45679, 'Jilla Doe'),
(45678, 'Jacka Doe'),
(56789, 'Jennya Doe'),
(67890, 'Jerry Doe'),
(78901, 'Judy Doe'),
(89012, 'Joe Doe'),
(90123, 'Jill Doe'),
(18786, 'Jack Doe'),
(64536, 'Jenny Doe');

-- Display the tables
SELECT * FROM Employee;
SELECT * FROM Works;
SELECT * FROM Company;
SELECT * FROM Manager;

/* --------------------------------------------------------- Query Section --------------------------------------------------------- */

-- Q1. Find the company that has the most employees.
SELECT Company_Name, COUNT(Employee_ID) AS Employee_Count
FROM Works
GROUP BY Company_Name
ORDER BY Employee_Count DESC
LIMIT 1;

-- Q2. Find the average salaries at each company.
SELECT Company_Name, AVG(Salary) AS Average_Salary
FROM Works
GROUP BY Company_Name;

-- Q3. Find all employees who live in Dhaka City, but their company is not in Dhaka.
SELECT E.Employee_Name, E.City, C.City AS Company_City
FROM Employee AS E
JOIN Works AS W ON E.Employee_ID = W.Employee_ID
JOIN Company AS C ON W.Company_Name = C.Company_Name
WHERE E.City = 'Dhaka' AND C.City != 'Dhaka';