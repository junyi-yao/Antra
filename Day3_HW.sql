USE Northwind
GO


--1
SELECT DISTINCT c.City
FROM Customers c 
WHERE c.City IN 
	(SELECT DISTINCT e.City
	FROM Employees e
	)



--2
	--a
SELECT DISTINCT c.City
FROM Customers c 
WHERE c.City NOT IN 
	(SELECT DISTINCT e.City
	FROM Employees e
	)
	--b
SELECT c.City
FROM Customers c
EXCEPT
SELECT e.City
FROM Employees e


--3
SELECT od.ProductID, SUM(od.Quantity) AS Total
FROM [Order Details] od
GROUP BY od.ProductID


--4

SELECT c.City, SUM(od.Quantity) AS Total
FROM Customers c INNER JOIN Orders o on c.City = o.ShipCity INNER JOIN [Order Details] od on od.OrderID = o.OrderID
GROUP BY c.City

--5 --I assume you mean at most 2 customers

	--a

SELECT c.City, COUNT(c.CustomerID)
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) = 1
UNION
SELECT c.City, COUNT(c.CustomerID)
FROM Customers c
GROUP BY c.City
HAVING COUNT(c.CustomerID) = 2

	--b
SELECT DISTINCT c.City
FROM Customers c
WHERE c.City in
	(SELECT c1.City
	FROM Customers c1
	GROUP BY c1.City
	HAVING COUNT(c1.CustomerID) = 1)
	or c.City in
	(
	SELECT c2.City
	FROM Customers c2
	GROUP BY c2.City
	HAVING COUNT(c2.CustomerID) = 2
	)



