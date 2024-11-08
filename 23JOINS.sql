--SQL Queries - all types of Joins, Sub-Query and View: (Note: also, examiner can ask it without join)

--Create the tables Employee (EmpID, Ename, Salary, Contactno, City, DeptID) and 

--Department (DeptID, Dname, Location)

--1.	Display Employee Name and Department name from given entity.
--2.	Retrieve list of employees along with their department names and locations. (Using inner join or natural join)
--3.	Display all employee names, location and their department name which are matching with employee table.
--4.	Display all department names, salary, location and department names of employee. (Right Joins)
--5.	Display list of all employees and departments (Full joins)
--6.	Display all possible combinations of employees and departments (cross joins)
--7.	Retrieve parts of employees who shares the same department (Self Join)
--8.	Create simple and complex views
--9.	Update simple view 
--10.	Delete the view



-- Step 1: Create the Department and Employee Tables
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    Dname VARCHAR(50),
    Location VARCHAR(100)
);

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Ename VARCHAR(100),
    Salary DECIMAL(10, 2),
    Contactno VARCHAR(15),
    City VARCHAR(50),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Step 2: Sample Data Insertion
INSERT INTO Department (DeptID, Dname, Location) VALUES
(1, 'IT', 'New York'),
(2, 'HR', 'London'),
(3, 'Finance', 'San Francisco');

INSERT INTO Employee (EmpID, Ename, Salary, Contactno, City, DeptID) VALUES
(1, 'John Doe', 55000, '1234567890', 'New York', 1),
(2, 'Jane Smith', 60000, '0987654321', 'London', 2),
(3, 'Mike Johnson', 65000, '1122334455', 'San Francisco', 3),
(4, 'Emily Davis', 57000, '5566778899', 'New York', 1),
(5, 'Sarah Brown', 59000, '6677889900', 'London', 2);

-- Step 3: Queries

-- 1. Display Employee Name and Department Name
SELECT E.Ename, D.Dname
FROM Employee E
INNER JOIN Department D ON E.DeptID = D.DeptID;

-- 2. Retrieve list of employees along with their department names and locations
SELECT E.Ename, D.Dname, D.Location
FROM Employee E
INNER JOIN Department D ON E.DeptID = D.DeptID;

-- 3. Display all employee names, location, and their department name which are matching with employee table
SELECT E.Ename, D.Location, D.Dname
FROM Employee E
INNER JOIN Department D ON E.DeptID = D.DeptID;

-- 4. Display all department names, salary, location, and department names of employee (Right Joins)
SELECT D.Dname, E.Salary, D.Location, E.Dname AS EmpDeptName
FROM Employee E
RIGHT JOIN Department D ON E.DeptID = D.DeptID;

-- 5. Display list of all employees and departments (Full Joins)
-- MySQL doesn't support FULL JOIN directly. Use LEFT JOIN and RIGHT JOIN combined.
SELECT E.Ename, D.Dname
FROM Employee E
LEFT JOIN Department D ON E.DeptID = D.DeptID
UNION
SELECT E.Ename, D.Dname
FROM Employee E
RIGHT JOIN Department D ON E.DeptID = D.DeptID;

-- 6. Display all possible combinations of employees and departments (Cross Joins)
SELECT E.Ename, D.Dname
FROM Employee E
CROSS JOIN Department D;

-- 7. Retrieve parts of employees who share the same department (Self Join)
SELECT E1.Ename AS Employee1, E2.Ename AS Employee2
FROM Employee E1
INNER JOIN Employee E2 ON E1.DeptID = E2.DeptID
WHERE E1.EmpID <> E2.EmpID;

-- 8. Create Simple and Complex Views
-- Simple View
CREATE VIEW EmployeeView AS
SELECT EmpID, Ename, Salary, DeptID
FROM Employee;

-- Complex View
CREATE VIEW EmployeeDepartmentView AS
SELECT E.Ename, D.Dname, E.Salary
FROM Employee E
INNER JOIN Department D ON E.DeptID = D.DeptID;

-- 9. Update Simple View
UPDATE EmployeeView
SET Salary = 55000
WHERE EmpID = 1;

-- 10. Delete the View
DROP VIEW EmployeeView;
