CREATE DATABASE BD02

USE BD02

CREATE TABLE Cliente
(
N_Cliente INT, 
Nombre VARCHAR (200),
Sexo VARCHAR (2),
Telefono INT,
ID_Edad INT
);

-- INSERTar datos en la Tabla Cliente --
INSERT INTO Cliente (N_Cliente, Nombre, Sexo, telefono, ID_Edad)
VALUES (562, 'Fernando', 'M', 42568360, 3);

INSERT INTO Cliente 
VALUES (398, 'Christian', 'M', 45786349, 1);

INSERT INTO Cliente
VALUES (591, 'Jose', 'M', 45741242, 2),
(581, 'Juan', 'M', 45786845, 4); 

-- Verificar registros realizados --
SELECT *
FROM Cliente

-- Actualizar un dato en la columna N_Cliente de la Tabla Cliente  --
UPDATE Cliente
SET Nombre = 'Carlos'
WHERE N_Cliente = 562;

-- Borrar los datos de una fila especificando un campo de la columna en la Tabla Cliente --
DELETE FROM Cliente
WHERE N_cliente = 562;

-- Borrar los datos de una fila especificando un campo de la columna en la Tabla Cliente --
DELETE FROM cliente
WHERE N_cliente = 591 or N_Cliente = 581;

-- Borrar los datos de la Tabla Cliente --
DELETE FROM cliente;

-- Realizar Consulta de la Tabla Cliente   --
SELECT N_Cliente, Nombre, Sexo
FROM Cliente;

-- Realizar Consulta de la Tabla Cliente a detalle--
SELECT N_Cliente, Nombre, Sexo
FROM Cliente
WHERE Nombre = 'Christian';


-- EJERCICIO ADICIONAL --
CREATE TABLE Prueba
(
N_Cliente INT PRIMARY KEY not null, 
Nombre VARCHAR (200)
);

INSERT INTO Prueba 
VALUES (398, 'Christian'), 
(395, 'Fernando');

SELECT * FROM Prueba

DELETE FROM Prueba; -- vemos que no borra la tabla, sino los registros en ella --

DROP TABLE Prueba; -- vemos que SI borra la tabla --