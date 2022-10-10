# sql_sample
Collection of SQL practices

# OVERVIEW
## BIKE SHOP RECORD
Process data based on:
- Customer 
- Inventory 
- Sales Order 
- Vendor information

# COURTESY 
This project is a group work including Justine Buenaobra, Alyssa Sangalang, Yazmin Soriano, Annalyn Ruiz and Mahdieh Darehzereshki. 

# TARGET & ACHIEVEMENTS
Get to learn a vision over small/medium size business and SQL practices.

# DATASET
Based on actual data set found and modified for practice purpose.
The dataset include different sheets including:
- Customer
- Category
- Sales Order
- Vendor
- POListing
- PO Details
- Geography
We extract, transform and load to SQL Database and comes up with analytics.

# DATA PROCESSING
Create Tables in SQL including Constraintsand Loading Dummy Data

I. Customer
```
CREATE TABLE Customer
    (
    CustomerIDvarchar(10)               NOTNULL,
    FirstNamevarchar(50)                NOTNULL,
    LastNamevarchar(50)                 NOTNULL,
    BirthDatedate                       NOTNULL,
    EmailAddvarchar(50)                 NOTNULL,
    CustomerAddress varchar(50)         NOTNULL,
    PhoneNumberchar(20)                 NOTNULL,
    DatePurchasedate                    NOTNULL,
    CONSTRAINT Customer_CustomerID_PK PRIMARYKEY (CustomerID)
    )
```
II. SalesOrder
```
CREATE TABLE SalesOrder
    (
    SalesOrderID        varchar(10)             NOTNULL,
    OrderDate           date                    NOTNULL,
    ShipDate            date                    NOTNULL,
    DueDate             date                    NOTNULL,
    SalesOrderLineItem  char(5)                 NOTNULL,
    SalesOrderQuantity  integer                 NOTNULL,
    SalesAmount         numeric(20,2)           NOTNULL,
    CustomerID          varchar(10),
    CONSTRAINT SalesOrder_SalesOrderID_PK PRIMARY KEY (SalesOrderID),CONSTRAINT SalesOrder_CustomerID_FK FOREIGN KEY (CustomerID) REFERENCES Customer,
    )
```
III. Product Category
```
CREATE TABLE ProductCategory
    (
    ProductCategoryID   varchar(10)        NOTNULL,
    ProductCategoryName varchar(50)        NOTNULL,
    CONSTRAINT ProductCategory_ProductCategoryID_PK PRIMARY KEY (ProductCategoryID)
    )
```
IV. Product SubCategory
```
CREATE TABLE ProductSubCategory
    (
    ProductSubCategoryID    varchar(10)      NOTNULL,
    ProductSubCategoryName  varchar(50)    NOTNULL,
    ProductCategoryID       varchar(10)         NOTNULL,
    CONSTRAINT ProductSubCategory_ProductSubCategoryID_PK PRIMARY KEY (ProductSubCategoryID),
    CONSTRAINT ProductSubCategory_ProductCategoryID_FK FOREIGN KEY (ProductCategoryID)
    REFERENCES ProductCategory
    )
```
V. Inventory Master
```
CREATE TABLE InventoryMaster
    (
    ProductID               varchar(10)   NOTNULL,
    ProductSubCategoryID    varchar(10)   NOTNULL,
    ProductName             varchar(50)   NOTNULL,
    SafetyStockLevel        varchar(10)   NOTNULL,
    ReorderPoint            varchar(10)   NOTNULL,
    ListPrice               numeric(20,2) NOTNULL,
    DealerPrice             numeric(20,2) NOTNULL,
    ModelName               varchar(50)   NOTNULL,
    CONSTRAINT InventoryMaster_ProductID_PK PRIMARYKEY (ProductID),
    CONSTRAINT InventoryMaster_ProductSubCategoryID_FK FOREIGNKEY (ProductSubCategoryID)
    REFERENCES  ProductSubCategory
    )
```
VI. Sales Order Details
```
CREATE TABLE SalesOrderDetails
    (
    SalesOrderID            varchar(10)     NOTNULL,
    SalesOrderLineNumber    char(5)         NOTNULL,
    OrderQuantity           integer         NOTNULL,
    UnitPrice               numeric(20,2)   NOTNULL,
    ProductID               varchar(10)     NOTNULL,
    CONSTRAINT  SalesOrderDetails_SalesOrderID_ProductID_PK PRIMARY KEY (SalesOrderID,ProductID),
    CONSTRAINT  SalesOrderDetails_SalesOrderID_FK FOREIGN KEY (SalesOrderID)
    REFERENCES  SalesOrder,CONSTRAINTSalesOrderDetails_ProductID_FK FOREIGN KEY (ProductID) REFERENCES  InventoryMaster,
    )
```
VII. Vendor
```
CREATE TABLE Vendor
    (
    VendorID            varchar(10)     NOTNULL,
    VendorName          varchar(50)     NOTNULL,
    VendorAddress       varchar(50)     NOTNULL,
    VendorPhoneNumber   char(20)        NOTNULL,
    VendorOrderFrequency    integer,
    VendorFirstOrderYear    char(20),
    VendorLastOrderYear     char(20),
    VendorBankName          varchar(50) NOTNULL,
    ContactPerson           varchar(50) NOTNULL,
    CONSTAINT Vendor_VendorID_PK PRIMARY KEY (VendorID)
    )
```
VIII. PO Listing
```
CREATE TABLE POListing
    (
    POID            varchar(10)     NOTNULL,
    VendorID        varchar(10)     NOTNULL,
    OrderDate       date            NOTNULL,
    DueDate         date            NOTNULL,
    DeliveryDate    date            NOTNULL,
    POQuantity      integer         NOTNULL,
    POTotalCost     numeric(20,2)   NOTNULL,
    CONSTRAINT POListing_POID_PK PRIMARY KEY (POID),
    CONSTRAINT POListing_VendorID_FK FOREIGN KEY (VendorID)
    REFERENCES  Vendor
    )
```
IX. PO Details
```
CREATE TABLE PODetails
    (
    POID            varchar(10)     NOTNULL,
    ProductID       varchar(10)     NOTNULL,
    POLineNumber    char(5)         NOTNULL,
    OrderQuantity   integer         NOTNULL,
    UnitPrice       numeric(20,2)   NOTNULL,
    TotalCost       numeric(20,2)   NOTNULL,
    CONSTRAINT  PODetails_POID_ProductID_PK PRIMARY KEY (POID,ProductID),
    CONSTRAINT  PODetails_POID_FK FOREIGNKEY (POID) REFERENCES POListing,
    CONSTRAINT  PODetails_ProductID_FK FOREIGNKEY (ProductID)
    REFERENCES InventoryMaster,
    )
```
X. Inventory Balance Date
```
CREATE  TABLE   InventoryBalanceDate
    (
    InventoryDate       date        NOTNULL,
    InventoryMonth      char(5)     NOTNULL,
    InventoryYear       char(5)     NOTNULL,
    CONSTRAINT  InventoryBalanceDate_InventoryDate_PK PRIMARY KEY(InventoryDate),
    )
```
XI. Inventory Balance
```
CREATE TABLE    InventoryBalance
    (
    ProductID           varchar(10)     NOTNULL,
    InventoryDate       date            NOTNULL,
    UnitPrice           numeric(20,2)   NOTNULL,
    Units               Ininteger       NOTNULL,
    UnitsOut            integer         NOTNULL,
    UnitsBalance        integer         NOTNULL,
    CONSTRAINT  InventoryBalance_ProductID_InventoryDate_PK PRIMARY KEY (ProductID,InventoryDate),
    CONSTRAINT  InventoryBalance_ProductID_FK FOREIGN KEY (ProductID)REFERENCES InventoryMaster,
    CONSTRAINT  InventoryBalance_InventoryDate_FK FOREIGN KEY (InventoryDate) REFERENCES InventoryBalanceDate
    )
```

# FINAL REPORT
1. Extract Top 10 Products Purchased by Order Value
```   
   SELECT TOP (10)ProductID,
        SUM(OrderQuantity)  AS  OrderQuantity,
        SUM(TotalCost)      AS  TotalCost
    FROM    PODetails   
    GROUP BY ProductID   
    ORDER BY TotalCost DESC
 ```   
2. Extract Top 10 Vendors by Purchased Order Amount
 ```   
    SELECT TOP (10)VendorID,
        SUM(POQuantity) AS  POQuantity,
        SUM(POTotalCost)AS  POTotalCost
    FROM    POListing
    GROUP BY    VendorID
    ORDER BY    POTotalCost DESC
```
3. Top 10 Customer by Sales Amount
```   
   SELECT TOP (10)CustomerID,
        SUM(SalesOrderQuantity) AS  SalesOrderQuantity,
        SUM(SalesAmount)AS  SalesAmount
    FROM    SalesOrder
    GROUP BY CustomerID
    ORDER BY    SalesAmount DESC
```
4. Products Sold by Quantity and Amount per Category
```   
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
```
5. Count of Customers by Age bracket
```
SELECT
COUNT(CASE WHEN DATEDIFF(YEAR,BirthDate,GETDATE())BETWEEN 18 AND 30 THEN 1 END)AS'Customer Count (Ages 18 -30)',
COUNT(CASE WHEN DATEDIFF(YEAR,BirthDate,GETDATE())BETWEEN 31 AND 40 THEN 1 END)AS'Customer Count (Ages 31 -40)',
COUNT(CASE WHEN DATEDIFF(YEAR,BirthDate,GETDATE())BETWEEN 41 AND 50 THEN 1 END)AS'Customer Count (Ages 41 -50)',
COUNT(CASE WHEN DATEDIFF(YEAR,BirthDate,GETDATE())BETWEEN 51 AND 60 THEN 1 END)AS'Customer Count (Ages 51 -60)',
COUNT(CASE WHEN DATEDIFF(YEAR,BirthDate,GETDATE())>60 THEN 1 END)AS'Customer Count (Ages above 60)'
FROM Customer;
```
6. Create a New Table with Top 10 Inventory by Value
```
SELECT 
TOP(10)ProductID,UnitPrice,UnitsBalance,[UnitPrice]*[UnitsBalance] 
AS 'Total Inventory Value'
INTO Top_10_InvFrom[dbo].[InventoryBalance]WhereInventoryDate='2021-06-30'
ORDER BY [UnitPrice]*[UnitsBalance] DESC
```
7. Top 10 Inventory by Value at a Specific Date
```
SELECT  
  TOP10.[ProductID], 
  TOP10.[UnitsBalance] AS 'Units Balance', 
  TOP10.[TotalInventoryValue], 
  inv.Productname AS 'Product Name' 
  FROM [dbo].[Top_10_Inv] Top10   
  LEFT OUTER JOIN
  [dbo].[Inventory] Inv 
  ON Top10.ProductID = Inv.ProductID 
```
# RESULT SNAPSHOT
/Tann1901/sql_sample/images/Top 10 Customer based on Sales and Order Count.jpg


