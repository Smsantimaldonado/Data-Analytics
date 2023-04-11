USE Municipios;

SELECT DISTINCT categoria
FROM municipios;

SELECT *
FROM municipios
WHERE categoria= 'MUNICIPIO' and provincia_id=10;

SELECT DISTINCT provincia_nombre as Provincia
FROM municipios
WHERE provincia_nombre like 'S%' or provincia_id > 50;

SELECT provincia_nombre as Provincia, COUNT(nombre) as CANTIDAD
FROM municipios
WHERE categoria = 'municipio'
GROUP BY provincia_nombre
ORDER BY CANTIDAD DESC;

SELECT provincia_nombre as Provincia, COUNT(DISTINCT categoria) as CANTIDAD
FROM municipios
GROUP BY provincia_nombre
HAVING COUNT(DISTINCT categoria) < 10
ORDER BY CANTIDAD DESC;