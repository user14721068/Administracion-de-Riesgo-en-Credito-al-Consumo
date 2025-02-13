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























































