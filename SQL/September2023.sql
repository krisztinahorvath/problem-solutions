create database sept2023

use sept2023

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    PhoneNumber VARCHAR(50)
);

CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY,
    DriverName VARCHAR(255),
    Salary DECIMAL(10, 2)
);

CREATE TABLE Cars (
    CarID INT PRIMARY KEY,
    LicensePlateNumber VARCHAR(50),
    CarMake VARCHAR(50),
    DriverID INT,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

CREATE TABLE Rides (
    RideID INT PRIMARY KEY,
    CustomerID INT,
    CarID INT,
    RideDate DATE,
    DepartureTime TIME,
    RideDuration DECIMAL(10, 2), -- Assuming this is in hours
    DeparturePlace VARCHAR(255),
    Destination VARCHAR(255),
    PaymentAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Cars(CarID)
);


-- Inserting data into Customers
INSERT INTO Customers (CustomerID, CustomerName, PhoneNumber) VALUES
(1, 'John Doe', '1234567890'),
(2, 'Jane Smith', '0987654321');

-- Inserting data into Drivers
INSERT INTO Drivers (DriverID, DriverName, Salary) VALUES
(1, 'Alice Johnson', 55000.00),
(2, 'Bob Brown', 60000.00);

-- Inserting data into Cars
INSERT INTO Cars (CarID, LicensePlateNumber, CarMake, DriverID) VALUES
(1, 'XYZ123', 'Toyota', 1),
(2, 'ABC456', 'Honda', 2);

-- Inserting data into Rides
INSERT INTO Rides (RideID, CustomerID, CarID, RideDate, DepartureTime, RideDuration, DeparturePlace, Destination, PaymentAmount) VALUES
(1, 1, 1, '2023-10-01', '08:00:00', 1.5, 'Downtown', 'Airport', 45.00),
(2, 2, 2, '2023-10-02', '09:00:00', 2.0, 'Suburbs', 'City Center', 70.00);

-- Assuming we might need to add a new driver and car
INSERT INTO Drivers (DriverID, DriverName, Salary) VALUES
(3, 'Chris Green', 62000.00);

INSERT INTO Cars (CarID, LicensePlateNumber, CarMake, DriverID) VALUES
(3, 'FOR123', 'Ford', 3);

-- Inserting rides where the destination is Iulius Mall Cluj and the car is a Ford
INSERT INTO Rides (RideID, CustomerID, CarID, RideDate, DepartureTime, RideDuration, DeparturePlace, Destination, PaymentAmount) VALUES
(3, 1, 3, '2023-10-05', '10:00:00', 0.8, 'Central Park', 'Iulius Mall Cluj', 30.00),
(4, 2, 3, '2023-10-06', '11:00:00', 0.5, 'Office Park', 'Iulius Mall Cluj', 25.00);

-- a
select distinct D1.DriverID, D1.DriverName, D1.Salary
from Drivers D1 inner join Cars C on D1.DriverID = C.DriverID 
		       inner join Rides R on R.CarID = C.CarID
where C.CarMake = 'Ford' and R.Destination = 'Iulius Mall Cluj' 
	  and D1.Salary = (select max(D2.Salary)
						from Drivers D2 inner join Cars C2 on D2.DriverID = C2.DriverID 
		                                inner join Rides R2 on R2.CarID = C2.CarID
						where C2.CarMake = 'Ford' and R2.Destination = 'Iulius Mall Cluj' )