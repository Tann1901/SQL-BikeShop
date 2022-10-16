SELECT
        ProductCategory.ProductCategoryName,
        SUM(OrderQuantity)  AS  OrderQuantity,
        SUM(UnitPrice*OrderQuantity)    AS  SalesAmount 
    FROM    
        SalesOrderDetails   
    LEFT OUTER JOIN 
    InventoryMaster
    ON
    SalesOrderDetails.ProductID =InventoryMaster.ProductID
    LEFT OUTER JOIN
    ProductSubCategory
    ON
    InventoryMaster.ProductSubCategoryID =ProductSubCategory.ProductSubCategoryID
    LEFT OUTER JOIN
    ProductCategory
    ON
    ProductSubCategory.ProductCategoryID =ProductCategory.ProductCategoryID 
    GROUP BY 
    ProductCategory.ProductCategoryName
    ORDER BY SalesAmount DESC