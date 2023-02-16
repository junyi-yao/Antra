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

