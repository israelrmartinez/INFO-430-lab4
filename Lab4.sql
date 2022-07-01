

-- Get Customer ID and Product ID Procedure
CREATE PROCEDURE getCustomerID
 @Cust_FName VARCHAR(100),
 @Cust_LName VARCHAR(100),
 @BD DATE,
 @Cust_ID INT OUTPUT
AS
IF @Cust_FName IS NULL OR @Cust_LName IS NULL OR @BD IS NULL
  BEGIN
  PRINT 'Customer’s first name, last name, and birthdate cannot be null'
  RAISERROR (15600,-1,-1, 'getCustomerID');
  RETURN
END
SET @Cust_ID = (SELECT CustomerID
FROM tblCUSTOMER
WHERE Fname = @Cust_FName AND Lname = @Cust_LName AND BirthDate = @BD)
GO
CREATE PROCEDURE getProductID
  @PD_Name VARCHAR(100),
  @PD_ID INT OUTPUT
AS
IF @PD_Name IS NULL
  BEGIN
  PRINT 'Product name cannot be null'
  RAISERROR (15600,-1,-1, 'getProductID');
  RETURN
END
SET @PD_ID = (SELECT ProductID
FROM tblPRODUCT
WHERE ProductName = @PD_Name)
GO
--Populating Cart table
CREATE PROCEDURE group9insertCart
  @Fname varchar(40),
  @Lname varchar(40),
  @DOB date,
  @Pname varchar(40),
  @Qty INT,
  @D date
AS
DECLARE @P_ID INT, @C_ID INT
EXEC getCustomerID
@Cust_FName = @FName,
@Cust_LName = @LName,
@BD = @DOB,
@Cust_ID = @C_ID OUTPUT
-- check for NULL
IF @C_ID IS NULL
  BEGIN
  PRINT 'There is an error with C_ID being NULL'
  RAISERROR ('C_ID cannot be null', 11,1)
  RETURN
END
EXEC getProductID
@PD_Name = @PName,
@PD_ID = @P_ID OUTPUT
-- check for NULL
IF @P_ID IS NULL
  BEGIN
  PRINT 'There is an error with P_ID being NULL'
  RAISERROR ('P_ID cannot be null', 11,1)
  RETURN
END
BEGIN TRAN G1
INSERT INTO tblCART
  (CustomerID, ProductID,CDate,Quantity)
VALUES
  (@C_ID, @P_ID, @D, @Qty)
IF @@ERROR <> 0
  BEGIN
  PRINT 'There is an error up ahead'
  ROLLBACK TRAN G1
END
ELSE
COMMIT TRAN G1
--Processing CART
DECLARE @Fname varchar(40), @Lname varchar(40), @DOB date
DECLARE @C_ID INT
EXEC getCustomerID
@Cust_FName = @Fname,
@Cust_LName = @Lname,
@BD = @DOB,
@Cust_ID = @C_ID OUTPUT
SELECT *
FROM tblCART
WHERE CustomerID = @C_ID
 
 
--Explicit transaction
 
DECLARE @Orderdate date, @Quantity INT, @P_ID INT
GO
Begin Tran T1
Begin Tran T2
SELECT ProductID, SUM(Quantity)
FROM tblCART
WHERE CustomerID = @C_ID
GROUP BY ProductID
COMMIT TRAN T2
Begin Tran T3
INSERT INTO tblORDER
  (CustomerID, OrderDate)
VALUES(@C_ID, @Orderdate)
SET @OrderID = SCOPE_IDENTITY()
SET @P_ID = (SELECT P.ProductID
FROM tblPRODUCT P
  JOIN tblCART C ON C.ProductID = P.ProductID
WHERE C.CustomerID = @C_ID)
INSERT INTO tblORDER_PRODUCT
  (OrderID, ProductID, Quantity)
VALUES(@OrderID, @P_ID, @Quantity)
COMMIT TRAN T3
BEGIN TRAN T4
DELETE
      FROM tblCART
      WHERE CustID = @C_ID
COMMIT TRAN T4
IF @@TRANCOUNT <> 1
  ROLLBACK TRAN T1
ELSE
  COMMIT TRAN T1
 
 
 
 
 
 
 


