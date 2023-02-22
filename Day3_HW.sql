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



--6
SELECT c.City, COUNT(DISTINCT od.ProductID) AS Kind_of_Products
FROM Customers c INNER JOIN Orders o on o.CustomerID = c.CustomerID INNER JOIN [Order Details] od on o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(DISTINCT od.ProductID) > 2




--7
SELECT DISTINCT c.CompanyName
FROM Customers c INNER JOIN Orders o on c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity


--8
(SELECT TOP 5 p.ProductID
FROM [Order Details] od INNER JOIN Products p on od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY SUM(od.Quantity) DESC) 

SELECT od.ProductID, od.UnitPrice*(1 - od.Discount) AS Actual_Price
FROM [Order Details] od
WHERE od.ProductID IN 
(SELECT TOP 5 p.ProductID
FROM [Order Details] od INNER JOIN Products p on od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY SUM(od.Quantity) DESC) 


(SELECT Price_table.ProductID, AVG(Price_table.Actual_Price) AS Average_price
FROM 
(
SELECT od.ProductID, od.UnitPrice*(1 - od.Discount) AS Actual_Price
FROM [Order Details] od
WHERE od.ProductID IN 
(SELECT TOP 5 p.ProductID
FROM [Order Details] od INNER JOIN Products p on od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY SUM(od.Quantity) DESC) 

) Price_table
GROUP BY Price_table.ProductID) Product_AVG_Price


SELECT dt.ProductID, dt.ShipCity, dt.Total, RANK() OVER (PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) RNK
FROM (SELECT od.ProductID, o.ShipCity, SUM(od.Quantity) Total
FROM Orders o INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
WHERE od.ProductID in 
(SELECT TOP 5 p.ProductID
FROM [Order Details] od INNER JOIN Products p on od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY SUM(od.Quantity) DESC) 
GROUP BY od.ProductID,o.ShipCity
) dt
ORDER BY dt.ProductID, dt.Total DESC



--9
SELECT 
