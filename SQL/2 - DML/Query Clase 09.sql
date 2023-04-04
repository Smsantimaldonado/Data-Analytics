/*
Análisis de docentes por camada
- Número de documento, nombre de docente y camada para identificar la camada **mayor** y la **menor**
según el **numero** de la **camada**.
- Número de documento, nombre de docente y camada para identificar la camada con **fecha de ingreso**
Mayo 2021.
- Agregar un campo indicador que informe cuales son los registros ”mayor o menor” y los que son
“Mayo 2021” y ordenar el listado de **menor** a **mayor** por camada.
*/
USE CODERHOUSE

SELECT 
Documento,
nombre,
Camada,
'Mayor' AS marca
FROM staff
WHERE Camada = (SELECT MAX(Camada) FROM staff)
UNION
SELECT Documento,nombre,Camada,
'Menor' AS marca
FROM staff 
WHERE Camada = (SELECT MIN(Camada) FROM staff)
UNION
SELECT Documento,nombre,Camada,
'Mayo 2021' AS marca
FROM staff
WHERE YEAR([Fecha Ingreso])=2021 AND MONTH([Fecha Ingreso])=05
order by Camada


/*
Análisis diario de estudiantes
- Por medio de la fecha de ingreso de los estudiantes identificar: cantidad total de estudiantes.
- Mostrar los periodos de tiempo separados por año, mes y día, y presentar la información ordenada por
la fecha que mAS ingresaron estudiantes.
*/
SELECT 
YEAR([Fecha Ingreso])AS Año,
MONTH([Fecha Ingreso])AS Mes,
Day([Fecha Ingreso])AS Día,
COUNT(EstudiantesID) AS cantidad_estudiantes
FROM Estudiantes
GROUP BY [Fecha Ingreso]
ORDER BY [cantidad_estudiantes] DESC


/*
Análisis de encargados con mAS docentes a cargo:
- Identificar el **top 10** de los encargados que tiene más docentes a cargo, filtrar solo los que
tienen a cargo docentes.
- Ordenar de **mayor** a **menor** para poder tener el listado correctamente.
*/
SELECT top (10) encargado.Encargado_ID, 
COUNT (staff.docentesID) AS cantidad_doc
FROM staff inner join Encargado
on Encargado.Encargado_ID = staff.Encargado
WHERE tipo LIKE '%docentes%'
group by Encargado.Encargado_ID
order by cantidad_doc desc


/*
Análisis de profesiones con mAS estudiantes:
- Identificar la profesión y la cantidad de estudiantes que ejercen, mostrar el listado solo de lAS
profesiones que tienen mAS de 5 estudiantes.
- Ordenar de **mayor** a **menor** por la profesión que tenga mAS estudiantes.
*/
SELECT Profesiones.Profesiones,
COUNT(Estudiantes.EstudiantesID) AS cant_estudiantes
FROM Profesiones
left join Estudiantes on Profesiones.ProfesionesID=Estudiantes.Profesion
group by Profesiones.Profesiones
having COUNT(Estudiantes.EstudiantesID) > 5
order by cant_estudiantes desc


/*
Análisis de estudiantes por área de educación:
- Identificar: nombre del área, si la ASignatura es carrera o curso , a qué jornada pertenece, cantidad
de estudiantes y monto total del costo de la ASignatura.
- Ordenar el informe de **mayor** a **menor** por monto de costos total tener en cuenta los docentes que
no tienen ASignaturAS ni estudiantes ASignados, también sumarlos.
*/
SELECT 
Area.Nombre,
ASignaturAS.Tipo,
ASignaturAS.Jornada,
COUNT(Estudiantes.EstudiantesID) AS Cantidad_Estudiantes,
SUM(ASignaturAS.Costo) AS costo_Total 
FROM ASignaturAS
inner join Area on ASignaturAS.Area=Area.AreaID
left join Staff on Staff.ASignatura=ASignaturAS.ASignaturASID
left join Estudiantes on Staff.DocentesID=Estudiantes.Docente
group by Area.Nombre,ASignaturAS.Tipo,ASignaturAS.Jornada
order by costo_Total desc


/*
Análisis mensual de estudiantes por área
- Identificar para cada área: el año y el mes (CONCATenados en formato YYYYMM), cantidad de estudiantes
y monto total de lAS ASignaturAS.
- Ordenar por mes del más actual al más antiguo y por cantidad de clientes de **mayor** a **menor**.
*/
SELECT Area.Nombre,
CONVERT(nVARCHAR(6),Estudiantes.[Fecha Ingreso],112) AS YYYYMM,
COUNT(Estudiantes.EstudiantesID) cantidad,
SUM(ASignaturAS.Costo) AS Total
FROM Estudiantes
inner join Staff on Estudiantes.Docente=Staff.DocentesID
inner join ASignaturAS on Staff.ASignatura=ASignaturAS.ASignaturASID
inner join Area on ASignaturAS.Area=Area.AreaID
GROUP BY Area.Nombre,CONVERT(nVARCHAR(6),Estudiantes.[Fecha Ingreso],112)
ORDER BY YYYYMM DESC, cantidad DESC


/*
Análisis encargado tutores jornada noche
- Identificar el nombre del encargado, el documento, el número de la camada(solo el número) y la fecha
de ingreso del tutor. Ordenar por camada de forma **mayor** a **menor**.
*/
SELECT 
Encargado.nombre,
Encargado.Documento,
right(Staff.Camada,5) AS camada,
Staff.[Fecha Ingreso] AS FechaIngresoTutor
FROM Encargado 
inner JOIN Staff on Encargado.Encargado_ID=Staff.Encargado
inner join ASignaturAS on ASignaturAS.ASignaturASID=Staff.ASignatura
WHERE ASignaturAS.Jornada='Noche'
AND Encargado.Tipo LIKE '%Tutores%'


/*
Análisis ASignaturAS sin docentes o tutores:
- Identificar el tipo de ASignatura, la jornada, la cantidad de áreAS únicAS y la cantidad total de 
ASignaturAS que no tienen ASignadAS docentes o tutores.
- Ordenar por tipo de forma **descendente**.
*/
SELECT 
ASignaturAS.Tipo,
ASignaturAS.jornada,
COUNT(DISTINCT ASignaturAS.area) AS cant_areAS,
COUNT(ASignaturAS.nombre) AS cant_ASignaturAS
FROM ASignaturAS
left join staff on ASignaturAS.ASignaturASID=Staff.ASignatura
WHERE DocentesID is null
group by ASignaturAS.Tipo, ASignaturAS.Jornada
order by ASignaturAS.tipo desc


/*
Análisis ASignaturAS mayor al promedio:
- Identificar el nombre de la ASignatura, el costo de la ASignatura y el promedio del costo de lAS 
ASignaturAS por área.
- Una vez obtenido el dato, del promedio se debe visualizar solo lAS carrerAS que se encuentran por 
encima del promedio.
*/
SELECT 
ASignaturAS.Nombre,
ASignaturAS.Costo,
Area.avgcosto
FROM ASignaturAS
left join 
(SELECT Area,avg(Costo) avgcosto
FROM  ASignaturAS 
group by Area) Area   
ON ASignaturAS.Area=Area.Area   
WHERE ASignaturAS.Costo>Area.avgcosto


/*
Análisis aumento de salario docentes (*uso de aliAS para TablAS*)
- Identificar el nombre, documento, el área, la ASignatura y el aumento del salario del docente, este 
ultimo calcularlo sacándole un porcentaje al costo de la ASignatura, todos lAS áreAS tienen un
porcentaje distINTO, Marketing-17%, Diseño-20%, Programacion-23%, Producto-13%, Data-15%, HerramientAS 8%
*/
SELECT
t1.Nombre,
t1.Documento,
t3.Nombre AS area,
t2.Nombre AS ASignaturAS,
CAST((costo * 0.17)AS decimal(7,3)) AS Salario
FROM Staff t1
left join ASignaturAS t2 on t1.ASignatura=t2.ASignaturASID
inner join area t3 on t2.Area=t3.AreaID
WHERE t3.Nombre LIKE ('%Marketing%')   
union
SELECT
t1.Nombre,
t1.Documento,
t3.Nombre AS area,
t2.Nombre AS ASignaturAS,
CAST((costo * 0.20)AS decimal(7,3)) AS Salario
FROM Staff t1
left join ASignaturAS t2 on t1.ASignatura=t2.ASignaturASID
inner join area t3 on t2.Area=t3.AreaID
WHERE t3.Nombre LIKE ('%Diseno%')
union
SELECT
t1.Nombre,
t1.Documento,
t3.Nombre AS area,
t2.Nombre AS ASignaturAS,
CAST((costo * 0.23)AS decimal(7,3)) AS Salario
FROM Staff t1
left join ASignaturAS t2 on t1.ASignatura=t2.ASignaturASID
inner join area t3 on t2.Area=t3.AreaID
WHERE t3.Nombre LIKE ('%Programacion%')
union
SELECT
t1.Nombre,
t1.Documento,
t3.Nombre AS area,
t2.Nombre AS ASignaturAS,
CAST((costo * 0.13)AS decimal(7,3)) AS Salario
FROM Staff t1
left join ASignaturAS t2 on t1.ASignatura=t2.ASignaturASID
inner join area t3 on t2.Area=t3.AreaID
WHERE t3.Nombre LIKE ('%Producto%')
union
SELECT
t1.Nombre,
t1.Documento,
t3.Nombre AS area,
t2.Nombre AS ASignaturAS,
CAST((costo * 0.15)AS decimal(7,3)) AS Salario
FROM Staff t1
left join ASignaturAS t2 on t1.ASignatura=t2.ASignaturASID
inner join area t3 on t2.Area=t3.AreaID
WHERE t3.Nombre LIKE ('%Data%')
union
SELECT
t1.Nombre,
t1.Documento,
t3.Nombre AS area,
t2.Nombre AS ASignaturAS,
CAST((costo * 0.08)AS decimal(7,3)) AS Salario
FROM Staff t1
left join ASignaturAS t2 on t1.ASignatura=t2.ASignaturASID
inner join area t3 on t2.Area=t3.AreaID
WHERE t3.Nombre LIKE ('%HerramientAS%')