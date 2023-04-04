CREATE DATABASE BD03

CREATE TABLE Cliente
(
N_Cliente INT,
Nombre VARCHAR (200),
Sexo VARCHAR (2),
Telefono INT,
ID_Edad INT
);

INSERT INTO Cliente
VALUES (398, 'Cristian', 'M', 45786349, 1),
(600, 'Cristian', 'M', 45786349, 1),
(601, 'Cristian', 'M', 45786349, 1),
(602, 'Cristian', 'M', 45786349, 1),
(603, 'Cristian', 'M', 45786349, 1);

CREATE TABLE Cliente2
(
N_Cliente INT,
Nombre VARCHAR (200),
Sexo VARCHAR (2),
Telefono INT,
ID_Edad INT
);

INSERT INTO Cliente2
VALUES (345, 'Juan', 'M', 34484056, 8),
(390, 'Mariela', 'F', 45835000, 9),
(398, 'Cristian', 'M', 45786349, 1),
(562, 'Fernando', 'M', 42568360, 3),
(610, 'Fernando', 'M', 42568360, 3),
(817, 'Silvana', 'F', 32583159, 5);


SELECT *
FROM Cliente

SELECT *
FROM Cliente2

delete FROM Cliente2;


-- Seleccionar registros todos los campos con la sentencia DISTINCT --
SELECT DISTINCT *
FROM Cliente;

-- Seleccionar registros de algunos campos con la sentencia DISTINCT --
SELECT DISTINCT N_Cliente, Nombre, sexo
FROM Cliente;

-- Seleccionar registros de algunos campos con la sentencia DISTINCT --
SELECT DISTINCT Nombre, Sexo
FROM Cliente;

SELECT DISTINCT Nombre, Sexo
FROM Cliente2;

-- Realizar consulta de Tabla Cliente2 con una condición y cambio de nombre de columna --
SELECT N_cliente AS id, Nombre 
FROM Cliente2
WHERE N_cliente > 400;

-- Realizar consulta de Tabla Cliente2 con una condición: nombres que comiencen con 'F' --
SELECT N_Cliente, Sexo, Nombre
FROM Cliente2
WHERE Nombre LIKE 'F%'

-- Realizar consulta de Tabla Cliente2 con una condición: nombres que terMINen con 'A' --
SELECT N_Cliente, Sexo, Nombre
FROM Cliente2
WHERE Nombre LIKE '%A'

-- Realizar consulta de Tabla Cliente2 con una condición: nombres que contengan 'V' --
SELECT N_Cliente, Sexo, Nombre
FROM Cliente2
WHERE Nombre LIKE '%V%'

-- Realizar consulta de Tabla Cliente2 con una condición: nombres iguales a 'Fernando' --
SELECT N_Cliente, Sexo, Nombre
FROM Cliente2
WHERE Nombre in ('Fernando')

SELECT N_Cliente, Sexo, Nombre
FROM Cliente2
WHERE N_Cliente BETWEEN 100 AND 400

-- ConsultAS diversAS con AS --
SELECT N_Cliente + ID_Edad AS Campo, Nombre
FROM Cliente2

SELECT N_Cliente - ID_Edad AS Campo
FROM Cliente2

SELECT N_Cliente * ID_Edad AS Campo
FROM Cliente2

-- Realizar diversAS consultAS --
SELECT DISTINCT *
FROM Cliente2

SELECT Nombre AS Cliente
FROM Cliente2
WHERE ID_Edad = 3; 

SELECT DISTINCT
Nombre AS Cliente, Sexo, Telefono
FROM Cliente2
WHERE N_Cliente > 400;

-- Mostrar dos filAS (en función del ID_Edad) que cumplan con lAS condiciones --
SELECT TOP(2)
N_Cliente,
ID_Edad
FROM Cliente2
ORDER BY ID_Edad desc 

-- Mostrar el uso de funciones agregaciones --
SELECT COUNT (ID_Edad) AS Edad
FROM Cliente2;

SELECT AVG (ID_Edad) AS Edad
FROM Cliente2;

SELECT sum (ID_Edad) AS Edad
FROM Cliente2;
 
 -- Mostrar la cantidad de personAS de sexo femenino y sexo mASculino --
 SELECT 
Sexo,
COUNT(N_Cliente)AS Cant_Clientes
FROM Cliente2
GROUP BY Sexo

-- Mostrar la cantidad de personAS de sexo femenino y sexo mASculino con condición --
SELECT 
Sexo,
COUNT(N_Cliente)AS Cant_Clientes
FROM Cliente2
GROUP BY Sexo
HAVING COUNT(N_Cliente)> 3

-- ConsultAS variAS -- 
SELECT * FROM Cliente2 
Order by N_Cliente desc; 

SELECT top (3) * FROM Cliente2 
Order by N_Cliente; 

SELECT COUNT (N_Cliente) AS Cantidad, 
Nombre
FROM Cliente2
Group by Nombre
Order by COUNT (N_Cliente) desc; 

SELECT COUNT (N_Cliente) AS Cantidad, 
Nombre
FROM Cliente2
Group by Nombre
Having COUNT (N_Cliente) >= 2
Order by COUNT (N_Cliente) desc; 