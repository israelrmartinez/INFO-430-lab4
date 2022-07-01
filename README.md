# INFO-430-lab4

## Canvas Assignment Instructions
 
Based on the diagram presented in class, write the SQL code to conduct the following:

1) Write two stored procedures to get the required foreign key values in tblCART (GetCustomerID and GetProductID). HINT: Pass in name values only and use OUTPUT parameter for each procedure.

2) Populate tblCART with a stored procedure; parameters are going to be CustFname, CustLname, CustBirthDate, ProductName, Quantity and Date.(hint: call the two procedures created in step 1)

3) Write the SQL stored procedure to process the contents of tblCART based on a customer first name, last name and BirthDate. HINT: Your calling stored procedure will also use the GetCustomerID created in step 1.

4) Include error-handling if a parameter or variable is NULL.

5) The final INSERT statement of processing rows into tblORDER_PRODUCT needs to be in an explicit transaction.

HINT: Obtain the new OrderID by using SCOPE_IDENTITY()

6) Include nested transaction to manage the different steps as explained in lecture (remember: @@TRANCOUNT must be 1 when the final commit is issued). 