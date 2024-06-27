create database NewspapersJournals
use NewspapersJournals


CREATE TABLE Newspapers (
    NewspaperID INT PRIMARY KEY,
    NewspaperName VARCHAR(255)
);

CREATE TABLE Journalists (
    JournalistID INT PRIMARY KEY,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    NewspaperID INT,
    FOREIGN KEY (NewspaperID) REFERENCES Newspapers(NewspaperID)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE Articles (
    ArticleID INT PRIMARY KEY,
    Title VARCHAR(255),
    PublicationDate DATE,
    Text TEXT,
    JournalistID INT,
    CategoryID INT,
    FOREIGN KEY (JournalistID) REFERENCES Journalists(JournalistID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Newspapers (NewspaperID, NewspaperName) VALUES (1, 'Universe');
INSERT INTO Categories (CategoryID, Name) VALUES (1, 'Economics');
INSERT INTO Categories (CategoryID, Name) VALUES (2, 'Sports');
INSERT INTO Journalists (JournalistID, LastName, FirstName, NewspaperID) VALUES (1, 'Smith', 'John', 1);
INSERT INTO Journalists (JournalistID, LastName, FirstName, NewspaperID) VALUES (2, 'Doe', 'Jane', 1);
INSERT INTO Journalists (JournalistID, LastName, FirstName, NewspaperID) VALUES (3, 'Smith', 'John', 1);
INSERT INTO Journalists (JournalistID, LastName, FirstName, NewspaperID) VALUES (4, 'Doe', 'Jane', 1);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES 
(1, 'Economic Trends', '2023-06-01', 'Detailed analysis of current economic trends.', 1, 1),
(2, 'Market Forecast', '2023-06-05', 'Predictions on the stock market movements.', 2, 1);
-- Additional category and articles
INSERT INTO Categories (CategoryID, Name) VALUES (3, 'Technology');

-- Additional articles in different categories
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES 
(3, 'Tech Innovations', '2023-06-10', 'Upcoming technology innovations to watch.', 1, 3),
(4, 'Championship Recap', '2023-06-02', 'Recap of the latest sports championship.', 2, 2);


-- a
select count(*) as TotalNoArticles
from Categories C inner join Articles A on C.CategoryID = A.CategoryID 
	inner join Journalists J on A.JournalistID = J.JournalistID
	inner join Newspapers N on J.NewspaperID = N.NewspaperID
where N.NewspaperName = 'Universe' and C.Name = 'Economics'

-- b1

delete from Articles
delete from Journalists
delete from Newspapers
delete from Categories

INSERT INTO Categories (CategoryID, Name) VALUES (1, 'c1');
INSERT INTO Categories (CategoryID, Name) VALUES (2, 'c2');
INSERT INTO Categories (CategoryID, Name) VALUES (3, 'c3');
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (1, 'a1', '2022-01-01', 't1', 1, 2);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (2, 'a2', '2022-02-01', 't2', 2, 3);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (3, 'a3', '2022-01-01', 't3', 3, 1);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (4, 'a4', '2022-05-01', 't4', 1, 2);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (5, 'a5', '2022-03-01', 't5', 2, 1);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (7, 'a7', '2022-07-01', 't7', 2, 2);
INSERT INTO Articles (ArticleID, Title, PublicationDate, Text, JournalistID, CategoryID) VALUES (8, 'a8', '2022-05-01', 't8', 4, 2);

SELECT A.JournalistID, COUNT(*) No 
FROM Articles A INNER JOIN Categories C ON A.CategoryID = C.CategoryID 
WHERE C.Name = 'c2' 
GROUP BY A.JournalistID 
HAVING 2 < (SELECT COUNT(*) 
          FROM Articles A2  
          WHERE A2.JournalistID = A.JournalistID) 