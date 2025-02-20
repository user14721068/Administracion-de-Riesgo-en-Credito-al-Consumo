/* -------------------------------------------------------------------------------------------- */
/* 06 FEBRERO 2025 */           

/* Ejercicios video C1 */

/*Ejemplo*/
/*Crear un par de tablas llamadas E1SQL y E1SAS en la base de datos WORK que contenga el id del cliente y 
su fecha de nacimiento */

/* Codigo SQL */
proc sql;
create table work.E1SQL as 
select 	d.Cliente,
		d.Fecha_Nacimiento
from origina.demograficos as d;
quit;

/* Codigo SAS */
data work.E1SAS;
set origina.demograficos;
keep cliente fecha_nacimiento;
run;

/*Ejemplo*/
/* Crear las tablas E2SQL y E2SAS en la base de datos WORK que tenga solo el id del cliente y su apellido paterno */

/* Codigo SQL */
proc sql;
create table work.E2SQL as
select 	d.Cliente,
		d.ApPaterno_Solic
from origina.nombre as d;
quit;

/* Codigo SAS */
data work.E2SAS;
set origina.nombre;
keep Cliente ApPaterno_Solic;
run;


/* -------------------------------------------------------------------------------------------- */


/* 10 FEBRERO 2025 LUNES */

/* Ejercicios video C2*/

/* Crea una tabla en la base de datos work de nombre "E3SQL" que contenga todos los campos de la tabla solicitud
pero solo con los registros cuyo monto solicitado sea mayor a 10,000 pesos utilizando codigo SQL */

/* SQL */
proc sql;
create table work.E3SQL as
select 	*
from 	origina.solicitud as s
where 	s.monto_solicitado > 10000;
quit;

/* SAS */
data work.E3SAS;
set origina.solicitud;
if monto_solicitado > 10000;
run;

/* Crear una tabla en la base de datos WORK de nombre "E4SQL" y "E4SAS" que contenga todos los campos de la tabla demograficos
pero solo con los registros de clientes de sexo masculino */

/* SQL */
proc sql;
create table work.E4SQL as
select *
from origina.demograficos as d
where d.sexo = "M";
quit;

/* SAS */
data work.E4SAS;
set origina.demograficos;
if sexo = "M";
run;



/* Ejercicio en clase */

/* Crear una tabla en la base de datos WORK de nombre "E5SQL" y "E5SAS" solo los campos cliente y sexo 
filtrando solo a las mujeres. */

/* SQL */
PROC SQL;
CREATE TABLE WORK.E5SQL AS
SELECT D.CLIENTE,
       D.SEXO
FROM   ORIGINA.DEMOGRAFICOS AS D
WHERE  D.SEXO = "F";
QUIT;


/* SAS */
DATA WORK.E5SAS;
SET ORIGINA.DEMOGRAFICOS;
KEEP CLIENTE SEXO;
IF SEXO="F";
RUN;



/* --------------------------------------------------------------------------------------- */

/* 11 FEBRERO 2025 */

/*Ejercicios video c3*/

/* Crea una tabla en al bd work de nombre E5SQL que contenga 
los campos de cliente, sexo, estado, ingreso fijo,
ingreso variable, construye un campo nuevo que se llame 
ingreso total, sumando ambos ingresos y quedate solo con 
los hombres del distrito federal usando SQL  */

/* SQL */
PROC SQL; 
CREATE TABLE WORK.E5SQL AS
SELECT D.CLIENTE,
       D.SEXO,
       D.ESTADO,
       D.INGRESO_FIJO,
       D.INGRESO_VARIABLE,
       D.INGRESO_FIJO + D.INGRESO_VARIABLE AS INGRESO_TOTAL
FROM ORIGINA.DEMOGRAFICOS AS D
WHERE D.SEXO = "M" AND D.ESTADO="DISTRITO FEDERAL";
QUIT;


/* SAS */
DATA WORK.E5SAS;
SET ORIGINA.DEMOGRAFICOS;
    INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
KEEP CLIENTE SEXO ESTADO INGRESO_FIJO INGRESO_VARIABLE INGRESO_TOTAL;
IF SEXO="M";
IF ESTADO="DISTRITO FEDERAL";
RUN;

/* EJERCICIO 1 TAREA 1 */
/* Crear una tabla T1SQL y T2SAS dentro de la base de datos WORK con la siguiente 
información: cliente, estado y sexo.  */

/* SQL */
PROC SQL;
CREATE TABLE WORK.T1SQL AS
SELECT 		CLIENTE,
			ESTADO,
			SEXO
FROM		ORIGINA.DEMOGRAFICOS;
QUIT;

/* SAS */
DATA 	WORK.T2SAS;
SET 	ORIGINA.DEMOGRAFICOS;
KEEP 	CLIENTE ESTADO SEXO;
RUN;


/* EJERCICIO 2 TAREA 1 */
/* Crear una tabla T3SQL y T4SAS dentro de la base de datoz work 
que contenga todos los datos de la tabla aprobadas 
pero solo con los clientes a los que se le aprobó su credito */

/* SQL */
PROC SQL;
CREATE TABLE WORK.T3SQL AS
SELECT *
FROM ORIGINA.APROBADAS AS A
WHERE A.ESTATUS="A";
QUIT;

/* SAS */
DATA WORK.T4SAS;
SET ORIGINA.APROBADAS;
IF ESTATUS="A";
RUN;



/* EJERCICIO 3 TAREA 1 */

/* CREAR UNA TABLA T5SQL Y T6SAS dentro de la BD work 
que contenga los siguientes campos:
cliente, sexo, estado, 
Nivel de estudios, ingreso total, aplocando los siguientes 
filtros: frecuencia de pago quincenal, ingreso total 
mayor a 7000 y solo del DISTRITO FEDERAL */

/* SQL */
PROC SQL;
CREATE TABLE WORK.T5SQL AS 
SELECT CLIENTE,
       SEXO,
       ESTADO,
       NIVEL_ESTUDIOS,
       D.INGRESO_FIJO + D.INGRESO_VARIABLE AS INGRESO_TOTAL,
       D.PERIODICIDAD
FROM ORIGINA.DEMOGRAFICOS AS D
WHERE D.PERIODICIDAD = "Quincenal" AND
	  D.INGRESO_FIJO + D.INGRESO_VARIABLE > 7000 AND
	  D.ESTADO = D.ESTADO="DISTRITO FEDERAL";
QUIT;


/* SAS */
DATA  WORK.T6SAS;
SET   ORIGINA.DEMOGRAFICOS;
	  INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
KEEP  CLIENTE SEXO ESTADO NIVEL_ESTUDIOS INGRESO_TOTAL PERIODICIDAD;
IF 	  PERIODICIDAD = "Quincenal";
IF    INGRESO_TOTAL > 7000;
IF    ESTADO = "DISTRITO FEDERAL";
RUN;


/* EJERCICIO DE CLASE */
/*Contruir un par de tablas en la BD wORK de nombre E8SQL y E8SAS que contengan los siguientes
campos: Cliente, Fecha de Nacimiento, Ingreso Total, Frecuencia de Pago, Sexo, Estado.
Aplicando los siguientes filtros: Ingreso Total > 7000, Estado = Estado de Mexico, Sexo = Mujer, 
Frecuencia de pago Quincenal*/

/*SQL*/
PROC SQL;
CREATE TABLE WORK.E8SQL AS
SELECT  CLIENTE,
		FECHA_NACIMIENTO,
		INGRESO_FIJO + INGRESO_VARIABLE AS INGRESO_TOTAL,
		PERIODICIDAD,
		SEXO,
		ESTADO
FROM ORIGINA.DEMOGRAFICOS AS D
WHERE INGRESO_FIJO + INGRESO_VARIABLE > 7000 AND
	  ESTADO = "ESTADO DE MEXICO" AND
	  SEXO = "F" AND
	  PERIODICIDAD = "Quincenal";
QUIT;


/*SAS*/
DATA WORK.E8SAS;
SET ORIGINA.DEMOGRAFICOS;
	INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
KEEP CLIENTE FECHA_NACIMIENTO INGRESO_TOTAL PERIODICIDAD SEXO ESTADO;
IF INGRESO_TOTAL > 7000;
IF ESTADO = "ESTADO DE MEXICO";
IF SEXO = "F";
IF PERIODICIDAD = "Quincenal";
RUN;


/* ----------------------------------------------------------------------------------------- */

/* 12 FEBRERO 2025 */

/* EJERCICIO VIDEO C4 */
/*Crear un par de tablas de nombre E9SQL y E9SAS que contengan los siguientes campos:
Cliente, Nombre, Apellido Paterno, Fecha de Nacimiento, Fecha en que se hizo la solicitud,
Edad, Ingreso Total. Aplicando los siguienes filtros: Ingreso Total > 10000 y Edad > 24*/

/*SQL*/
PROC SQL;
CREATE TABLE WORK.E9SQL AS
SELECT 	N.CLIENTE, 
		N.NOMBRE_SOLIC,
		N.APPATERNO_SOLIC,
		D.FECHA_NACIMIENTO,
		S.FECHA_SOLICITUD,
		INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD,
		INGRESO_FIJO + INGRESO_VARIABLE AS INGRESO_TOTAL
FROM ORIGINA.NOMBRE AS N 
LEFT JOIN ORIGINA.DEMOGRAFICOS AS D ON N.CLIENTE = D.CLIENTE
LEFT JOIN ORIGINA.SOLICITUD AS S ON S.CLIENTE = N.CLIENTE
WHERE D.INGRESO_FIJO + INGRESO_VARIABLE > 10000 
  AND INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) > 24;   
QUIT;

/*SAS*/
DATA WORK.E9SAS;
MERGE 	ORIGINA.NOMBRE (IN=N) 
		ORIGINA.DEMOGRAFICOS (IN=D)
		ORIGINA.SOLICITUD (IN=S);
		INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
		EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
BY 		CLIENTE;
KEEP CLIENTE NOMBRE_SOLIC APPATERNO_SOLIC FECHA_NACIMIENTO FECHA_SOLICITUD EDAD INGRESO_TOTAL;
IF INGRESO_TOTAL > 10000;
IF EDAD > 24;
RUN;

/* MINI EXAMEN */
/* Crear un par de tablas de nombre E10SQL y E10SAS que contengan los siguientes campos:
Cliente, Nombre, Apellido Paterno, Monto Solicitado, Ingreso Total, Edad, Estatus y BC Score.
Aplicar los siguientes filtros: Ingreso Total > 10000, Mas de 40 años de edad, Vivir en el DF, Solo clientes
aprobados (ie estatus = "A") y BC Score > 650 */

/* SQL */
PROC SQL;
CREATE TABLE WORK.E10SQL AS
SELECT 	  	N.CLIENTE,
		  	N.NOMBRE_SOLIC,
		  	N.APPATERNO_SOLIC,
		  	S.MONTO_SOLICITADO,
		  	D.INGRESO_FIJO + D.INGRESO_VARIABLE AS INGRESO_TOTAL,
		  	INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD,
		  	A.ESTATUS,
		  	BURO.BC_SCORE
FROM 	  	ORIGINA.NOMBRE AS N 
LEFT JOIN 	ORIGINA.DEMOGRAFICOS AS D ON N.CLIENTE = D.CLIENTE
LEFT JOIN 	ORIGINA.SOLICITUD AS S ON S.CLIENTE = N.CLIENTE
LEFT JOIN 	ORIGINA.BURO AS B ON B.CLIENTE = N.CLIENTE
LEFT JOIN 	ORIGINA.APROBADAS AS A ON A.CLIENTE = N.CLIENTE
WHERE     	D.INGRESO_FIJO + D.INGRESO_VARIABLE > 10000
AND   		INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD)>40
AND			D.ESTADO = "DISTRITO FEDERAL"
AND 		A.ESTATUS = "A"
AND 		B.BC_SCORE > 650;
QUIT;

/* SAS */
DATA WORK.E10SAS;
MERGE		ORIGINA.NOMBRE (IN=N)
			ORIGINA.DEMOGRAFICOS (IN=D)
			ORIGINA.SOLICITUD (IN=S)
			ORIGINA.BURO (IN=B)
			ORIGINA.APROBADAS (IN=A);
			INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
			EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
BY			CLIENTE;
IF 			INGRESO_TOTAL > 10000;
IF			EDAD > 40;
IF			ESTADO = "DISTRITO FEDERAL";
IF          ESTATUS = "A";
IF			BC_SCORE > 650;
RUN;


/*EJERCICIO 4 TAREA 1*/
/* Crear una tabla T7SQL y T8SAS dentro de la base de datos WORK que contenga los 
siguientes campos: Cliente, apellido paterno, apellido materno, Nombres, Estado, Sexo, 
Fecha de nacimiento, Ingreso total, Edad, Estatus (de si fue aprobado o rechazado su 
crédito), BC Score, Monto Solicitado. Aplicando los siguientes filtros: estatus aprobado, 
ingreso total >= 10mil pesos, BC Score > 0 , que vivan en el distrito Federal y que tengan 
más de 24 años.  */

/* SQL */
PROC SQL;
CREATE TABLE WORK.T7SQL AS
SELECT      N.CLIENTE,
			N.APPATERNO_SOLIC,
			N.APMATERNO_SOLIC,
			N.NOMBRE_SOLIC,
			D.ESTADO,
			D.SEXO,
			D.FECHA_NACIMIENTO,
			D.INGRESO_FIJO + D.INGRESO_VARIABLE AS INGRESO_TOTAL,
			INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD,
			A.ESTATUS,
			BURO.BC_SCORE,
			S.MONTO_SOLICITADO
FROM 	  	ORIGINA.NOMBRE AS N 
LEFT JOIN 	ORIGINA.DEMOGRAFICOS AS D ON N.CLIENTE = D.CLIENTE
LEFT JOIN 	ORIGINA.SOLICITUD AS S ON S.CLIENTE = N.CLIENTE
LEFT JOIN 	ORIGINA.BURO AS B ON B.CLIENTE = N.CLIENTE
LEFT JOIN 	ORIGINA.APROBADAS AS A ON A.CLIENTE = N.CLIENTE
WHERE		A.ESTATUS = "A"
AND			D.INGRESO_FIJO + D.INGRESO_VARIABLE > 10000
AND         B.BC_SCORE > 0
AND         D.ESTADO = "DISTRITO FEDERAL"
AND         INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) > 24;
QUIT;

/* SAS */
DATA WORK.T8SAS;
MERGE		ORIGINA.NOMBRE (IN=N)
			ORIGINA.DEMOGRAFICOS (IN=D)
			ORIGINA.SOLICITUD (IN=S)
			ORIGINA.BURO (IN=B)
			ORIGINA.APROBADAS (IN=A);
			INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
			EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
BY          CLIENTE;
IF          ESTATUS = "A";
IF 			INGRESO_TOTAL > 10000;
IF			BC_SCORE > 0;
IF			ESTADO = "DISTRITO FEDERAL";
IF			EDAD > 24;
RUN;


/* ----------------------------------------------------------------------------------------- */

/* 2025 FEBRERO 13 */

/* EJERCICIOS VIDEO C5 */

/* Generar un reporte R1SQL y R1SAS dentro de la BD work que resuma:
¿Cuántos clientes hay por nivel de estudio? */

/* SQL */
PROC SQL;
CREATE TABLE WORK.R1SQL AS 
SELECT	D.NIVEL_ESTUDIOS,
		COUNT(D.CLIENTE) AS CLIENTES
FROM ORIGINA.DEMOGRAFICOS AS D
GROUP BY D.NIVEL_ESTUDIOS;
QUIT;

/* SQL */
PROC SUMMARY DATA=ORIGINA.DEMOGRAFICOS NWAy; /* NWAY omite la fila con el total de clientes */
CLASS NIVEL_ESTUDIOS;
VAR CLIENTE;
OUTPUT OUT=WORK.R1SAS (DROP=_TYPE_ _FREQ_)
N(CLIENTE)=CLIENTES;
RUN;

/* Generar un reporte R2SQL y R2SAS dentro de la base de datos WORK que resuma: 
¿Cuántos clientes hay por estado y por sexo?
¿Cuál es su ingreso total promedio, mínimo y máximo?
¿Cuál es el monto solicitado promedio, mínimo y máximo?
Solo consideramos aquellos clientes que fueron aprobados.
 */

/* SQL */
PROC SQL;
CREATE TABLE R2SQL AS 
SELECT 		D.ESTADO,
			D.SEXO,
			COUNT(D.CLIENTE) AS CLIENTES,
			AVG(D.INGRESO_FIJO + D.INGRESO_VARIABLE) AS PROMEDIO_INGRESOS,
			AVG(S.MONTO_SOLICITADO) AS PROM_MONTO_SOLICITADO,
			MIN(S.MONTO_SOLICITADO) AS MIN_MONTO_SOLICITADO,
			MAX(S.MONTO_SOLICITADO) AS MAX_MONTO_SOLICITADO
FROM		ORIGINA.DEMOGRAFICOS AS D 
LEFT JOIN	ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
LEFT JOIN 	ORIGINA.APROBADAS AS A ON D.CLIENTE=A.CLIENTE
WHERE 		A.ESTATUS="A"
GROUP BY 	1,2;
QUIT;

/* SAS */
DATA WORK.TEMPORAL;
MERGE 	ORIGINA.DEMOGRAFICOS (IN=D)
		ORIGINA.SOLICITUD (IN=S)
		ORIGINA.APROBADAS (IN=A);
		INGRESO_TOT = INGRESO_FIJO + INGRESO_VARIABLE;
BY		CLIENTE;
KEEP 	CLIENTE ESTADO SEXO MONTO_SOLICITADO INGRESO_TOT;
IF		ESTATUS = "A";
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS ESTADO SEXO;									/* Variables a agrupar */
VAR   CLIENTE INGRESO_TOT MONTO_SOLICITADO;			/* Variables a usar */
OUTPUT OUT=WORK.R2SAS(DROP=_TYPE_ _FREQ_)			/* Ruta donde guardar y omitir tipo de dato y frecuencia */
N(CLIENTE)= CLIENTES								/* Conteo de clientes */
MEAN(INGRESO_TOT) = PROM_INGRESOS					/* Promedio de ingreso */
MEAN(MONTO_SOLICITADO) = PROM_MONTO_SOLICITADO  	/* Promedio del monto solciitado */
MIN(MONTO_SOLICITADO) = MIN_MONTO_SOLICITADO		/* Minimo monto solicitado */
MAX(MONTO_SOLICITADO) = MAX_MONTO_SOLICITADO;		/* Maximo monto solcitado */
RUN;


/* MINI EXAMEN */
/* Crear un reporte R3SQL y R3SAS que resuma por estado, sexo y nivel de estudios:
¿Cuántos clientes hay?
¿Cuál es el monto promedio solicitado?
¿Cuál es el ingreso total promedio?
¿Cuál es el BC Score promedio?
¿Cuál es el BC Score mínimo?
¿Cuál es el BC Score máximo?
Solo considerar clientes aprobados cuyo score sea mayor a 650
y con ingresos > 7000 
*/

/* SQL */
proc sql;
create table work.r3sql as
select d.estado,
       D.sexo,
       d.nivel_estudios,
       count(d.cliente) as num_clientes,
       avg(s.monto_solicitado) as monto_promedio,
       avg(d.ingreso_fijo + d.ingreso_variable) as ingreso_tot_prom,         
       avg(B.bc_score) as buro_prom,
       max(b.bc_score) as buro_max,
       min(b.bc_score) as buro_min
from origina.demograficos as d
left join origina.solicitud as s on d.cliente=s.cliente
left join origina.aprobadas as a on A.cliente=d. cliente
left join origina.buro as b on b.cliente=d.cliente
Where b.bc_score > 650 
and d.ingreso_fijo + d.ingreso_variable > 7000
and a.estatus="A"
group by 1,2,3;
quit;

/* SAS */
data work.temporal;
merge	origina.demograficos (in=d)
		origina.solicitud (in=s)
		origina.aprobadas (in=a)
		origina.buro (in=b);
		ingreso_total = ingreso_fijo + ingreso_variable;
by 		cliente;
keep 	estado sexo nivel_estudios cliente monto_solicitado ingreso_total bc_score;
if		estatus="A";
if      ingreso_total > 7000;
if      bc_score > 650;
run;

proc summary data=work.temporal nway;
class	estado sexo nivel_estudios;
var		cliente monto_solicitado ingreso_total bc_score;
output out=work.R3SAS(drop=_type_ _freq_)
n(cliente) = clientes
mean(monto_solicitado) = monto_promedio
mean(ingreso_total) = ingreso_promedio
max(bc_score) = bc_score_max
min(bc_score) = bc_score_min;
run;

/* EJERCICIO 5 TAREA 1 */
/* Generar un reporte R1SQL y R2SAS dentro de la base de datos WORK que resuma: 
¿cuántos clientes y cuál es ingreso total promedio que hay por sexo y entidad federativa? */

/* SQL */
PROC SQL;
CREATE TABLE WORK.R1SQL AS
SELECT 		SEXO,
			ESTADO,
			COUNT(CLIENTE) AS NRO_CLIENTES,
			AVG(INGRESO_FIJO + INGRESO_VARIABLE) AS INGRESO_TOTAL_AVG
FROM 		ORIGINA.DEMOGRAFICOS
GROUP BY 	1,2;
QUIT;

/* SAS */
DATA 		WORK.TEMPORAL;
SET			ORIGINA.DEMOGRAFICOS;
			INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
KEEP 		SEXO ESTADO CLIENTE INGRESO_TOTAL;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS 		SEXO ESTADO;
VAR			CLIENTE INGRESO_TOTAL;
OUTPUT OUT=WORK.R2SAS(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = NRO_CLIENTES
MEAN(INGRESO_TOTAL) = INGRESO_TOTAL_AVG;
RUN;


/* EJERCICIO 6 TAREA 1 */
/* Generar un reporte R3SQL y R4SAS dentro de la base  de datos WORK que resuma: 
¿Cuántos clientes hay y qué monto promedio solicitaron por Tipo de crédito solo de 
clientes cuyo que nacieron después de 1985? */

/* SQL */
PROC SQL;
CREATE TABLE WORK.R3SQL AS
SELECT 		D.TIPO_CR_DITO,
			COUNT(D.CLIENTE) AS NRO_CLIENTES,
			AVG(S.MONTO_SOLICITADO) AS MONTO_PROMEDIO_SOLICITADO
FROM 		ORIGINA.DEMOGRAFICOS AS D
LEFT JOIN   ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
WHERE 		YEAR(FECHA_NACIMIENTO) > 1985
GROUP BY    1;
QUIT;

/* SAS */
DATA WORK.TEMPORAL;
MERGE		ORIGINA.DEMOGRAFICOS 	(IN=D)
			ORIGINA.SOLICITUD 		(IN=S);
			AÑO_NACIMIENTO = YEAR(FECHA_NACIMIENTO);
BY			CLIENTE;
KEEP		TIPO_CR_DITO CLIENTE MONTO_SOLICITADO;
IF			AÑO_NACIMIENTO > 1985;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS 		TIPO_CR_DITO;
VAR			CLIENTE MONTO_SOLICITADO;
OUTPUT OUT=WORK.R4SAS(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = NRO_CLIENTES
MEAN(MONTO_SOLICITADO) = MONTO_SOLICITADO_PROMEDIO;
RUN;

/* EJERCICIO 7 TAREA 1 */

/* Generar un reporte R5SQL y R6SAS dentro de la base de datos WORK  que resuma: 
¿Cuántos clientes hay, qué monto promedio solicitaron, ingreso total promedio , BC Score 
promedio por quinquenio de edad solo de los clientes que fueron aprobados y cuyo BC 
Score sea mayor a 0? */

/* SQL */
PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 	EDAD,
		CASE 
			WHEN EDAD > 0  AND EDAD <= 5   THEN   "Quinquenio 01: 0  a 05"
			WHEN EDAD > 5  AND EDAD <= 10  THEN   "Quinquenio 02: 05 a 10"
			WHEN EDAD > 10 AND EDAD <= 15  THEN   "Quinquenio 03: 10 a 15"
			WHEN EDAD > 15 AND EDAD <= 20  THEN   "Quinquenio 04: 15 a 20"
			WHEN EDAD > 20 AND EDAD <= 25  THEN   "Quinquenio 05: 20 a 25"
			WHEN EDAD > 25 AND EDAD <= 30  THEN   "Quinquenio 06: 25 a 30"
			WHEN EDAD > 30 AND EDAD <= 35  THEN   "Quinquenio 07: 30 a 35"
			WHEN EDAD > 35 AND EDAD <= 40  THEN   "Quinquenio 08: 35 a 40"
			WHEN EDAD > 40 AND EDAD <= 45  THEN   "Quinquenio 09: 40 a 45"
			WHEN EDAD > 45 AND EDAD <= 50  THEN   "Quinquenio 10: 45 a 50"
			WHEN EDAD > 50 AND EDAD <= 55  THEN   "Quinquenio 11: 50 a 55"
			WHEN EDAD > 55 AND EDAD <= 60  THEN   "Quinquenio 12: 55 a 60"
			WHEN EDAD > 60 AND EDAD <= 65  THEN   "Quinquenio 13: 60 a 65"
			WHEN EDAD > 65 AND EDAD <= 70  THEN   "Quinquenio 14: 65 a 70"
			WHEN EDAD > 70 AND EDAD <= 75  THEN   "Quinquenio 15: 70 a 75"
			WHEN EDAD > 75 AND EDAD <= 80  THEN   "Quinquenio 16: 75 a 80"
			WHEN EDAD > 80 AND EDAD <= 85  THEN   "Quinquenio 17: 80 a 85"
			WHEN EDAD > 85 AND EDAD <= 90  THEN   "Quinquenio 18: 85 a 90"
			WHEN EDAD > 90 AND EDAD <= 95  THEN   "Quinquenio 19: 90 a 95"
			WHEN EDAD > 95 AND EDAD <= 100 THEN   "Quinquenio 20: 95 a 100"
		END AS QUINQUENIO,
		CLIENTE,
		MONTO_SOLICITADO,
		INGRESO_TOTAL,
		BC_SCORE
FROM 	(SELECT 	D.CLIENTE,
					S.MONTO_SOLICITADO,
					INGRESO_FIJO + INGRESO_VARIABLE AS INGRESO_TOTAL,
					BC_SCORE,
					INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD) AS EDAD
		FROM 		ORIGINA.DEMOGRAFICOS AS D
		LEFT JOIN	ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
		LEFT JOIN	ORIGINA.BURO AS B ON B.CLIENTE=D.CLIENTE
		LEFT JOIN   ORIGINA.APROBADAS AS A ON A.CLIENTE=D.CLIENTE
		WHERE 		BC_SCORE > 0
		AND 		ESTATUS="A") AS T;
QUIT;

PROC SQL;
CREATE TABLE WORK.R5SQL AS 
SELECT 	QUINQUENIO,
		COUNT(CLIENTE) AS NRO_CLIENTES,
		AVG(MONTO_SOLICITADO) AS MONTO_PROMEDIO_SOLICITADO,
		AVG(INGRESO_TOTAL) AS INGRESO_PROMEDIO_TOTAL,
		AVG(BC_SCORE) AS BC_SCORE_PROMEDIO
FROM 	WORK.TEMPORAL
GROUP BY 1
ORDER BY 1;
QUIT;

/* SAS */
DATA 		WORK.TEMPORAL;
MERGE		ORIGINA.DEMOGRAFICOS	(IN=D)
			ORIGINA.SOLICITUD 		(IN=S)
			ORIGINA.BURO			(IN=B)
			ORIGINA.APROBADAS		(IN=A);
			INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
			EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
			QUINQUENIO = "No se tiene información";
			IF 		EDAD > 0  AND EDAD <= 5   THEN QUINQUENIO = "Quinquenio 01: 0   a 05" ;
    		ELSE IF EDAD > 5  AND EDAD <= 10  THEN QUINQUENIO = "Quinquenio 02: 05  a 10" ;
    		ELSE IF EDAD > 10 AND EDAD <= 15  THEN QUINQUENIO = "Quinquenio 03: 10  a 15" ;
    		ELSE IF EDAD > 15 AND EDAD <= 20  THEN QUINQUENIO = "Quinquenio 04: 15  a 20" ;
    		ELSE IF EDAD > 20 AND EDAD <= 25  THEN QUINQUENIO = "Quinquenio 05: 20  a 25" ;
    		ELSE IF EDAD > 25 AND EDAD <= 30  THEN QUINQUENIO = "Quinquenio 06: 25  a 30" ;
    		ELSE IF EDAD > 30 AND EDAD <= 35  THEN QUINQUENIO = "Quinquenio 07: 30  a 35" ;
    		ELSE IF EDAD > 35 AND EDAD <= 40  THEN QUINQUENIO = "Quinquenio 08: 35  a 40" ;
    		ELSE IF EDAD > 40 AND EDAD <= 45  THEN QUINQUENIO = "Quinquenio 09: 40  a 45" ;
    		ELSE IF EDAD > 45 AND EDAD <= 50  THEN QUINQUENIO = "Quinquenio 10: 45  a 50" ;
    		ELSE IF EDAD > 50 AND EDAD <= 55  THEN QUINQUENIO = "Quinquenio 11: 50  a 55" ;
    		ELSE IF EDAD > 55 AND EDAD <= 60  THEN QUINQUENIO = "Quinquenio 12: 55  a 60" ;
    		ELSE IF EDAD > 60 AND EDAD <= 65  THEN QUINQUENIO = "Quinquenio 13: 60  a 65" ;
    		ELSE IF EDAD > 65 AND EDAD <= 70  THEN QUINQUENIO = "Quinquenio 14: 65  a 70" ;
    		ELSE IF EDAD > 70 AND EDAD <= 75  THEN QUINQUENIO = "Quinquenio 15: 70  a 75" ;
    		ELSE IF EDAD > 75 AND EDAD <= 80  THEN QUINQUENIO = "Quinquenio 16: 75  a 80" ;
    		ELSE IF EDAD > 80 AND EDAD <= 85  THEN QUINQUENIO = "Quinquenio 17: 80  a 85" ;
    		ELSE IF EDAD > 85 AND EDAD <= 90  THEN QUINQUENIO = "Quinquenio 18: 85  a 90" ;
    		ELSE IF EDAD > 90 AND EDAD <= 95  THEN QUINQUENIO = "Quinquenio 19: 90  a 95" ;
    		ELSE IF EDAD > 95 AND EDAD <= 100 THEN QUINQUENIO = "Quinquenio 20: 95  a 100";
BY			CLIENTE;
KEEP 		CLIENTE MONTO_SOLICITADO INGRESO_TOTAL BC_SCORE EDAD QUINQUENIO;
IF 			BC_SCORE > 0;
IF			ESTATUS="A";
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS 	QUINQUENIO; 
VAR		CLIENTE MONTO_SOLICITADO INGRESO_TOTAL BC_SCORE;
OUTPUT OUT=WORK.R6SAS(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = NRO_CLIENTES
MEAN(MONTO_SOLICITADO) = MONTO_PROMEDIO_SOLICITADO
MEAN(INGRESO_TOTAL) = INGRESO_PROMEDIO_TOTAL
MEAN(BC_SCORE) = BC_SCORE_PROMEDIO;
RUN;





/* --------------------------------------------------------------------------------------------- */

/* 17 FEBRERO 2025 LUNES */

/* EJERCICIO C6 */

/* Crear un reporte R10SQL y R10SAS que resuma cuantos clientes hay y cual es su ingreso total promedio por quinquenio de
edad, considerando solo aquellos clientes que son hombres. */

/* SQL */
PROC SQL;
CREATE TABLE WORK.R10SQL AS
SELECT 	W.RANGO_EDAD,
		COUNT(W.CLIENTE) AS CLIENTES,
		AVG(W.INGRESO_TOTAL) AS INGRESO_PROM
FROM
( /* ******************************** W **************************** */
SELECT 	Z.CLIENTE,
		Z.EDAD,
		CASE 	WHEN Z.EDAD >= 18 AND Z.EDAD < 23 THEN "18-23"
				WHEN Z.EDAD >= 23 AND Z.EDAD < 28 THEN "23-28"
				WHEN Z.EDAD >= 28 AND Z.EDAD < 33 THEN "28-33"
				WHEN Z.EDAD >= 33 AND Z.EDAD < 38 THEN "33-38"
				WHEN Z.EDAD >= 38 AND Z.EDAD < 43 THEN "38-43"
				WHEN Z.EDAD >= 43 AND Z.EDAD < 53 THEN "43-53"
				WHEN Z.EDAD >= 53 AND Z.EDAD < 58 THEN "53-58"
				WHEN Z.EDAD >= 58 AND Z.EDAD < 63 THEN "58-63"
				WHEN Z.EDAD >= 63 AND Z.EDAD < 68 THEN "63-68"
				WHEN Z.EDAD >= 68 AND Z.EDAD < 73 THEN "68-73" END AS RANGO_EDAD,
		Z.INGRESO_TOTAL
FROM
( /* ******************************** Z **************************** */
SELECT 		D.CLIENTE,
			D.INGRESO_FIJO + D.INGRESO_VARIABLE AS INGRESO_TOTAL,
			INTCK("YEAR",D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD
FROM 		ORIGINA.DEMOGRAFICOS AS D
LEFT JOIN	ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
WHERE  		D.SEXO = "M"
) AS Z /* *************************** Z **************************** */
) AS W /* *************************** W **************************** */
GROUP 1
;QUIT;


/* SAS */

DATA WORK.TEMPORAL;
MERGE		ORIGINA.DEMOGRAFICOS 	(IN=D)
			ORIGINA.SOLICITUD 		(IN=S);
			INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
			EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
			IF EDAD >= 18 AND EDAD < 23 THEN RANGO_EDAD="18-23";
			IF EDAD >= 23 AND EDAD < 28 THEN RANGO_EDAD="23-28";
			IF EDAD >= 28 AND EDAD < 33 THEN RANGO_EDAD="28-33";
			IF EDAD >= 33 AND EDAD < 38 THEN RANGO_EDAD="33-38";
			IF EDAD >= 38 AND EDAD < 43 THEN RANGO_EDAD="38-43";
			IF EDAD >= 43 AND EDAD < 53 THEN RANGO_EDAD="43-53";
			IF EDAD >= 53 AND EDAD < 58 THEN RANGO_EDAD="53-58";
			IF EDAD >= 58 AND EDAD < 63 THEN RANGO_EDAD="58-63";
			IF EDAD >= 63 AND EDAD < 68 THEN RANGO_EDAD="63-68";
			IF EDAD >= 68 AND EDAD < 73 THEN RANGO_EDAD="68-73";
BY      	CLIENTE;
KEEP		CLIENTE INGRESO_TOTAL EDAD RANGO_EDAD;
IF			SEXO = "M";
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS  		RANGO_EDAD;
VAR			CLIENTE INGRESO_TOTAL;
OUTPUT OUT=WORK.R10SAS(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = CLIENTES
MEAN(INGRESO_TOTAL) = INGRESO_PROMEDIO;
RUN;

/* MINI EXAMEN */
/* Crear un reporte R11SQL y R11SAS que resuma cuantos clientes hay y cuanto es su edad promedio por rango de ingreso
total, considerando solo aquellos clientes que son mujeres y considerando los siguientes rangos de ingreso:
0 		a 1,000
1,000	a 5,000
5,000 	a 10,000
10,000	a 90,000
90,000 	a MÄS
 */
			
/* SQL */
PROC SQL;
CREATE TABLE WORK.R11SQL AS
SELECT 		RANGO_INGRESO,
			COUNT(CLIENTE) AS NRO_CLIENTES,
			AVG(EDAD) AS EDAD_PROMEDIO 
FROM
(       /*************************** Z *****************************************/
SELECT 		INGRESO_FIJO + INGRESO_VARIABLE AS INGRESO_TOTAL,
			CASE
			WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 0     AND (INGRESO_FIJO + INGRESO_VARIABLE) < 1000  THEN "0      a 1,000"
			WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 1000  AND (INGRESO_FIJO + INGRESO_VARIABLE) < 5000  THEN "1,000  a 5,000"
			WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 5000  AND (INGRESO_FIJO + INGRESO_VARIABLE) < 10000 THEN "5,000  a 10,000"
			WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 10000 AND (INGRESO_FIJO + INGRESO_VARIABLE) < 90000 THEN "10,000 a 90,000"
			WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 90000                                               THEN "90,000 a MÁS"
			END AS RANGO_INGRESO,
			D.CLIENTE,
			INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD
FROM 		ORIGINA.DEMOGRAFICOS AS D
LEFT JOIN	ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
WHERE 		D.SEXO = "F"
) AS Z  /*************************** Z *****************************************/
GROUP BY 1;
QUIT;


/* SAS */
DATA WORK.TEMPORAL;
MERGE 	ORIGINA.DEMOGRAFICOS 	(IN=D)
		ORIGINA.SOLICITUD 		(IN=S);
		INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
		EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
		IF INGRESO_TOTAL >= 0     AND INGRESO_TOTAL < 1000  THEN RANGO_INGRESO="0      a 1,000";
		IF INGRESO_TOTAL >= 1000  AND INGRESO_TOTAL < 5000  THEN RANGO_INGRESO="1,000  a 5,000";
		IF INGRESO_TOTAL >= 5000  AND INGRESO_TOTAL < 10000 THEN RANGO_INGRESO="5,000  a 10,000";
		IF INGRESO_TOTAL >= 10000 AND INGRESO_TOTAL < 90000 THEN RANGO_INGRESO="10,000 a 90,000";
		IF INGRESO_TOTAL >= 90000                           THEN RANGO_INGRESO="90,000 a MÁS";
BY		CLIENTE;
KEEP	INGRESO_TOTAL RANGO_INGRESO CLIENTE EDAD;
IF		SEXO="F";
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS 	RANGO_INGRESO;
VAR		CLIENTE EDAD;
OUTPUT OUT=WORK.R11SAS(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = NRO_CLIENTES
MEAN(EDAD) = EDAD_PROMEDIO;
RUN;


/* Generar el código SAS y SQL de los siguientes 
ejercicios:
1. Crear un reporte Rn_SQL_variable y Rn_SAS_variable 
donde se resuma cuántos clientes 
hay? Cuántos no pagaron su crédito? Y qué porcentaje
 de ellos no pagó su crédito? De las 
siguientes variables: 
a. código postal 					ORIGINA.DEMOGRAFICOS CP
b. municipio 						ORIGINA.DEMOGRAFICOS MUNICIPIO
c. estado  							ORIGINA.DEMOGRAFICOS ESTADO
d. nivel de estudios 				ORIGINA.DEMOGRAFICOS NIVEL_ESTUDIOS
e. actividad económica 				ORIGINA.DEMOGRAFICOS ACTIVIDAD
f. puesto solicitante 				ORIGINA.DEMOGRAFICOS PUESTO_SOLICITANTE
g. contrato laboral 				ORIGINA.DEMOGRAFICOS CONTRATO_LABORAL
h. sucursal 						ORIGINA.DEMOGRAFICOS SUCURSAL
i. tipo de crédito 					ORIGINA.DEMOGRAFICOS TIPO_CR_DITO
j. Micro_cr_dito_Lugar 
k. Micro_cr_dito_Tipo 
l. Micro_cr_dito_Ubicaci_n 
m. meses domicilio 
n. meses empleo 
o. ocupaciÃ³n 
p. TipoEmpleoSolicitante 
q. EdoCiv 
r. TipoComprobanteIngresos 
s. TipoVivienda
t. FrecuenciaPrecepcionIngresos
 */


/*
Nota:
La tabla origina.flag_g_b es un subconjunto la tabla origina.aprobadas tales que estatus="A".
A cada fila de la tabla tabla origina.flag_g_b le corresponde una sola fila de la tabla origina.demograficos
*/


/* SQL */
PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		COALESCEC(PUESTO_SOLICITANTE,'NULO'),
			COUNT(D.CLIENTE) AS NRO_CLIENTES,
			SUM(BAD) AS NRO_IMPAGOS,
			100*(SUM(BAD) / COUNT(D.CLIENTE)) AS PCT_IMPAGOS
FROM 		ORIGINA.DEMOGRAFICOS AS D
INNER JOIN 	ORIGINA.APROBADAS AS A ON D.CLIENTE = A.CLIENTE
INNER JOIN 	ORIGINA.FLAG_G_B AS F ON D.CLIENTE = F.CLIENTE
INNER JOIN 	ORIGINA.SOLICITUD AS S ON D.CLIENTE = S.CLIENTE
WHERE 		A.ESTATUS="A"
GROUP BY 	1
ORDER BY 	4 DESC
;QUIT;

/* SAS */
DATA WORK.TEMPORAL;
MERGE      ORIGINA.FLAG_G_B      (IN=F)
           ORIGINA.DEMOGRAFICOS  (IN=D)
           ORIGINA.APROBADAS     (IN=A)
           ORIGINA.SOLICITUD     (IN=S);
           IF PUESTO_SOLICITANTE = "" THEN PUESTO_SOLICITANTE = 'NULO';
BY         CLIENTE;
IF         F;
KEEP       PUESTO_SOLICITANTE CLIENTE BAD;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS      PUESTO_SOLICITANTE;
VAR        CLIENTE BAD;
OUTPUT OUT=WORK.R01SAS(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = NRO_CLIENTES
SUM(BAD)   = NRO_IMPAGOS
MEAN(BAD)  = PCT_IMPAGOS;
RUN;












































































































































































































































































































/**/













































