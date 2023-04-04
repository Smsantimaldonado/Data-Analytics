USE CoderHouse

/*
Indicar cuantos cursos y carreras tiene el �rea de Data. Renombrar 
la nueva columna como cant_asignaturas. Keywords: Tipo, �rea, Asignaturas.
*/
SELECT tipo, COUNT(AsignaturasID) AS "cant_asignaturas"
FROM Asignaturas
WHERE Asignaturas.Area = 5
group by tipo;



/*
Se requiere saber cual es el nombre, el documento y el tel�fono de los
estudiantes que son profesionales en agronom�a y que nacieron entre el
a�o 1970 y el a�o 2000. Keywords: Estudiantes, Profesi�n, fecha de Nacimiento.
*/
SELECT Nombre, Documento, Telefono
FROM Estudiantes
WHERE (Profesion = '6')
and (YEAR([Fecha de Nacimiento]) between '1970' and '1999');