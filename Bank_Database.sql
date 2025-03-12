-- Create database & use it
-- CREATE DATABASE Bank_database;
USE Bank_database;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Branch, Customer, Loan, Borrower, Account, Depositor;

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

-- Create the Loan table
CREATE TABLE Loan(
    Loan_Number INT PRIMARY KEY,
    Branch_Name VARCHAR(255) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);

-- Insert data into Loan table
INSERT INTO Loan VALUES
(12345, 'New York', 10000.00),
(23454, 'Los Angeles', 20000.00),
(34586, 'San Francisco', 30000.00),
(45679, 'San Diego', 40000.00),
(45678, 'San Jose', 50000.00),
(56789, 'Sacramento', 60000.00),
(67890, 'Fresno', 70000.00),
(78901, 'Long Beach', 80000.00),
(89012, 'Oakland', 90000.00),
(90123, 'Bakersfield', 100000.00),
(18786, 'Anaheim', 110000.00),
(64536, 'Santa Ana', 120000.00);

-- Create the Borrower table
CREATE TABLE Borrower(
    Customer_Name VARCHAR(255) NOT NULL,
    Loan_Number INT NOT NULL,
    PRIMARY KEY (Customer_Name, Loan_Number)
);

-- Insert data into Borrower table
INSERT INTO Borrower VALUES
('John Doe', 12345),
('Jane Doe', 23454),
('Jim Doe', 34586),
('Jilla Doe', 45679),
('Jacka Doe', 45678),
('Jennya Doe', 56789),
('Jerry Doe', 67890),
('Joe Doe', 89012),
('Jill Doe', 90123),
('Jack Doe', 18786);

-- Create the Account table
CREATE TABLE Account(
    Account_Number INT PRIMARY KEY,
    Branch_Name VARCHAR(255) NOT NULL,
    Balance DECIMAL(10,2) NOT NULL
);

-- Insert data into Account table
INSERT INTO Account VALUES
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
    Customer_Name VARCHAR(255) NOT NULL,
    Account_Number INT NOT NULL,
    PRIMARY KEY (Customer_Name, Account_Number)
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

-- Select everything from the Branch table
SELECT * FROM Branch;

-- Select everything from the Borrower table
SELECT * FROM Borrower;

-- Select everything from the Account table
SELECT * FROM Account;

-- Select everything from the Depositor table
SELECT * FROM Depositor;

/* --------------------------------------------------------- Query Section --------------------------------------------------------- */

-- Q1. Find the all customers who have account but no loan from the bank.

SELECT Customer_Name
FROM Customer
WHERE Customer_Name NOT IN (
    SELECT Customer_Name
    FROM Borrower
)
UNION ALL
SELECT 'No Results Found'
WHERE NOT EXISTS (
    SELECT Customer_Name
    FROM Customer
    WHERE Customer_Name NOT IN (
        SELECT Customer_Name
        FROM Borrower
    )
);

-- Q2. Delete all loon amount between 10000/- and 20000/-

DELETE FROM Loan WHERE Amount BETWEEN 10000 AND 20000;

-- Select everything from the Loan table
SELECT * FROM Loan;

-- Q3. Add a record in the database using a form.

INSERT INTO Customer VALUES
('Foridul Islam', '123 Main St', 'Las Vegas'),
('Shoton Ahamed', '456 Elm St', 'Los Angeles');

-- Select everything from the Customer table
SELECT * FROM Customer;

-- Q4. Display your result of query (Q1) on a report.

SELECT Customer_Name
FROM Customer
WHERE Customer_Name NOT IN (
    SELECT Customer_Name
    FROM Borrower
);