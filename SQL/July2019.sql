create database july2019
use july2019

CREATE TABLE Patients (
    PId INT PRIMARY KEY,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    Age INT,
    DateOfBirth DATE
);

CREATE TABLE Procedures (
    ProcId INT PRIMARY KEY,
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2) 
);

CREATE TABLE PatientsMedicalRecords (
    PatientId INT,
    ProcedureId INT,
    Date DATE,
    DoctorLastName VARCHAR(255),
    DoctorFirstName VARCHAR(255),
    DoctorSpecialty VARCHAR(255),
    DoctorSeniority INT,
    FOREIGN KEY (PatientId) REFERENCES Patients(PId),
    FOREIGN KEY (ProcedureId) REFERENCES Procedures(ProcId)
);

INSERT INTO Patients (PId, LastName, FirstName, Age, DateOfBirth) VALUES
(1, 'Smith', 'John', 30, '1992-07-16'),
(2, 'Doe', 'Jane', 25, '1997-02-25'),
(3, 'Brown', 'Charlie', 40, '1982-09-13');

INSERT INTO Procedures (ProcId, Name, Description, Price) VALUES
(1, 'X-Ray', 'Radiographic study of body structures', 100.00),
(2, 'MRI', 'Magnetic Resonance Imaging of the brain', 700.00),
(3, 'Blood Test', 'General health check through blood analysis', 50.00);
INSERT INTO Procedures (ProcId, Name, Description, Price) VALUES
(4, 'CT Scan', 'Computed Tomography Scan of the chest', 500.00),
(5, 'Echocardiogram', 'Ultrasound scan of the heart', 300.00),
(6, 'Ultrasound', 'Ultrasound scanning of abdominal region', 200.00);


INSERT INTO PatientsMedicalRecords (PatientId, ProcedureId, Date, DoctorLastName, DoctorFirstName, DoctorSpecialty, DoctorSeniority) VALUES
(1, 4, '2023-10-01', 'Gray', 'Meredith', 'Radiology', 8),
(2, 5, '2023-10-02', 'Shepherd', 'Derek', 'Cardiology', 9),
(3, 6, '2023-10-03', 'Bailey', 'Miranda', 'General Surgery', 7),
(1, 1, '2023-10-04', 'Karev', 'Alex', 'Radiology', 5),
(2, 2, '2023-10-05', 'Stevens', 'Izzie', 'Neurology', 6),
(3, 3, '2023-10-06', 'O’Malley', 'George', 'Pathology', 4),
(1, 4, '2023-10-07', 'Torres', 'Callie', 'Radiology', 8),
(2, 5, '2023-10-08', 'Yang', 'Cristina', 'Cardiology', 10),
(3, 6, '2023-10-09', 'Sloan', 'Mark', 'General Surgery', 9);

--5. On the given structure, write an SQL query that returns, for the specialties with the largest amount of money 
--collected from procedures, the specialty name, the total number of procedures performed within the specialty and 
--the amount of money collected (Specialty, NumberOfProcedures, AmountOfMoney). Display all specialties that 
--satisfy this condition.

select PMR.DoctorSpecialty as Speciality, count(PMR.ProcedureId) as NumberOfProcedures, sum(P.Price) as AmountOfMoney
from PatientsMedicalRecords PMR inner join Procedures P on PMR.ProcedureId = P.ProcId
group by PMR.DoctorSpecialty
having sum(P.Price) = ( select max(t.totalMoney) 
						from (
select PMR.DoctorSpecialty, sum(P.Price) as totalMoney
						from PatientsMedicalRecords PMR inner join Procedures P on PMR.ProcedureId = P.ProcId
						group by PMR.DoctorSpecialty
						) as t)
