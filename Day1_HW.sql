USE AdventureWorks2019
GO

--1.

SELECT p.ProductID, p.Name , p.Color, p.ListPrice
FROM Production.Product AS p


--2.

SELECT p.ProductID, p.Name , p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.ListPrice <> 0 --or !=0



--3.
SELECT p.ProductID, p.Name , p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NULL

--4.
SELECT p.ProductID, p.Name , p.Color, p.ListPrice
FROM Production.Product AS p
WHERE NOT p.Color IS  NULL  -- OR p.Color IS NOT NULL

--5.
SELECT p.ProductID, p.Name , p.Color, p.ListPrice
FROM Production.Product AS p
WHERE p.Color IS NOT NULL AND p.ListPrice > 0


--6.
SELECT p.Name, p.Color
FROM Production.Product AS p
WHERE p.Color IS NOT NULL

--7.
SELECT 'NAME: ' + p.Name + ' -- COLOR: ' + p.Color AS result
FROM Production.Product as p
WHERE p.Name is NOT NULL AND p.Color is NOT NULL
ORDER BY CURRENT_TIMESTAMP -- must have order by here(to use offset), use timestamp to skip order by
	OFFSET 0 ROWS
	FETCH NEXT 6 ROWS ONLY


--8.
SELECT p.ProductID, p.Name
FROM Production.Product as p
WHERE p.ProductID BETWEEN 400 AND 500


--9.
SELECT p.ProductID, p.Name, p.Color
FROM Production.Product AS p
WHERE p.Color IN ('black', 'blue')


--10.
SELECT p.Name
FROM Production.Product as p
WHERE p.Name LIKE 'S%'


--11.
SELECT p.Name, p.ListPrice
FROM Production.Product as p
WHERE p.Name LIKE 'S%' --???the question itself did not require "start with S", but he sample results all start with S
ORDER BY p.Name


--12.
SELECT p.Name, p.ListPrice
FROM Production.Product as p
--WHERE p.Name LIKE 'A%' OR p.Name LIKE 'S%'
WHERE p.Name LIKE '[AS]%'  --[AS] ==> A or S; [A-S] ==> A~S. SQL server not case sensitive
ORDER BY p.Name


--13.
SELECT p.Name
FROM Production.Product AS p
WHERE p.Name LIKE 'SPO[^K]%'
ORDER BY p.Name


--14. 
SELECT DISTINCT p.Color
FROM Production.Product AS p
ORDER BY p.Color DESC


--15.
SELECT DISTINCT p.ProductSubcategoryID, p.Color 
FROM Production.Product AS p
WHERE p.ProductSubcategoryID IS NOT NULL and p.Color IS NOT NULL
