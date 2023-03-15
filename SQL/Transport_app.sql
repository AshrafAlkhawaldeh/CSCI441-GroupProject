CREATE TABLE Truck (
    Truck_ID INT PRIMARY KEY NOT NULL,
    Truck_VIN VARCHAR(17),
    Truck_Max_Load FLOAT,
    Truck_Capacity INT NOT NULL,
    Truck_Mileage INT
);

/* Vehicle damage report. For damage types refere to read me */

CREATE TABLE Car_Line_Item (
    Car_Line_Item_ID INT PRIMARY KEY NOT NULL,
    Vehicle_ID INT NOT NULL,
    Invoice_ID INT NOT NULL,
    Line_drawing BLOB, /*might need some modification*/
    Shipping_Cost DECIMAL(10,2)  NOT NULL,
    Notes VARCHAR(2000),
    FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Job(Invoice_ID)
);

/*Transported vehicle information */
/* Everything is NOT NULL in this category */

CREATE TABLE Vehicle (
    Vehicle_ID INT PRIMARY KEY NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    Vehicle_Make VARCHAR(255) NOT NULL,
    Vehicle_Model VARCHAR(255) NOT NULL,
    Vehicle_Year INT NOT NULL,
    Vehicle_Color VARCHAR(255) NOT NULL
);

/* Employee information including Admin, Assigner and driver information */

CREATE TABLE Employee(
    Employee_ID INT PRIMARY KEY NOT NULL,
    Is_Admin BOOL NOT NULL,
    Is_Driver BOOL NOT NULL,
    Employee_First_Name VARCHAR(255) NOT NULL,
    Employee_Last_Name VARCHAR(255) NOT NULL,
    Employee_Username VARCHAR(20) NOT NULL,
    Employee_Password VARCHAR(20) NOT NULL,
    Employee_Contact_No VARCHAR(20) NOT NULL,
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
    Company_Branch_ID INT NOT NULL, /*added*/
    Company_Name VARCHAR(255) NOT NULL, /* remove */
    Branch_Name VARCHAR(255)  NOT NULL,/* remove */
    Customer_Contact_No INT  NOT NULL,/* remove */
    Customer_Street_Address VARCHAR(255),/* remove */
    Customer_City VARCHAR(255),/* remove */
    Customer_State VARCHAR(13),/* remove */
    Customer_Zip_Code VARCHAR(9),/* remove */
    FOREIGN KEY (Company_Branch_ID) REFERENCES Company_Branch(Company_Branch_ID) /*added*/

);
);

/* All the information related to the invoices*/

CREATE TABLE Job (
    Invoice_ID INT PRIMARY KEY NOT NULL,
    Shipper_ID INT NOT NULL,
    Receiver_ID INT NOT NULL,
    Truck_ID INT NOT NULL,
    Driver_ID INT,
    Intake_ID INT NOT NULL , /* is it the Assigner_ID foriegn key*/
    Driver_signature BLOB, 
    Shipper_Signature BLOB,
    Receiver_Signature BLOB,
    Date_of_Order DATE NOT NULL, /* added */
    Job_Status ENUM ('Pending','Loading','Enroute','Arrived','Unloaded','Complete'), /* remove? */
    Date_job_completed DATE, /*added*/
    Job_Special_Instruction VARCHAR(2000), /*added*/
    Total_amount_$ DECIMAL(10,2), /* remove*/
    FOREIGN KEY (Shipper_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Receiver_ID) REFERENCES Customer(Customer_ID), /* needs further work incase the shipper and the receiver are not the same*/
    FOREIGN KEY (Truck_ID) REFERENCES Truck(Truck_ID),
    FOREIGN KEY (Driver_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Assigner_ID) REFERENCES Employee(Employee_ID) 
);

/* Record of payments received */
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY NOT NULL,
    Invoice_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Payment_Amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Invoice_ID) REFERENCES Job(Invoice_ID)
);

/* To save photos in the system as url text */

CREATE TABLE Photo_Record (
    Photo_ID INT PRIMARY KEY NOT NULL,
    Car_Line_Item_ID INT  NOT NULL,
    Photo_URL VARCHAR(4096)  NOT NULL,
    Photo_Note VARCHAR(2000)
    FOREIGN KEY (Car_Line_Item_ID) REFERENCES Car_Line_Item(Car_Line_Item_ID)
);

/*To save companies details*/

CREATE TABLE Company (
Company_ID INT PRIMARY KEY NOT NULL,
Company_Name VARCHAR(255) UNIQUE NOT NULL
);

/*To save company branches incase we are transfaring from one branch to an other for the same company*/

CREATE TABLE Company_Branch (
Company_Branch_ID INT PRIMARY KEY NOT NULL,
Company_ID INT NOT NULL,
Branch_Name VARCHAR(255) UNIQUE NOT NULL,
Branch_Contact_No VARCHAR(20) NOT NULL,
Branch_Street_Address VARCHAR(255),
Branch_City VARCHAR(255),
Branch_State VARCHAR(13),
Branch_Zip_Code VARCHAR(9)
FOREIGN KEY (Company_ID) REFERENCES Company(Company_ID)
);


