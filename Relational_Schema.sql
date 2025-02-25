-- CREATE DATABASE Relational_Schema;
USE Relational_Schema;

-- Drop tables if they already exist
DROP TABLE IF EXISTS Employee, Books, Loan;

-- Create the Employee table
CREATE TABLE Employee(
    Empno INT PRIMARY KEY,
    E_Name VARCHAR(255) NOT NULL,
    Office VARCHAR(255) NOT NULL,
    Age INT NOT NULL
);

-- Insert data into Employee table
INSERT INTO Employee VALUES
(12435, 'John Doe', 'New York', 30),
(23454, 'Jane Doe', 'Las Vegas', 40),
(64536, 'Foridul Islam', 'Dhaka', 22),
(18786, 'Emran Ismail', 'Mirpur', 22),
(23489, 'Jane Doe', 'Los Angeles', 40),
(34586, 'Jim Doe', 'San Francisco', 50),
(45678, 'Jilla Doe', 'San Diego', 60),
(56789, 'Jacka Doe', 'San Jose', 70),
(67890, 'Jennya Doe', 'Sacramento', 80),
(78901, 'Jerry Doe', 'Fresno', 90),
(89012, 'Judy Doe', 'Long Beach', 100),
(90123, 'Joe Doe', 'Oakland', 110),
(18758, 'Hridoy Khan', 'Naraongonj', 22);

-- Create the Books table
CREATE TABLE Books(
    ISBN INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    Publisher VARCHAR(255) NOT NULL
);

-- Insert data into Books table
INSERT INTO Books VALUES
(12435, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner'),
(23454, 'The Life Time', 'Shoton Ahamed', 'T. Egerton, Whitehall'),
(08879, 'Mathemathics', 'Esrat Jahan', 'T. Egerton, Whitehall'),
(89712, 'The Alchemist', 'Paulo Dybala', 'T. Egerton, Whitehall'),
(20983, 'The Da Vinci Code', 'Dan Brown', 'T. Egerton, Whitehall'),
(34567, 'The Catcher in the Rye', 'J.D. Salinger', 'T. Egerton, Whitehall'),
(45675, 'Pride and Prejudice', 'Jane Austen', 'T. Egerton, Whitehall'),
(45674, 'Pride and Prejudice', 'Jane Austen', 'T. Egerton, Whitehall'),
(23489, 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott & Co.'),
(34586, '1984', 'George Orwell', 'Secker & Warburg'),
(56789, 'The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown and Company'),
(67890, 'The Hobbit', 'J.R.R. Tolkien', 'Allen & Unwin'),
(78901, 'Fahrenheit 451', 'Ray Bradbury', 'Ballantine Books'),
(89012, 'Moby-Dick', 'Herman Melville', 'Richard Bentley'),
(90123, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Allen & Unwin'),
(10111, 'Animal Farm', 'George Orwell', 'Secker & Warburg'),
(11111, 'Brave New World', 'Aldous Huxley', 'Chatto & Windus'),
(12111, 'The Grapes of Wrath', 'John Steinbeck', 'The Viking Press');

-- Create the Loan table
CREATE TABLE Loan(
    Empno INT,
    ISBN INT NOT NULL,
    L_Data DATE NOT NULL,
    PRIMARY KEY (Empno, ISBN)
);

-- Insert data into Loan table
INSERT INTO Loan VALUES
(12435, 12435, '2025-02-24'),
(23454, 23454, '2025-02-25'),
(34586, 34586, '2025-02-26'),
(45678, 45674, '2025-02-27'),
(56789, 56789, '2025-02-28'),
(67890, 67890, '2025-03-01'),
(78901, 78901, '2025-03-02'),
(89012, 89012, '2025-03-03'),
(90123, 90123, '2025-03-04'),
(34586, 10111, '2025-03-05'),
(23454, 11111, '2025-03-06'),
(12435, 12111, '2025-03-07'),
(23454, 12435, '2025-03-08'),
(18786, 12435, '2025-03-09'),
(64536, 12435, '2025-03-10'),
(45678, 23454, '2025-03-11'),
(12435, 23454, '2025-03-12'),
(34586, 23454, '2025-03-14'),
(56789, 23454, '2025-03-16'),
(67890, 23454, '2025-03-17'),
(78901, 23454, '2025-03-18'),
(89012, 23454, '2025-03-19'),
(90123, 23454, '2025-03-20'),
(12435, 45674, '2025-03-12'),
(34586, 45674, '2025-03-14'),
(56789, 45674, '2025-03-16'),
(67890, 45674, '2025-03-17'),
(78901, 45674, '2025-03-18'),
(89012, 45674, '2025-03-19'),
(90123, 45674, '2025-03-20'),
(90123, 08879, '2025-03-21'),
(90123, 89712, '2025-03-22'),
(90123, 20983, '2025-03-23'),
(90123, 34567, '2025-04-02'),
(18758, 23454, '2025-04-03'),
(18758, 08879, '2025-04-04'),
(18758, 89712, '2025-04-05'),
(18758, 20983, '2025-04-06'),
(18758, 34567, '2025-04-07'),
(18758, 45675, '2025-04-08'),
(18758, 45674, '2025-04-09');

SELECT * FROM Employee;
SELECT * FROM Books;
SELECT * FROM Loan;

/* --------------------------------------------------------- Query Section --------------------------------------------------------- */

-- Query to find employees who have borrowed books published by Scribner
SELECT DISTINCT E.E_Name
FROM Employee E
JOIN Loan L ON E.Empno = L.Empno
JOIN Books B ON L.ISBN = B.ISBN
WHERE B.Publisher = 'Scribner';

-- Query to find employees who have borrowed all books published by T. Egerton, Whitehall
SELECT E.E_Name
FROM Employee E
JOIN Loan L ON E.Empno = L.Empno
JOIN Books B ON L.ISBN = B.ISBN
WHERE B.Publisher = 'T. Egerton, Whitehall'
GROUP BY E.E_Name
HAVING COUNT(DISTINCT B.ISBN) = (SELECT COUNT(*)
FROM Books
WHERE Publisher = 'T. Egerton, Whitehall');

-- Query to find employees who have borrowed more than five books from each publisher
SELECT E.E_Name, B.Publisher
FROM Employee E
JOIN Loan L ON E.Empno = L.Empno
JOIN Books B ON L.ISBN = B.ISBN
GROUP BY B.Publisher, E.E_Name
HAVING COUNT(L.ISBN) > 5;