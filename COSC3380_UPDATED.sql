/*Project 2 */
/*Question 1A*/
/*Create Customer Table*/
CREATE TABLE Customer( 
    CustomerID INTEGER,
    CustomerName CHAR(100),
    CustomerAddress CHAR(100),
    CustomerCity CHAR(100),
    CustomerState CHAR(100),
    CustomerPostalCode CHAR(100),
    CustomerEmail CHAR(100),
    CustomerUsername CHAR(100),
    CustomerPassword CHAR(100),
    PRIMARY KEY (CustomerID)
);

/*Create Territory Table */
CREATE TABLE Territory(
    TerritoryID INTEGER,
    TerritoryName CHAR(100),
    PRIMARY KEY (TerritoryID)
);

/*Create Salesperson Table */
CREATE TABLE Salesperson(
    SalespersonID INTEGER,
    SalespersonName CHAR(100),
    SalespersonTelephone CHAR(100),
    SalespersonEmail CHAR(100),
    SalespersonUsername CHAR(100),
    SalespersonPassword CHAR(100),
    TerritoryID INTEGER,
    PRIMARY KEY(SalespersonID),
    FOREIGN KEY(TerritoryID) REFERENCES Territory(TerritoryID)
);

/*Create DoesBusinessIn Table*/
CREATE TABLE DoesBusinessIn(
    CustomerID INTEGER,
    TerritoryID INTEGER,
    PRIMARY KEY (CustomerID, TerritoryID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (TerritoryID) REFERENCES Territory(TerritoryID)
);

/*Create Orders Table*/
CREATE TABLE Orders(
    OrderID INTEGER,
    OrderDate CHAR(15),
    CustomerID INTEGER,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

/*Create Product Line Table*/
CREATE TABLE ProductLine(
    ProductLineID INTEGER,
    ProductLineName CHAR(100),
    PRIMARY KEY (ProductLineID)
);

/*Create Product Table*/
CREATE TABLE Product(
    ProductID INTEGER,
    ProductName CHAR(100),
    ProductFinish CHAR(100),
    ProductStandardPrice INTEGER,
    ProductLineID INTEGER,
    Photo CHAR(100),
    PRIMARY KEY (ProductID),
    FOREIGN KEY (ProductLineID) REFERENCES ProductLine(ProductLineID)
);

/*Create Orderline Table*/
CREATE TABLE OrderLine(
    OrderID INTEGER,
    ProductID INTEGER,
    OrderedQuantity INTEGER,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
/*Create PriceUpdate Table*/
CREATE TABLE PriceUpdate(
    PriceUpdateID NUMBER GENERATED ALWAYS AS IDENTITY,
    DateChanged DATE,
    OldPrice DECIMAL(30,2),
    NewPrice DECIMAL(30,2),
    PRIMARY KEY (PriceUpdateID)
);

/*Create View ProductLineSales*/
CREATE VIEW ProductLineSales(ProductLineName, TotalSales) AS
SELECT L.ProductLineName, SUM(P.ProductStandardPrice)
FROM ProductLine L, Product P
WHERE L.ProductLineID = P.ProductLineID
GROUP BY L.ProductLineID, L.ProductLineName
;


/*Create View TotalValueForProducts*/
CREATE VIEW TotalValueForProducts(ProductName, TotalValue) AS
SELECT P.ProductName, SUM(P.ProductStandardPrice * O.OrderedQuantity)
FROM Product P, OrderLine O
WHERE P.ProductID = O.ProductID
GROUP BY P.ProductName
;

/*Create DataForCustomer*/
CREATE VIEW DataForCustomer(Territory, Customer, Product, Price) AS
SELECT T.TerritoryName, C.CustomerName, P.ProductName, P.ProductStandardPrice
FROM Territory T, DoesBusinessIn B, Customer C, Orders O, OrderLine L, Product P
WHERE T.TerritoryID = B.TerritoryID AND B.CustomerID = C.CustomerID AND C.CustomerID = O.CustomerID 
    AND O.OrderID = L.OrderID AND L.ProductID = P.ProductID
ORDER BY T.TerritoryName;

/*Create CustomerByStates*/
CREATE VIEW CustomerByStates(CustomerState, COUNT) AS
SELECT C.CustomerState, COUNT(*)
FROM Customer C
GROUP BY C.CustomerState;

/*Create View PastPurchaseHistory*/
CREATE VIEW PastPurchaseHistory(Customer,OrderDate,Quantity,Price,Product) AS
SELECT C.CustomerName, O.OrderDate, L.OrderedQuantity, P.ProductStandardPrice, P.ProductName
FROM Customer C, Orders O, OrderLine L, Product P
WHERE C.CustomerID = O.CustomerID AND O.OrderID = L.OrderID AND L.ProductID = P.ProductID;

/*Project 2 Question 2*/

/*insert customer info*/

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601-2871');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(2, 'Value Furnitures', '15145 S.W. 17th St.', 'Plano', 'TX', '75094-7734');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(3, 'Home Furnishings', '1900 Allard Ave', 'Albany', 'NY', '12209-1125');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(4, 'Eastern Furniture', '1925 Beltline Rd.', 'Carteret', 'NJ', '07008-3188');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(5, 'Impressions', '5585 Westcott Ct.', 'Sacramento', 'CA', '94206-4056');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(6, 'Furniture Gallery', '325 Flatiron Dr.', 'Boulder', 'CO', '80514-4432');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(7, 'New Furniture', 'Palace Ave', 'Farmington', 'NM', '');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(8, 'Dunkins Furniture', '7700 Main St', 'Syracuse', 'NY', '31590');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(9, 'A Carpet', '434 Abe Dr', 'Rome', 'NY', '13440');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(12, 'Flanigan Furniture', 'Snow Flake Rd', 'Ft Walton Beach', 'FL', '32548');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(13, 'Ikards', '1011 S. Main St', 'Las Cruces', 'NM', '88001');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(14, 'Wild Bills', 'Four Horse Rd', 'Oak Brook', 'Il', '60522');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(15, 'Janets Collection', 'Janet Lane', 'Virginia Beach', 'VA', '10012');

INSERT INTO Customer(CustomerID,CustomerName, CustomerAddress,CustomerCity,CustomerState,CustomerPostalCode)
VALUES(16, 'ABC Furniture Co.', '152 Geramino Drive', 'Rome', 'NY', '13440');

UPDATE Customer
SET CustomerEmail= 'ContemporaryCasuals@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=1;

SET CustomerEmail= 'ValueFurnitures@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=2;

UPDATE Customer
SET CustomerEmail= 'HomeFurnishings@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=3;

UPDATE Customer
SET CustomerEmail= 'EasternFurniture@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=4;

UPDATE Customer
SET CustomerEmail= 'Impressions@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=5;

UPDATE Customer
SET CustomerEmail= 'FurnitureGallery@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=6;

UPDATE Customer
SET CustomerEmail= 'NewFurniture@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=7;

UPDATE Customer
SET CustomerEmail= 'DunkinsFurniture@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=8;

UPDATE Customer
SET CustomerEmail= 'ACarpet@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=9;

UPDATE Customer
SET CustomerEmail= 'FlaniganFurniture@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=12;

UPDATE Customer
SET CustomerEmail= 'Ikards@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=13;

UPDATE Customer
SET CustomerEmail= 'WildBillS@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=14;


UPDATE Customer
SET CustomerEmail= 'JanetsCollection@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=15;

UPDATE Customer
SET CustomerEmail= 'ABCFurnitureCo@gmail.com',
    CustomerUsername='CUSTOMER1',
    CustomerPassword='CUSTOMER1#'
WHERE
    CustomerID=16;

/*end of customer insert*/

/*Territory insert*/
INSERT INTO Territory(TerritoryID,TerritoryName)
VALUES(1, 'SouthEast');

INSERT INTO Territory(TerritoryID,TerritoryName)
VALUES(2, 'SouthWest');

INSERT INTO Territory(TerritoryID,TerritoryName)
VALUES(3, 'NorthEast');

INSERT INTO Territory(TerritoryID,TerritoryName)
VALUES(4, 'NorthWest');

INSERT INTO Territory(TerritoryID,TerritoryName)
VALUES(5, 'Central');
/*end of insert Territory*/

/*insert sales person*/
INSERT INTO Salesperson(SalespersonID,SalespersonName,SalespersonTelephone,SalespersonEmail,SalespersonUsername,SalespersonPassword,TerritoryID)
VALUES(1, 'Doug Henny', '8134445555', 'doughenry@gmail.com', 'SALESPERSON', 'SALESPERSON1',1);

INSERT INTO Salesperson(SalespersonID,SalespersonName,SalespersonTelephone,SalespersonEmail,SalespersonUsername,SalespersonPassword,TerritoryID)
VALUES(2, 'Robert Lewis', '8139264006', 'robertlewis@gmail.com', 'SALESPERSON', 'SALESPERSON2', 2);

INSERT INTO Salesperson(SalespersonID,SalespersonName,SalespersonTelephone,SalespersonEmail,SalespersonUsername,SalespersonPassword,TerritoryID)
VALUES(3, 'William Strong', '5053821212', 'williamstrong@gmail.com', 'SALESPERSON', 'SALESPERSON3', 3);

INSERT INTO Salesperson(SalespersonID,SalespersonName,SalespersonTelephone,SalespersonEmail,SalespersonUsername,SalespersonPassword,TerritoryID)
VALUES(4, 'Julie Dawson', '4355346677', 'juliewilson@gmail.com', 'SALESPERSON', 'SALESPERSON4', 4);

INSERT INTO Salesperson(SalespersonID,SalespersonName,SalespersonTelephone,SalespersonEmail,SalespersonUsername,SalespersonPassword,TerritoryID)
VALUES(5, 'Jacob Winslow', '2238973498', 'jacobwinslow@gmail.com', 'SALESPERSON', 'SALESPERSON5', 5);

/*end of insert Salesperson*/



/*insert DoBusinessIn*/
INSERT INTO DoesBusinessIn(CustomerID, TerritoryID)
VALUES(1, 1);

INSERT INTO DoesBusinessIn(CustomerID, TerritoryID)
VALUES(2, 2);

INSERT INTO DoesBusinessIn(CustomerID, TerritoryID)
VALUES(3, 3);

INSERT INTO DoesBusinessIn(CustomerID, TerritoryID)
VALUES(4, 4);

INSERT INTO DoesBusinessIn(CustomerID, TerritoryID)
VALUES(5, 5);

INSERT INTO DoesBusinessIn(CustomerID,TerritoryID)
VALUES(6,1);

INSERT INTO DoesBusinessIn(CustomerID, TerritoryID)
VALUES(7,2);
/*end of DoBusiness*/




/*insert Orders*/
INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1001, '21/Aug/16', 1);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1002, '21/Jul/16', 8);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1003, '22/ Aug/16', 15);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1004, '22/Oct/16', 5);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1005, '24/Jul/16', 3);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1006, '24/Oct/16', 2);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1007, '27/ Aug/16', 5);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1008, '30/Oct/16', 12);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1009, '05/Nov/16', 4);

INSERT INTO Orders(OrderID,OrderDate,CustomerID)
VALUES(1010, '05/Nov/16', 1);
/*End Orders*/




/*Insert Into ProductLine*/
INSERT INTO ProductLine(ProductLineID, ProductLineName)
VALUES(1,'Cherry Tree');

INSERT INTO ProductLine(ProductLineID, ProductLineName)
VALUES(2,'Scandinavia');

INSERT INTO ProductLine(ProductLineID, ProductLineName)
VALUES(3,'Country Look');
/* end Insert Into ProductLine*/


/*Insert Into Product*/
INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(1, 'End Table', 'Cherry', 175, 1, 'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(2, 'Coffee Table', 'Natural Ash', 200, 2,'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(3, 'Computer Desk', 'Natural Ash', 375, 2,'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(4, 'Entertainment Center', 'Natural Maple', 650, 3,'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(5, 'Writers Desk', 'Cherry', 325, 1,'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(6, '8-Drawer Desk', 'White Ash', 750, 2,'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(7, 'Dining Table', 'Natural Ash', 800, 2,'table.jpg');

INSERT INTO Product(ProductID, ProductName, ProductFinish, ProductStandardPrice, ProductLineID, Photo)
VALUES(8, 'Computer Desk', 'Walnut', 250, 3,'table.jpg');
/*end Insert Into Product*/



/*insert orderline*/
INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1001, 1, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1001, 2, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1001, 4, 1);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1002, 3, 5);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1003, 3, 3);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1004, 6, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1004, 8, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1005, 4, 4);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1006, 4, 1);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1006, 5, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1006, 7, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1007, 1, 3);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1007, 2, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1008, 3, 3);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1008, 8, 3);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1009, 4, 2);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1009, 7, 3);

INSERT INTO OrderLine(OrderID,ProductID,OrderedQuantity)
VALUES(1010, 8, 10);
/*end Orderline*/



/*Project 2 Question 3*/
/*Question 1 Which products have a standard price of less than $ 275? 
        ProductName             ProductStandardPrice
        End Table                       175
        Coffee Table                    200
        Computer Desk                   250
*/
SELECT ProductName, ProductStandardPrice
FROM Product
WHERE ProductStandardPrice < 275;

/*Question 2 List the unit price, product name, and product ID for all products in the Product table. 
     ProductStandardPrice       ProductName         ProductID
     175                        End Table               1
     200	                Coffee Table            2
     375                    	Computer Desk           3
     650                        Entertainment Center    4 
     325                        Writers Desk            5
     750                        8-Drawer Desk           6
     800	                Dining Table            7
     250                        Computer Desk           8
*/
SELECT ProductStandardPrice, ProductName, ProductID
FROM Product;

/*Question 3 What is the average standard price for all products in inventory?
    AVG(ProductStandardPrice)
    440.625
*/
SELECT AVG(ProductStandardPrice)
FROM Product;

/*Question 4 How many different items were ordered on order number 1004? 
    COUNT(ProductID)
    2
*/
SELECT COUNT(ProductID)
FROM Orderline
WHERE OrderID = 1004;

/*Question 5 Which orders have been placed since 10/24/2010? 
    OrderID
    1001
    1002
    1003
    1004
    1005
    1006
    1007
    1008
    1009
    1010
*/
SELECT OrderID
FROM Orders
WHERE OrderDate > '10/24/2010';  

/*Question 6 What furniture does COSC3380 carry that isn’t made of cherry? 
    ProductName
    Coffee Table
    Computer Desk
    Entertainment Center
    8-Drawer Desk
    Dining Table
    Computer Desk
*/
SELECT ProductName
FROM Product
WHERE ProductFinish != 'Cherry';

/*Question 7 List product name, finish, and standard price for all 
desks and all tables that cost more than $ 300 in the Product table.

    ProductName     ProductFinish   ProductStandardPrice
    Computer Desk   Natural Ash     375
    Writers Desk    Cherry          325
    8-Drawer Desk   White Ash       750
    Dining Table    Natural Ash     800

*/
SELECT ProductName, ProductFinish, ProductStandardPrice
FROM Product
WHERE ProductStandardPrice > 300 AND 
(P.ProductName LIKE '%Table%' OR P.ProductName LIKE '%Desk%');

/*Question 8 Which products in the Product table have a standard price between $ 200 and $ 300? 
    ProductName
    Coffee Table
    Computer Name
*/
SELECT ProductName
FROM Product
WHERE ProductStandardPrice BETWEEN 200 AND 300;

/*Question 9 List customer, city, and state for all customers in the Customer table whose 
address is Florida, Texas, California, or Hawaii. List the customers alphabetically by
state and alphabetically by customer within each state. 

    CustomerName            CustomerCity        CustomerState
    Impressions             Sacramento          CA
    Contemporary Casuals    Gainesville         FL
    Flanigan Furniture      Ft Walton Beach     FL
    Value Furnitures        Plano               TX

*/
SELECT CustomerName, CustomerCity, CustomerState
FROM Customer
WHERE CustomerState = 'FL' 
OR CustomerState = 'TX' 
OR CustomerState = 'CA' 
OR CustomerState = 'HI'
ORDER BY CustomerState, CustomerName;

/*Question 10 Count the number of customers with addresses in each state to which we ship. 
    
CustomerState   COUNT(CustomerAddress)
    CA              1
    CO              1
    FL              2
    IL              1
    NJ              1
    NM              2
    NY              4
    TX              1
    VA              1

*/
SELECT CustomerState, COUNT(CustomerAddress)
FROM Customer
GROUP BY CustomerState
ORDER BY CustomerState;

/*Question 11 Count the number of customers with addresses in each city to which we ship. 
List the cities by state. 

    CustomerCity     COUNT(CustomerAddress)
    Sacramento       1             
    Boulder          1 
    Ft Walton Beach  1  
    Gainesville      1 
    Oak Brook        1
    Carteret         1 
    Farmington       1 
    Las Cruces       1
    Albany           1 
    Rome             2 
    Syracuse         1 
    Plano            1                          
    Virginia Beach   1            

*/
SELECT C.CustomerCity, COUNT(C.CustomerAddress)
FROM Customer C
GROUP BY C.CustomerCity, C.CustomerState
ORDER BY C.CustomerState;   

/*Question 12 Find only states with more than one customer. 
    CustomerState
    FL
    NM
    NY
*/
SELECT CustomerState
FROM Customer
GROUP BY CustomerState
HAVING COUNT(CustomerState) > 1;

/*Question 13 List, in alphabetical order, the product finish and the average 
standard price for each finish for selected finishes having an average standard
price less than 750.
  
  ProductFinish           AVG(P.ProductStandardPrice)
    Cherry                  250
    Natural Ash             458.333(continuous float point number)
    Natural Maple           650
    Walnut                  250

*/
SELECT ProductFinish, AVG(ProductStandardPrice)
FROM Product
GROUP BY ProductFinish
HAVING AVG(ProductStandardPrice) < 750
ORDER BY ProductFinish;

/*Question 14 What is the total value of orders placed for each furniture product? 
   
 ProductName             SUM(ProductStandardPrice)
    8-Drawer Desk                 	1500
    End Table                     	875
    Dining Table                  	4000
    Entertainment Center          	5200
    Coffee Table                  	800
    Writers Desk                  	650
    Computer Desk                 	7875

*/
SELECT P.ProductName, SUM(P.ProductStandardPrice*O.OrderedQuantity)
FROM Product P, Orderline O
WHERE P.ProductID = O.ProductID
GROUP BY P.ProductName;