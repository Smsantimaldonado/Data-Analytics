CREATE TABLE PersonAS
(
PersonaID INT,
Apellido VARCHAR (200),
);

CREATE TABLE Logros
(
LogroID INT,
PersonaID INT, 
Logro VARCHAR (200),
);

INSERT INTO PersonAS VALUES (1, 'FleMINg');
INSERT INTO PersonAS VALUES (2, 'ErAStontenes');
INSERT INTO PersonAS VALUES (3, 'Newton');
INSERT INTO PersonAS VALUES (4, 'Fernandez');

INSERT INTO Logros VALUES (1, 1, 'Descubrimiento de la Penicilina');
INSERT INTO Logros VALUES (2, 2, 'Calculo del perimetro terrestre');
INSERT INTO Logros VALUES (3, 3, 'Ley de gravitación universal');
INSERT INTO Logros VALUES (4, 3, 'Desarrollo del Cálculo');
INSERT INTO Logros VALUES (5, 0, 'Cura del Cancer');

CREATE TABLE Logros1
(
IDLogro INT,
PersonaID VARCHAR (200),
Logro VARCHAR (200),
);

CREATE TABLE Logros2
(
IDLogro INT,
PersonaID VARCHAR (200),
Logro VARCHAR (200),
);


INSERT INTO Logros1 VALUES (1, 1, 'FleMINg');
INSERT INTO Logros1 VALUES (2, 2, 'ErAStontenes');

INSERT INTO Logros2 VALUES (3, 3, 'Caviedes');
INSERT INTO Logros2 VALUES (4, 4, 'De la Torre');


--se demostrarán lAS funciones de JOIN
SELECT PersonAS.Apellido, Logros.Logro
FROM PersonAS INNER JOIN Logros
ON PersonAS.PersonaID = Logros.PersonaID;

SELECT PersonAS.Apellido, Logros.Logro
FROM PersonAS LEFT JOIN Logros
ON PersonAS.PersonaID = Logros.PersonaID;

SELECT PersonAS.Apellido, Logros.Logro
FROM PersonAS RIGHT JOIN Logros
ON PersonAS.PersonaID = Logros.PersonaID;

SELECT PersonAS.Apellido, Logros.Logro
FROM PersonAS FULL JOIN Logros
ON PersonAS.PersonaID = Logros.PersonaID;

--se demostrarán la función de UNION
SELECT IDLogro, PersonaID, Logro
FROM Logros1
UNION
SELECT IDLogro, PersonaID, Logro
FROM Logros2
