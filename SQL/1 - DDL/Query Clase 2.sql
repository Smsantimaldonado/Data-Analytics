-- CREACION DE LA DB --
CREATE DATABASE BD01
CREATE DATABASE BD01X
DROP DATABASE BD01X;

-- CREACION DE TABLAS --
USE BD01

CREATE TABLE t01
(
Nombre VARCHAR(100)
);

CREATE TABLE t02
(
n_cliente INT PRIMARY KEY not null,
nombre VARCHAR (100)
);

CREATE TABLE t03
(
id INT PRIMARY KEY not null,
nm_cliente INT,
sexo VARCHAR(2),
telefono INT,
edad INT,
CONSTRAINT FK FOREIGN KEY (nm_cliente) REFERENCES t02 (n_cliente)
);

-- CREAR VISTA --
CREATE VIEW cliente_m
AS 
SELECT
nm_cliente, sexo
FROM [dbo].[t03];

-- PRIMERA CONSULTA --
SELECT *
FROM cliente_m;

CREATE SCHEMA RT01;


-- AGREGAR COLUMNA --
ALTER TABLE t02
ADD apellido VARCHAR(200);


--ELIMINAR COLUMNA --
ALTER TABLE t02
DROP COLUMN apellido;


-- MODIFICAR DATOS --

EXEC sp_rename
"t02.nombre", "nm";
/*
'sp_rename' es un procedimiento almacenado de Transact-SQL utilizado en SQL Server para cambiar el
nombre de un objeto de base de datos existente. El procedimiento se utiliza para cambiar el nombre
de una tabla, columna, índice u otro objeto de base de datos en una base de datos de SQL Server
*/

ALTER TABLE t03
ALTER COLUMN sexo VARCHAR (20);

-- BORRAR VISTA --
DROP VIEW cliente_m;

-- BORRAR TABLA --
DROP TABLE t01;