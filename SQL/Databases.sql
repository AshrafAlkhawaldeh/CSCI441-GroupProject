
CREATE TABLE Truck (
    Truck_ID INT PRIMARY KEY NOT NULL,
    Truck_VIN VARCHAR(17),
    Truck_Max_Load FLOAT,
    Truck_Capacity FLOAT  NOT NULL,
    Truck_Mileage INT
);

/* Vehicle damage report. For damage types refere to read me */

CREATE TABLE Damage_Record (
    Damage_Record_ID INT PRIMARY KEY NOT NULL,
    Vehicle_ID INT NOT NULL,
    Invoice_ID INT NOT NULL,
    Damage VARCHAR(255),
    Line_drawing BLOB, /*might need some modification*/
    Amount_$ DECIMAL(10,2)  NOT NULL,
    Payment_Date DATE NOT NULL,
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Job(Invoice_ID)
);

/*Transported vehicle information */

CREATE TABLE Vehicle (
    Vehicle_ID INT PRIMARY KEY NOT NULL,
    VIN VARCHAR(17),
    Vehicle_Make VARCHAR(255),
    Vehicle_Model VARCHAR(255),
    Vehicle_Year INT,
    Vehicle_Color VARCHAR(255)
);

/* Employee information including Admin, Assigner and driver information */

CREATE TABLE Employee(
    Employee_ID INT PRIMARY KEY NOT NULL,
    Is_It_Admin BOOL NOT NULL,
    Is_it_Driver BOOL NOT NULL,
    Employee_First_Name VARCHAR(255) NOT NULL,
    Employee_Last_Name VARCHAR(255) NOT NULL,
    Employee_Username VARCHAR(20),
    Employee_Password VARCHAR(20),
    Employee_Contact_No INT NOT NULL,
    Employee_Street_Address VARCHAR(255),
    Employee_City VARCHAR(255),
    Employee_State VARCHAR(13),
    Employee_Zip_Code VARCHAR(9)
);

/* Customer information */

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY NOT NULL,
    Customer_First_Name VARCHAR(255) NOT NULL,
    Customer_Last_Name VARCHAR(255) NOT NULL,
    Company_Name VARCHAR(255) NOT NULL, /* is it a foreign key from the Companies table ? */
    Branch_Name VARCHAR(255)  NOT NULL, /* is it a foreign key from the Company_Branches table ? */
    Customer_Contact_No INT  NOT NULL,
    Customer_Street_Address VARCHAR(255),
    Customer_City VARCHAR(255),
    Customer_State VARCHAR(13),
    Customer_Zip_Code VARCHAR(9)
);

/* All the information related to the invoices*/

CREATE TABLE Job (
    Invoice_ID INT PRIMARY KEY NOT NULL,
    Shipper_ID INT NOT NULL,
    Receiver_ID INT NOT NULL,
    Truck_ID INT NOT NULL,
    Driver_ID INT ,
    Assigner_ID INT  ,
    Driver_signature BLOB, 
    Shipper_Signature BLOB,
    Receiver_Signature BLOB,
    Job_Status ENUM ('Pending','Loading','Enroute','Arrived','Unloaded','Complete'),
    Total_amount_$ DECIMAL(10,2),
    FOREIGN KEY (Shipper_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Receiver_ID) REFERENCES Customer(Customer_ID), /* needs further work incase the shipper and the receiver are not the same*/
    FOREIGN KEY (Truck_ID) REFERENCES Truck(Truck_ID),
    FOREIGN KEY (Driver_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Assigner_ID) REFERENCES Employee(Employee_ID) 
);

/* To save photos in the system as url text */

CREATE TABLE Photo_Record (
    Photo_ID INT PRIMARY KEY NOT NULL,
    Damage_Record_ID INT  NOT NULL,
    URL VARCHAR(4096)  NOT NULL,
    FOREIGN KEY (Damage_Record_ID) REFERENCES Damage_Record(Damage_Record_ID)
);

/*To save companies details*/

CREATE TABLE Companies (
Company_ID INT PRIMARY KEY NOT NULL,
Company_Name VARCHAR(255) UNIQUE NOT NULL
);

/*To save company branches incase we are transfaring from one branch to an other for the same company*/

CREATE TABLE Company_Branches (
Company_Branches_ID INT PRIMARY KEY NOT NULL,
Company_ID INT  NOT NULL,
Branch_Name VARCHAR(255) UNIQUE NOT NULL,
FOREIGN KEY (Company_ID) REFERENCES Companies(Company_ID)
);

