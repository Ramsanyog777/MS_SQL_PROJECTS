use AdventureWorks2012;
--Problem Statement:

--How to get details about customers by querying a database?

--Topics:
--In this project, you will work on downloading a database and restoring it on the
--server. You will then query the database to get customer details like name, phone
--number, email ID, sales made in a particular month, increase in month-on-month
--sales and even the total sales made to a particular customer.

--Highlights:
--Table basics and data types
--Various SQL operators
--Various SQL functions

--Tasks To Be Performed:
--1. Download the AdventureWorks database from the following location and
--restore it in your server:
--Location:
--https://github.com/Microsoft/sql-server-samples/releases/tag/adventurewor
--ks
--File Name: AdventureWorks2012.bak
--AdventureWorks is a sample database shipped with SQL Server and it can
--be downloaded from the GitHub site. AdventureWorks has replaced
--Northwind and Pubs sample databases that were available in SQL Server
--in 2005. Microsoft keeps updating the sample database as it releases new
--versions.

--2. Restore Backup:
--Follow the below steps to restore a backup of your database using SQL
--Server Management Studio:
--a. Open SQL Server Management Studio and connect to the target
--SQL Server instance
--b. Right-click on the Databases Node and select Restore Database
--c. Select Device and click on the ellipsis (...)

--d. In the dialog box, select Backup devices, click on Add, navigate to
--the database backup in the file system of the server, select the
--backup, and click on OK.
--e. If needed, change the target location for the data and log files in the
--Files pane
--Note: It is a best practice to place the data and log files on different
--drives.
--f. Now, click on OK

--This will initiate the database restore. After it completes, you will have the
--AdventureWorks database installed on your SQL Server instance


--3. Perform the following with help of the above database:

--a. Get all the details from the person table including email ID, phone
--number and phone number type
SELECT 
    p.BusinessEntityID,
    p.PersonType,
    p.Title,
    p.FirstName,
    p.MiddleName,
    p.LastName,
    p.Suffix,
    p.EmailPromotion,
    ea.EmailAddress,
    pp.PhoneNumber,
    pnt.Name AS PhoneNumberType,
    p.rowguid,
    p.ModifiedDate
FROM Person.Person AS p
LEFT JOIN Person.EmailAddress AS ea
    ON p.BusinessEntityID = ea.BusinessEntityID
LEFT JOIN Person.PersonPhone AS pp
    ON p.BusinessEntityID = pp.BusinessEntityID
LEFT JOIN Person.PhoneNumberType AS pnt
    ON pp.PhoneNumberTypeID = pnt.PhoneNumberTypeID;




select * from [Person].[EmailAddress];
select * from [Person].[Person]
select * from [Person].[PersonPhone]
select * from [Person].[PhoneNumberType]

--b. Get the details of the sales header order made in May 2011
SELECT *
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011
  AND MONTH(OrderDate) = 5;

--c. Get the details of the sales details order made in the month of May
--2011
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.CustomerID,
    soh.SalesPersonID,
    soh.SubTotal,
    soh.TaxAmt,
    soh.Freight,
    soh.TotalDue,
    sod.SalesOrderDetailID,
    sod.ProductID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.LineTotal
FROM Sales.SalesOrderHeader AS soh
JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.OrderDate >= '2011-05-01'
  AND soh.OrderDate <  '2011-06-01';

select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail


--d. Get the total sales made in May 2011
select sum(TotalDue) as Total_sales from Sales.SalesOrderHeader
WHERE OrderDate >= '2011-05-01'
  AND OrderDate <  '2011-06-01';

--e.Get the total sales made in the year 2011 by month order by
--increasing sales
SELECT 
    YEAR(OrderDate)  AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalDue)    AS TotalSales
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011
GROUP BY 
    YEAR(OrderDate),
    MONTH(OrderDate)
ORDER BY 
    TotalSales ASC;   


--f. Get the total sales made to the customer with FirstName='Gustavo'
--and LastName ='Achong'SELECT 
    p.FirstName,
    p.LastName,
    SUM(soh.TotalDue) AS TotalSalesToCustomer
FROM Person.Person AS p
JOIN Sales.Customer AS c
    ON p.BusinessEntityID = c.PersonID          -- link person to customer
JOIN Sales.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID           -- link customer to orders
WHERE p.FirstName = 'Gustavo'
  AND p.LastName  = 'Achong'
GROUP BY 
    p.FirstName,
    p.LastName;


select * from [Person].[Address];
select * from [Person].[AddressType]