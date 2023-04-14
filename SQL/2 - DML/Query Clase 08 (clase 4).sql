USE BD04;

CREATE TABLE Personas (
PersonaID INT,
Apellido VARCHAR (200)
);

CREATE TABLE Logros (
LogroID INT,
PersonaID INT, 
Logro VARCHAR (200)
);

INSERT INTO Personas VALUES (1, 'Fleming');
INSERT INTO Personas VALUES (2, 'Erastontenes');
INSERT INTO Personas VALUES (3, 'Newton');
INSERT INTO Personas VALUES (4, 'Fernandez');

INSERT INTO Logros VALUES (1, 1, 'Descubrimiento de la Penicilina');
INSERT INTO Logros VALUES (2, 2, 'Calculo del perimetro terrestre');
INSERT INTO Logros VALUES (3, 3, 'Ley de gravitación universal');
INSERT INTO Logros VALUES (4, 3, 'Desarrollo del Cálculo');
INSERT INTO Logros VALUES (5, 0, 'Cura del Cancer');

CREATE TABLE Logros1 (
IDLogro INT,
PersonaID VARCHAR (200),
Logro VARCHAR (200)
);

CREATE TABLE Logros2 (
IDLogro INT,
PersonaID VARCHAR (200),
Logro VARCHAR (200)
);

INSERT INTO Logros1 VALUES (1, 1, 'Fleming');
INSERT INTO Logros1 VALUES (2, 2, 'Erastontenes');

INSERT INTO Logros2 VALUES (3, 3, 'Caviedes');
INSERT INTO Logros2 VALUES (4, 4, 'De la Torre');

SELECT * FROM Personas;
SELECT * FROM Logros;

--se demostrarán las funciones de JOIN
SELECT Personas.Apellido, Logros.Logro
FROM Personas
INNER JOIN Logros ON Personas.PersonaID = Logros.PersonaID;

SELECT Personas.Apellido, Logros.Logro
FROM Personas
LEFT JOIN Logros ON PersonAS.PersonaID = Logros.PersonaID;

SELECT Personas.Apellido, Logros.Logro
FROM Personas
RIGHT JOIN Logros ON PersonAS.PersonaID = Logros.PersonaID;

SELECT Personas.Apellido, Logros.Logro
FROM Personas
FULL JOIN Logros ON PersonAS.PersonaID = Logros.PersonaID;


--se demostrarán la función de UNION

SELECT * FROM Logros1;
SELECT * FROM Logros2;

SELECT IDLogro, PersonaID, Logro
FROM Logros1
UNION
SELECT IDLogro, PersonaID, Logro
FROM Logros2;