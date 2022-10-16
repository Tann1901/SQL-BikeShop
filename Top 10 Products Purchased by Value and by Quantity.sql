SELECT TOP (10) ProductID,
	SUM(OrderQuantity) AS OrderQuantity,
	SUM(TotalCost) AS TotalCost
FROM
	PODetails
GROUP BY 
	ProductID
ORDER BY TotalCost DESC