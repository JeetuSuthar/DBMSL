-- Create the database and use it
CREATE DATABASE Student;
USE Student;

-- Create Result table to store the grade category for each student
CREATE TABLE Result (
    Roll_No INT,               -- Unique identifier for each student
    Name VARCHAR(10),          -- Student's name
    Class VARCHAR(20)          -- Category (Distinction, First Class, etc.)
);

-- Create Stud_Marks table to store students' total marks
CREATE TABLE Stud_Marks (
    Roll_No INT,               -- Unique identifier for each student
    Name VARCHAR(10),          -- Student's name
    Total_marks INT            -- Total marks scored by the student
);

-- Insert sample data into Stud_Marks
INSERT INTO Stud_Marks VALUES (3102023, 'Ritesh', 1499);
INSERT INTO Stud_Marks VALUES (3102025, 'Pratiksha', 959);
INSERT INTO Stud_Marks VALUES (3102053, 'Piyush', 850);
INSERT INTO Stud_Marks VALUES (3202010, 'Aniket', 1500);
INSERT INTO Stud_Marks VALUES (3102099, 'Sanket', 800);

-- Create the stored procedure for grading
DELIMITER //

CREATE PROCEDURE proc_Grade(IN r INT, IN n VARCHAR(50))
BEGIN
    DECLARE tm INT;  -- Variable to store the student's total marks

    -- Retrieve the total marks for the student from Stud_Marks
    SELECT Total_marks INTO tm FROM Stud_Marks WHERE Roll_No = r AND Name = n;

    -- Insert into Result based on the grade category determined by marks
    IF tm <= 1500 AND tm >= 990 THEN
        INSERT INTO Result VALUES (r, n, 'Distinction');
    ELSEIF tm <= 989 AND tm >= 900 THEN
        INSERT INTO Result VALUES (r, n, 'First Class');
    ELSEIF tm <= 899 AND tm >= 825 THEN
        INSERT INTO Result VALUES (r, n, 'Higher Second Class');
    ELSE
        INSERT INTO Result VALUES (r, n, 'Fail');
    END IF;
END //

DELIMITER ;

-- Call the stored procedure for each student to categorize them
CALL proc_Grade(3102023, 'Ritesh');
CALL proc_Grade(3102025, 'Pratiksha');
CALL proc_Grade(3102053, 'Piyush');
CALL proc_Grade(3202010, 'Aniket');
CALL proc_Grade(3102099, 'Sanket');

-- Display the results to see the categorization
SELECT * FROM Result;
