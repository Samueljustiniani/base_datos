DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket DEFAULT CHARACTER SET utf8mb4;
USE dbGamarraMarket;

CREATE TABLE CLIENTE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_documento CHAR(3) NOT NULL,
    numero_documento CHAR(15) NOT NULL UNIQUE,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(90) NOT NULL,
    email VARCHAR(80),
    celular CHAR(9),
    fecha_nacimiento DATE,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE VENDEDOR (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_documento CHAR(3) NOT NULL,
    numero_documento CHAR(15) NOT NULL UNIQUE,
    nombres VARCHAR(60) NOT NULL,
    apellidos VARCHAR(90) NOT NULL,
    salario DECIMAL(8,2) NOT NULL,
    celular CHAR(9),
    email VARCHAR(80),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE PRENDA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion VARCHAR(90) NOT NULL,
    marca VARCHAR(60) NOT NULL,
    cantidad INT NOT NULL,
    talla VARCHAR(10) NOT NULL,
    precio DECIMAL(8,2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE VENTA (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    cliente_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE VENTA_DETALLE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cantidad INT NOT NULL,
    venta_id INT NOT NULL,
    prenda_id INT NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES VENTA(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (prenda_id) REFERENCES PRENDA(id) ON DELETE CASCADE ON UPDATE CASCADE
);


ALTER TABLE VENTA
ADD CONSTRAINT fk_cliente_venta
FOREIGN KEY (cliente_id) REFERENCES CLIENTE(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE VENTA
ADD CONSTRAINT fk_vendedor_venta
FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE VENTA_DETALLE
ADD CONSTRAINT fk_venta_venta_detalle
FOREIGN KEY (venta_id) REFERENCES VENTA(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE VENTA_DETALLE
ADD CONSTRAINT fk_prenda_venta_detalle
FOREIGN KEY (prenda_id) REFERENCES PRENDA(id) ON DELETE CASCADE ON UPDATE CASCADE;


SELECT 
    kcu.CONSTRAINT_NAME AS 'Nombre de Relación',
    kcu.REFERENCED_TABLE_NAME AS 'Tabla Padre',
    kcu.REFERENCED_COLUMN_NAME AS 'Primary Key',
    kcu.TABLE_NAME AS 'Tabla Hija',
    kcu.COLUMN_NAME AS 'Foreign Key'
FROM 
    information_schema.KEY_COLUMN_USAGE AS kcu
WHERE 
    kcu.TABLE_SCHEMA = 'dbGamarraMarket' 
    AND kcu.REFERENCED_TABLE_NAME IS NOT NULL;
    
SHOW TABLES;

DESCRIBE CLIENTE;
DESCRIBE VENDEDOR;
DESCRIBE PRENDA;
DESCRIBE VENTA;

-- Datos en la tabla CLIENTE --
INSERT INTO CLIENTE 
	(tipo_documento, numero_documento, nombres, apellidos, email, celular, fecha_nacimiento)
VALUES
    ("DNI", "77889955", "Alberto", "Solano Pariona", "alberto.pariona@gmail.com", "998456323", str_to_date("10/02/1970", "%d/%m/%Y")),
    ("DNI", "45781233", "Alicia", "García Campos", "", "", str_to_date("20/03/1980", "%d/%m/%Y")),
    ("CNE", "315487922", "Juana", "Avila Chumpitaz", "juana.avila@gmail.com", "923568741", str_to_date("06/06/1986", "%d/%m/%Y")),
    ("CNE", "122116633", "Ana", "Enriquez Flores", "ana.enriquez@empresa.com", "", str_to_date("10/02/1970", "%d/%m/%Y")),
    ("CNE", "088741589", "Claudia", "Perales Ortiz", "claudia.perales@yahoo.com", "997845263", str_to_date("25/07/1981", "%d/%m/%Y")),
    ("DNI", "45122587", "Mario", "Barrios Martinez", "mario.barrios@outlook.com", "986525871", str_to_date("10/10/1987", "%d/%m/%Y")),
    ("CNE", "175258564", "Brunela", "Tarazona Guerra", "brunela.tarazona@gmail.com", "995236741", str_to_date("06/06/1990", "%d/%m/%Y")),
    ("DNI", "47142536", "Alejandro", "Jimenes Huapaya", "", "941525365", str_to_date("01/06/1989", "%d/%m/%Y")),
    ("DNI", "15352585", "Claudia", "Marquez Litano", "claudia.marquez@gmail.com", "985814723", str_to_date("01/10/1991", "%d/%m/%Y")),
    ("CNE", "465772587", "Mario", "Rodriguez Mayo", "mario.rodriguez@outlook.com", "912662587", str_to_date("10/11/1987", "%d/%m/%Y")),
    ("CNE", "837952514", "Luisa", "Guerra Ibarra", "luisa.guerra@yahoo.com", "974422136", str_to_date("21/12/1988", "%d/%m/%Y")),
    ("DNI", "74142585", "Pedro Alberto", "Candela Valenzuela", "pedro.candela@gmail.com", "94148525", str_to_date("30/06/1995", "%d/%m/%Y")),
    ("DNI", "53298147", "Angel Manuel", "Rojas Avila", "angel.rojas@outlook.com", "", str_to_date("02/03/1975", "%d/%m/%Y")),
    ("DNI", "11453265", "Hilario Fabiano", "Avila Huapaya", "", "985514326", str_to_date("02/05/2000", "%d/%m/%Y")),
    ("CNE", "757472186", "Octavio", "Marquez Osorio", "octavio.marquez@yahoo.es", "966223141", str_to_date("22/09/2000", "%d/%m/%Y")),
    ("CNE", "558693219", "Manolo", "Vasquez Saravia", "manolo.vasquez@outlook.es", "966223141", str_to_date("22/09/2000", "%d/%m/%Y")),
    ("DNI", "41552567", "Genoveva Pilar", "Ortiz Quispe", "genoveva.ortiz@outlook.es", "92564137", str_to_date("12/04/2003", "%d/%m/%Y")),
    ("DNI", "49985471", "Oscar César", "Quiroz Zavala", "", "988223145", str_to_date("12/10/2004", "%d/%m/%Y")),
    ("DNI", "44992217", "Verónica", "Romero Vargas", "veronica.romero@yahoo.com", "", str_to_date("25/08/2002", "%d/%m/%Y")),
    ("DNI", "00253641", "Eliseo", "Prada Ortiz", "elseo.prada@yahoo.com", "", str_to_date("15/09/2004", "%d/%m/%Y"));
SELECT * FROM CLIENTE;

/*DATOS DE TABLA VENDEDOR*/
INSERT INTO VENDEDOR
	(tipo_documento, numero_documento, nombres, apellidos, salario, celular, email)
VALUES
	("DNI", "85471236", "Enrique", "Pérez Manco", "1500.00", "96521873", "enrique.perez@outlook.com"),
    ("DNI", "47259136", "Sofía", "Ávila Solis", "1350.00", "", ""),
    ("DNI", "61542280", "Marcela", "Napaico Cama", "1600.00", "965874357", "marcela.napaico@gmail.com"),
    ("CNE", "742536140", "Carmelo", "Rodríguez Chauca", "1550.00", "", "carmelo.rodriguez@yahoo.com");

SELECT * FROM VENDEDOR;

/*DATOS DE TABLA PRENDA*/
INSERT INTO PRENDA
	(descripcion, marca, cantidad, talla, precio)
VALUES
	("Pantalon Jeans","Levis", 60, 28, 65.80),
	("Camisa manga corta","Adams", 75, 16, 55.00),
	("Polo sport","Australia", 100, 16, 40.00),
	("Camisa manga larga","Newport", 150, 16, 42.50),
	("Pijama para caballero","Adams", 180, 28, 79.50),
	("Corbata","Maxwell", 85, 16, 14.50),
	("Pijama para dama","Adams", 170, 24, 55.50),
	("Pantalon Jeans","Australia", 200, 28, 68.50),
	("Camisa Sport","John Holden", 85, 16, 88.50),
	("Short Jeans","Pepe Jeans", 185, 28, 77.20);
SELECT * FROM PRENDA;

/*DATOS DE TABLA VENTA*/
INSERT INTO VENTA
	(fecha_hora, cliente_id, vendedor_id)
VALUES
	(now(), 4, 1),
	(now(), 6, 3),
	(now(), 10, 1),
	(now(), 18, 4);
SELECT * FROM VENTA;

/*DATOS DE TABLA VENTA-DETALLE*/
INSERT INTO VENTA_DETALLE
	(venta_id, prenda_id, cantidad)
VALUES
	(1, 6, 3),
	(1, 3, 5),
	(1, 2, 7),
	(2, 2, 3),
	(3, 7, 4),
	(3, 10, 6),
	(3, 2, 6),
	(3, 5, 7),
	(4, 2, 4),
	(4, 5, 3);
SELECT * FROM VENTA_DETALLE;

/* Actualizar el número de celular de Mario Mayo por el número 922881101 */
UPDATE CLIENTE
SET celular = '922881101' WHERE id = 10;

/* El cliente con DNI 53298147 ya cuenta con número de celular es: 977226604*/
UPDATE CLIENTE
set celular = 977226604 
WHERE numero_documento = "53298147";

/*Eliminar lógicamente los clientes cuyo DNI son: 11453265, 74142585 y 49985471*/
UPDATE CLIENTE
SET activo = 0
WHERE numero_documento IN ("11453265", "74142585", "49985471");

/*Los clientes cuyos DNI son: 87952514, 55869321, 74142585 han perdido su celuLar por lo tanto tienen que estar en blanco*/
UPDATE CLIENTE
SET celular = " "
WHERE numero_documento IN ("87952514", "55869321", "74142585");

/*El cliente Oscar César Quiroz Zavala será reactivado y debemos actualizar su nuevo correo: oscar.quiroz@yahoo.es */
UPDATE CLIENTE
SET activo = 1,
	email = "oscar.quiroz@yahoo.es"
    WHERE nombres = "Oscar César" AND apellidos = "Quiroz Zavala";

SET SQL_SAFE_UPDATES = 0;

/*Agregar los datos de los siguientes clientes y vendedor */
INSERT INTO CLIENTE 
    (tipo_documento, numero_documento, nombres, apellidos, email, celular, fecha_nacimiento)
VALUES
    ("DNI", "88225463", "Gustavo Tadeo", "Quispe Solorzano", "gustavo.quispe@gmail.com","", str_to_date("13/10/2001", "%d/%m/%Y")),
    ("DNI", "15753955", "Daniela", "Solis Vargas", "daniela.solis@outlook.com", "", str_to_date("09/11/1993", "%d/%m/%Y")),
    ("DNI", "76314895", "Milton Gregorio", "Vásquez Iturriaga", "milton.gregorio@yahoo.es", "974815233", str_to_date("22/06/2004", "%d/%m/%Y")),
    ("DNI", "84725001", "Verónica", "Ancaima Araujo", "veronica.ancaima@yahoo.com", "964050167", str_to_date("25/11/1980", "%d/%m/%Y")),
    ("DNI", "11228514", "Felicita", "Marroquín Callañaupa", "felicita.marroquin@outlook.com", "966010472", str_to_date("06/06/2005", "%d/%m/%Y")),
    ("DNI", "51436952", "Luhana", "Ortiz Rodríguez", "luhana.ortiz@outlook.com", "", str_to_date("25/11/1980", "%d/%m/%Y"));

/*Actualizar el precio del polo sport de marca Australia a 45.00 */
UPDATE PRENDA
SET precio = 45.00
WHERE descripcion = "Polo sport" AND marca = "Australia";

/*Cambiar el nombre de la prenda Corbata por Corbata Michi elegante*/
UPDATE PRENDA
SET descripcion = "Corbata Michi elegante"
WHERE descripcion = "Corbata" AND marca = "Maxwell";



DELETE FROM PRENDA
WHERE descripcion IN ("Camisa manga corta", "Camisa Sport");

DELETE FROM VENDEDOR
WHERE nombres = "Marcela" AND apellidos = "Napaico Cama";

DELETE FROM CLIENTE
WHERE numero_documento IN ("47142536", "77889955");

DELETE FROM CLIENTE
WHERE YEAR(fecha_nacimiento) = 1980;

 
