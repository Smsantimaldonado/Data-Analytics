USE Municipios;

SELECT CAST(centroide_lat as FLOAT) as Latitud_Centroide,
       CAST(centroide_lon as FLOAT) as Longitud_Centroide
FROM municipios;

SELECT ABS(CAST(centroide_lat as FLOAT)) as Latitud_Centroide_Absoluto
FROM municipios;

SELECT categoria, provincia_nombre, nombre as Municipio 
FROM municipios
WHERE provincia_id = (SELECT TOP (1) ID_Provincia
                      FROM Provincia);