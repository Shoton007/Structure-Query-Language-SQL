-- CREATE DATABASE MyBank_Database;
USE MyBank_Database;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Branch, Customer, Loan_Account, Borrower, Savings_Account, Depositor;

-- Create the Branch table
CREATE TABLE Branch(
    Branch_Name VARCHAR(255) PRIMARY KEY,
    Branch_City VARCHAR(255) NOT NULL,
    Assets DECIMAL(10,2) NOT NULL
);

-- Insert data into Branch table
INSERT INTO Branch VALUES
('New York', 'Las Vegas', 23456.56),
('Los Angeles', 'Los Angeles', 34567.67),
('San Francisco', 'San Francisco', 45678.78),
('San Diego', 'San Diego', 56789.89),
('San Jose', 'San Jose', 67890.90),
('Sacramento', 'Sacramento', 78901.01),
('Fresno', 'Fresno', 89012.12),
('Long Beach', 'Long Beach', 90123.23),
('Oakland', 'Oakland', 12345.45),
('Bakersfield', 'Bakersfield', 23456.56),
('Anaheim', 'Anaheim', 34567.67),
('Santa Ana', 'Santa Ana', 45678.78);

-- Create the Customer table
CREATE TABLE Customer(
    Customer_Name VARCHAR(255) PRIMARY KEY,
    Customer_Street VARCHAR(255) NOT NULL,
    Customer_City VARCHAR(255) NOT NULL
);

-- Insert data into Customer table
INSERT INTO Customer VALUES
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
('Jenny Doe', '202 Grape St', 'Santa Ana');

-- Create the Loan_Account table
CREATE TABLE Loan_Account(
    Loan_Number INT PRIMARY KEY,
    Branch_Name VARCHAR(255) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);

-- Insert data into Loan_Account table
INSERT INTO Loan_Account VALUES
(12345, 'New York', 10000.00),
(23456, 'Los Angeles', 20000.00),
(34567, 'San Francisco', 30000.00),
(45678, 'San Diego', 40000.00),
(56789, 'San Jose', 50000.00),
(67890, 'Sacramento', 60000.00),
(78901, 'Fresno', 70000.00),
(89012, 'Long Beach', 80000.00),
(90123, 'Oakland', 90000.00),
(10111, 'Bakersfield', 100000.00),
(11111, 'Anaheim', 110000.00),
(12111, 'Santa Ana', 120000.00);

-- Create the Borrower table
CREATE TABLE Borrower(
    PRIMARY KEY(Customer_Name, Loan_Number),
    Customer_Name VARCHAR(255) NOT NULL,
    Loan_Number INT NOT NULL
);

-- Insert data into Borrower table
INSERT INTO Borrower VALUES
('John Doe', 12345),
('Jane Doe', 23456),
('Jim Doe', 34567),
('Jilla Doe', 45678),
('Jacka Doe', 56789),
('Jennya Doe', 67890),
('Jerry Doe', 78901),
('Judy Doe', 89012),
('Joe Doe', 90123),
('Jill Doe', 10111),
('Jack Doe', 11111),
('Jenny Doe', 12111);

-- Create the Savings_Account table
CREATE TABLE Savings_Account(
    Account_Number INT PRIMARY KEY,
    Branch_Name VARCHAR(255) NOT NULL,
    Balance DECIMAL(10,2) NOT NULL
);

-- Insert data into Savings_Account table
INSERT INTO Savings_Account VALUES
(12345, 'New York', 10000.00),
(23456, 'Los Angeles', 20000.00),
(34567, 'San Francisco', 30000.00),
(45678, 'San Diego', 40000.00),
(56789, 'San Jose', 50000.00),
(67890, 'Sacramento', 60000.00),
(78901, 'Fresno', 70000.00),
(89012, 'Long Beach', 80000.00),
(90123, 'Oakland', 90000.00),
(10111, 'Bakersfield', 100000.00),
(11111, 'Anaheim', 110000.00),
(12111, 'Santa Ana', 120000.00);

-- Create the Depositor table
CREATE TABLE Depositor(
    PRIMARY KEY(Customer_Name),
    Customer_Name VARCHAR(255) NOT NULL,
    Account_Number INT NOT NULL
);

-- Insert data into Depositor table
INSERT INTO Depositor VALUES
('John Doe', 12345),
('Jane Doe', 23456),
('Jim Doe', 34567),
('Jilla Doe', 45678),
('Jacka Doe', 56789),
('Jennya Doe', 67890),
('Jerry Doe', 78901),
('Judy Doe', 89012),
('Joe Doe', 90123),
('Jill Doe', 10111),
('Jack Doe', 11111),
('Jenny Doe', 12111);

-- Queries select data from all tables
SELECT * FROM Branch;
SELECT * FROM Customer;
SELECT * FROM Loan_Account;
SELECT * FROM Borrower;
SELECT * FROM Savings_Account;
SELECT * FROM Depositor;

/* --------------------------------------------------------- Query Section --------------------------------------------------------- */

-- Q1: Find all customers who have both a loan and a savings account
SELECT DISTINCT C.Customer_Name
FROM Customer C
JOIN Borrower B ON C.Customer_Name = B.Customer_Name
JOIN Depositor D ON C.Customer_Name = D.Customer_Name;

-- Q2: Find the average account balance at each branch
SELECT Branch_Name, AVG(Balance) AS Average_Balance
FROM Savings_Account
GROUP BY Branch_Name;

-- Q3.1: Deduct 1% service charge for customers who have both a loan and a savings account
UPDATE Savings_Account
SET Balance = Balance * 0.99
WHERE Account_Number IN (
    SELECT D.Account_Number
    FROM Depositor D
    JOIN Borrower B ON D.Customer_Name = B.Customer_Name
);

-- Verify balances after the first update
SELECT Account_Number, Balance
FROM Savings_Account;

-- Q3.2: Deduct 2% service charge for customers who only have a savings account
UPDATE Savings_Account
SET Balance = Balance * 0.98
WHERE Account_Number NOT IN (
    SELECT D.Account_Number
    FROM Depositor D
    JOIN Borrower B ON D.Customer_Name = B.Customer_Name
);

-- Verify balances after the second update
SELECT Account_Number, Balance
FROM Savings_Account;