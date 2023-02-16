USE AdventureWorks2019
GO

--1
SELECT COUNT(*)
FROM Production.Product p

--2
SELECT COUNT(p.ProductSubcategoryID)
FROM Production.Product p


--3
SELECT	p.ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product p
GROUP BY p.ProductSubcategoryID


--4
SELECT COUNT(*)
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NULL



--5
SELECT pi.ProductID, SUM(pi.Quantity) as Total_Quantity
FROM Production.ProductInventory pi
GROUP BY pi.ProductID


--6
SELECT pi.ProductID, SUM(pi.Quantity) AS TheSum
FROM Production.ProductInventory pi
WHERE pi.LocationID = 40
GROUP BY pi.ProductID
HAVING SUM(pi.Quantity) < 100

--7

SELECT pi.ProductID, pi.Shelf, SUM(pi.Quantity) AS TheSum
FROM Production.ProductInventory pi
WHERE pi.LocationID = 40
GROUP BY pi.ProductID, pi.Shelf
HAVING SUM(pi.Quantity) < 100



--8

SELECT pi.ProductID, AVG(pi.Quantity) as TheAvg
FROM Production.ProductInventory pi
WHERE pi.LocationID = 10
GROUP BY pi.ProductID




--9
SELECT pi.ProductID, pi.Shelf, AVG(pi.Quantity) as TheAvg
FROM Production.ProductInventory pi
GROUP BY pi.ProductID, pi.Shelf



--10
SELECT pi.ProductID, pi.Shelf, AVG(pi.Quantity) AS TheAvg
FROM Production.ProductInventory pi
WHERE pi.Shelf <> 'N/A'
GROUP BY pi.ProductID, pi.Shelf

--11
SELECT pi.Color, pi.Class, COUNT(*) as TheCount, AVG(pi.ListPrice) as AvgPrice
FROM Production.Product pi
WHERE pi.Color IS NOT NULL AND pi.Class IS NOT NULL
GROUP BY pi.Color, pi.Class

--12

SELECT c.Name, s.Name
FROM Person.CountryRegion c INNER JOIN Person.StateProvince s on c.CountryRegionCode = s.CountryRegionCode

--13
SELECT c.Name, s.Name
FROM Person.CountryRegion c INNER JOIN Person.StateProvince s on c.CountryRegionCode = s.CountryRegionCode
WHERE c.Name in ('Germany', 'Canada')

USE Northwind
GO


--14
SELECT DISTINCT p.ProductID, p.ProductName
FROM dbo.[Order Details] od INNER JOIN dbo.Products p on p.ProductID = od.ProductID
	INNER JOIN Orders o on od.OrderID = o.OrderID
WHERE DATEPART(yy, GETDATE()) - DATEPART(yy, o.OrderDate) <= 25


--15
SELECT TOP 5 dt.Zipcode, dt.Amount_Sold	
FROM (SELECT o.ShipPostalCode as Zipcode, COUNT(o.OrderID) as Amount_Sold 
	FROM Orders o
	WHERE o.ShipPostalCode IS NOT NULL
	GROUP BY o.ShipPostalCode) dt
ORDER BY dt.Amount_Sold DESC

--16
SELECT TOP 5 dt.Zipcode, dt.Amount_Sold	
FROM (SELECT o.ShipPostalCode as Zipcode, COUNT(o.OrderID) as Amount_Sold 
	FROM Orders o
	WHERE o.ShipPostalCode IS NOT NULL AND DATEPART(yy, GETDATE()) - DATEPART(yy, o.OrderDate) <= 25
	GROUP BY o.ShipPostalCode) dt
ORDER BY dt.Amount_Sold DESC


--17
SELECT c.City, COUNT(c.CustomerID) AS Number_Customers
FROM dbo.Customers c
GROUP BY c.City

--18
SELECT c.City, COUNT(c.CustomerID) AS Number_Customers
FROM dbo.Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) > 2


--19
SELECT c.ContactName AS Customer_Name, o.OrderDate AS Order_Date
FROM dbo.Orders o INNER JOIN dbo.Customers c on o.CustomerID = c.CustomerID
WHERE o.OrderDate > '1998-01-01 00:00:00.000'
ORDER BY Customer_Name


--20
SELECT c.ContactName AS Customer_Name, MAX(o.OrderDate) AS Order_Date
FROM dbo.Orders o INNER JOIN dbo.Customers c on o.CustomerID = c.CustomerID
WHERE o.OrderDate > '1998-01-01 00:00:00.000'
GROUP BY c.ContactName

--21

SELECT c.ContactName as Customer_Name, COUNT(od.ProductID) as Number_Prodeucts_Bought
FROM Customers c INNER JOIN Orders o on c.CustomerID = o.CustomerID INNER JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY c.ContactName


--22
SELECT c.CustomerID, COUNT(od.ProductID) as Number_Prodeucts_Bought
FROM Customers c INNER JOIN Orders o on c.CustomerID = o.CustomerID INNER JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.ProductID) > 100


--23
SELECT sup.CompanyName AS [Supplier Company Name], shi.CompanyName AS [Shipping Company Name]
FROM Shippers shi CROSS JOIN Suppliers sup


--24

SELECT o.OrderDate, p.ProductName
FROM ORDERS o INNER JOIN [Order Details] od ON o.OrderID = od.OrderID INNER JOIN Products p ON p.ProductID = od.ProductID

--25

SELECT e1.FirstName + ' ' + e1.LastName AS Employee1, e2.FirstName + ' ' + e2.LastName As Employee2
FROM Employees e1 INNER JOIN Employees e2 on e1.Title = e2.Title
WHERE e1.EmployeeID <> e2.EmployeeID

--26
SELECT manager.EmployeeID AS ManagerID, COUNT(emp.EmployeeID) AS Num_emp
FROM Employees manager INNER JOIN Employees emp ON emp.ReportsTo = manager.EmployeeID
GROUP BY manager.EmployeeID
HAVING COUNT(emp.EmployeeID) > 2


--27
SELECT *
FROM (SELECT c.City, c.CompanyName, c.ContactName, 'Customer' AS Type
FROM Customers c
UNION
SELECT s.City, s.CompanyName, s.ContactName, 'Supplier' AS Type
FROM Suppliers s) dt
ORDER BY dt.City
