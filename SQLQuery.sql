use Shop

CREATE TABLE County(
	CountyID	int IDENTITY(1,1) PRIMARY KEY,
	CountyName nvarchar(20)
);

CREATE TABLE Town(
	TownID int IDENTITY(1,1) PRIMARY KEY,
	CountyID int NOT NULL,
	TownName nvarchar(20) NOT NULL,
	CONSTRAINT FK_TCountyID FOREIGN KEY (CountyID) REFERENCES County(CountyID)
);

CREATE TABLE Addres(
	AddressID int IDENTITY(1,1) PRIMARY KEY,
	TownID int NOT NULL,
	Street1 char(20) NOT NULL,
	Street2 char(20) NOT NULL,
	AddressType char(20) NOT NULL,
	CONSTRAINT FK_ATownID FOREIGN KEY (TownID) REFERENCES Town(TownID)
);
CREATE TABLE UserRole(
	RoleID int IDENTITY(1,1) PRIMARY KEY,
	RoleName char(10) NOT NULL,
);
CREATE TABLE ShopUser(
	UserID int IDENTITY(1,1) PRIMARY KEY,
	LastLogin date NOT NULL,
	Username char(25) NOT NULL,
	UserPass char(25) NOT NULL,
	IsLoged bit NOT NULL DEFAULT 0,
	RoleID int NOT NULL,
	CONSTRAINT FK_SRoleID FOREIGN KEY (RoleID) REFERENCES UserRole(RoleID)
);

CREATE TABLE Customer(
	CustomerID int IDENTITY(1,1) PRIMARY KEY,
	FirstName char(20) NOT NULL,
	LastName char(20) NOT NULL,
	Email char(20) NOT NULL,
	Street1 nvarchar(40) NOT NULL,
	AddressID int NOT NULL,
	Phone char(20) NOT NULL,
	UserID int NOT NULL,
	DateRegistered date NOT NULL,
	IsActivated bit NOT NULL DEFAULT 0,
	CONSTRAINT FK_CAddressID FOREIGN KEY (AddressID) REFERENCES Addres(AddressID),
	CONSTRAINT FK_CUserID FOREIGN KEY (UserID) REFERENCES ShopUser(UserID)
); 

CREATE TABLE UserCard(
	CardID int NOT NULL PRIMARY KEY,
	CardProvider char(20) NOT NULL,
	ExpiryDate date NOT NULL
);

CREATE TABLE UserAccount(
	AccountID int IDENTITY(1,1) PRIMARY KEY,
	CardID int NOT NULL,
	CustomerID int NOT NULL,
	CONSTRAINT FK_UCardID FOREIGN KEY (CardID) REFERENCES UserCard(CardID)
);
CREATE TABLE OrderStatus(
	OrderStatusID int IDENTITY(1,1) PRIMARY KEY,
	OrderType char(20) NOT NULL 
);

CREATE TABLE DeliveryStatus(
	DeliveryStatusID int IDENTITY(1,1) PRIMARY KEY,
	IsDelivered bit NOT NULL DEFAULT 0 
);

CREATE TABLE ShippingMethod(
	ShippingID int IDENTITY(1,1) PRIMARY KEY,
	ShipProvider char(20) NOT NULL,
	ShipCharges decimal 
);
CREATE TABLE Cart(
	CartID int IDENTITY(1,1) PRIMARY KEY,
	CustomerID int NOT NULL,
	TotalCost decimal NOT NULL,
	OrderStatusID int NOT NULL,
	OrderDate date NOT NULL,
	DeliveryDate date NOT NULL,
	DeliveryStatusID int NOT NULL,
	ShippingID int NOT NULL,
	Note char(100)
	CONSTRAINT FK_CCustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT FK_COrderStatusID FOREIGN KEY (OrderStatusID) REFERENCES OrderStatus(OrderStatusID),
	CONSTRAINT FK_CDeliveryStatusID FOREIGN KEY (DeliveryStatusID) REFERENCES DeliveryStatus(DeliveryStatusID),
	CONSTRAINT FK_CShippingID FOREIGN KEY (ShippingID) REFERENCES ShippingMethod(ShippingID) 
);

CREATE TABLE UserTransaction(
	TransactionID int IDENTITY(1,1) PRIMARY KEY,
	CartID int NOT NULL,
	TranCost decimal NOT NULL,
	TranStatus bit NOT NULL DEFAULT 0,
	TranDate date NOT NULL,
	AccountID int NOT NULL,
	CONSTRAINT FK_UCartID FOREIGN KEY (CartID) REFERENCES Cart(CartID)
);

CREATE TABLE ProductImage(
	ImageID int IDENTITY(1,1) PRIMARY KEY,
	ImageUrl char(20) NOt NULL
); 

CREATE TABLE Category(
	CategoryID int IDENTITY(1,1) PRIMARY KEY,
	CatName char(30) NOT NULL,
	CatDescription char(100)
);

CREATE TABLE Supplier(
	SupplierID int IDENTITY(1,1) PRIMARY KEY,
	SupName char(30) NOT NULL,
	SupAddress char(50) NOT NULL,
	SupPhone char(20) NOT NULL 
);

CREATE TABLE Product(
	ProductId int IDENTITY(1,1) PRIMARY KEY,
	Quantity int DEFAULT 0,
	Price decimal DEFAULT 0.00,
	ProdDescription char(100),
	ProdName char(20) NOT NULL,
	Discout int DEFAULT 0,
	ProdWeight float DEFAULT 0.00,
	Condition char(10) NOT NULL,
	ImageID int NOT NULL,
	DateSupplied date NOT NULL,
	CategoryID int NOT NULL,
	SupplierID int NOT NULL,
	CONSTRAINT FK_PImageID FOREIGN KEY (ImageID) REFERENCES ProductImage(ImageID),
	CONSTRAINT FK_PCategoryID FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
	CONSTRAINT FK_PSupplierID FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID) 
);






drop table customer
drop table shopuser
drop table userrole
drop table addres
drop table town
drop table county
drop table useraccount
drop table usercard
drop table usettransaction
drop table orderstatus
drop table deliverystatus
drop table shippingmethod
drop table cart
drop table productimage
drop table category
drop table supplier
drop table product
