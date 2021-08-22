----------------------- CREATE TABLE SCRIPTS ----------------------
CREATE TABLE ecommerce.Customers(
CustomerId int IDENTITY Not Null Primary Key,
FirstName Varchar(50),
LastName Varchar(50),
Phone Bigint,
Email varchar(50),
DateOfBirth Date,
Age AS 
);

CREATE TABLE ecommerce.Cart(
CartId int  IDENTITY NOT NULL PRIMARY KEY,
DateCreated date,
CustomerId int references ecommerce.Customers(CustomerId)
);

CREATE TABLE ecommerce.Address(
AddressId int  IDENTITY NOT NULL Primary Key,
CustomerId int References ecommerce.Customers(CustomerId),
AptNumber varchar(50),
HouseNumber varchar(50),
Street varchar(50),
ZipCode varchar(50),
City varchar(50),
State varchar(50),
Country varchar(50),
Contact varchar(50)
);

 

CREATE TABLE ecommerce.Payments(
PaymentId INT IDENTITY NOT NULL PRIMARY KEY,
PaymentType VARCHAR(50) NOT NULL,
PaymentTotal DECIMAL(10,2) NOT NULL,
PaymentDate DATE NOT NULL,
ExpiryDate DATE NOT NULL,
CVV INT NOT NULL,
CardNumber INT NOT NULL
);

 
CREATE TABLE ecommerce.Orders(
OrderId INT IDENTITY NOT NULL PRIMARY KEY,
CustomerId INT REFERENCES ecommerce.Customers(CustomerId),
PaymentId INT NOT NULL REFERENCES ecommerce.Payments(PaymentId),
DateCreated DATE ,
DateShipped DATE NOT NULL,
ShippingId VARCHAR(50) NOT NULL,
Status VARCHAR(50) NOT NULL
);

 
CREATE TABLE ecommerce.ProductCategory(
ProductCategoryID INT IDENTITY NOT NULL PRIMARY KEY,
Name VARCHAR(50) NOT NULL
);

 
CREATE TABLE Ecommerce.ProductSubCategory
(
ProductSubCategoryID INT IDENTITY NOT NULL PRIMARY KEY,
ProductCategoryID INT REFERENCES ecommerce.ProductCategory(ProductCategoryID),
Name VARCHAR(50) NOT NULL
);

CREATE TABLE ecommerce.Seller(
SellerID INT IDENTITY NOT NULL PRIMARY KEY,
SellerName VARCHAR(50) NOT NULL,
AptNumber VARCHAR(5) NOT NULL,
HouseNumber VARCHAR(5) NOT NULL,
Street VARCHAR(50) NOT NULL,
City VARCHAR(20) NOT NULL,
State VARCHAR(50) NOT NULL,
Country VARCHAR(20) NOT NULL,
Zipcode VARCHAR(6) NOT NULL,
Contact VARCHAR(15) NOT NULL
);

CREATE TABLE ecommerce.Product
(
ProductID INT IDENTITY NOT NULL PRIMARY KEY,
ProductCategoryID INT REFERENCES ecommerce.ProductCategory(ProductCategoryID),
ProductSubCategoryID INT REFERENCES ecommerce.ProductSubCategory(ProductSubCategoryID),
ProductName VARCHAR(50) NOT NULL,
--ReviewID INT, --REFERENCES ecommerce.Review(ReviewID),
Price INT NOT NULL,
Manufacturer VARCHAR(50) NOT NULL,
ProductDimension VARCHAR(50) NOT NULL,
ProductWeight DECIMAL NOT NULL,
SellerID INT REFERENCES ecommerce.Seller(SellerID),
SellerName VARCHAR(50) NOT NULL,
Rating VARCHAR(50) NOT NULL,
DateOfManufacture DATE NOT NULL
);


CREATE TABLE ecommerce.Review(
ReviewId int  IDENTITY not null PRIMARY KEY,
Rating varchar(50),
Comments varchar(50),
CustomerId int references ecommerce.Customers(CustomerId),
ProductId int references ecommerce.Product(ProductId)
);

 

CREATE TABLE ecommerce.DeliveryPartner(
DeliveryPartnerId int  IDENTITY NOT NULL PRIMARY KEY,
AptNumber varchar(5),
HouseNumber varchar(5),
Street varchar(50),
Zipcode varchar(5),
City varchar(50),
State varchar(50),
Country varchar(50),
Contact varchar(50)
);

 

CREATE TABLE ecommerce.Returns(
ReturnId INT IDENTITY NOT NULL PRIMARY KEY,
CustomerId INT NOT NULL REFERENCES ecommerce.Customers(CustomerId),
DeliveryPartnerId INT NOT NULL REFERENCES ecommerce.DeliveryPartner(DeliveryPartnerId),
OrderId INT NOT NULL REFERENCES ecommerce.Orders (OrderId),
ProductId INT NOT NULL REFERENCES ecommerce.Product (ProductId),
ReturnDate DATE NOT NULL,
Description VARCHAR(50)
);

 
CREATE TABLE ecommerce.ShippingInfo(
ShippingId Int NOT NULL PRIMARY KEY,
DeliveryPartnerId Int  REFERENCES ecommerce.DeliveryPartner(DeliveryPartnerId),
ShippingCost decimal(10,2),
ShippingType varchar(50)
);

 

CREATE TABLE ecommerce.OrderDetails
(
OrderId INT NOT NULL REFERENCES ecommerce.Orders (OrderId),
ProductId INT NOT NULL REFERENCES ecommerce.Product (ProductId),
ProductName VARCHAR(50),
Quantity INT NOT NULL,
UnitCost DECIMAL(10,2) NOT NULL,
CONSTRAINT PKOrderDetail PRIMARY KEY CLUSTERED (OrderId, ProductId)
);


CREATE TABLE ecommerce.CartDetail(
CartId int NOT NULL  References ecommerce.Cart(CartId),
ProductId int NoT NULL References ecommerce.Product(productId),
CONSTRAINT PKCartDetail PRIMARY KEY CLUSTERED (CartId,ProductId)
);

CREATE TABLE ecommerce.WareHouse(
WarehouseId  int  IDENTITY Not Null Primary Key,
Street varchar(50),
Zipcode int,
City varchar(50),
State varchar(50),
Country varchar(50),
Contact varchar(50)
);


INSERT INTO Ecommerce.Customers(FirstName,LastName,Phone,DateOfBirth)
VALUES
    ('Jennifer','Johnson',4578985623,'10-06-2001'),
    ('Natalie','Robinson',7548965865,'01-23-1996'),
    ('John','Ferguson',1245785478,'05-28-1997'),
    ('Samuel','Patterson',2536987458,'12-15-1991'),
    ('Jasmine','James',7458965874,'11-01-1998'),
    ('Patricia','Hamilton',8547625698,'02-26-2003'),
    ('Michael','Hensley',2586589654,'04-09-1994'),
    ('Elijah','Fisher',7548658965,'10-23-1985'),
    ('Justin','Wright',7589621587,'01-01-1978'),
    ('Paula','Reyes',8659745896,'11-12-1987');
--Email was inserted after contraint addition

----------------------- INSERT TABLE SCRIPTS ----------------------
INSERT INTO Ecommerce.Address(CustomerId,AptNumber,HouseNumber,Street,ZipCode,City,State,Country,Contact)
VALUES
    (1,'2','A','Mystic Ave','02130','Boston','MA','USA','4578985623'),
    (5,'5','B','Smith Street','05614','Ney York City','NY','USA','7458965874'),
    (2,'2','3','Johnson Ave','02135','Virginia','VI','USA','7548965865'),
    (6,'3','A','Tremont Street','75486','Seattle','WA','USA','8547625698'),
    (3,'5','1','Parker Ave','02478','Atlanta','GE','USA','1245785478'),
    (4,'1','3','Highlands Street','41253','Boston','MA','USA','2536987458'),
    (8,'2','B','Brooks Ave','02153','Florida','FL','USA','7548658965'),
    (7,'3','A','Harvard Street','04258','Boston','MA','USA','2586589654'),
    (9,'2','B','Johnson Ave','03521','Boston','MA','USA','7589621587'),
    (10,'2','2','Midland Ave','01425','Newyork','NY','USA','8659745896');

INSERT INTO Ecommerce.ProductCategory(Name)
VALUES
    ('Sports'),
    ('Electronics'),
    ('Furniture'),
    ('Books'),
    ('Shoes'),
    ('Apparel'),
    ('Healthcare'),
    ('Accessories'),
    ('Cooking'),
    ('Network Components');

INSERT INTO Ecommerce.ProductSubCategory(ProductCategoryID,Name)
VALUES
    (01,'Basketball'),
    (01,'Football'),
    (02,'Mobile'),
    (02,'Laptops'),
    (05,'Sneakers'),
    (05,'Boots'),
    (06,'Jackets'),
    (04,'Biography'),
    (04,'Fiction'),
    (03,'Bedroom');
	
INSERT INTO Ecommerce.Seller(SellerName,AptNumber,HouseNumber,Street,City,State,Country,Zipcode,Contact)
VALUES
('Amazon','3D','115','Northampton','Boston','Massachusetts','USA','02119','6126780987'),
('BestBuy','1A','100','Washington','San Fransisco','Massachusetts','USA','019203','4567890987'),
('Target','2B','120','Newport','Los Angeles','Massachusetts','USA','076576','6176058923'),
('Nike','3C','134','Dudley','Boston','Massachusetts','USA','02118','3214567890'),
('Adidas','4E','178','Clinton','Seattle','Massachusetts','USA','456789','8907654321'),
('Flipkart','5F','345','Willow Ave','Portland','Massachusetts','USA','034567','5647890321'),
('Myntra','6G','789','Hoboken Ave','Jersey City','Massachusetts','USA','067890','4321567890'),
('Under Armour','7F','356','Palisade','Chicago','Massachusetts','USA','054456','7823451698'),
('5th Avenue','8I','234','Warwick','New york','Massachusetts','USA','034234','3114567890'),
('Crossword','9J','111','Hammond','Boston','Massachusetts','USA','02120','6176061633');

INSERT INTO ecommerce.Product(ProductCategoryID,ProductSubCategoryID,ProductName,ReviewID,Price,Manufacturer,ProductDimension,ProductWeight,SellerID,
    SellerName,Rating,DateOfManufacture)
VALUES (1,1,'Basketball Adult Size',NULL,100,'JD Sports','11*10*9',900.0,1,'Amazon','0','01-30-2009'),
	(2,3,'Apple iphone 7',NULL,1000,'Apple','5*4*6',140.0,2,'BestBuy','0','01-01-2014'),
	(3,10,'Queen Bedframe',NULL,500,'Wayfair','11*10*9',1000.0,3,'Target','0','02-06-2020'),
	(4,8,'Becoming by Michelle Obama',NULL,50,'Penguin','3*4*5',10.0,1,'Amazon','0','05-22-2019'),
	(2,3,'Samsung Galaxy S15',NULL,1000,'Samsung','5*4*6',140.0,2,'BestBuy','0','11-13-2018'),
	(5,5,'Adidas Running Shoes',NULL,100,'Adidas','8*9*10',100.0,3,'Target','0','07-19-2009'),
	(6,7,'Nike Fleece Jacket',NULL,200,'Nike','11*10*9',200.0,4,'Nike','0','08-15-2017'),
	(1,2,'Adidas Shoe',NULL,30,'Adidas','14*15*16',10.0,5,'Adidas','0','10-06-2016'),
	(4,9,'The Alchemist by Paulo Coelho',NULL,100,'Penguin','3*4*5',10.0,1,'Amazon','0','02-07-2012'),
	(5,6,'Nike Hiking Shoes',NULL,150,'Nike','8*9*10',100.0,3,'Target','0','05-09-2020');

INSERT INTO Ecommerce.Orders(CustomerId,PaymentId,DateCreated,DateShipped,ShippingId,Status)
VALUES
    (1,1,'04-06-2021','04-08-2021',5,'SHIPPED'),
    (5,2,'01-23-2021','01-25-2021',15,'SHIPPED'),
    (2,3,'05-28-2021','05-30-2021',16,'DELIVERED'),
    (6,4,'10-15-2020','10-17-2020',8,'DELIVERED'),
    (3,5,'11-01-2020','11-03-2020',7,'TRANSIT'),
    (4,6,'02-26-2020','02-28-2020',1,'SHIPPED'),
    (8,7,'04-09-2020','04-12-2020',2,'TRANSIT'),
    (7,8,'06-23-2021','06-24-2021',4,'DELIVERED'),
    (9,9,'01-01-2021','01-05-2021',3,'SHIPPED'),
    (10,10,'05-12-2021','05-15-2021',9,'TRANSIT');

INSERT INTO Ecommerce.OrderDetails(OrderId,ProductId,ProductName,Quantity,UnitCost)
VALUES
    (3,45,'Queen Bedframe',1,500),
	(2,52,'Nike Hiking Shoes',2,150.00),
	(5,50,'Adidas Shoe',2,30.00),
	(2,51,'The Alchemist by Paulo Coelho',3,100.00),
	(3,47,'Samsung Galaxy S15',1,1000.00),
	(3,48,'Adidas Running Shoes',1,100.00),
	(3,49,'Nike Fleece Jacket',5,200.00),
	(3,50,'Adidas Shoe',2,30.00),
    (4,46,'Becoming by Michelle Obama',4,50.00),
    (5,48,'Adidas Running Shoes',5,100.00),
	(5,49,'Nike Fleece Jacket',2,200.00),
    (6,48,'Adidas Running Shoes',1,100.00),
    (7,51,'The Alchemist by Paulo Coelho',1,100.00),
    (8,52,'Nike Hiking Shoes',1,150.00),
    (9,50,'Adidas Shoe',2,30.00),
    (10,46,'Becoming by Michelle Obama',5,50.00),
    (11,48,'Adidas Running Shoes',7,100.00),
    (8,49,'Nike Fleece Jacket',5,200.00);

INSERT INTO Ecommerce.cart(DateCreated,CustomerId)
VALUES
    ('05-23-2021',1),
	('06-21-2021',1),
	('01-25-2021',1),
    ('04-12-2021',5),
    ('01-11-2021',2),
    ('06-12-2021',6),
    ('07-21-2020',3),
    ('01-12-2021',4),
    ('02-05-2021',8),
    ('03-27-2020',7),
    ('02-25-2020',9),
    ('01-12-2020',10);

INSERT INTO Ecommerce.CartDetail(CartId,ProductId)
VALUES
    (1,45),
	(1,52),
	(1,50),
	(2,51),
	(3,47),
	(3,48),
	(3,49),
	(3,50),
    (4,46),
    (5,48),
	(5,49),
    (6,48),
    (7,51),
    (8,52),
    (9,50),
    (10,46),
    (11,48),
    (12,49);

INSERT INTO Ecommerce.WareHouse(Street,Zipcode,City,Country,Contact)
VALUES
    ('Main Street',25325,'Boston','USA','7452365898'),
	('I-901',45215,'New York City','USA','7755412586'),
	('I-94',47856,'Virginia','USA','5632558874'),
	('I-32',23658,'Ohio','USA','7584225586'),
	('Boston Turnpike',74123,'Maryland','USA','9985745586'),
	('I-53',75321,'Maine','USA','4258652147');

INSERT INTO Ecommerce.DeliveryPartner(AptNumber,HouseNumber,Street,Zipcode,City,State,Country,Contact)
VALUES
    ('21','A','Mystic Ave','02130','Boston','MA','USA','7458622214'),
    ('5','B','Smith Street','05614','Ney York City','NY','USA','7563214455'),
    ('23','3','Johnson Ave','02135','Virginia','VI','USA','7755214455'),
    ('31','A','Tremont Street','75486','Seattle','WA','USA','9875566214'),
    ('5','1','Parker Ave','02478','Atlanta','GE','USA','8875448862'),
    ('14','3','Highlands Street','41253','Boston','MA','USA','745862144'),
    ('23','B','Brooks Ave','02153','Florida','FL','USA','7754112248'),
    ('3','A','Harvard Street','04258','Boston','MA','USA','7548221144'),
    ('23','B','Johnson Ave','03521','Boston','MA','USA','8975462142'),
    ('21','2','Midland Ave','01425','Newyork','NY','USA','8955447541');

INSERT INTO Ecommerce.ShippingInfo(DeliveryPartnerId,ShippingCost,ShippingType)
VALUES
    (1,45.20,'AIR'),
	(1,52.45,'ROAD'),
	(1,50.74,'PALLET'),
	(2,51.85,'EXPEDITED'),
	(3,47.12,'EXPEDITED'),
	(3,48.42,'NOT PRIORITY'),
	(3,49.00,'AIR'),
	(3,50.41,'PALLET'),
    (4,46.42,'PRIORITY'),
    (5,48.75,'AIR'),
	(5,49.42,'ROAD'),
    (6,48.85,'NOT PRIORITY'),
    (7,51.23,'AIR'),
    (8,52.86,'ROAD'),
    (9,50.25,'PALLET'),
    (10,46.42,'EXPEDITED');

INSERT ecommerce.Payments(PaymentId, PaymentType, PaymentTotal, PaymentDate, ExpiryDate, CVV, CardNumber)
VALUES	(1,'Debit',10.2,'11/20/2019','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '111')),1234567890123456),
		(2,'Credit',20.1,'05/01/2020','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '222')),5678901212343456),
		(3,'Debit',30.3,'06/07/2020','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '333')),9012567812343456),
		(4,'Debit',13.2,'10/25/2019','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '444')),3456567890121234),
		(5,'Credit',25.1,'05/31/2021','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '555')),3456567856783456),
		(6,'Debit',37.3,'08/22/2020','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '666')),5678567834563456),
		(7,'Debit',130.2,'01/10/2019','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '777')),5421567876573456),
		(8,'Credit',250.1,'04/05/2021','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '888')),3142567845623456),
		(9,'Debit',370.3,'09/10/2020','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '999')),3578567823413456),
		(10,'Debit',26.2,'01/25/2019','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '145')),7865567809673456);

INSERT INTO Ecommerce.returns(CustomerId,DeliveryPartnerId,OrderId,ProductId,ReturnDate,Description)
VALUES
    (1,1,2,51,'04-10-2021','Incorrect Order'),
	(2,2,4,46,'06-10-2021','Not Satisfied'),
	(3,3,6,48,'11-10-2020','Damaged'),
	(4,4,7,51,'03-10-2020','Package issues'),
	(5,5,3,49,'01-30-2021','Not satisfied'),
	(6,6,5,48,'11-01-2020','Incorrect Order'),
	(7,7,9,50,'07-01-2021','Damaged'),
	(8,2,8,52,'04-25-2020','Not fit'),
    (9,3,10,46,'01-10-2021','Incorrect Order'),
    (10,4,11,48,'05-30-2021','Upgrades');

INSERT INTO Ecommerce.Review(Rating,Comments,CustomerId,ProductId)
VALUES
    (1,'Not good',1,45),
	(2,'Not the best value for the price',5,46),
	(4,'Best one out in the market',5,48),
	(5,'This is a great buy if you are on budget',8,48),
	(4,'This product does the work',10,51),
	(3,'Not great not terrible',2,48),
	(5,'One of the best products I bought',5,45),
	(2,'Worst',9,46),
    (5,'Product of the year',1,48),
    (1,'This is an imitation product',2,45);

----------------------- VIEW SCRIPTS ----------------------
    CREATE VIEW ecommerce.Purchase_Behaviour
AS
select grouped as [Age Group], name as [Popular Product Category] from (
select grouped,name,quantity,rank()over(partition by grouped order by quantity desc) as rn from (
select case when age<=20 then '10-20' 
when age>=21 and age<=30 then '21-30' 
 when age>=31 and age <=40 then '31-40' 
 when age>=41 then '40-60' else 'Others' end grouped, name,quantity from(
    Select distinct age,pc.Name,Quantity,
	rank() over (partition by age order by quantity desc) rnk
	from ecommerce.Customers c join ecommerce.Orders O
	on c.CustomerId=o.CustomerId
	join ecommerce.OrderDetails OD
	on o.OrderId=od.OrderId
	join ecommerce.Product p
	on od.ProductId=p.ProductID
	join ecommerce.ProductCategory pc
	on p.ProductCategoryID=pc.ProductCategoryID)a where rnk=1)b) final where rn=1

--=======================================================================================
CREATE VIEW ecommerce.Quarterly_Sales
AS
	Select DATENAME(YEAR,DateCreated) as [Year],
	case when DATENAME(QQ,DateCreated)=1 then 'Q-1'
	when DATENAME(QQ,DateCreated)=2 then 'Q-2'
	when DATENAME(QQ,DateCreated)=3 then 'Q-3'
	when DATENAME(QQ,DateCreated)=4 then 'Q-4' end as [Quarter]
	,sum(SubTotal) as [Total Sales] from ecommerce.Orders O
	join ecommerce.OrderDetails OD
	on o.OrderId=OD.OrderId
	group by DATENAME(YEAR,DateCreated),DATENAME(QQ,DateCreated)

----------------------- TABLE CONSTRAINTS ----------------------
CREATE FUNCTION isValidCVV(@paymentId INT)
RETURNS INT
AS
BEGIN
    DECLARE @len = 0;
    SET @len = SELECT LEN(cvv) from Payments WHERE paymentId = @paymentId;
    if @len > 3
        SET @len = 1
    else if @len < 3
        SET @len = 1
    RETURN @len
END

ALTER TABLE Ecommerce.Payments ADD CONSTRAINT checkCVV CHECK (dbo.isValidCVV(paymentId) = 0);



CREATE FUNCTION isValidCardNumber(@paymentId INT)
RETURNS INT
AS
BEGIN
    DECLARE @len = 0;
    SET @len = SELECT LEN(cardNumber) from Payments WHERE paymentId = @paymentId;
    if @len > 16
        SET @len = 1
    else if @len < 16
        SET @len = 1
    RETURN @len
END

ALTER TABLE Ecommerce.Payments ADD CONSTRAINT checkCardNumber CHECK (dbo.isValidCardNumber(paymentId) = 0);

----------------------- COMPUTED COLUMN ----------------------
CREATE FUNCTION calculateTotal(@orderId INT, @productId INT)
RETURNS DECIMAL
AS   
BEGIN      
    DECLARE @total DECIMAL = SELECT (unitcost * subTotal) FROM Ecommerce.OrderDetail
                             WHERE orderId = @orderId and productId = @productId;     
    SET @total = ISNULL(@total, 0);      
    RETURN @total;
END

ALTER TABLE Ecommerce.OrderDetail ADD subTotal AS (dbo.calculateTotal(orderId,productId));

----------------------- ENCRYPTION ----------------------
SET IDENTITY_INSERT Payments ON;

CREATE MASTER KEY ENCRYPTION BY 
PASSWORD = 'Team@14';

CREATE CERTIFICATE Team_14_Certificate
WITH SUBJECT = 'Team 14 Test Certificate',
EXPIRY_DATE = '2022-12-31';

CREATE SYMMETRIC KEY Team_14_SymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Team_14_Certificate;

OPEN SYMMETRIC KEY Team_14_SymmetricKey
DECRYPTION BY CERTIFICATE Team_14_Certificate;

INSERT Payments(PaymentId, PaymentType, PaymentTotal, PaymentDate, ExpiryDate, CVV, CardNumber)
VALUES	(1,'Debit',10.2,'11/20/2019','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '111')),123),
		(2,'Credit',20.1,'05/01/2020','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '222')),123),
		(3,'Debit',30.3,'06/07/2020','12/12/2025',EncryptByKey(Key_GUID(N'Team_14_SymmetricKey'), convert(varbinary, '333')),123);
		

select * from Payments;

SELECT DecryptByKey(CVV) 
FROM Payments;

SELECT CONVERT(VARCHAR, DecryptByKey(CVV)) AS CVV
FROM Payments;


DROP TABLE Payments;
