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

INSERT INTO Customers (CustomerID, CustomerName, PhoneNumber) VALUES
(3, 'Mariana', '1234567890');

-- Inserting data into Drivers
INSERT INTO Drivers (DriverID, DriverName, Salary) VALUES
(1, 'Alice Johnson', 55000.00),
(2, 'Bob Brown', 60000.00);

INSERT INTO Drivers (DriverID, DriverName, Salary) VALUES
(3, 'Chris Green', 62000.00);

-- Inserting data into Cars
INSERT INTO Cars (CarID, LicensePlateNumber, CarMake, DriverID) VALUES
(1, 'CJ11AAA', 'Ford', 1),
(2, 'CJ22BBB', 'Opel', 2),
(3, 'CJ33CCC', 'Volkswagen', 3);


-- Inserting data into Rides
INSERT INTO Rides (RideID, CustomerID, CarID, RideDate, DepartureTime, RideDuration, DeparturePlace, Destination, PaymentAmount) VALUES
(1, 1, 1, '2023-06-25', '07:30', 15, 'LP1', 'D1', 20),
(2, 1, 2, '2023-06-26', '08:30', 20, 'LP2', 'D3', 30),
(3, 2, 1, '2023-06-26', '12:30', 10, 'LP4', 'D4', 15),
(4, 1, 1, '2023-06-30', '10:15', 5, 'LP1', 'D2', 10),
(5, 3, 3, '2023-07-01', '15:05', 40, 'LP1', 'D4', 50),
(6, 3, 2, '2023-07-01', '20:00', 12, 'LP2', 'D2', 15);



-- a
select distinct D1.DriverID, D1.DriverName, D1.Salary
from Drivers D1 inner join Cars C on D1.DriverID = C.DriverID 
		       inner join Rides R on R.CarID = C.CarID
where C.CarMake = 'Ford' and R.Destination = 'Iulius Mall Cluj' 
	  and D1.Salary = (select max(D2.Salary)
						from Drivers D2 inner join Cars C2 on D2.DriverID = C2.DriverID 
		                                inner join Rides R2 on R2.CarID = C2.CarID
						where C2.CarMake = 'Ford' and R2.Destination = 'Iulius Mall Cluj' )

--b
SELECT c.DriverID, COUNT(DISTINCT r.CustomerID) No
FROM Cars c
INNER JOIN Rides r ON c.CarID = r.CarID
WHERE r.RideDate BETWEEN '2023.01.01' AND '2023.06.30'
GROUP BY c.DriverID
HAVING COUNT(DISTINCT r.CustomerID) >= ALL (
    SELECT COUNT(DISTINCT t.CustomerID)
    FROM Cars c
    INNER JOIN Rides t ON c.CarID = t.CarID
    WHERE t.RideDate BETWEEN '2023.01.01' AND '2023.06.30'
    GROUP BY c.DriverID
);
