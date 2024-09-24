create database CodingChallenge;
 
use CodingChallenge;

CREATE TABLE Artists ( ArtistID INT PRIMARY KEY, Name VARCHAR(255) NOT NULL, Biography TEXT,
Nationality VARCHAR(100));

INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES (1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'), (2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

CREATE TABLE Categories ( CategoryID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL);

INSERT INTO Categories (CategoryID, Name) VALUES (1, 'Painting'), (2, 'Sculpture'),
(3, 'Photography');

CREATE TABLE Artworks ( ArtworkID INT PRIMARY KEY, Title VARCHAR(255) NOT NULL, ArtistID INT, CategoryID INT, Year INT, Description TEXT, ImageURL VARCHAR(255), FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID),
FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID));

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL)
VALUES 
    (1, N'Starry Night', 2, 1, 1889, N'A famous painting by Vincent van Gogh.', N'starry_night.jpg'),
    (2, N'Mona Lisa', 3, 1, 1503, N'The iconic portrait by Leonardo da Vinci.', N'mona_lisa.jpg'),
    (3, N'Guernica', 1, 1, 1937, N'Pablo Picasso''s powerful anti-war mural.', N'guernica.jpg');

CREATE TABLE Exhibitions ( ExhibitionID INT PRIMARY KEY, Title VARCHAR(255) NOT NULL, StartDate DATE, EndDate DATE,
Description TEXT);

INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES (1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

CREATE TABLE ExhibitionArtworks ( ExhibitionID INT, ArtworkID INT, PRIMARY KEY (ExhibitionID, ArtworkID), FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID),
FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID));

INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES (1, 1), (1, 2), (1, 3),
(2, 2);


1. select A.Name as ArtistName, COUNT(AW.ArtworkID) as ArtworkCount
from Artists A
left join
Artworks AW 
on A.ArtistID = AW.ArtistID
group by A.ArtistID, A.Name
order by ArtworkCount DESC;

2. SELECT AR.Title, A.Nationality, AR.Year
FROM Artworks AR
JOIN Artists A ON AR.ArtistID = A.ArtistID
WHERE A.Nationality IN ('Spanish', 'Dutch')
ORDER BY AR.Year ASC;



3. SELECT A.Name AS ArtistName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks AR ON A.ArtistID = AR.ArtistID
JOIN Categories C ON AR.CategoryID = C.CategoryID
WHERE C.Name = 'Painting'
GROUP BY A.Name;

4.SELECT AR.Title AS ArtworkTitle, A.Name AS ArtistName, C.Name AS CategoryName
FROM ExhibitionArtworks EA
JOIN Artworks AR ON EA.ArtworkID = AR.ArtworkID
JOIN Artists A ON AR.ArtistID = A.ArtistID
JOIN Categories C ON AR.CategoryID = C.CategoryID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

5.SELECT A.Name AS ArtistName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks AR ON A.ArtistID = AR.ArtistID
GROUP BY A.Name
HAVING COUNT(AR.ArtworkID) > 2;

6.SELECT AR.Title AS ArtworkTitle
FROM Artworks AR
JOIN ExhibitionArtworks EA1 ON AR.ArtworkID = EA1.ArtworkID
JOIN Exhibitions E1 ON EA1.ExhibitionID = E1.ExhibitionID
JOIN ExhibitionArtworks EA2 ON AR.ArtworkID = EA2.ArtworkID
JOIN Exhibitions E2 ON EA2.ExhibitionID = E2.ExhibitionID
WHERE E1.Title = 'Modern Art Masterpieces'
AND E2.Title = 'Renaissance Art';

7. SELECT C.Name AS CategoryName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Categories C
JOIN Artworks AR ON C.CategoryID = AR.CategoryID
GROUP BY C.Name;

8. SELECT A.Name AS ArtistName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks AR ON A.ArtistID = AR.ArtistID
GROUP BY A.Name
HAVING COUNT(AR.ArtworkID) > 3;

9. SELECT AR.Title AS ArtworkTitle, A.Name AS ArtistName, A.Nationality
FROM Artworks AR
JOIN Artists A ON AR.ArtistID = A.ArtistID
WHERE A.Nationality = 'Spanish';

10. 
SELECT E.Title AS ExhibitionTitle
FROM Exhibitions E
JOIN ExhibitionArtworks EA ON E.ExhibitionID = EA.ExhibitionID
JOIN Artworks AR ON EA.ArtworkID = AR.ArtworkID
JOIN Artists A ON AR.ArtistID = A.ArtistID
WHERE A.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY E.Title
HAVING COUNT(DISTINCT A.Name) = 2;


11.SELECT AR.Title AS ArtworkTitle
FROM Artworks AR
LEFT JOIN ExhibitionArtworks EA ON AR.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

12.SELECT A.Name AS ArtistName
FROM Artists A
JOIN Artworks AR ON A.ArtistID = AR.ArtistID
GROUP BY A.Name
HAVING COUNT(DISTINCT AR.CategoryID) = (SELECT COUNT(*) FROM Categories);

13. SELECT C.Name AS CategoryName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Categories C
JOIN Artworks AR ON C.CategoryID = AR.CategoryID
GROUP BY C.Name;

14.SELECT A.Name AS ArtistName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Artists A
JOIN Artworks AR ON A.ArtistID = AR.ArtistID
GROUP BY A.Name
HAVING COUNT(AR.ArtworkID) > 2;

15.SELECT C.Name AS CategoryName, AVG(AR.Year) AS AverageYear
FROM Categories C
JOIN Artworks AR ON C.CategoryID = AR.CategoryID
GROUP BY C.Name
HAVING COUNT(AR.ArtworkID) > 1;

16. SELECT AR.Title AS ArtworkTitle
FROM Artworks AR
JOIN ExhibitionArtworks EA ON AR.ArtworkID = EA.ArtworkID
JOIN Exhibitions E ON EA.ExhibitionID = E.ExhibitionID
WHERE E.Title = 'Modern Art Masterpieces';

17.SELECT C.Name AS CategoryName, AVG(AR.Year) AS CategoryAverageYear
FROM Categories C
JOIN Artworks AR ON C.CategoryID = AR.CategoryID
GROUP BY C.Name
HAVING AVG(AR.Year) > (SELECT AVG(Year) FROM Artworks);

18. SELECT AR.Title AS ArtworkTitle
FROM Artworks AR
LEFT JOIN ExhibitionArtworks EA ON AR.ArtworkID = EA.ArtworkID
WHERE EA.ExhibitionID IS NULL;

19.SELECT DISTINCT A.Name AS ArtistName
FROM Artists A
JOIN Artworks AR ON A.ArtistID = AR.ArtistID
WHERE AR.CategoryID = (
    SELECT CategoryID 
    FROM Artworks 
    WHERE Title = 'Mona Lisa'
);

20.SELECT A.Name AS ArtistName, COUNT(AR.ArtworkID) AS ArtworkCount
FROM Artists A
LEFT JOIN Artworks AR ON A.ArtistID = AR.ArtistID
GROUP BY A.Name;










