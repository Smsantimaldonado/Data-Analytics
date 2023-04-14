USE Municipios;

SELECT *
FROM Provincia;

SELECT *
FROM municipios;

SELECT provincia_nombre, provincia_id 
FROM municipios
UNION
SELECT Nombre_Provincia, ID_Provincia
FROM Provincia;

UPDATE Provincia
SET ID_Provincia = provincia_id
FROM municipios
WHERE municipios.provincia_nombre = Provincia.Nombre_Provincia;

SELECT DISTINCT A.provincia_nombre, B.Nombre_Provincia
FROM municipios as A
LEFT JOIN Provincia as B
ON B.ID_Provincia = A.provincia_id;

SELECT DISTINCT A.provincia_nombre, B.Nombre_Provincia
FROM municipios as A
RIGHT JOIN Provincia as B
ON B.ID_Provincia = A.provincia_id;

SELECT *
FROM Provincia;

SELECT *
FROM Pais;

SELECT *
FROM Provincia as A
INNER JOIN Pais as B
ON A.Pais = B.ID_Pais;

SELECT *
FROM Provincia as A
LEFT JOIN Pais as B
ON A.Pais = B.ID_Pais;

SELECT *
FROM Provincia as A
RIGHT JOIN Pais as B
ON A.Pais = B.ID_Pais;