-- Crear base de datos DB01 --
create database BD01

--Crear Tablas en BD01--
create table Table01
(
Nombre varchar (100)
);

create table Table02
(
N_Cliente int PRIMARY KEY not null,
Nombre varchar (200)
);

create table Table03
(
ID int PRIMARY KEY not null, 
NM_Cliente int, 
sexo varchar (2), 
telefono int,
ID_Edad int,
CONSTRAINT FK FOREIGN KEY (NM_Cliente)
REFERENCES Table02 (N_Cliente)
);

create view Cliente_M
as
select 
NM_Cliente, sexo
from [dbo].[Table03]

-- Visualizar Vista Cliente_M --
select *
from Cliente_M

-- Crear Esquema RT01 en BD01 --
create schema RT01

-- Agregar Columna en Table02 --
alter table Table02
add Apellido varchar (200);

-- Eliminar Columna Apellido en Table02 --
alter table Table02
drop column Apellido;

-- Renombrar Columna de Table 02--
EXEC sp_rename
"Table02.Nombre", "NM";

-- Modificar el tipo de dato de una columna Sexo en la Table03--
alter table Table03
alter column sexo 
varchar (10);

-- Borrar la vista Cliente_M--
drop view Cliente_M;

-- Eliminar Tabla --
drop table Table01;
