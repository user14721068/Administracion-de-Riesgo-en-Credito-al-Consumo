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
Proc sql;
Create table work.r3sql as
Select d.estado,
       D.sexo,
       d.nivel_estudios,
       Count(d.cliente) as num_clientes,
       Avg(s.monto_solicitado) as monto_promedio,
       Avg(d.ingreso_fijo + d.ingreso_variable) as ingreso_tot_prom,         
       Avg(B.bc_score) as buro_prom,
       max(b.bc_score) as buro_max,
       min(b.bc_score) as buro_min
From origina.demograficos as d
Left join origina.solicitud as s on d.cliente=s.cliente
Left join origina.aprobadas as a on A.cliente=d. cliente
Left join origina.buro as b on b.cliente=d.cliente
Where b.bc_score > 650 
And d.ingreso_fijo + d.ingreso_variable > 7000
And a.estatus="A"
Group by 1,2,3;
Quit;

/* SAS */



/* --------------------------------------------------------------------------------------------- */

