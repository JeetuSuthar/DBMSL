-- Create the database
CREATE DATABASE library;
USE library;

-- Create Borrower table
CREATE TABLE IF NOT EXISTS Borrower (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(20),
    DateofIssue DATE,
    NameofBook VARCHAR(20),
    Status VARCHAR(20) DEFAULT 'I'  -- Default status is 'Issued'
);

-- Create Fine table
CREATE TABLE IF NOT EXISTS Fine (
    Roll_no INT,
    ReturnDate DATE,
    Amount INT,
    FOREIGN KEY (Roll_no) REFERENCES Borrower(Roll_no)
);

-- Insert sample data into Borrower table
INSERT INTO Borrower (Roll_no, Name, DateofIssue, NameofBook, Status) VALUES
(1, 'abc', '2021-06-01', 'SEPM', 'I'),
(2, 'xyz', '2021-05-01', 'OOP', 'I'),
(3, 'pqr', '2021-06-15', 'DBMS', 'I'),
(4, 'def', '2021-06-30', 'DSA', 'I'),
(5, 'lmn', '2021-07-05', 'ADS', 'I');

-- Create stored procedure to calculate fine
DELIMITER //
CREATE PROCEDURE calc_fine_lib(IN roll INT)
BEGIN
    DECLARE v_fine INT DEFAULT 0;        -- Renamed fine_amount to v_fine
    DECLARE v_days INT;                   -- Renamed days_borrowed to v_days
    DECLARE v_issue_date DATE;            -- Renamed issue_date to v_issue_date
    
    -- Get the date of issue for the specified roll number
    SELECT DateofIssue INTO v_issue_date FROM Borrower WHERE Roll_no = roll;
    
    -- Calculate the number of days borrowed
    SET v_days = DATEDIFF(CURDATE(), v_issue_date);
    
    -- Calculate fine based on the number of days borrowed
    IF v_days > 15 AND v_days <= 30 THEN
        SET v_fine = v_days * 5;
    ELSEIF v_days > 30 THEN
        SET v_fine = (30 * 5) + ((v_days - 30) * 50);
    ELSE
        SET v_fine = 0; -- No fine if days are less than or equal to 15
    END IF;

    -- Update status to 'R' (Returned)
    UPDATE Borrower SET Status = 'R' WHERE Roll_no = roll;

    -- Insert fine amount into Fine table
    INSERT INTO Fine (Roll_no, ReturnDate, Amount) VALUES (roll, CURDATE(), v_fine);
    
END //
DELIMITER ;

-- Example of calling the procedure to calculate fine for a specific roll number
CALL calc_fine_lib(1);

-- Check the contents of Borrower and Fine tables after processing fines
SELECT * FROM Borrower;
SELECT * FROM Fine;
