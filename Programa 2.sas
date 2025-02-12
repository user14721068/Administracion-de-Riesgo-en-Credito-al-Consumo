

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








