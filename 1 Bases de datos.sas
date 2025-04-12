/* ---------------------------------------------------------------------------------------------------------------------------------- */
/* Ejercicios c1 */

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


/* ---------------------------------------------------------------------------------------------------------------------------------- */

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



/* ---------------------------------------------------------------------------------------------------------------------------------- */

/*Ejercicios video c3*/

/* Crea una tabla en la bd work de nombre E5SQL que contenga 
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


/* ---------------------------------------------------------------------------------------------------------------------------------- */

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


/* ---------------------------------------------------------------------------------------------------------------------------------- */

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





/* ---------------------------------------------------------------------------------------------------------------------------------- */

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
( 
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
( 
SELECT 		D.CLIENTE,
			D.INGRESO_FIJO + D.INGRESO_VARIABLE AS INGRESO_TOTAL,
			INTCK("YEAR",D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD
FROM 		ORIGINA.DEMOGRAFICOS AS D
LEFT JOIN	ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
WHERE  		D.SEXO = "M"
) AS Z 
) AS W 
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
(       
	SELECT 		INGRESO_FIJO + INGRESO_VARIABLE AS INGRESO_TOTAL,
				CASE
				WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 0     AND (INGRESO_FIJO + INGRESO_VARIABLE) < 1000  THEN "Rango 1  0      a 1,000"
				WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 1000  AND (INGRESO_FIJO + INGRESO_VARIABLE) < 5000  THEN "Rango 2  1,000  a 5,000"
				WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 5000  AND (INGRESO_FIJO + INGRESO_VARIABLE) < 10000 THEN "Rango 3  5,000  a 10,000"
				WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 10000 AND (INGRESO_FIJO + INGRESO_VARIABLE) < 90000 THEN "Rango 4  10,000 a 90,000"
				WHEN (INGRESO_FIJO + INGRESO_VARIABLE) >= 90000                                               THEN "Rango 5  90,000 a MÁS"
				END AS RANGO_INGRESO,
				D.CLIENTE,
				INTCK('YEAR',D.FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD
	FROM 		ORIGINA.DEMOGRAFICOS AS D
	LEFT JOIN	ORIGINA.SOLICITUD AS S ON D.CLIENTE=S.CLIENTE
	WHERE 		D.SEXO = "F"
) AS Z  
GROUP BY 1;
QUIT;


/* SAS */
DATA WORK.TEMPORAL;
MERGE 	ORIGINA.DEMOGRAFICOS 	(IN=D)
		ORIGINA.SOLICITUD 		(IN=S);
		INGRESO_TOTAL = INGRESO_FIJO + INGRESO_VARIABLE;
		EDAD = INTCK('YEAR',FECHA_NACIMIENTO,FECHA_SOLICITUD);
		IF INGRESO_TOTAL >= 0     AND INGRESO_TOTAL < 1000  THEN RANGO_INGRESO="Rango 1   0      a 1,000";
		IF INGRESO_TOTAL >= 1000  AND INGRESO_TOTAL < 5000  THEN RANGO_INGRESO="Rango 2   1,000  a 5,000";
		IF INGRESO_TOTAL >= 5000  AND INGRESO_TOTAL < 10000 THEN RANGO_INGRESO="Rango 3   5,000  a 10,000";
		IF INGRESO_TOTAL >= 10000 AND INGRESO_TOTAL < 90000 THEN RANGO_INGRESO="Rango 4   10,000 a 90,000";
		IF INGRESO_TOTAL >= 90000                           THEN RANGO_INGRESO="Rango 5   90,000 a MÁS";
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

/* ---------------------------------------------------------------------------------------------------------------------------------- */

/* Tarea 1 Parte 2 inciso i) variable tipo_cr_dito */
/* Crear un reporte Rn_SQL_variable y Rn_SAS_variable donde se resuma: 
-¿Cuántos clientes hay? 
-¿Cuántos no pagaron su crédito? 
-¿Qué porcentaje de ellos no pagó su crédito? 
De las siguientes variables: 
i. tipo de crédito 					ORIGINA.DEMOGRAFICOS.TIPO_CR_DITO */

/* CODIGO SQL */
PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		COALESCEC(D.TIPO_CR_DITO, "NA") AS TIPO_CR_DITO,
			COUNT(D.CLIENTE) AS NRO_CLIENTES,
			SUM(F.BAD) AS BADS,
			SUM(F.BAD) / COUNT(D.CLIENTE) AS PORCENTAJE_BADS
FROM		ORIGINA.DEMOGRAFICOS AS D
INNER JOIN 	ORIGINA.FLAG_G_B AS F ON D.CLIENTE = F.CLIENTE
GROUP BY 1
ORDER BY PORCENTAJE_BADS DESC;
QUIT;


/* CODIGO SAS */
DATA WORK.TEMPORAL;
MERGE 	ORIGINA.DEMOGRAFICOS 	(IN=D)
		ORIGINA.FLAG_G_B 		(IN=F);
IF TIPO_CR_DITO = NULL THEN TIPO_CR_DITO = 'NA';
KEEP	CLIENTE TIPO_CR_DITO BAD;
BY		CLIENTE;
IF		F;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS TIPO_CR_DITO;
VAR CLIENTE BAD;
OUTPUT OUT = WORK.TEMPORAL(DROP=_TYPE_ _FREQ_ )
N(CLIENTE) = CLIENTES
SUM(BAD) = BADS
MEAN(BAD) = PORCENTAJE_BADS;
RUN;



/* ---------------------------------------------------------------------------------------------------------------------------------- */

/* TAREA 1 PARTE 2
Generar el código SAS y SQL de los siguientes ejercicios:
1. Crear un reporte Rn_SQL_variable y Rn_SAS_variable donde se resuma cuántos clientes hay? Cuántos no pagaron su crédito? 
Y qué porcentaje de ellos no pagó su crédito? De las siguientes variables: 
a. código postal 					ORIGINA.DEMOGRAFICOS.CP
b. municipio 						ORIGINA.DEMOGRAFICOS.MUNICIPIO
c. estado  							ORIGINA.DEMOGRAFICOS.ESTADO
d. nivel de estudios 				ORIGINA.DEMOGRAFICOS.NIVEL_ESTUDIOS
e. actividad económica 				ORIGINA.DEMOGRAFICOS.ACTIVIDAD
f. puesto solicitante 				ORIGINA.DEMOGRAFICOS.PUESTO_SOLICITANTE
g. contrato laboral 				ORIGINA.DEMOGRAFICOS.CONTRATO_LABORAL
h. sucursal 						ORIGINA.DEMOGRAFICOS.SUCURSAL						TIPO NUMERICO
i. tipo de crédito 					ORIGINA.DEMOGRAFICOS.TIPO_CR_DITO
j. Micro_cr_dito_Lugar 				ORIGINA.DEMOGRAFICOS.MICRO_CR_DITO_LUGAR
k. Micro_cr_dito_Tipo               ORIGINA.DEMOGRAFICOS.MICRO_CR_DITO_TIPO
l. Micro_cr_dito_Ubicaci_n          ORIGINA.DEMOGRAFICOS.MICRO_CR_DITO_UBICACI_N
m. meses domicilio                  ORIGINA.DEMOGRAFICOS.MESES_DOM						TIPO NUMERICO
n. meses empleo                     ORIGINA.DEMOGRAFICOS.MESES_EMP						TIPO NUMERICO
o. ocupaciÃ³n                       ORIGINA.DEMOGRAFICOS.OCUPACION
p. TipoEmpleoSolicitante            ORIGINA.DEMOGRAFICOS.TIPOEMPLEOSOLICITANTE
q. EdoCiv                           ORIGINA.DEMOGRAFICOS.EDOCIV  
r. TipoComprobanteIngresos          ORIGINA.DEMOGRAFICOS.TIPOCOMPROBANTEINGRESOS
s. TipoVivienda                     ORIGINA.DEMOGRAFICOS.TIPOVIVIENDA
t. FrecuenciaPrecepcionIngresos     ORIGINA.DEMOGRAFICOS.FRECUENCIAPRECEPCIONINGRESOS
 */


/*
Nota:
La tabla origina.flag_g_b es un subconjunto la tabla origina.aprobadas tales que estatus="A".
A cada fila de la tabla tabla origina.flag_g_b le corresponde una sola fila de la tabla origina.demograficos
*/


/* Veamos cuáles variables son de tipo "num" y cuales son tipo "char" */
PROC SQL;
    CREATE TABLE WORK.TEMPORAL as
    SELECT  name AS nombre_columna,
    		type as tipo_columna
    FROM 	dictionary.columns
    WHERE 	libname = 'ORIGINA' AND memname = 'DEMOGRAFICOS';
QUIT;

/* SQL */
/* SOLUCION PARA LA VARIABLE PUESTO_SOLICITANTE */
PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		COALESCEC(PUESTO_SOLICITANTE,"NA") AS PUESTO_SOLICITANTE,  				/* PARA COLUMNAS TIPO CHAR */
			/* COALESCE(SUCURSAL,9999) AS SUCURSAL */      							/* PARA COLUMNAS TIPO NUM  */
			COUNT(D.CLIENTE) AS CLIENTES,
			SUM(BAD) AS BADS,
			( SUM(BAD) / COUNT(D.CLIENTE) ) AS PORCENTAJE_BADS
FROM 		ORIGINA.DEMOGRAFICOS AS D
INNER JOIN 	ORIGINA.FLAG_G_B AS F ON D.CLIENTE = F.CLIENTE
GROUP BY 	1
ORDER BY 	4 DESC
;QUIT;

/* SAS */
/* SOLUCION PARA LA VARIABLE TIPO_CR_DITO */
DATA WORK.TEMPORAL;								
MERGE      ORIGINA.FLAG_G_B      (IN=F)
           ORIGINA.DEMOGRAFICOS  (IN=D);
           IF TIPO_CR_DITO = NULL THEN TIPO_CR_DITO = 'NA';			/* PARA COLUMNAS TIPO CHAR */
           /* IF SUCURSAL = .  THEN SUCURSAL = 999; */  			/* PARA COLUMNAS TIPO NUM  */
BY         CLIENTE;
IF         F;														/* INDICA QUE ES UN LEFT JOIN SOBRE TABLA F */
KEEP       TIPO_CR_DITO CLIENTE BAD;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;								/* Obtener el numero y porcentaje de bads */
CLASS      TIPO_CR_DITO;
VAR        CLIENTE BAD;
OUTPUT OUT = WORK.TEMPORAL(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = CLIENTES
SUM(BAD)   = BADS
MEAN(BAD)  = PORCENTAJE_BADS;
RUN;

PROC SORT DATA=WORK.TEMPORAL OUT=WORK.TEMPORAL;						/* Ordenar por el porcentaje de bads */
BY DESCENDING PORCENTAJE_BADS;
RUN;

/* EJEMPLO: CICLO SOBRE UNA LISTA DE VARIABLES PARA CREAR DATASETS CON NOMBRE VARIABLE */
%let nombres = A B C; 					/* Lista de nombres */
%macro procesar_nombres;							/* Declarar la macro */
    %let count = %sysfunc(countw(&nombres)); 		/* Contar el número de nombres */
    %do i = 1 %to &count; 							/* Ciclo sobre cada nombre */
        %let nombre_actual = %scan(&nombres, &i); 	/* Extrae el nombre actual */
        data WORK.dataset_&nombre_actual&i; 		/* Crea un dataset con el nombre actual en la librería work */
            nombre = "&nombre_actual";
        run;										/* Fin del paso data */
    %end;											/* Fin del ciclo */
%mend procesar_nombres;								/* Fin de la macro */
%procesar_nombres; 									/* Ejecuta la macro */


/* CODIGO SQL */
%let variables = CP MUNICIPIO ESTADO NIVEL_ESTUDIOS ACTIVIDAD PUESTO_SOLICITANTE CONTRATO_LABORAL SUCURSAL TIPO_CR_DITO MICRO_CR_DITO_LUGAR MICRO_CR_DITO_TIPO MICRO_CR_DITO_UBICACI_N MESES_DOM MESES_EMP OCUPACION TIPOEMPLEOSOLICITANTE EDOCIV TIPOCOMPROBANTEINGRESOS TIPOVIVIENDA FRECUENCIAPRECEPCIONINGRESOS;	 	
%let incisos   = a b c d e f g h i j k l m n o p q r s t;	 	
%macro procesar_variables;
    %let count = %sysfunc(countw(&variables)); 		  				/* Cuenta el número de variables */
    %do i = 1 %to &count; 							    			/* Ciclo sobre cada variable */
        %let variable_actual = %scan(&variables, &i);   			/* Extraer el nombre de la variable actual */
       	%let inciso          = %scan(&incisos,   &i);   			/* Extraer el nombre del inciso actual */
       	%let variable_truncada = %substr(&variable_actual, 1, 23); 	/* Truncar el nombre de la variable a 23 caracteres */
       	%let name_dataset = WORK.R&inciso._SQL_&variable_truncada;	/* Concatenar texto y macro variable. Se concatena la macro variable "inciso" con la cadena "_SQL_" usando el caracter "." */
			proc sql noprint;										/* Extraer el tipo de variable y guardar en tipo_columna */
			    select type
			    into :tipo_columna
			    from dictionary.columns
			    where libname = 'ORIGINA' and memname = 'DEMOGRAFICOS' and upcase(name) = "&variable_actual";
			quit;
			%put La columna &variable_actual es de tipo &tipo_columna;
																		
	        %if &tipo_columna = char %then %do;				/* Si la variable es char usar COALESCEC */
		        %put La variable es char, usar COALESCEC;
		       	PROC SQL NOPRINT;							/* PROC SQL para crear los datasets */   	
				CREATE TABLE &name_dataset AS																
				SELECT 		COALESCEC(&variable_actual,'NA') AS &variable_actual,			
							COUNT(D.CLIENTE) AS CLIENTES,												
							SUM(BAD) AS BADS,														
							( SUM(BAD) / COUNT(D.CLIENTE) ) AS PORCENTAJE_BADS						
				FROM 		ORIGINA.DEMOGRAFICOS AS D													
				INNER JOIN 	ORIGINA.APROBADAS AS A ON D.CLIENTE = A.CLIENTE								
				INNER JOIN 	ORIGINA.FLAG_G_B AS F ON D.CLIENTE = F.CLIENTE								
				INNER JOIN 	ORIGINA.SOLICITUD AS S ON D.CLIENTE = S.CLIENTE								
				WHERE 		A.ESTATUS="A"																
				GROUP BY 	1																				
				ORDER BY 	4 DESC;																			
				QUIT;	
			%end;
		    %else %if &tipo_columna = num %then %do;		/* Si la variable es num usar COALESCE */
		        %put La variable es num, usar COALESCE;
		        PROC SQL NOPRINT;						  	/* PROC SQL para crear los datasets */   	
				CREATE TABLE &name_dataset AS																
				SELECT 		COALESCE(&variable_actual,9999) AS &variable_actual,			
							COUNT(D.CLIENTE) AS CLIENTES,												
							SUM(BAD) AS BADS,														
							( SUM(BAD) / COUNT(D.CLIENTE) ) AS PORCENTAJE_BADS						
				FROM 		ORIGINA.DEMOGRAFICOS AS D													
				INNER JOIN 	ORIGINA.APROBADAS AS A ON D.CLIENTE = A.CLIENTE								
				INNER JOIN 	ORIGINA.FLAG_G_B AS F ON D.CLIENTE = F.CLIENTE								
				INNER JOIN 	ORIGINA.SOLICITUD AS S ON D.CLIENTE = S.CLIENTE								
				WHERE 		A.ESTATUS="A"																
				GROUP BY 	1																				
				ORDER BY 	4 DESC;																			
				QUIT;
		    %end;																
    %end;													/* Fin del loop */
%mend procesar_variables;									/* Fin de la macro */
%procesar_variables; 										/* Ejecución de la macro */



/* CODIGO SAS */
%let variables = CP MUNICIPIO ESTADO NIVEL_ESTUDIOS ACTIVIDAD PUESTO_SOLICITANTE CONTRATO_LABORAL SUCURSAL TIPO_CR_DITO MICRO_CR_DITO_LUGAR MICRO_CR_DITO_TIPO MICRO_CR_DITO_UBICACI_N MESES_DOM MESES_EMP OCUPACION TIPOEMPLEOSOLICITANTE EDOCIV TIPOCOMPROBANTEINGRESOS TIPOVIVIENDA FRECUENCIAPRECEPCIONINGRESOS;	 	
%let incisos   = a b c d e f g h i j k l m n o p q r s t;	 	
%macro procesar_variables;
    %let count = %sysfunc(countw(&variables)); 		  				/* Cuenta el número de variables */
    %do i = 1 %to &count; 							    			/* Ciclo sobre cada variable */
        %let variable_actual = %scan(&variables, &i);   			/* Extraer el nombre de la variable actual */
       	%let inciso          = %scan(&incisos,   &i);   			/* Extraer el nombre del inciso actual */
       	%let variable_truncada = %substr(&variable_actual, 1, 23); 	/* Truncar el nombre de la variable a 23 caracteres */
       	%let name_dataset = WORK.R&inciso._SAS_&variable_truncada;	/* Concatenar texto y macro variable. Se concatena la macro variable "inciso" con la cadena "_SQL_" usando el caracter "." */
			proc sql noprint;										/* Extraer el tipo de variable y guardar en tipo_columna */
			    select type
			    into :tipo_columna
			    from dictionary.columns
			    where libname = 'ORIGINA' and memname = 'DEMOGRAFICOS' and upcase(name) = "&variable_actual";
			quit;
			%put La columna &variable_actual es de tipo &tipo_columna;
																		
	        %if &tipo_columna = char %then %do;														/* Si la variable es char usar COALESCEC */
		        %put La variable es char, usar COALESCEC;
						DATA WORK.TEMPORAL;								
						MERGE      ORIGINA.FLAG_G_B      (IN=F)
						           ORIGINA.DEMOGRAFICOS  (IN=D);
						           IF &variable_actual = NULL THEN &variable_actual = 'NA';			/* PARA COLUMNAS TIPO CHAR */
						           /* IF SUCURSAL = .  THEN SUCURSAL = 999; */  					/* PARA COLUMNAS TIPO NUM  */
						BY         CLIENTE;
						IF         F;																/* INDICA QUE ES UN LEFT JOIN SOBRE TABLA F */
						KEEP       &variable_actual CLIENTE BAD;
						RUN;
						
						PROC SUMMARY DATA=WORK.TEMPORAL NWAY;										/* Obtener el numero y porcentaje de bads */
						CLASS      &variable_actual;
						VAR        CLIENTE BAD;
						OUTPUT OUT = WORK.TEMPORAL(DROP=_TYPE_ _FREQ_)
						N(CLIENTE) = CLIENTES
						SUM(BAD)   = BADS
						MEAN(BAD)  = PORCENTAJE_BADS;
						RUN;
						
						PROC SORT DATA=WORK.TEMPORAL OUT=&name_dataset;								/* Ordenar por el porcentaje de bads */
						BY DESCENDING PORCENTAJE_BADS;
						RUN;
			%end;
		    %else %if &tipo_columna = num %then %do;												/* Si la variable es num usar COALESCE */
		        %put La variable es num, usar COALESCE;
						DATA WORK.TEMPORAL;								
						MERGE      ORIGINA.FLAG_G_B      (IN=F)
						           ORIGINA.DEMOGRAFICOS  (IN=D);
						           /* IF &variable_actual = NULL THEN &variable_actual = 'NA';*/	/* PARA COLUMNAS TIPO CHAR */
						           IF &variable_actual = .  THEN &variable_actual = -999;  			/* PARA COLUMNAS TIPO NUM  */
						BY         CLIENTE;
						IF         F;																/* INDICA QUE ES UN LEFT JOIN SOBRE TABLA F */
						KEEP       &variable_actual CLIENTE BAD;
						RUN;
						
						PROC SUMMARY DATA=WORK.TEMPORAL NWAY;										/* Obtener el numero y porcentaje de bads */
						CLASS      &variable_actual;
						VAR        CLIENTE BAD;
						OUTPUT OUT = WORK.TEMPORAL(DROP=_TYPE_ _FREQ_)
						N(CLIENTE) = CLIENTES
						SUM(BAD)   = BADS
						MEAN(BAD)  = PORCENTAJE_BADS;
						RUN;
						
						PROC SORT DATA=WORK.TEMPORAL OUT=&name_dataset;								/* Ordenar por el porcentaje de bads */
						BY DESCENDING PORCENTAJE_BADS;
						RUN;
		    %end;																
    %end;													/* Fin del loop */
%mend procesar_variables;									/* Fin de la macro */
%procesar_variables; 	



/* --------------------------------------------------------------------------------------------- */

/* TAREA 3 BASES DE DATOS */
/* Crear un reporte Rn_SQL_variable y Rn_SAS_Variable por cada uno de los siguientes incisos usando código SQL y código SAS que 
resuma por cada “veintil” de rango de la variable:  
1. Cuantos clientes hay  
2. Cuántos no pagaron 
3. Cuál es el porcentaje de clientes que no pagaron
Incisos:
a) Monto Solicitado   						ORIGINA.SOLICITUD.MONTO_SOLICITADO
b) BC Score 								ORIGINA.BURO.BC_SCORE
c) Ingreso Total 							ORIGINA.DEMOGRAFICOS.INGRESO_FIJO + ORIGINA.DEMOGRAFICOS.INGRESO_VARIABLE
d) Edad 									ORIGINA.DEMOGRAFICOS.FECHA_NACIMIENTO y ORIGINA.SOLICITUD.FECHA_SOLICITUD				
e) Antigüedad en Meses Domicilio 			ORIGINA.DEMOGRAFICOS.ANOS_DOM Y ORIGINA.DEMOGRAFICOS.MESES_DOM
f) Antigüedad en Meses en el Empleo			ORIGINA.DEMOGRAFICOS.ANOS_EMP y ORIGINA.DEMOGRAFICOS.MESES_EMP

Nota: Veintil, el rango deberá garantizar tener el 5% de las observaciones, de tal forma que se generen 20 rangos de 5% de 
población que en total de el 100% de la población   
Nota2: Consideren respaldar sus códigos ya que se reciclaran los códigos par el siguiente tema del curso : ANALISIS UNIVARIADO  
*/

/* CODIGO SQL */
/* INCISO A) MONTO_SOLICITADO */

PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		S.CLIENTE,
			MONTO_SOLICITADO as MONTO_SOLICITADO_ORIGINAL,
			CASE 
				WHEN	MONTO_SOLICITADO IS NULL THEN .
				ELSE 	MONTO_SOLICITADO
			END AS MONTO_SOLICITADO,
			F.BAD
FROM		ORIGINA.SOLICITUD 		AS S
INNER JOIN	ORIGINA.FLAG_G_B 		AS F ON F.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.DEMOGRAFICOS 	AS D ON D.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.BURO 			AS B ON B.CLIENTE=S.CLIENTE;
QUIT;

PROC UNIVARIATE DATA=WORK.TEMPORAL NOPRINT;			/* Generar rangos con al menos el 5% de la población cada uno de ellos */
VAR MONTO_SOLICITADO;
OUTPUT OUT=WORK.RANGOS PCTLPRE=P_ PCTLPTS=0 TO 100 BY 5;		
RUN;

PROC SQL;
CREATE TABLE WORK.RA_SQL_MONTO_SOLICITADO AS 
SELECT 	RANGO_MONTO_SOLICITADO,
		COUNT(CLIENTE) AS CLIENTES,
		SUM(BAD) AS BADS,
		AVG(BAD) AS PORCENTAJE_BADS
FROM
(   	/**************************************** Z ****************************************/
	SELECT 	CLIENTE,
			BAD,
			MONTO_SOLICITADO,
			CASE 
			WHEN MONTO_SOLICITADO >= 1500  AND MONTO_SOLICITADO < 3000  THEN '00 1500 - 3000'
			WHEN MONTO_SOLICITADO >= 3000  AND MONTO_SOLICITADO < 5000  THEN '01 3000 - 5000'
			WHEN MONTO_SOLICITADO >= 5000  AND MONTO_SOLICITADO < 6000  THEN '02 5000 - 6000'
			WHEN MONTO_SOLICITADO >= 6000  AND MONTO_SOLICITADO < 7000  THEN '03 6000 - 7000'
			WHEN MONTO_SOLICITADO >= 7000  AND MONTO_SOLICITADO < 8000  THEN '04 7000 - 8000'
			WHEN MONTO_SOLICITADO >= 8000  AND MONTO_SOLICITADO < 9000  THEN '05 8000 - 9000'
			WHEN MONTO_SOLICITADO >= 9000  AND MONTO_SOLICITADO < 10000 THEN '06 9000 - 10000'
			WHEN MONTO_SOLICITADO >= 10000 AND MONTO_SOLICITADO < 15000 THEN '07 10000 - 15000'
			WHEN MONTO_SOLICITADO >= 15000 AND MONTO_SOLICITADO < 20000 THEN '08 15000 - 20000'
			WHEN MONTO_SOLICITADO >= 20000 								THEN '09 20000 - MAS'
			END AS RANGO_MONTO_SOLICITADO
		FROM	WORK.TEMPORAL
) AS Z	/**************************************** Z ****************************************/
GROUP BY 1
ORDER BY 1
;QUIT;


/* CODIGO SQL */
/* INCISO B) BC_SCORE */

PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		S.CLIENTE,
			BC_SCORE AS BC_SCORE_ORIGINAL,
			CASE 
				WHEN	BC_SCORE <= 0 	 THEN .
				WHEN 	BC_SCORE IS NULL THEN .
				ELSE 	BC_SCORE
			END AS BC_SCORE,
			BAD
FROM		ORIGINA.SOLICITUD 		AS S
INNER JOIN	ORIGINA.FLAG_G_B 		AS F ON F.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.DEMOGRAFICOS 	AS D ON D.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.BURO 			AS B ON B.CLIENTE=S.CLIENTE;
QUIT;

PROC UNIVARIATE DATA=WORK.TEMPORAL NOPRINT;			/* Generar rangos con al menos el 5% de la población cada uno de ellos */
VAR BC_SCORE;
OUTPUT OUT=WORK.RANGOS PCTLPRE=P_ PCTLPTS=0 TO 100 BY 5;		
RUN;

PROC SQL;
CREATE TABLE WORK.RB_SQL_BC_SCORE AS
SELECT 	RANGO_BC_SCORE,
		COUNT(CLIENTE) AS CLIENTES,
		SUM(BAD) AS BADS,
		AVG(BAD) AS PORCENTAJE_BADS
FROM
( 	/**************************************** Z ****************************************/
SELECT 		CLIENTE,
			BAD,
			BC_SCORE,
			CASE 
				WHEN BC_SCORE >= 589  AND BC_SCORE < 633  THEN '01 589 - 633'
				WHEN BC_SCORE >= 633  AND BC_SCORE < 647  THEN '02 633 - 647'
				WHEN BC_SCORE >= 647  AND BC_SCORE < 657  THEN '03 647 - 657'
				WHEN BC_SCORE >= 657  AND BC_SCORE < 665  THEN '04 657 - 665'
				WHEN BC_SCORE >= 665  AND BC_SCORE < 673  THEN '05 665 - 673'
				WHEN BC_SCORE >= 673  AND BC_SCORE < 679  THEN '06 673 - 679'
				WHEN BC_SCORE >= 679  AND BC_SCORE < 685  THEN '07 679 - 685'
				WHEN BC_SCORE >= 685  AND BC_SCORE < 689  THEN '08 685 - 689'
				WHEN BC_SCORE >= 689  AND BC_SCORE < 694  THEN '09 689 - 694'
				WHEN BC_SCORE >= 694  AND BC_SCORE < 697  THEN '10 694 - 697'
				WHEN BC_SCORE >= 697  AND BC_SCORE < 701  THEN '11 697 - 701'
				WHEN BC_SCORE >= 701  AND BC_SCORE < 705  THEN '12 701 - 705'
				WHEN BC_SCORE >= 705  AND BC_SCORE < 710  THEN '13 705 - 710'
				WHEN BC_SCORE >= 710  AND BC_SCORE < 714  THEN '14 710 - 714'
				WHEN BC_SCORE >= 714  AND BC_SCORE < 718  THEN '15 714 - 718'
				WHEN BC_SCORE >= 718  AND BC_SCORE < 723  THEN '16 718 - 723'
				WHEN BC_SCORE >= 723  AND BC_SCORE < 729  THEN '17 723 - 729'
				WHEN BC_SCORE >= 729  AND BC_SCORE < 739  THEN '18 729 - 739'
				WHEN BC_SCORE >= 739  AND BC_SCORE < 748  THEN '19 739 - 748'
				WHEN BC_SCORE >= 748                        THEN '20 748 - MAS'
			END AS RANGO_BC_SCORE
		FROM	WORK.TEMPORAL
) AS Z	/**************************************** Z ****************************************/
GROUP BY 1
ORDER BY 1
;QUIT;


/* CODIGO SQL */
/* INCISO C) INGRESO_TOTAL */

PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		S.CLIENTE,
			INGRESO_FIJO + INGRESO_VARIABLE AS INGRESO_TOTAL_ORIGINAL,
			CASE 
				WHEN	INGRESO_FIJO 	 IS NULL 	   THEN .
				WHEN 	INGRESO_VARIABLE IS NULL       THEN .
				ELSE 	INGRESO_FIJO + INGRESO_VARIABLE
			END AS INGRESO_TOTAL,
			BAD
FROM		ORIGINA.SOLICITUD 		AS S
INNER JOIN	ORIGINA.FLAG_G_B 		AS F ON F.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.DEMOGRAFICOS 	AS D ON D.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.BURO 			AS B ON B.CLIENTE=S.CLIENTE;
QUIT;

PROC UNIVARIATE DATA=WORK.TEMPORAL NOPRINT;			/* Generar rangos con al menos el 5% de la población cada uno de ellos */
VAR INGRESO_TOTAL;
OUTPUT OUT=WORK.RANGOS PCTLPRE=P_ PCTLPTS=0 TO 100 BY 5;		
RUN;

PROC SQL;
CREATE TABLE WORK.RC_SQL_INGRESO_TOTAL AS
SELECT 	RANGO_INGRESO_TOTAL,
		COUNT(CLIENTE) AS CLIENTES,
		SUM(BAD) AS BADS,
		AVG(BAD) AS PORCENTAJE_BADS
FROM
( 	/**************************************** Z ****************************************/
SELECT 		CLIENTE,
			BAD,
			INGRESO_TOTAL,
			CASE 
				WHEN INGRESO_TOTAL >= 1959.05  AND INGRESO_TOTAL <3372    	THEN '01 1959.05 - 3372 ' 
				WHEN INGRESO_TOTAL >= 3372     AND INGRESO_TOTAL <3990    	THEN '02 3372 - 3990 ' 
				WHEN INGRESO_TOTAL >= 3990     AND INGRESO_TOTAL <4286    	THEN '03 3990 - 4286 ' 
				WHEN INGRESO_TOTAL >= 4286     AND INGRESO_TOTAL <4619.02 	THEN '04 4286 - 4619.02 ' 
				WHEN INGRESO_TOTAL >= 4619.02  AND INGRESO_TOTAL <5000    	THEN '05 4619.02 - 5000 ' 
				WHEN INGRESO_TOTAL >= 5000     AND INGRESO_TOTAL <5196    	THEN '06 5000 - 5196 ' 
				WHEN INGRESO_TOTAL >= 5196     AND INGRESO_TOTAL <5520    	THEN '07 5196 - 5520 ' 
				WHEN INGRESO_TOTAL >= 5520     AND INGRESO_TOTAL <6000    	THEN '08 5520 - 6000 ' 
				WHEN INGRESO_TOTAL >= 6000     AND INGRESO_TOTAL <6062    	THEN '09 6000 - 6062 ' 
				WHEN INGRESO_TOTAL >= 6062     AND INGRESO_TOTAL <6500  	THEN '10 6062 - 6500 ' 
				WHEN INGRESO_TOTAL >= 6500     AND INGRESO_TOTAL <6990  	THEN '11 6500 - 6990 ' 
				WHEN INGRESO_TOTAL >= 6990     AND INGRESO_TOTAL <7342.78 	THEN '12 6990 - 7342.78 ' 
				WHEN INGRESO_TOTAL >= 7342.78  AND INGRESO_TOTAL <7936.88 	THEN '13 7342.78 - 7936.88 ' 
				WHEN INGRESO_TOTAL >= 7936.88  AND INGRESO_TOTAL <8027  	THEN '14 7936.88 - 8027 ' 
				WHEN INGRESO_TOTAL >= 8027     AND INGRESO_TOTAL <8713.8  	THEN '15 8027 - 8713.8 ' 
				WHEN INGRESO_TOTAL >= 8713.8   AND INGRESO_TOTAL <9376.33 	THEN '16 8713.8 - 9376.33 ' 
				WHEN INGRESO_TOTAL >= 9376.33  AND INGRESO_TOTAL <10624  	THEN '17 9376.33 - 10624 ' 
				WHEN INGRESO_TOTAL >= 10624    AND INGRESO_TOTAL <13000  	THEN '18 10624 - 13000 ' 
				WHEN INGRESO_TOTAL >= 13000    AND INGRESO_TOTAL <18495  	THEN '19 13000 - 18495 ' 
				WHEN INGRESO_TOTAL >= 18495                        			THEN '20 18495 - MAS ' 
			END AS RANGO_INGRESO_TOTAL
		FROM	WORK.TEMPORAL
) AS Z	/**************************************** Z ****************************************/
GROUP BY 1
ORDER BY 1
;QUIT;



/* CODIGO SQL */
/* INCISO D) EDAD */

PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		S.CLIENTE,
			INTCK('YEAR',FECHA_NACIMIENTO,S.FECHA_SOLICITUD) AS EDAD_ORIGINAL,
			CASE 
				WHEN	INTCK('YEAR',FECHA_NACIMIENTO,S.FECHA_SOLICITUD) 	 IS NULL 	   THEN .
				ELSE 	INTCK('YEAR',FECHA_NACIMIENTO,S.FECHA_SOLICITUD)
			END AS EDAD,
			BAD
FROM		ORIGINA.SOLICITUD 		AS S
INNER JOIN	ORIGINA.FLAG_G_B 		AS F ON F.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.DEMOGRAFICOS 	AS D ON D.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.BURO 			AS B ON B.CLIENTE=S.CLIENTE;
QUIT;

PROC UNIVARIATE DATA=WORK.TEMPORAL NOPRINT;			/* Generar rangos con al menos el 5% de la población cada uno de ellos */
VAR EDAD;
OUTPUT OUT=WORK.RANGOS PCTLPRE=P_ PCTLPTS=0 TO 100 BY 5;		
RUN;

PROC SQL;
CREATE TABLE WORK.RD_SQL_EDAD AS
SELECT 	RANGO_EDAD,
		COUNT(CLIENTE) AS CLIENTES,
		SUM(BAD) AS BADS,
		AVG(BAD) AS PORCENTAJE_BADS
FROM
( 	/**************************************** Z ****************************************/
SELECT 		CLIENTE,
			BAD,
			EDAD,
			CASE 
				WHEN EDAD >= 18  AND EDAD <21  	THEN '01 18 - 21 ' 
				WHEN EDAD >= 21  AND EDAD <23  	THEN '02 21 - 23 ' 
				WHEN EDAD >= 23  AND EDAD <25  	THEN '03 23 - 25 ' 
				WHEN EDAD >= 25  AND EDAD <26  	THEN '04 25 - 26 ' 
				WHEN EDAD >= 26  AND EDAD <28  	THEN '05 26 - 28 ' 
				WHEN EDAD >= 28  AND EDAD <30  	THEN '06 28 - 30 ' 
				WHEN EDAD >= 30  AND EDAD <31  	THEN '07 30 - 31 ' 
				WHEN EDAD >= 31  AND EDAD <33  	THEN '08 31 - 33 ' 
				WHEN EDAD >= 33  AND EDAD <35  	THEN '09 33 - 35 ' 
				WHEN EDAD >= 35  AND EDAD <37  	THEN '10 35 - 37 ' 
				WHEN EDAD >= 37  AND EDAD <39  	THEN '11 37 - 39 ' 
				WHEN EDAD >= 39  AND EDAD <41  	THEN '12 39 - 41 ' 
				WHEN EDAD >= 41  AND EDAD <42  	THEN '13 41 - 42 ' 
				WHEN EDAD >= 42  AND EDAD <45  	THEN '14 42 - 45 ' 
				WHEN EDAD >= 45  AND EDAD <47  	THEN '15 45 - 47 ' 
				WHEN EDAD >= 47  AND EDAD <49  	THEN '16 47 - 49 ' 
				WHEN EDAD >= 49  AND EDAD <52  	THEN '17 49 - 52 ' 
				WHEN EDAD >= 52  AND EDAD <55  	THEN '18 52 - 55 ' 
				WHEN EDAD >= 55  AND EDAD <60  	THEN '19 55 - 60 ' 
				WHEN EDAD >= 60    				THEN '20 60 - MAS ' 
			END AS RANGO_EDAD
		FROM	WORK.TEMPORAL
) AS Z	/**************************************** Z ****************************************/
GROUP BY 1
ORDER BY 1
;QUIT;


/* CODIGO SQL */
/* INCISO E) ANTIGUEDAD_DOMICILIO */

PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		S.CLIENTE,
			ANOS_DOM + MESES_DOM AS ANTIGUEDAD_DOMICILIO_ORIGINAL,
			CASE 
				WHEN	ANOS_DOM + MESES_DOM 	 IS NULL 	   THEN .
				ELSE 	ANOS_DOM + MESES_DOM
			END AS ANTIGUEDAD_DOMICILIO,
			BAD
FROM		ORIGINA.SOLICITUD 		AS S
INNER JOIN	ORIGINA.FLAG_G_B 		AS F ON F.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.DEMOGRAFICOS 	AS D ON D.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.BURO 			AS B ON B.CLIENTE=S.CLIENTE;
QUIT;

PROC UNIVARIATE DATA=WORK.TEMPORAL NOPRINT;			/* Generar rangos con al menos el 5% de la población cada uno de ellos */
VAR ANTIGUEDAD_DOMICILIO;
OUTPUT OUT=WORK.RANGOS PCTLPRE=P_ PCTLPTS=0 TO 100 BY 5;		
RUN;

PROC SQL;
CREATE TABLE WORK.RE_SQL_ANTIGUEDAD_DOMICILIO AS
SELECT 	RANGO_ANTIGUEDAD_DOMICILIO,
		COUNT(CLIENTE) AS CLIENTES,
		SUM(BAD) AS BADS,
		AVG(BAD) AS PORCENTAJE_BADS
FROM
( 	/**************************************** Z ****************************************/
SELECT 		CLIENTE,
			BAD,
			ANTIGUEDAD_DOMICILIO,
			CASE 
				WHEN ANTIGUEDAD_DOMICILIO >= 0  AND ANTIGUEDAD_DOMICILIO <5  THEN '01 0 - 5 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 5  AND ANTIGUEDAD_DOMICILIO <6  THEN '02 5 - 6 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 6  AND ANTIGUEDAD_DOMICILIO <8  THEN '03 6 - 8 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 8  AND ANTIGUEDAD_DOMICILIO <10  THEN '04 8 - 10 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 10  AND ANTIGUEDAD_DOMICILIO <11  THEN '05 10 - 11 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 11  AND ANTIGUEDAD_DOMICILIO <14  THEN '06 11 - 14 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 14  AND ANTIGUEDAD_DOMICILIO <15  THEN '07 14 - 15 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 15  AND ANTIGUEDAD_DOMICILIO <18  THEN '08 15 - 18 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 18  AND ANTIGUEDAD_DOMICILIO <20  THEN '09 18 - 20 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 20  AND ANTIGUEDAD_DOMICILIO <22  THEN '10 20 - 22 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 22  AND ANTIGUEDAD_DOMICILIO <23  THEN '11 22 - 23 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 23  AND ANTIGUEDAD_DOMICILIO <25  THEN '12 23 - 25 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 25  AND ANTIGUEDAD_DOMICILIO <26  THEN '13 25 - 26 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 26  AND ANTIGUEDAD_DOMICILIO <29  THEN '14 26 - 29 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 29  AND ANTIGUEDAD_DOMICILIO <30  THEN '15 29 - 30 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 30  AND ANTIGUEDAD_DOMICILIO <33  THEN '16 30 - 33 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 33  AND ANTIGUEDAD_DOMICILIO <36  THEN '17 33 - 36 ' 
				WHEN ANTIGUEDAD_DOMICILIO >= 36                                 THEN '18 36 - MAS ' 
			END AS RANGO_ANTIGUEDAD_DOMICILIO
		FROM	WORK.TEMPORAL
) AS Z	/**************************************** Z ****************************************/
GROUP BY 1
ORDER BY 1
;QUIT;



/* CODIGO SQL */
/* INCISO F) ANTIGUEDAD_EMPLEO */

PROC SQL;
CREATE TABLE WORK.TEMPORAL AS
SELECT 		S.CLIENTE,
			ANOS_EMP,
			MESES_EMP,
			ANOS_EMP + MESES_EMP AS ANTIGUEDAD_EMPLEO_ORIGINAL,
			CASE 
				WHEN	ANOS_EMP + MESES_EMP 	 IS NULL 	   THEN .
				ELSE 	ANOS_EMP + MESES_EMP
			END AS ANTIGUEDAD_EMPLEO,
			BAD
FROM		ORIGINA.SOLICITUD 		AS S
INNER JOIN	ORIGINA.FLAG_G_B 		AS F ON F.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.DEMOGRAFICOS 	AS D ON D.CLIENTE=S.CLIENTE
INNER JOIN  ORIGINA.BURO 			AS B ON B.CLIENTE=S.CLIENTE;
QUIT;

PROC UNIVARIATE DATA=WORK.TEMPORAL NOPRINT;			/* Generar rangos con al menos el 5% de la población cada uno de ellos */
VAR ANTIGUEDAD_EMPLEO;
OUTPUT OUT=WORK.RANGOS PCTLPRE=P_ PCTLPTS=0 TO 100 BY 5;		
RUN;

PROC SQL;
CREATE TABLE WORK.RF_ANTIGUEDAD_EMPLEO AS
SELECT 	RANGO_ANTIGUEDAD_EMPLEO,
		COUNT(CLIENTE) AS CLIENTES,
		SUM(BAD) AS BADS,
		AVG(BAD) AS PORCENTAJE_BADS
FROM
( 	/**************************************** Z ****************************************/
SELECT 		CLIENTE,
			BAD,
			ANTIGUEDAD_EMPLEO,
			CASE 
				WHEN ANTIGUEDAD_EMPLEO >= 0  AND ANTIGUEDAD_EMPLEO <2  THEN '01 0 - 2 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 2  AND ANTIGUEDAD_EMPLEO <3  THEN '02 2 - 3 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 3  AND ANTIGUEDAD_EMPLEO <3  THEN '03 3 - 3 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 3  AND ANTIGUEDAD_EMPLEO <4  THEN '04 3 - 4 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 4  AND ANTIGUEDAD_EMPLEO <4  THEN '05 4 - 4 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 4  AND ANTIGUEDAD_EMPLEO <5  THEN '06 4 - 5 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 5  AND ANTIGUEDAD_EMPLEO <5  THEN '07 5 - 5 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 5  AND ANTIGUEDAD_EMPLEO <6  THEN '08 5 - 6 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 6  AND ANTIGUEDAD_EMPLEO <7  THEN '09 6 - 7 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 7  AND ANTIGUEDAD_EMPLEO <8  THEN '10 7 - 8 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 8  AND ANTIGUEDAD_EMPLEO <9  THEN '11 8 - 9 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 9  AND ANTIGUEDAD_EMPLEO <10  THEN '12 9 - 10 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 10  AND ANTIGUEDAD_EMPLEO <10  THEN '13 10 - 10 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 10  AND ANTIGUEDAD_EMPLEO <11  THEN '14 10 - 11 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 11  AND ANTIGUEDAD_EMPLEO <13  THEN '15 11 - 13 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 13  AND ANTIGUEDAD_EMPLEO <15  THEN '16 13 - 15 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 15  AND ANTIGUEDAD_EMPLEO <16  THEN '17 15 - 16 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 16  AND ANTIGUEDAD_EMPLEO <20  THEN '18 16 - 20 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 20  AND ANTIGUEDAD_EMPLEO <25  THEN '19 20 - 25 ' 
				WHEN ANTIGUEDAD_EMPLEO >= 25                                 THEN '20 25 - MAS ' 
			END AS RANGO_ANTIGUEDAD_EMPLEO
		FROM	WORK.TEMPORAL
) AS Z	/**************************************** Z ****************************************/
GROUP BY 1
ORDER BY 1
;QUIT;




/* CODIGO SAS */
/* INCISO A) MONTO_SOLICITADO */

DATA WORK.TEMPORAL;
MERGE 	ORIGINA.SOLICITUD 		(IN=S)
		ORIGINA.FLAG_G_B		(IN=F)
		ORIGINA.DEMOGRAFICOS 	(IN=D)
		ORIGINA.BURO 			(IN=B);
BY		CLIENTE;
IF		F;
FORMAT RANGO_MONTO_SOLICITADO $25.;
IF MONTO_SOLICITADO >= 1500 AND MONTO_SOLICITADO < 3000   THEN RANGO_MONTO_SOLICITADO='00 1500 - 3000';
IF MONTO_SOLICITADO >= 3000 AND MONTO_SOLICITADO < 5000   THEN RANGO_MONTO_SOLICITADO='01 3000 - 5000';
IF MONTO_SOLICITADO >= 5000 AND MONTO_SOLICITADO < 6000   THEN RANGO_MONTO_SOLICITADO='02 5000 - 6000';
IF MONTO_SOLICITADO >= 6000 AND MONTO_SOLICITADO < 7000   THEN RANGO_MONTO_SOLICITADO='03 6000 - 7000';
IF MONTO_SOLICITADO >= 7000 AND MONTO_SOLICITADO < 8000   THEN RANGO_MONTO_SOLICITADO='04 7000 - 8000';
IF MONTO_SOLICITADO >= 8000 AND MONTO_SOLICITADO < 9000   THEN RANGO_MONTO_SOLICITADO='05 8000 - 9000';
IF MONTO_SOLICITADO >= 9000 AND MONTO_SOLICITADO < 10000  THEN RANGO_MONTO_SOLICITADO='06 9000 - 10000';
IF MONTO_SOLICITADO >= 10000 AND MONTO_SOLICITADO < 15000 THEN RANGO_MONTO_SOLICITADO='07 10000 - 15000';
IF MONTO_SOLICITADO >= 15000 AND MONTO_SOLICITADO < 20000 THEN RANGO_MONTO_SOLICITADO='08 15000 - 20000';
IF MONTO_SOLICITADO >= 20000 								  THEN RANGO_MONTO_SOLICITADO='09 20000 - MAS';
KEEP 	CLIENTE MONTO_SOLICITADO RANGO_MONTO_SOLICITADO BAD;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS	RANGO_MONTO_SOLICITADO;
VAR		CLIENTE BAD;
OUTPUT OUT=WORK.RA_SAS_MONTO_SOLICITADO(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = CLIENTES
SUM(BAD) = BADS
MEAN(BAD) = PORCENTAJE_BADS;
RUN;


/* CODIGO SAS */
/* INCISO B) BC_SCORE */

DATA WORK.TEMPORAL;
MERGE 	ORIGINA.SOLICITUD 		(IN=S)
		ORIGINA.FLAG_G_B		(IN=F)
		ORIGINA.DEMOGRAFICOS 	(IN=D)
		ORIGINA.BURO 			(IN=B);
BY		CLIENTE;
IF		F;
IF BC_SCORE <= 0  THEN BC_SCORE_2 = .;
IF BC_SCORE >  0  THEN BC_SCORE_2 = BC_SCORE;
FORMAT RANGO_BC_SCORE $25.;
IF BC_SCORE_2 >= 589  AND BC_SCORE_2 < 633  THEN RANGO_BC_SCORE ='01 589 - 633';
IF BC_SCORE_2 >= 633  AND BC_SCORE_2 < 647  THEN RANGO_BC_SCORE ='02 633 - 647';
IF BC_SCORE_2 >= 647  AND BC_SCORE_2 < 657  THEN RANGO_BC_SCORE ='03 647 - 657';
IF BC_SCORE_2 >= 657  AND BC_SCORE_2 < 665  THEN RANGO_BC_SCORE ='04 657 - 665';
IF BC_SCORE_2 >= 665  AND BC_SCORE_2 < 673  THEN RANGO_BC_SCORE ='05 665 - 673';
IF BC_SCORE_2 >= 673  AND BC_SCORE_2 < 679  THEN RANGO_BC_SCORE ='06 673 - 679';
IF BC_SCORE_2 >= 679  AND BC_SCORE_2 < 685  THEN RANGO_BC_SCORE ='07 679 - 685';
IF BC_SCORE_2 >= 685  AND BC_SCORE_2 < 689  THEN RANGO_BC_SCORE ='08 685 - 689';
IF BC_SCORE_2 >= 689  AND BC_SCORE_2 < 694  THEN RANGO_BC_SCORE ='09 689 - 694';
IF BC_SCORE_2 >= 694  AND BC_SCORE_2 < 697  THEN RANGO_BC_SCORE ='10 694 - 697';
IF BC_SCORE_2 >= 697  AND BC_SCORE_2 < 701  THEN RANGO_BC_SCORE ='11 697 - 701';
IF BC_SCORE_2 >= 701  AND BC_SCORE_2 < 705  THEN RANGO_BC_SCORE ='12 701 - 705';
IF BC_SCORE_2 >= 705  AND BC_SCORE_2 < 710  THEN RANGO_BC_SCORE ='13 705 - 710';
IF BC_SCORE_2 >= 710  AND BC_SCORE_2 < 714  THEN RANGO_BC_SCORE ='14 710 - 714';
IF BC_SCORE_2 >= 714  AND BC_SCORE_2 < 718  THEN RANGO_BC_SCORE ='15 714 - 718';
IF BC_SCORE_2 >= 718  AND BC_SCORE_2 < 723  THEN RANGO_BC_SCORE ='16 718 - 723';
IF BC_SCORE_2 >= 723  AND BC_SCORE_2 < 729  THEN RANGO_BC_SCORE ='17 723 - 729';
IF BC_SCORE_2 >= 729  AND BC_SCORE_2 < 739  THEN RANGO_BC_SCORE ='18 729 - 739';
IF BC_SCORE_2 >= 739  AND BC_SCORE_2 < 748  THEN RANGO_BC_SCORE ='19 739 - 748';
IF BC_SCORE_2 >= 748                        THEN RANGO_BC_SCORE ='20 748 - MAS';
KEEP 	CLIENTE BC_SCORE_2 RANGO_BC_SCORE BAD;
RUN;

PROC SUMMARY DATA=WORK.TEMPORAL NWAY;
CLASS	RANGO_BC_SCORE / MISSING;
VAR		CLIENTE BAD;
OUTPUT OUT=WORK.RB_SAS_BC_SCORE(DROP=_TYPE_ _FREQ_)
N(CLIENTE) = CLIENTES
SUM(BAD) = BADS
MEAN(BAD) = PORCENTAJE_BADS;
RUN;






