-- 
-- Problem Statement: Property Dealership Database Management
--
-- Create database named propertydealers
-- Create tables with the following structures:
-- Branch(branchno, street, city, postcode)
-- Staff(Staffno, fname, lname, position, Sex, DOB, salary, branchno)
-- PropertyforRent(propertyNo, street, city, postcode, Type, rooms, rent, ownerno, staffno, branchno)
-- Client(CUID, fName, lName, Rent)
-- PrivateOwner(OUID, fName, lName, address)
-- Insert data as shown in the above tables
-- Update the lname of the staff with staffno. 106 to 'Shinde'
-- Delete the branch with postcode '411041'
-- List the employees who have at least 2 'A's in their name
-- List the maximum salary from each branch of the staff members from highest to lowest
-- Find the clients who have also owners
-- Find the owners who are not clients
-- Find the owners who have 'C' as the third alphabet in their name
--

-- Create Database
CREATE DATABASE propertydealers;
USE propertydealers;

-- Create Tables
CREATE TABLE Branch (
    branchno INT PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50),
    postcode VARCHAR(10)
);

CREATE TABLE Staff (
    staffno INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    position VARCHAR(50),
    sex CHAR(1),
    DOB DATE,
    salary DECIMAL(10, 2),
    branchno INT,
    FOREIGN KEY (branchno) REFERENCES Branch(branchno)
);

CREATE TABLE PropertyforRent (
    propertyNo INT PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50),
    postcode VARCHAR(10),
    type VARCHAR(20),
    rooms INT,
    rent DECIMAL(10, 2),
    ownerno INT,
    staffno INT,
    branchno INT,
    FOREIGN KEY (staffno) REFERENCES Staff(staffno),
    FOREIGN KEY (branchno) REFERENCES Branch(branchno)
);

CREATE TABLE Client (
    CUID INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    rent DECIMAL(10, 2)
);

CREATE TABLE PrivateOwner (
    OUID INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    address VARCHAR(100)
);

-- Insert Sample Data
INSERT INTO Branch VALUES (1, 'Main St', 'CityA', '411041');
INSERT INTO Branch VALUES (2, 'Park Ave', 'CityB', '411042');

INSERT INTO Staff VALUES (101, 'John', 'Doe', 'Manager', 'M', '1985-06-15', 50000, 1);
INSERT INTO Staff VALUES (102, 'Jane', 'Smith', 'Agent', 'F', '1990-08-20', 45000, 2);
INSERT INTO Staff VALUES (106, 'Robert', 'Brown', 'Agent', 'M', '1988-12-10', 47000, 1);

INSERT INTO PropertyforRent VALUES (1, 'Broadway', 'CityA', '411041', 'Apartment', 3, 1200, 1, 101, 1);

INSERT INTO Client VALUES (201, 'Alice', 'Johnson', 1000);
INSERT INTO Client VALUES (202, 'Bob', 'Brown', 1500);

INSERT INTO PrivateOwner VALUES (301, 'Chris', 'Carter', '123 Elm St');
INSERT INTO PrivateOwner VALUES (302, 'Alice', 'Johnson', '456 Maple St');

-- Update the lname of the staff with staffno = 106 to 'Shinde'
UPDATE Staff
SET lname = 'Shinde'
WHERE staffno = 106;

-- Delete the Branch with postcode = '411041'
DELETE FROM Branch
WHERE postcode = '411041';

-- List Employees who have at least 2 'A's in their name
SELECT *
FROM Staff
WHERE fname LIKE '%A%A%' OR lname LIKE '%A%A%';

-- List the Maximum Salary from Each Branch of the Staff Members, Ordered from Highest to Lowest
SELECT branchno, MAX(salary) AS max_salary
FROM Staff
GROUP BY branchno
ORDER BY max_salary DESC;

-- Find Clients who are also Owners
SELECT c.fname, c.lname
FROM Client c
JOIN PrivateOwner o ON c.fname = o.fname AND c.lname = o.lname;

-- Find Owners who are not Clients
SELECT o.fname, o.lname
FROM PrivateOwner o
LEFT JOIN Client c ON o.fname = c.fname AND o.lname = c.lname
WHERE c.CUID IS NULL;

-- Find Owners Who Have 'C' as the Third Alphabet in Their Name
SELECT *
FROM PrivateOwner
WHERE fname LIKE '__C%';
