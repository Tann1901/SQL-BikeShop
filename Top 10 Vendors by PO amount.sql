SELECT TOP (10) VendorID,
	SUM(POQuantity) AS POQuantity,
	SUM(POTotalCost) AS POTotalCost
FROM
	POListing
GROUP BY 
	VendorID
ORDER BY POTotalCost DESC