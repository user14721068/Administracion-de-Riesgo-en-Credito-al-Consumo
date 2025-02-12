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








