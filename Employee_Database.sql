-- Create & Use the Employee_Database
-- CREATE DATABASE Employee_Database;
USE Employee_Database;

-- Drop existing tables, procedures, and views if they exist
DROP TABLE IF EXISTS Employee, Works, Company, Manages;
DROP PROCEDURE IF EXISTS AddEmployee;
DROP VIEW IF EXISTS Employee_Report;

-- Create the Employee table
CREATE TABLE Employee (
    Employee_Name VARCHAR(255) NOT NULL,
    Street VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    PRIMARY KEY (Employee_Name)
);


-- Insert initial data into the Employee table
INSERT INTO Employee (Employee_Name, Street, City) VALUES
('John Doe', '123 Main St', 'Las Vegas'),
('Jane Doe', '456 Elm St', 'Los Angeles'), 
('Jim Doe', '789 Oak St', 'San Francisco'),
('Jilla Doe', '101 Pine St', 'San Diego'),
('Jacka Doe', '112 Birch St', 'San Jose'),
('Jennya Doe', '131 Maple St', 'Sacramento'),
('Jerry Doe', '415 Walnut St', 'Fresno'),
('Judy Doe', '161 Cherry St', 'Long Beach'),
('Joe Doe', '171 Pineapple St', 'Oakland'),
('Jill Doe', '181 Banana St', 'Bakersfield'),
('Jack Doe', '191 Orange St', 'Anaheim'),
('Jenny Doe', '202 Grape St', 'Santa Ana'),
('Foridul Islam', '456 Some St', 'Dhaka'),
('Shoton Ahamed', '123 Main St', 'Dhaka');

-- Add the Salary column separately using ALTER TABLE
ALTER TABLE Employee
ADD COLUMN Salary DECIMAL(10, 2);

UPDATE Employee SET Salary = CASE
    WHEN Employee_Name = 'John Doe' THEN 75000
    WHEN Employee_Name = 'Jane Doe' THEN 85000
    WHEN Employee_Name = 'Jim Doe' THEN 90000
    WHEN Employee_Name = 'Jilla Doe' THEN 78000
    WHEN Employee_Name = 'Jacka Doe' THEN 82000
    WHEN Employee_Name = 'Jennya Doe' THEN 89000
    WHEN Employee_Name = 'Jerry Doe' THEN 76000
    WHEN Employee_Name = 'Judy Doe' THEN 81000
    WHEN Employee_Name = 'Joe Doe' THEN 84000
    WHEN Employee_Name = 'Jill Doe' THEN 88000
    WHEN Employee_Name = 'Jack Doe' THEN 83000
    WHEN Employee_Name = 'Jenny Doe' THEN 86000
    WHEN Employee_Name = 'Foridul Islam' THEN 100000
    WHEN Employee_Name = 'Shoton Ahamed' THEN 2500000
END;

-- Create the Works table
CREATE TABLE Works (
    Employee_Name VARCHAR(255) NOT NULL,
    Company_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Employee_Name, Company_Name)
);

-- Insert initial data into the Works table
INSERT INTO Works (Employee_Name, Company_Name) VALUES
('John Doe', 'Google'),
('Jane Doe', 'Facebook'),
('Jim Doe', 'Amazon'),
('Jilla Doe', 'Microsoft'),
('Jacka Doe', 'Apple'),
('Jennya Doe', 'Oracle'),
('Jerry Doe', 'IBM'),
('Judy Doe', 'Intel'),
('Joe Doe', 'Cisco'),
('Jill Doe', 'HP'),
('Jack Doe', 'Dell'),
('Jenny Doe', 'Nvidia'),
('Foridul Islam', 'Trust Bank'),
('Shoton Ahamed', 'Trust Bank');

-- Create the Company table
CREATE TABLE Company (
    Company_Name VARCHAR(255) NOT NULL,
    City VARCHAR(255) NOT NULL,
    PRIMARY KEY (Company_Name)
);

-- Insert initial data into the Company table
INSERT INTO Company (Company_Name, City) VALUES
('Google', 'Mountain View'),
('Facebook', 'Menlo Park'),
('Amazon', 'Seattle'),
('Microsoft', 'Redmond'),
('Apple', 'Cupertino'),
('Oracle', 'Redwood City'),
('IBM', 'Armonk'),
('Intel', 'Santa Clara'),
('Cisco', 'San Jose'),
('HP', 'Palo Alto'),
('Dell', 'Round Rock'),
('Nvidia', 'Santa Clara'),
('Trust Bank', 'Dhaka');

-- Create the Manages table
CREATE TABLE Manages (
    Employee_Name VARCHAR(255) NOT NULL,
    Manager_Name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Employee_Name)
);

-- Insert initial data into the Manages table
INSERT INTO Manages (Employee_Name, Manager_Name) VALUES
('John Doe', 'Jane Doe'),
('Jane Doe', 'Jim Doe'),
('Jim Doe', 'Jilla Doe'),
('Jilla Doe', 'Jacka Doe'),
('Jacka Doe', 'Jennya Doe'),
('Jennya Doe', 'Jerry Doe'),
('Jerry Doe', 'Judy Doe'),
('Judy Doe', 'Joe Doe'),
('Joe Doe', 'Jill Doe'),
('Jill Doe', 'Jack Doe'),
('Jack Doe', 'Jenny Doe'),
('Foridul Islam', 'Shoton Ahamed');

SELECT * FROM Employee;
SELECT * FROM Works;
SELECT * FROM Company;
SELECT * FROM Manages;

/* ----------------------------------------------------------- Query Section --------------------------------------------------------*/

-- Q1. Find the names, cities, and salaries of all employees who work for Trust Bank
SELECT E.Employee_Name, E.City, E.Salary
FROM Employee E
JOIN Works W ON E.Employee_Name = W.Employee_Name
JOIN Company C ON W.Company_Name = C.Company_Name
WHERE C.Company_Name = 'Trust Bank';

-- Q2. Find the total salaries of each company
SELECT C.Company_Name, SUM(E.Salary) AS Total_Salaries
FROM Works W
JOIN Company C ON W.Company_Name = C.Company_Name
JOIN Employee E ON W.Employee_Name = E.Employee_Name
GROUP BY C.Company_Name;

-- Q3. Stored procedure to add an employee correctly using parameters
DELIMITER //

CREATE PROCEDURE AddEmployee(
    IN P_Employee_Name VARCHAR(255),
    IN P_Street VARCHAR(255),
    IN P_City VARCHAR(255),
    IN P_Salary DECIMAL(10, 2),
    IN P_Company_Name VARCHAR(255)
)
BEGIN
    INSERT INTO Employee (Employee_Name, Street, City) 
    VALUES (P_Employee_Name, P_Street, p_City);
    
    INSERT INTO Works (Employee_Name, Company_Name) 
    VALUES (P_Employee_Name, P_Company_Name);
END //

DELIMITER ;

-- Verify the stored procedure existence
SELECT * FROM information_schema.routines WHERE BINARY routine_name = 'AddEmployee' AND routine_type = 'PROCEDURE';
SHOW PROCEDURE STATUS WHERE Db = 'Employee_Database' AND Name = 'AddEmployee';

-- Example call to the stored procedure
CALL AddEmployee('New Employee', '789 New St', 'New York', 70000, 'Google');

-- Q4. Create a view for the Trust Bank employee report
CREATE VIEW Employee_Report AS
SELECT E.Employee_Name, E.City, E.Salary
FROM Employee E
JOIN Works W ON E.Employee_Name = W.Employee_Name
JOIN Company C ON W.Company_Name = C.Company_Name
WHERE C.Company_Name = 'Trust Bank';

-- Verify the view existence
SHOW FULL TABLES IN Employee_Database WHERE Table_Type = 'VIEW';

-- Select from the view to check the result
SELECT * FROM Employee_Report;