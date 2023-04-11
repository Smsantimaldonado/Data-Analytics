CREATE DATABASE BD04;

USE BD04;

CREATE TABLE Cliente3
(
N_Cliente INT, Nombre VARCHAR (200), Sexo VARCHAR (2),
Telefono INT, Fecha_Nac DATE, Fecha_Inscr DATE,
Nota decimal (10,2), ID_Edad INT
);

INSERT INTO Cliente3 VALUES (345, 'Juan', 'M', 34484056,'12-01-1980','12-01-1980',8.2, 8);
INSERT INTO Cliente3 VALUES (390, 'Mariela', 'F',45835000,'12-01-1980','12-01-1980',8.2, 9);
INSERT INTO Cliente3 VALUES (398, 'Cristian', 'M',45786349,'12-01-1980','12-01-1980', 5.2, 1);
INSERT INTO Cliente3 VALUES (562, 'Fernando', 'M',42568360,'12-01-1980','12-01-1980', 2.3, 3);
INSERT INTO Cliente3 VALUES (610, 'Fernando', 'M',42568360,'12-01-1980','12-01-1980', 1.2, 3);
INSERT INTO Cliente3 VALUES (817, 'Silvana', 'F',32583159,'12-01-1980','12-01-1980', 9.5, 5);


--se demostrarán lAS funciones de caracteres.
SELECT LEFT (N_Cliente,2) AS Nc2, RIGHT (Telefono, 3) AS T2,
       CONCAT (Nombre, Telefono, 'P') AS NT,
       REPLACE (Sexo, 'M', 'F') AS S1,
       UPPER (Nombre) AS N2
FROM Cliente3;

--se demostrarán lAS funciones de fecha y tiempo
SELECT YEAR (Fecha_Nac) AS Año, MONTH (Fecha_Nac) AS Mes, 
       DATENAME (MONTH, Fecha_Nac) AS Nombre_Mes, 
       DATEDIFF (DAY, Fecha_Nac, Fecha_Inscr) AS Diferencia_Día
FROM Cliente3;

SELECT FLOOR (nota) AS Entero, MAX (nota) AS MAXoluto,
       CAST (Fecha_Nac AS DATETIME) AS Fecha_NacT
FROM Cliente3;

--Obtener el registro de la persona que tuvo la máxima nota - -
SELECT * FROM Cliente3
WHERE Nota = (SELECT MAX (nota) FROM Cliente3);

--Obtener el total de personAS que obtuvieron la mínima nota agrupadAS por sexo - -
SELECT Sexo, COUNT(N_Cliente) AS Cant_Clientes
FROM Cliente3
WHERE Nota = (SELECT MIN (nota) FROM Cliente3)
GROUP BY Sexo;