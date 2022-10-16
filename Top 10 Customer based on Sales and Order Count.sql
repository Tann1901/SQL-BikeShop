SELECT TOP (10) CustomerID,
	SUM(SalesOrderQuantity) AS SalesOrderQuantity,
	SUM(SalesAmount) AS SalesAmount
FROM
	SalesOrder
GROUP BY 
	CustomerID
ORDER BY SalesAmount DESC