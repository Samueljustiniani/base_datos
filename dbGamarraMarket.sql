/* Crear base de datos dbGamarraMarket */
DROP DATABASE IF EXISTS dbGamarraMarket;
CREATE DATABASE dbGamarraMarket
DEFAULT CHARACTER SET utf8;

/* Poner en uso la base de datos dbGamarraMarket */
USE dbGamarraMarket;

/* Crear la tabla VENDEDOR */
CREATE TABLE VENDEDOR (
    id INT,
    tipo_documento CHAR(3),
    numero_documento CHAR(15),
    nombres VARCHAR(60),
    apellidos VARCHAR(90),
    salario DECIMAL(8,2),
    celular CHAR(9),
    email VARCHAR(80),
    activo BOOL,
    CONSTRAINT vendedor_pk PRIMARY KEY (id)
);

/* Crear la tabla CLIENTE */
CREATE TABLE CLIENTE (
    id INT,
    tipo_documento CHAR(3),
    numero_documento CHAR(9),
    nombres VARCHAR(60),
    apellidos VARCHAR(90),
    email VARCHAR(80),
    celular CHAR(9),
    fecha_nacimiento DATE,
    activo BOOL,
    CONSTRAINT cliente_pk PRIMARY KEY (id)
);

/* Crear la tabla PRENDA */
CREATE TABLE PRENDA (
    id INT,
    descripcion VARCHAR(90),
    marca VARCHAR(60),
    cantidad INT,
    talla VARCHAR(10),
    precio DECIMAL(8,2),
    activo BOOL,
    CONSTRAINT prenda_pk PRIMARY KEY (id)
);

/* Crear la tabla VENTA */
CREATE TABLE VENTA (
    id INT,
    fecha_hora TIMESTAMP,
    activo BOOL,
    cliente_id INT,
    vendedor_id INT,
    CONSTRAINT venta_pk PRIMARY KEY (id),
    CONSTRAINT cliente_venta_fk FOREIGN KEY (cliente_id) REFERENCES CLIENTE (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT vendedor_venta_fk FOREIGN KEY (vendedor_id) REFERENCES VENDEDOR (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/* Crear la tabla VENTA_DETALLE */
CREATE TABLE VENTA_DETALLE (
    id INT,
    cantidad INT,
    venta_id INT,
    prenda_id INT,
    CONSTRAINT venta_detalle_pk PRIMARY KEY (id),
    CONSTRAINT venta_venta_detalle_fk FOREIGN KEY (venta_id) REFERENCES VENTA (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT venta_detalle_prenda_fk FOREIGN KEY (prenda_id) REFERENCES PRENDA (id) ON UPDATE CASCADE ON DELETE CASCADE
);

/* Listar todas las tablas en la base de datos en uso */
SHOW TABLES;

/* Listar estructura de cada tabla */
SHOW COLUMNS IN VENDEDOR;
SHOW COLUMNS IN CLIENTE;
SHOW COLUMNS IN PRENDA;
SHOW COLUMNS IN VENTA;
SHOW COLUMNS IN VENTA_DETALLE;

/* Listar relaciones de tablas (foreign keys) en la base de datos activa */
SELECT 
    i.constraint_name, k.table_name, k.column_name, 
    k.referenced_table_name, k.referenced_column_name
FROM 
    information_schema.TABLE_CONSTRAINTS i 
LEFT JOIN information_schema.KEY_COLUMN_USAGE k 
ON i.CONSTRAINT_NAME = k.CONSTRAINT_NAME 
WHERE i.CONSTRAINT_TYPE = 'FOREIGN KEY' 
AND i.TABLE_SCHEMA = DATABASE();
