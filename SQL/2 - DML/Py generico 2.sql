USE CoderHouse;

/* Indicar por jornada la cantidad de docentes que dictan y sumar los costos.
Esta información solo se desea visualizar para las asignaturas de desarrollo
web. El resultado debe contener todos los valores registrados en la primera
tabla, Renombrar la columna del calculo de la cantidad de docentes como
cant_docentes y la columna de la suma de los costos como suma_total.
Keywords: Asignaturas,Staff, DocentesID, Jornada, Nombre, costo.*/
SELECT A.Jornada, SUM(A.Costo) as suma_total, COUNT(S.DocentesID) as cant_docentes
FROM
     Asignaturas A INNER JOIN Staff S ON A.AsignaturasID = S.Asignatura
WHERE A.Nombre = 'desarrollo web'
GROUP BY A.Jornada;


/* Se requiere saber el id del encargado, el nombre, el apellido y cuantos son
los docentes que tiene asignados cada encargado. Luego filtrar los encargados
que tienen como resultado 0 ya que son los encargados que NO tienen asignado un
docente. Renombrar el campo de la operación como Cant_Docentes.
Keywords: Docentes_id, Encargado, Staff, Nombre, Apellido,Encargado_ID.*/
SELECT E.Encargado_ID as ID, E.Nombre, E.Apellido, COUNT(S.DocentesID) as Cant_Docentes
FROM 
     Encargado E LEFT JOIN Staff S ON E.Encargado_ID = S.Encargado
GROUP BY E.Encargado_ID, E.Nombre, E.Apellido
HAVING COUNT(S.DocentesID) = 0;


/* Se requiere saber todos los datos de asignaturas que no tienen un docente
asignado.El modelo de la consulta debe partir desde la tabla docentes.
Keywords: Staff, Encargado, Asignaturas, costo, Area.*/
SELECT A.*
FROM 
     Staff S RIGHT JOIN Asignaturas A ON S.Asignatura = A.AsignaturasID
WHERE S.Nombre is null
GROUP BY A.AsignaturasID, A.Nombre, A.Tipo, A.Jornada, A.Costo, A.Area;


/* Se quiere conocer la siguiente información de los docentes: El nombre
completo concatenar el nombre y el apellido (renombrar NombresCompletos), el
documento, hacer un calculo para conocer los meses de ingreso (renombrar
meses_ingreso), el nombre del encargado (renombrar NombreEncargado), el tefelono
del encargado (renombrar TelefonoEncargado), el nombre del curso o carrera, la
jornada y el nombre del área. Solo se desean visualizar solo los que llevan mas
de 3 meses.Ordenar los meses de ingreso de mayor a menor.
Keywords: Encargo, Area, Staff, jornada, fecha ingreso.*/
SELECT CONCAT(S.Nombre, ' ', S.Apellido) as Nombre_Completo,
	   S.Documento as Documento,
	   MONTH(S.[Fecha Ingreso]) as Mes_Ingreso,
	   E.Nombre as Nombre_Encargado,
	   E.Telefono as Telefono_Encargado,
	   A.Nombre as Asignatura,
	   A.Jornada as Jornada,
	   B.AreaID
FROM Staff S
	 INNER JOIN Encargado E ON S.Encargado = E.Encargado_ID
	 INNER JOIN Asignaturas A ON S.Asignatura = A.AsignaturasID
	 INNER JOIN Area B ON A.Area = B.AreaID
GROUP BY S.[Fecha Ingreso],
		 S.Nombre,
		 S.Apellido,
		 S.Documento,
		 E.Nombre,
		 E.Telefono,
		 A.Nombre,
		 A.Jornada,
		 B.AreaID
HAVING DATEDIFF(MONTH, S.[Fecha Ingreso], GETDATE()) > 3
ORDER BY Mes_Ingreso DESC;


/* Se requiere una listado unificado con nombre, apellido, documento y una marca
indicando a que base corresponde. Renombrar como Marca.
Keywords: Encargo, Staff, Estudiantes*/
SELECT Nombre, Apellido, Documento, 'Encargado' as Marca
FROM Encargado
UNION
SELECT Nombre, Apellido, Documento, 'Estudiante' as Marca
FROM Estudiantes
UNION
SELECT Nombre, Apellido, Documento, 'Staff' as Marca
FROM Staff;