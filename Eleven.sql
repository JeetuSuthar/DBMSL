--Create a db called company consist of the following tables.
--1.Emp (eno,ename, job,hiredate,salary,commission,deptno,)
--2.dept(deptno,deptname,location)
--eno is primary key in emp
---deptno is primary key in dept
--Solve Queries by SQL
--1. List the maximum salary paid to salesman
--2. List name of emp whose name start with ‘I’
--3. List details of emp who have joined before ’30-sept-81’
--4. List the emp details in the descending order of their basic salary
--5. List of no. of emp &amp; avg salary for emp in the dept no ‘20’
--6. List the avg salary, minimum salary of the emp hiredatewise for dept no ‘10’.
--7. List emp name and its department
--8. List total salary paid to each department
--9. List details of employee working in ‘Dev’ department
--10. Update salary of all employees in deptno 10 by 5 %


-- Create the Dept table first since it will be referenced by Emp
CREATE TABLE Dept (
    deptno INT PRIMARY KEY,
    deptname VARCHAR(50),
    location VARCHAR(50)
);

-- Create the Emp table with a foreign key reference to Dept
CREATE TABLE Emp (
    eno INT PRIMARY KEY,
    ename VARCHAR(50),
    job VARCHAR(50),
    hiredate DATE,
    salary DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES Dept(deptno)  -- Foreign key constraint
);

-- Insert sample data into the Dept table
INSERT INTO Dept (deptno, deptname, location) VALUES
(10, 'HR', 'New York'),
(20, 'Sales', 'Los Angeles'),
(30, 'Development', 'San Francisco');

-- Insert sample data into the Emp table
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno) VALUES
(1, 'Alice', 'Saleswoman', '1980-01-15', 70000, NULL, 20),
(2, 'Bob', 'Salesman', '1982-03-22', 75000, NULL, 20),
(3, 'Charlie', 'Developer', '1981-06-05', 90000, 5000, 30),
(4, 'Diana', 'Manager', '1979-09-30', 95000, 10000, 10),
(5, 'Eve', 'Saleswoman', '1983-12-11', 72000, NULL, 20),
(6, 'Frank', 'Salesman', '1984-04-20', 73000, NULL, 20),
(7, 'Grace', 'Developer', '1982-05-15', 88000, 4000, 30),
(8, 'Hank', 'Manager', '1985-07-30', 100000, 12000, 10),
(9, 'Ivy', 'HR Specialist', '1986-02-28', 60000, NULL, 10),
(10, 'Jack', 'Salesman', '1987-08-18', 74000, NULL, 20);

-- Now the queries with the correct table name

-- 1. List the maximum salary paid to salesman
SELECT MAX(salary) AS max_salary
FROM Emp
WHERE job = 'salesman';

-- 2. List name of emp whose name starts with ‘I’
SELECT ename
FROM Emp
WHERE ename LIKE 'I%';

-- 3. List details of emp who have joined before ‘30-sept-81’
SELECT *
FROM Emp
WHERE hiredate < '1981-09-30';

-- 4. List the emp details in the descending order of their basic salary
SELECT *
FROM Emp
ORDER BY salary DESC;

-- 5. List of no. of emp & avg salary for emp in the dept no ‘20’
SELECT COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM Emp
WHERE deptno = 20;

-- 6. List the avg salary, minimum salary of the emp hiredate wise for dept no ‘10’
SELECT hiredate, AVG(salary) AS avg_salary, MIN(salary) AS min_salary
FROM Emp
WHERE deptno = 10
GROUP BY hiredate;

-- 7. List emp name and its department
SELECT e.ename, d.deptname
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno;

-- 8. List total salary paid to each department
SELECT d.deptname, SUM(e.salary) AS total_salary
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
GROUP BY d.deptname;

-- 9. List details of employee working in ‘Dev’ department
SELECT e.*
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
WHERE d.deptname = 'Development';

-- 10. Update salary of all employees in deptno 10 by 5 %
UPDATE Emp
SET salary = salary * 1.05
WHERE deptno = 10;
