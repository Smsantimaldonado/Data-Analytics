CREATE DATABASE Municipios;

USE Municipios;

CREATE TABLE Pais
(
ID_Pais INT not null,
Nombre VARCHAR(20) not null
);

CREATE TABLE Provincia
(
ID_Provincia INT not null,
Nombre_Provincia VARCHAR(25) not null,
Pais INT not null,
Limitrofe BIT not null
);

ALTER TABLE Pais ALTER COLUMN Nombre VARCHAR (255);
ALTER TABLE Provincia ALTER COLUMN Nombre_Provincia VARCHAR (255);

EXEC sp_rename 'Pais.Nombre', 'Nombre_pais', 'COLUMN';

ALTER TABLE Pais
ADD PRIMARY KEY (ID_Pais);

ALTER TABLE Provincia
ADD PRIMARY KEY (ID_Provincia);

ALTER TABLE Provincia
ADD FOREIGN KEY (Pais) REFERENCES Pais (ID_Pais);

ALTER TABLE municipios
ADD PRIMARY KEY (id, provincia_id);