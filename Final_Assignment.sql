USE kelly; 

-- Task 1: Create Tables

-- Create Books table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    CopiesAvailable INT DEFAULT 1 CHECK (CopiesAvailable >= 0)
);
-- Create Members table
-- CREATE TABLE Members (
--     MemberID INT PRIMARY KEY,
--     MemberName VARCHAR(100) NOT NULL,
--     Email VARCHAR(100) UNIQUE NOT NULL
-- );

-- Create Loans table
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);


-- Task 2: Populate Sample Data

-- Insert sample Books
INSERT INTO Books (BookID, Title, Author, Genre, CopiesAvailable) VALUES
(1, '1984', 'George Orwell', 'Fiction', 3),
(2, 'The Pragmatic Programmer', 'Andy Hunt', 'Programming', 5),
(3, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 2),
(4, 'Sapiens', 'Yuval Noah Harari', 'History', 4),
(5, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 0);

-- Insert sample Members
INSERT INTO Members (MemberID, MemberName, Email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com'),
(3, 'Catherine Green', 'catherine@example.com'),
(4, 'David Brown', 'david@example.com');

-- Insert sample Loans (at least 2 with ReturnDate = NULL)
INSERT INTO Loans (LoanID, MemberID, BookID, LoanDate, ReturnDate) VALUES
(1, 1, 1, '2024-06-01', '2024-06-10'),
(2, 2, 1, '2024-06-11', '2024-06-18'),
(3, 3, 2, '2024-06-15', NULL),
(4, 4, 2, '2024-06-17', NULL),
(5, 1, 3, '2024-06-18', '2024-06-25'),
(6, 2, 3, '2024-06-20', NULL),
(7, 3, 4, '2024-06-22', NULL),
(8, 4, 5, '2024-06-23', NULL),
(9, 1, 2, '2024-06-24', NULL),
(10, 1, 4, '2024-06-25', NULL);


-- Task 3: SQL Operations

-- INSERT a new book
INSERT INTO Books (BookID, Title, Author, Genre, CopiesAvailable)
VALUES (6, 'Clean Code', 'Robert C. Martin', 'Programming', 6);

-- SELECT all books
SELECT * FROM Books;

-- UPDATE CopiesAvailable
UPDATE Books SET CopiesAvailable = 10 WHERE BookID = 2;

-- DELETE a book
DELETE FROM Books WHERE BookID = 5;

-- COUNT total loans per book
SELECT BookID, COUNT(*) AS TotalLoans
FROM Loans
GROUP BY BookID;

-- AVG CopiesAvailable
SELECT AVG(CopiesAvailable) AS AvgCopies
FROM Books;

-- MemberName and COUNT of currently loaned books (ReturnDate IS NULL)
SELECT M.MemberName, COUNT(*) AS ActiveLoans
FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
WHERE L.ReturnDate IS NULL
GROUP BY M.MemberName;

-- Members with more than 2 active loans
SELECT M.MemberName, COUNT(*) AS ActiveLoans
FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
WHERE L.ReturnDate IS NULL
GROUP BY M.MemberName
HAVING COUNT(*) > 2;


