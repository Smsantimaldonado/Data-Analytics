USE CODERHOUSE;

/* Análisis de docentes por camada
- Número de documento, nombre de docente y camada para identificar la camada
*mayor* y la *menor* según el *numero* de la *camada*.
- Número de documento, nombre de docente y camada para identificar la camada con *fecha de ingreso*
Mayo 2021.
- Agregar un campo indicador que informe cuales son los registros ”mayor o menor” y los que son
“Mayo 2021” y ordenar el listado de *menor* a *mayor* por camada.*/
SELECT Documento,
	   nombre,
	   Camada,
	   'Mayor' as marca
FROM staff
WHERE Camada = (SELECT MAX(Camada)
				FROM staff)
UNION
SELECT Documento,
	   nombre,
	   Camada,
	   'Menor' as marca
FROM staff 
WHERE Camada = (SELECT MIN(Camada)
				FROM staff)
UNION
SELECT Documento,
	   nombre,
	   Camada,
	   'Mayo 2021' as marca
FROM staff
WHERE YEAR([Fecha Ingreso]) = 2021
	  AND
	  MONTH([Fecha Ingreso]) = 05
ORDER BY Camada;


/* Análisis diario de estudiantes
- Por medio de la fecha de ingreso de los estudiantes identificar: cantidad total de estudiantes.
- Mostrar los periodos de tiempo separados por año, mes y día, y presentar la información ordenada por
la fecha que mAS ingresaron estudiantes. */
SELECT YEAR([Fecha Ingreso]) as Año,
	   MONTH([Fecha Ingreso]) as Mes,
	   Day([Fecha Ingreso]) as Día,
	   COUNT(EstudiantesID) as cantidad_estudiantes
FROM Estudiantes
GROUP BY [Fecha Ingreso]
ORDER BY [cantidad_estudiantes] DESC;


/* Análisis de encargados con mAS docentes a cargo:
- Identificar el *top 10* de los encargados que tiene más docentes a cargo, filtrar solo los que
tienen a cargo docentes.
- Ordenar de *mayor* a *menor* para poder tener el listado correctamente.*/
SELECT TOP (10) E.Encargado_ID, 
	   COUNT (S.docentesID) as cantidad_doc
FROM staff S
	 INNER JOIN
	 Encargado E
	 ON E.Encargado_ID = S.Encargado
WHERE tipo LIKE '%docentes%'
GROUP BY E.Encargado_ID
ORDER BY cantidad_doc DESC;


/* Análisis de profesiones con mAS estudiantes:
- Identificar la profesión y la cantidad de estudiantes que ejercen, mostrar el listado solo de lAS
profesiones que tienen mAS de 5 estudiantes.
- Ordenar de *mayor* a *menor* por la profesión que tenga mAS estudiantes.*/
SELECT P.Profesiones,
	   COUNT(E.EstudiantesID) as cant_estudiantes
FROM Profesiones P
	 LEFT JOIN
	 Estudiantes E
	 ON P.ProfesionesID = E.Profesion
GROUP BY P.Profesiones
HAVING COUNT(E.EstudiantesID) > 5
ORDER BY cant_estudiantes DESC;


/* Análisis de estudiantes por área de educación:
- Identificar: nombre del área, si la Asignatura es carrera o curso , a qué jornada pertenece, cantidad
de estudiantes y monto total del costo de la Asignatura.
- Ordenar el informe de *mayor* a *menor* por monto de costos total tener en cuenta los docentes que
no tienen Asignaturas ni estudiantes ASignados, también sumarlos. */
SELECT B.Nombre,
	   A.Tipo,
	   A.Jornada,
	   COUNT(E.EstudiantesID) as Cantidad_Estudiantes,
	   SUM(A.Costo) as costo_Total 
FROM Asignaturas A
	 INNER JOIN
	 Area B
	 ON A.Area = B.AreaID
	 LEFT JOIN
	 Staff S
	 ON S.Asignatura = A.AsignaturasID
	 LEFT JOIN
	 Estudiantes E
	 ON S.DocentesID = E.Docente
GROUP BY B.Nombre, A.Tipo, A.Jornada
ORDER BY costo_Total DESC;


/* Análisis mensual de estudiantes por área
- Identificar para cada área: el año y el mes (CONCATenados en formato YYYYMM), cantidad de estudiantes
y monto total de lAS Asignaturas.
- Ordenar por mes del más actual al más antiguo y por cantidad de clientes de *mayor* a *menor*.*/
SELECT B.Nombre,
	   CONVERT(NVARCHAR(6), E.[Fecha Ingreso], 112) as YYYYMM,
	   COUNT(E.EstudiantesID) cantidad,
	   SUM(A.Costo) as Total
FROM Estudiantes E
	 INNER JOIN
	 Staff S
	 ON E.Docente = S.DocentesID
	 INNER JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 Area B
	 ON A.Area = B.AreaID
GROUP BY B.Nombre,
		 CONVERT(NVARCHAR(6),
		 E.[Fecha Ingreso],112)
ORDER BY YYYYMM DESC,
		 cantidad DESC;


/* Análisis encargado tutores jornada noche
- Identificar el nombre del encargado, el documento, el número de la camada(solo el número) y la fecha
de ingreso del tutor. Ordenar por camada de forma *mayor* a *menor*. */
SELECT E.nombre,
	   E.Documento,
	   RIGHT(S.Camada,5) as camada,
	   S.[Fecha Ingreso] as FechaIngresoTutor
FROM Encargado E
	 INNER JOIN
	 Staff S
	 ON E.Encargado_ID = S.Encargado
	 INNER JOIN
	 Asignaturas A
	 ON A.AsignaturasID = S.Asignatura
WHERE A.Jornada='Noche'
	  AND
	  E.Tipo LIKE '%Tutores%';


/* Análisis Asignaturas sin docentes o tutores:
- Identificar el tipo de Asignatura, la jornada, la cantidad de áreAS únicAS y la cantidad total de 
Asignaturas que no tienen ASignadAS docentes o tutores.
- Ordenar por tipo de forma *descendente*. */
SELECT A.Tipo,
	   A.jornada,
	   COUNT(DISTINCT A.area) as cant_areAS,
	   COUNT(A.nombre) as cant_Asignaturas
FROM Asignaturas A
	 LEFT JOIN
	 staff S
	 ON A.AsignaturasID = S.Asignatura
WHERE DocentesID IS NULL
GROUP BY A.Tipo,
		 A.Jornada
ORDER BY A.tipo DESC;


/* Análisis Asignaturas mayor al promedio:
- Identificar el nombre de la Asignatura, el costo de la Asignatura y el promedio del costo de lAS 
Asignaturas por área.
- Una vez obtenido el dato, del promedio se debe visualizar solo lAS carrerAS que se encuentran por 
encima del promedio. */
SELECT A.Nombre,
	   A.Costo,
	   B.AvgCosto
FROM Asignaturas A
	 LEFT JOIN
			 (SELECT Area,
					 avg(Costo) as AvgCosto
			  FROM Asignaturas
			  GROUP BY Area) B   
ON A.Area = B.Area   
WHERE A.Costo > B.AvgCosto;


/* Análisis aumento de salario docentes (*uso de aliAS para TablAS*)
- Identificar el nombre, documento, el área, la Asignatura y el aumento del salario del docente, este 
ultimo calcularlo sacándole un porcentaje al costo de la Asignatura, todos lAS áreAS tienen un
porcentaje distINTO, Marketing-17%, Diseño-20%, Programacion-23%, Producto-13%, Data-15%, HerramientAS 8% */
SELECT S.Nombre,
	   S.Documento,
	   B.Nombre as area,
	   A.Nombre as Asignaturas,
	   CAST((costo * 0.17) as decimal(7,3)) as Salario
FROM Staff S
	 LEFT JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 area B
	 ON A.Area = B.AreaID
WHERE B.Nombre LIKE ('%Marketing%')   
UNION
SELECT S.Nombre,
	   S.Documento,
	   B.Nombre as area,
	   A.Nombre as Asignaturas,
	   CAST((costo * 0.2) as decimal(7,3)) as Salario
FROM Staff S
	 LEFT JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 area B
	 ON A.Area = B.AreaID
WHERE B.Nombre LIKE ('%Diseno%')
UNION
SELECT S.Nombre,
	   S.Documento,
	   B.Nombre as area,
	   A.Nombre as Asignaturas,
	   CAST((costo * 0.23) as decimal(7,3)) as Salario
FROM Staff S
	 LEFT JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 area B
	 ON A.Area = B.AreaID
WHERE B.Nombre LIKE ('%Programacion%')
UNION
SELECT S.Nombre,
	   S.Documento,
	   B.Nombre as area,
	   A.Nombre as Asignaturas,
	   CAST((costo * 0.13) as decimal(7,3)) as Salario
FROM Staff S
	 LEFT JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 area B
	 ON A.Area = B.AreaID
WHERE B.Nombre LIKE ('%Producto%')
UNION
SELECT S.Nombre,
	   S.Documento,
	   B.Nombre as area,
	   A.Nombre as Asignaturas,
	   CAST((costo * 0.15) as decimal(7,3)) as Salario
FROM Staff S
	 LEFT JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 area B
	 ON A.Area = B.AreaID
WHERE B.Nombre LIKE ('%Data%')
UNION
SELECT S.Nombre,
	   S.Documento,
	   B.Nombre as area,
	   A.Nombre as Asignaturas,
	   CAST((costo * 0.08) as decimal(7,3)) as Salario
FROM Staff S
	 LEFT JOIN
	 Asignaturas A
	 ON S.Asignatura = A.AsignaturasID
	 INNER JOIN
	 area B
	 ON A.Area = B.AreaID
WHERE B.Nombre LIKE ('%HerramientAS%');