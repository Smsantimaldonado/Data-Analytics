USE CoderHouse

/*
Indicar cuantos cursos y carreras tiene el área de Data. Renombrar 
la nueva columna como cant_asignaturas. Keywords: Tipo, Área, Asignaturas.
*/
SELECT tipo, COUNT(AsignaturasID) AS "cant_asignaturas"
FROM Asignaturas
WHERE Asignaturas.Area = 5
group by tipo;



/*
Se requiere saber cual es el nombre, el documento y el teléfono de los
estudiantes que son profesionales en agronomía y que nacieron entre el
año 1970 y el año 2000. Keywords: Estudiantes, Profesión, fecha de Nacimiento.
*/
SELECT Nombre, Documento, Telefono
FROM Estudiantes
WHERE (Profesion = '6')
and (YEAR([Fecha de Nacimiento]) between '1970' and '1999');