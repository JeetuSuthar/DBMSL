-- Create the following tables. And Solve the following queries by SQL:
-- 1. Deposit (actno, cname, bname, amount, adate)
-- 2. Branch (bname, city)
-- 3. Customers (cname, city)
-- 4. Borrow (loanno, cname, bname, amount) 
-- Add primary key and foreign key wherever applicable.

-- Insert data into the above-created tables.

-- a. Display names of all branches located in city Bombay.
-- b. Display account no. and amount of depositors.
-- c. Update the city of customer Anil from Pune to Mumbai.
-- d. Find the number of depositors in the bank.
-- e. Calculate Min and Max amount of customers.
-- f. Create an index on the Deposit table.
-- g. Create a view on the Borrow table.

-- Solution:

-- 1. Create the Branch table
CREATE TABLE Branch (
    bname VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- 2. Create the Customers table
CREATE TABLE Customers (
    cname VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50)
);

-- 3. Create the Deposit table with foreign keys referencing Branch and Customers
CREATE TABLE Deposit (
    actno INT PRIMARY KEY,
    cname VARCHAR(50),
    bname VARCHAR(50),
    amount DECIMAL(10, 2),
    adate DATE,
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);

-- 4. Create the Borrow table with foreign keys referencing Branch and Customers
CREATE TABLE Borrow (
    loanno INT PRIMARY KEY,
    cname VARCHAR(50),
    bname VARCHAR(50),
    amount DECIMAL(10, 2),
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);

-- Insert sample data into the Branch table
INSERT INTO Branch (bname, city) VALUES
('Branch1', 'Bombay'),
('Branch2', 'Delhi'),
('Branch3', 'Bombay');

-- Insert sample data into the Customers table
INSERT INTO Customers (cname, city) VALUES
('Anil', 'Pune'),
('Sunita', 'Mumbai'),
('Raj', 'Delhi');

-- Insert sample data into the Deposit table
INSERT INTO Deposit (actno, cname, bname, amount, adate) VALUES
(101, 'Anil', 'Branch1', 15000.50, '2024-01-15'),
(102, 'Sunita', 'Branch2', 12000.00, '2024-02-10'),
(103, 'Raj', 'Branch3', 18000.75, '2024-03-05');

-- Insert sample data into the Borrow table
INSERT INTO Borrow (loanno, cname, bname, amount) VALUES
(201, 'Anil', 'Branch1', 5000.00),
(202, 'Sunita', 'Branch2', 7500.50),
(203, 'Raj', 'Branch3', 6000.00);

-- a. Display names of all branches located in city Bombay
SELECT bname
FROM Branch
WHERE city = 'Bombay';

-- b. Display account no. and amount of depositors
SELECT actno, amount
FROM Deposit;

-- c. Update the city of customer Anil from Pune to Mumbai
UPDATE Customers
SET city = 'Mumbai'
WHERE cname = 'Anil';

-- d. Find the number of depositors in the bank
SELECT COUNT(*) AS depositor_count
FROM Deposit;

-- e. Calculate Min and Max amount of customers
SELECT MIN(amount) AS min_amount, MAX(amount) AS max_amount
FROM Deposit;

-- f. Create an index on the Deposit table
CREATE INDEX idx_deposit_cname ON Deposit(cname);

-- g. Create a view on the Borrow table
CREATE VIEW Borrow_View AS
SELECT loanno, cname, bname, amount
FROM Borrow;

-- Test the Borrow_View
SELECT * FROM Borrow_View;
