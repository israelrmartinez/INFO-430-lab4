-- Write the SQL code to create a stored procedure to find all students whose StudentID matches a 4-number pattern
-- at the beginning of their number

CREATE PROCEDURE israelmaMatchID
@StudentNum INT
AS
SELECT StudentID, StudentFName, StudentLName
FROM tblSTUDENT
WHERE SUBSTRING(CONVERT(varchar, StudentID), 1, 4) = @StudentNum
GROUP BY StudentID, StudentFName, StudentLName
GO

EXEC israelmaMatchID @StudentNum = 1040
