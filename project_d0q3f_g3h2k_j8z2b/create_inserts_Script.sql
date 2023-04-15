CREATE TABLE CustomerPhoneAddress
(
    phoneNumber INTEGER   NOT NULL,
    address     VARCHAR(50) NOT NULL,
    PRIMARY KEY (phoneNumber)
);

CREATE TABLE Customer
(
    customerID   INTEGER,
    name         VARCHAR(50) NOT NULL,
    emailAddress VARCHAR(50) NOT NULL,
    phoneNumber  INTEGER,
    PRIMARY KEY (customerID),
    UNIQUE (emailAddress),
    FOREIGN KEY (phoneNumber) REFERENCES CustomerPhoneAddress ON DELETE CASCADE
);


CREATE TABLE Contract_Dates
(
    signedDate DATE,
    startDate  DATE,
    PRIMARY KEY (signedDate)
);

CREATE TABLE Signs_Contract
(
    contractID INTEGER,
    signedDate DATE,
    endDate    DATE,
    customerID INTEGER NOT NULL,
    PRIMARY KEY (contractID),
    FOREIGN KEY (customerID) REFERENCES Customer ON DELETE CASCADE,
    FOREIGN KEY (signedDate) REFERENCES Contract_Dates
);

CREATE TABLE Farm
(
    farmID  INTEGER,
    name    CHAR(64),
    address VARCHAR(50) NOT NULL,
    type    VARCHAR(16),
    PRIMARY KEY (farmID),
    UNIQUE (address)
);

CREATE TABLE Warehouse
(
    name     VARCHAR(50),
    capacity INTEGER,
    address  VARCHAR(50) NOT NULL,
    PRIMARY KEY (name),
    UNIQUE (address)
);

CREATE TABLE Farm_Warehouse_Supplies
(
    farmID        INTEGER,
    frequency     VARCHAR(50),
    warehouseName VARCHAR(50),
    PRIMARY KEY (farmID, warehouseName),
    FOREIGN KEY (warehouseName) REFERENCES Warehouse ON DELETE CASCADE,
    FOREIGN KEY (farmID) REFERENCES Farm ON DELETE CASCADE
);

CREATE TABLE Pays_Bill
(
    billID          INTEGER,
    customerID      INTEGER NOT NULL,
    fulfillmentDate DATE,
    fulfillmentTime TIMESTAMP,
    amount          REAL    NOT NULL,
    PRIMARY KEY (billID),
    FOREIGN KEY (customerID) REFERENCES Customer ON DELETE CASCADE
);

CREATE TABLE Drivers
(
    licenseNumber INTEGER,
    name          VARCHAR(50) NOT NULL,
    status        VARCHAR(32),
    PRIMARY KEY (licenseNumber)
);

CREATE TABLE TransportVehicle
(
    name   CHAR(50),
    type   VARCHAR(32),
    status VARCHAR(32),
    PRIMARY KEY (name)
);

CREATE TABLE DeliveryReceived
(
    warehouseName VARCHAR(50),
    scheduledDate DATE      NOT NULL,
    destination   VARCHAR(50) NOT NULL,
    receivedDate  DATE,
    PRIMARY KEY (warehouseName, scheduledDate, destination),
    FOREIGN KEY (warehouseName) REFERENCES Warehouse
);

CREATE TABLE Delivery
(
    deliveryID           INTEGER,
    deliveryTime         TIMESTAMP,
    totalWeight          REAL      NOT NULL,
    totalCost            REAL,
    customerID           INTEGER   NOT NULL,
    transportStatus      VARCHAR(32),
    driverLicenseNumber  INTEGER,
    transportVehicleName CHAR(50),
    storedSince          DATE,
    warehouseName        VARCHAR(50),
    scheduledDate        DATE      NOT NULL,
    destination          VARCHAR(50) NOT NULL,
    PRIMARY KEY (deliveryID),
    FOREIGN KEY (customerID) REFERENCES Customer,
    FOREIGN KEY (driverLicenseNumber) REFERENCES Drivers,
    FOREIGN KEY (transportVehicleName) REFERENCES TransportVehicle,
    FOREIGN KEY (warehouseName, scheduledDate, destination) REFERENCES DeliveryReceived
);

CREATE TABLE ItemCosts
(
    name CHAR(32),
    cost REAL,
    PRIMARY KEY (name)
);

CREATE TABLE Items
(
    deliveryID INTEGER,
    name       CHAR(32),
    weight     REAL,
    quantity   INTEGER,
    PRIMARY KEY (deliveryID, name),
    FOREIGN KEY (deliveryID) REFERENCES Delivery,
    FOREIGN KEY (name) REFERENCES ItemCosts
);

insert into CustomerPhoneAddress (PHONENUMBER, ADDRESS)
values (7783321234, '2345 West Mall');

insert into CustomerPhoneAddress(PHONENUMBER, ADDRESS)
values (7786321234, '1245 West Mall');

insert into CustomerPhoneAddress(phonenumber, address)
values (7783321231, '1345 West Mall');

insert into CustomerPhoneAddress(phonenumber, address)
values (7786321232, '1545 West Mall');

insert into CustomerPhoneAddress(phonenumber, address)
values (7782321234, '1645 West Mall');



insert into CustomerPhoneAddress(PHONENUMBER, ADDRESS)
values (7789321234, '2945 West Mall');

insert into CustomerPhoneAddress(PHONENUMBER, ADDRESS)
values (7781321234, '1845 West Mall');

insert into CustomerPhoneAddress(PHONENUMBER, ADDRESS)
values (7789321233, '1945 West Mall');

insert into CustomerPhoneAddress(PHONENUMBER, ADDRESS)
values (7782321294, '1045 West Mall');

insert into CustomerPhoneAddress(PHONENUMBER, ADDRESS)
values (7781321235, '1745 West Mall');


insert into Customer(customerid, name, emailaddress, phonenumber)
values (4560, 'Alex Ba', 'alexba@gmail.com', 7783321234);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4561, 'Alicia Keys', 'cust2@gmail.com', 7786321234);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4510, 'cust4', 'alexabc@gmail.com', 7783321231);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4511, 'cust5', 'cust5@gmail.com', 7786321232);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4563, 'Riha Sed', 'cust4@gmail.com', 7782321234);



insert into Customer(customerid, name, emailaddress, phonenumber)
values (4562, 'Justin B', 'cust1@gmail.com', 7789321234);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4564, 'Whitney Houston', 'cust10@gmail.com', 7781321234);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4512, 'cust6', 'cust6@gmail.com', 7789321233);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4513, 'cust7', 'cust7@gmail.com', 7782321294);

insert into Customer(customerid, name, emailaddress, phonenumber)
values (4514, 'cust8', 'cust8@gmail.com', 7781321235);



insert into Contract_Dates(signeddate, startdate)
values (TO_DATE('2023-01-23', 'YY-MM-DD'), TO_DATE('2023-02-01', 'YY-MM-DD'));
insert into Contract_Dates(signeddate, startdate)
values (TO_DATE('2022-04-03', 'YY-MM-DD'), TO_DATE('2022-04-09', 'YY-MM-DD'));
insert into Contract_Dates(signeddate, startdate)
values (TO_DATE('2022-05-23', 'YY-MM-DD'), TO_DATE('2022-06-07', 'YY-MM-DD'));
insert into Contract_Dates(signeddate, startdate)
values (TO_DATE('2022-03-13', 'YY-MM-DD'), TO_DATE('2022-03-19', 'YY-MM-DD'));
insert into Contract_Dates(signeddate, startdate)
values (TO_DATE('2022-10-17', 'YY-MM-DD'), TO_DATE('2022-10-29', 'YY-MM-DD'));


insert into Signs_Contract(contractid, signeddate, enddate, customerid)
values (1234, TO_DATE('2023-01-23', 'YY-MM-DD'), TO_DATE('2023-01-23', 'YY-MM-DD'), 4510);
insert into Signs_Contract(contractid, signeddate, enddate, customerid)
values (1236, TO_DATE('2022-04-03', 'YY-MM-DD'), TO_DATE('2024-02-24', 'YY-MM-DD'), 4511);
insert into Signs_Contract(contractid, signeddate, enddate, customerid)
values (1237, TO_DATE('2022-05-23', 'YY-MM-DD'), TO_DATE('2023-03-23', 'YY-MM-DD'), 4512);
insert into Signs_Contract(contractid, signeddate, enddate, customerid)
values (1238, TO_DATE('2022-03-13', 'YY-MM-DD'), TO_DATE('2023-08-23', 'YY-MM-DD'), 4560);
insert into Signs_Contract(contractid, signeddate, enddate, customerid)
values (1239, TO_DATE('2022-10-17', 'YY-MM-DD'), TO_DATE('2024-01-23', 'YY-MM-DD'), 4561);


insert into Farm(farmid, name, address, type)
values (234, 'Maplewood Farm', '405 Seymour River Pl, North Vancouver', 'fruits');
insert into Farm(farmid, name, address, type)
values (235, 'Maan Farms', '790 McKenzie Rd, Abbotsford', 'fruits');
insert into Farm(farmid, name, address, type)
values (236, 'Aldor Acres', '24990 84 Ave, Langley Twp', 'vegetables');
insert into Farm(farmid, name, address, type)
values (237, 'Southland Farms', '6767 Balaclava St, Vancouver', 'pumpkins');
insert into Farm(farmid, name, address, type)
values (238, 'Eagle Acres Dairy Farm', '8796 240 St, Langley Twp', 'meat');



insert into Warehouse(name, capacity, address)
values ('warehouse_1', 500, ' 5021 Granville St');
insert into Warehouse(name, capacity, address)
values ('warehouse_2', 750, ' 302 Davie St');
insert into Warehouse(name, capacity, address)
values ('warehouse_3', 400, '229 English Bay');
insert into Warehouse(name, capacity, address)
values ('warehouse_4', 550, '5959 Student Union Blvd');
insert into Warehouse(name, capacity, address)
values ('warehouse_5', 1090, '5612 Newton Wynd');


insert into Farm_Warehouse_Supplies(farmid, frequency, warehousename)
values (234, 'bi-weekly', 'warehouse_1');
insert into Farm_Warehouse_Supplies(farmid, frequency, warehousename)
values (235, 'monthly', 'warehouse_1');
insert into Farm_Warehouse_Supplies(farmid, frequency, warehousename)
values (236, 'weekly', 'warehouse_2');
insert into Farm_Warehouse_Supplies(farmid, frequency, warehousename)
values (237, 'bi-weekly', 'warehouse_3');
insert into Farm_Warehouse_Supplies(farmid, frequency, warehousename)
values (238, 'monthly', 'warehouse_3');



insert into Pays_Bill(billid, customerid, fulfillmentdate, fulfillmenttime, amount)
values (356, 4511, TO_DATE('2023-02-23', 'YY-MM-DD'), TO_DATE('23:44', 'HH24:MI'), 100.7);
insert into Pays_Bill(billid, customerid, fulfillmentdate, fulfillmenttime, amount)
values (357, 4512, TO_DATE('2023-02-23', 'YY-MM-DD'), TO_DATE('23:44', 'HH24:MI'), 356.7);
insert into Pays_Bill(billid, customerid, fulfillmentdate, fulfillmenttime, amount)
values (358, 4513, TO_DATE('2023-02-24', 'YY-MM-DD'), TO_DATE('13:22', 'HH24:MI'), 200.0);
insert into Pays_Bill(billid, customerid, fulfillmentdate, fulfillmenttime, amount)
values (359, 4562, TO_DATE('2023-02-25', 'YY-MM-DD'), TO_DATE('18:41', 'HH24:MI'), 1500.45);
insert into Pays_Bill(billid, customerid, fulfillmentdate, fulfillmenttime, amount)
values (360, 4564, TO_DATE('2023-02-28', 'YY-MM-DD'), TO_DATE('10:44', 'HH24:MI'), 100.7);


insert into Drivers(licensenumber, name, status)
values (1234567, 'Joe Smith', 'delivering');
insert into Drivers(licensenumber, name, status)
values (1234568, 'Brenda Fox', 'free');
insert into Drivers(licensenumber, name, status)
values (1234569, 'Terry Daniels', 'delivering');
insert into Drivers(licensenumber, name, status)
values (1234570, 'Bob Newman', 'free');
insert into Drivers(licensenumber, name, status)
values (1234571, 'Sara Taylor', 'delivering');

insert into TransportVehicle(name, type, status)
values ('truck_1', 'semi-truck', 'in-use');
insert into TransportVehicle(name, type, status)
values ('truck_2', 'refrigerated', 'free');
insert into TransportVehicle(name, type, status)
values ('truck_3', 'box truck', 'in-use');
insert into TransportVehicle(name, type, status)
values ('truck_4', 'refrigerated', 'in-use');
insert into TransportVehicle(name, type, status)
values ('truck_5', 'semi-trailer', 'free');


insert into DeliveryReceived(warehousename, scheduleddate, destination, receiveddate)
values ('warehouse_1', TO_DATE('2023-02-26', 'YY-MM-DD'), '2345 West Mall', TO_DATE('2023-02-26', 'YY-MM-DD'));
insert into DeliveryReceived(warehousename, scheduleddate, destination, receiveddate)
values ('warehouse_1', TO_DATE('2023-02-25', 'YY-MM-DD'), '1245 West Mall', TO_DATE('2023-02-25', 'YY-MM-DD'));
insert into DeliveryReceived(warehousename, scheduleddate, destination, receiveddate)
values ('warehouse_2', TO_DATE('2023-02-28', 'YY-MM-DD'), '1345 West Mall', TO_DATE('2023-03-01', 'YY-MM-DD'));
insert into DeliveryReceived(warehousename, scheduleddate, destination, receiveddate)
values ('warehouse_2', TO_DATE('2023-02-25', 'YY-MM-DD'), '1545 West Mall', TO_DATE('2023-02-26', 'YY-MM-DD'));
insert into DeliveryReceived(warehousename, scheduleddate, destination, receiveddate)
values ('warehouse_3', TO_DATE('2023-02-25', 'YY-MM-DD'), '1645 West Mall', TO_DATE('2023-02-26', 'YY-MM-DD'));
INSERT INTO DeliveryReceived VALUES ('warehouse_3', TO_DATE('2023-02-05', 'yyyy-mm-dd'), '123 ABC Rd', TO_DATE('2023-02-05', 'yyyy-mm-dd'));
INSERT INTO DeliveryReceived VALUES ('warehouse_1', TO_DATE('2023-02-05', 'yyyy-mm-dd'), '234 5th Ave', TO_DATE('2023-02-05', 'yyyy-mm-dd'));
INSERT INTO DeliveryReceived VALUES ('warehouse_1', TO_DATE('2023-02-05', 'yyyy-mm-dd'), '410 8th Ave E', NULL);




insert into Delivery(deliveryid, deliverytime, totalweight, totalcost, customerid, transportstatus, driverlicensenumber, transportvehiclename, storedsince, warehousename, scheduleddate, destination)
values (456,TO_DATE('11:16', 'HH24:MI'), 45.5, 1600.56,4560, 'in-delivery',1234568,'truck_2',TO_DATE('2023-02-21', 'YY-MM-DD'),'warehouse_1', TO_DATE('2023-02-26', 'YY-MM-DD'), '2345 West Mall');

insert into Delivery(deliveryid, destination, deliverytime, scheduleddate, totalweight, totalcost, customerid, transportstatus, driverlicensenumber, transportvehiclename, storedsince, warehousename)
values (457, '1245 West Mall', TO_TIMESTAMP('2023-02-25 19:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-02-25', 'YY-MM-DD'), 45.5, 1700.56, 4561,
        'delivered', 1234571, 'truck_2', TO_DATE('2023-02-12', 'YY-MM-DD'), 'warehouse_1');

insert into Delivery(DELIVERYID, DESTINATION, DELIVERYTIME, SCHEDULEDDATE, TOTALWEIGHT, TOTALCOST, CUSTOMERID, TRANSPORTSTATUS, DRIVERLICENSENUMBER, TRANSPORTVEHICLENAME, STOREDSINCE, WAREHOUSENAME)
values (458, '1345 West Mall', TO_DATE('14:16', 'HH24:MI'), TO_DATE('2023-02-28', 'YY-MM-DD'), 45.5, 1800.56, 4510,
        'in warehouse', 1234569, 'truck_3', TO_DATE('2023-02-22', 'YY-MM-DD'), 'warehouse_2');

insert into Delivery(deliveryid, destination, deliverytime, scheduleddate, totalweight, totalcost, customerid, transportstatus, driverlicensenumber, transportvehiclename, storedsince, warehousename)
values (459, '1545 West Mall', TO_TIMESTAMP('2023-02-25 19:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-02-25', 'YY-MM-DD'), 45.5, 1900.56, 4513,
        'delayed', 1234571 , 'truck_4', TO_DATE('2023-02-24', 'YY-MM-DD'), 'warehouse_2');

insert into Delivery(deliveryid, destination, deliverytime, scheduleddate, totalweight, totalcost, customerid, transportstatus, driverlicensenumber, transportvehiclename, storedsince, warehousename)
values (460, '1645 West Mall', TO_TIMESTAMP('2023-02-25 19:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-02-25', 'YY-MM-DD'), 45.5, 1600.56, 4513,
        'in-delivery', 1234571, 'truck_5', TO_DATE('2023-02-22', 'YY-MM-DD'), 'warehouse_3');

INSERT INTO Delivery VALUES (461, to_timestamp('2023-02-05 15:00:00', 'yyyy-mm-dd hh24:mi:ss'), 15, 150.45, 4512,
    'in warehouse', 1234569, 'truck_2', to_date('2023-01-01', 'yyyy-mm-dd'), 'warehouse_3', 
    TO_DATE('2023-02-05', 'yyyy-mm-dd'), '123 ABC Rd');

INSERT INTO Delivery VALUES (462, to_timestamp('2023-02-05 18:13:00', 'yyyy-mm-dd hh24:mi:ss'), 56.2 , 260.12, 4563,
    'delivered', 1234569, 'truck_4', to_date('2023-01-16', 'yyyy-mm-dd'), 'warehouse_1', 
    TO_DATE('2023-02-05', 'yyyy-mm-dd'), '234 5th Ave');

INSERT INTO Delivery VALUES (463, to_timestamp('2023-02-05 06:21:00', 'yyyy-mm-dd hh24:mi:ss'), 98.0, 243.22, 4563,
    'in warehouse', 1234569, 'truck_2', to_date('2023-02-01', 'yyyy-mm-dd'), 'warehouse_1', 
    TO_DATE('2023-02-05', 'yyyy-mm-dd'), '410 8th Ave E');

insert into ItemCosts
values ('apples', 25);
insert into ItemCosts
values ('mango', 20);
insert into ItemCosts
values ('berries', 35);
insert into ItemCosts
values ('orange', 12);
insert into ItemCosts
values ('banana', 15);
INSERT INTO ItemCosts VALUES ('kiwi', 14);

insert into Items
values (456, 'apples', 12.2, 10);
insert into Items
values (457, 'mango', 5, 2);
insert into Items
values (458, 'mango', 10, 4);
insert into Items
values (459, 'orange', 2, 1);
insert into Items
values (460, 'banana', 2, 3);
insert into Items
values (461, 'kiwi', 87.4, 32);
insert into Items
values (462, 'kiwi', 56.4, 65);
insert into Items
values (463, 'kiwi', 64, 123);
insert into Items
values (463, 'banana', 139, 207);
insert into Items
values (462, 'banana', 355, 173);



CREATE TABLE Business
(
    customerID  INTEGER,
    companyName VARCHAR(50) NOT NULL,
    type        VARCHAR(16),
    PRIMARY KEY (customerID),
    FOREIGN KEY (customerID) REFERENCES Customer ON DELETE CASCADE
);

CREATE TABLE Individual
(
    customerID   INTEGER,
    rewardPoints INTEGER,
    PRIMARY KEY (customerID),
    FOREIGN KEY (customerID) REFERENCES Customer ON DELETE CASCADE
);

insert into Business(customerid, companyname, type)
values (4510, 'Browns Crafthouse', 'Restaurant');
insert into Business(customerid, companyname, type)
values (4511, 'Save on Foods', 'Grocery Store');
insert into Business(customerid, companyname, type)
values (4512, 'Costco', 'Wholesale Store');
insert into Business(customerid, companyname, type)
values (4513, 'Uncle Fatih’s', 'Restaurant');
insert into Business(customerid, companyname, type)
values (4514, 'Safeway', 'Grocery Store');


insert into Individual(customerid, rewardpoints)
values (4560, 2000);
insert into Individual(customerid, rewardpoints)
values (4561, 900);
insert into Individual(customerid, rewardpoints)
values (4562, 2030);
insert into Individual(customerid, rewardpoints)
values (4563, 1003);
insert into Individual(customerid, rewardpoints)
values (4564, 4031);


commit;