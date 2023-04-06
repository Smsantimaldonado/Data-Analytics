USE CoderHouse

/*Indicar cuantos cursos y carreras tiene el área de Data. Renombrar la
nueva columna como cant_asignaturas. Keywords: Tipo, Área, Asignaturas*/
SELECT tipo, COUNT(AsignaturasID) AS cant_asignaturas
FROM Asignaturas
WHERE Asignaturas.Area = 5
group by tipo;

/* Se requiere saber cual es el nombre, el documento y el teléfono de los
estudiantes que son profesionales en agronomía y que nacieron entre el año
1970 y el año 2000. Keywords: Estudiantes, Profesión, fecha de Nacimiento*/
SELECT Nombre, Documento, Telefono
FROM Estudiantes
WHERE (Profesion = 6) and (YEAR([Fecha de Nacimiento]) between 1970 and 1999);

/* Se requiere un listado de los docentes que ingresaron en el año 2021 y
concatenar los campos nombre y apellido. El resultado debe utilizar un
separador: guión (-). Ejemplo: Elba-Jimenez. Renombrar la nueva columna
como Nombres_Apellidos. Los resultados de la nueva columna deben estar
en mayúsculas. Keywords: Staff, Fecha Ingreso, Nombre, Apellido*/
SELECT UPPER(CONCAT(Nombre, '-', Apellido)) as Nombres_Apellidos, [Fecha Ingreso]
FROM Staff
WHERE YEAR([Fecha Ingreso]) = 2021;

/* Indicar la cantidad de encargados de docentes y de tutores. Renombrar
la columna como CantEncargados. Quitar la palabra ”Encargado ”en cada uno
de los registros. Renombrar la columna como NuevoTipo.
Keywords: Encargado, tipo, Encargado_ID*/
SELECT REPLACE(Tipo, 'Encargado ', '') AS NuevoTipo, COUNT(Tipo) AS CantEncargados
FROM Encargado
GROUP BY Tipo;

/* Indicar cual es el precio promedio de las carreras y los cursos por
jornada. Renombrar la nueva columna como Promedio. Ordenar los promedios
 de Mayor a menor *Keywords: Tipo, Jornada, Asignaturas*/
SELECT Jornada, Tipo, AVG(Costo) AS Promedio
FROM Asignaturas
GROUP BY Tipo, Jornada
ORDER BY Promedio DESC;

/* Se requiere calcular la edad de los estudiantes en una nueva columna.
Renombrar a la nueva columna Edad. Filtrar solo los que son mayores de 18
años. Ordenar de Menor a Mayor *Keywords: Fecha de Nacimiento, Estudiantes*/
SELECT Nombre, Apellido, DATEDIFF(YEAR, [Fecha de Nacimiento], GETDATE()) AS Edad
FROM Estudiantes
WHERE DATEDIFF(YEAR, [Fecha de Nacimiento], GETDATE()) >= 18
ORDER BY Edad ASC;

/*Se requiere saber el Nombre, el correo, la camada y la fecha de ingreso
de personas del staff que contienen correo .edu y su DocenteID se mayor o
igual que 100 Keywords: Staff, correo, DocentesID*/
SELECT Nombre, Correo, REPLACE(Camada, 'camada ', '') as Camada, [Fecha Ingreso]
FROM Staff
WHERE (Correo like '%.edu%') and (DocentesID >= 100);

/*Se requiere conocer el documento, el domicilio el código postal y el
nombre de los primeros estudiantes que se registraron en la plataforma.
Keywords: Documento, Estudiantes, Fecha Ingreso.*/
SELECT Documento, Domicilio, [Codigo Postal], [Fecha Ingreso]
FROM Estudiantes
WHERE [Fecha Ingreso] = (SELECT MIN([Fecha Ingreso])
						FROM Estudiantes);

/*Indicar el nombre apellido y documento de los docentes y tutores que
tienen asignaturas “UX”. Keywords: Staff, Asignaturas, Nombre, Apellido*/
SELECT Nombre, Apellido, Documento
FROM Staff
WHERE Asignatura in
	(SELECT AsignaturasID
	FROM Asignaturas
	WHERE Nombre like '%UX%');

/*Se desea calcular el 25% de aumento para las asignaturas del área de
marketing de la jornada mañana, se deben traer todos los campos, mas el
de los cálculos correspondientes, el porcentaje y el Nuevo costo debe
estar en decimal con 3 digitos. Renombrar el calculo del porcentaje con
el nombre porcentaje y la suma del costo mas el porcentaje por NuevoCosto.
Keywords: Asignaturas, Costo, Área, Jornada, Nombre*/
SELECT *,
       ROUND((Costo * 0.25) ,3) AS Porcentaje,
       ROUND((Costo * 1.25) ,3) AS NuevoCosto
FROM Asignaturas
WHERE Area = 2 and Jornada = 'Manana';