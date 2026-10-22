-- =============================================================================
-- Practica 2 ASGBD - Creacion de Tablas y Consultas
-- Nombre: [Tu Nombre y Apellidos]
-- Curso: 2º ASIR
-- =============================================================================

-- Creo la base de datos si no existe y me conecto a ella
CREATE DATABASE IF NOT EXISTS tienda_informatica;
USE tienda_informatica;

-- Borro las tablas si ya existian para evitar problemas al reejecutar el script
-- Las borro en este orden por las claves foraneas
DROP TABLE IF EXISTS reparaciones;
DROP TABLE IF EXISTS articulos;
DROP TABLE IF EXISTS tecnicos;
DROP TABLE IF EXISTS fabricantes;


-- =============================================================================
-- PARTE 1: CREACION DE TABLAS E INSERCION DE DATOS
-- =============================================================================

-- Tabla para guardar los fabricantes de componentes
CREATE TABLE fabricantes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) UNIQUE NOT NULL,
    pais VARCHAR(100) NOT NULL
);

-- Tabla de articulos con clave foranea apuntando a fabricantes
CREATE TABLE articulos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    fabricante_id INT NOT NULL,
    FOREIGN KEY (fabricante_id) REFERENCES fabricantes(id)
);

-- Tabla de tecnicos de la tienda
CREATE TABLE tecnicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL
);

-- Tabla de reparaciones vinculada con los tecnicos
CREATE TABLE reparaciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descripcion_averia TEXT NOT NULL,
    coste_reparacion DECIMAL(10, 2) NOT NULL,
    tecnico_id INT NOT NULL,
    FOREIGN KEY (tecnico_id) REFERENCES tecnicos(id)
);

-- Meto los datos de fabricantes
INSERT INTO fabricantes (id, nombre, pais) VALUES
(1, 'Kingston', 'Estados Unidos'),
(2, 'Asus', 'Taiwán'),
(3, 'Samsung', 'Corea del Sur'),
(4, 'Logitech', 'Suiza'),
(5, 'Intel', 'Estados Unidos');

-- Insercion de los articulos de la practica
INSERT INTO articulos (id, nombre, precio, fabricante_id) VALUES
(1, 'Memoria RAM 16GB DDR4', 45.50, 1),
(2, 'SSD NVMe 1TB', 79.99, 1),
(3, 'Placa Base ROG Strix', 185.00, 2),
(4, 'Monitor 27" IPS 144Hz', 249.00, 2),
(5, 'Monitor 32" Curved', 320.00, 3),
(6, 'Ratón Óptico Inalámbrico', 29.99, 4),
(7, 'Teclado Mecánico RGB', 89.90, 4),
(8, 'Procesador Core i7', 310.00, 5);

-- Insercion de datos de los tecnicos
INSERT INTO tecnicos (id, nombre, especialidad, salario) VALUES
(1, 'Carlos Pérez', 'Hardware', 1800.00),
(2, 'Ana Gómez', 'Redes y Servidores', 2100.00),
(3, 'Luis Martínez', 'Portátiles', 1650.00),
(4, 'Marta Ruiz', 'Movilidad y Tablets', 1750.00);

-- Registro las reparaciones realizadas
INSERT INTO reparaciones (id, descripcion_averia, coste_reparacion, tecnico_id) VALUES
(1, 'Sustitución de pantalla rota', 120.50, 3),
(2, 'Cambio de fuente de alimentación', 65.00, 1),
(3, 'Recuperación de datos en disco dañado', 150.00, 2),
(4, 'Limpieza interna y cambio de pasta térmica', 45.00, 1),
(5, 'Sustitución de conector de carga', 50.00, 3),
(6, 'Ampliación de RAM y formateo', 80.00, 4);


-- =============================================================================
-- PARTE 2: CONSULTAS (SIN JOINs)
-- =============================================================================

-- Ejercicio 1: Sacar nombre y precio de articulos ordenados del mas caro al mas barato
SELECT nombre, precio 
FROM articulos 
ORDER BY precio DESC;

-- Ejercicio 2: Filtrar los fabricantes que sean de EE.UU.
SELECT nombre 
FROM fabricantes 
WHERE pais = 'Estados Unidos';

-- Ejercicio 3: Articulos con precio entre 100 y 300 euros usando BETWEEN
SELECT * 
FROM articulos 
WHERE precio BETWEEN 100 AND 300;

-- Ejercicio 4: Precio medio de los articulos con la funcion AVG
SELECT AVG(precio) AS precio_medio 
FROM articulos;

-- Ejercicio 5: Contar cuantos articulos tiene cada fabricante agrupando por id
SELECT fabricante_id, COUNT(*) AS total_articulos 
FROM articulos 
GROUP BY fabricante_id;

-- Ejercicio 6: Tecnicos que han arreglado mas de una averia (usando HAVING tras agrupar)
SELECT tecnico_id 
FROM reparaciones 
GROUP BY tecnico_id 
HAVING COUNT(*) > 1;

-- Ejercicio 7: Articulos de Taiwán usando una subconsulta en vez de JOIN
SELECT nombre, precio 
FROM articulos 
WHERE fabricante_id IN (
    SELECT id 
    FROM fabricantes 
    WHERE pais = 'Taiwán'
);

-- Ejercicio 8: La reparacion mas cara filtrando por la subconsulta MAX()
SELECT descripcion_averia, coste_reparacion 
FROM reparaciones 
WHERE coste_reparacion = (
    SELECT MAX(coste_reparacion) 
    FROM reparaciones
);

-- Ejercicio 9: Calcular el salario de los tecnicos con una subida del 10% (* 1.10)
SELECT nombre, salario * 1.10 AS salario_con_subida 
FROM tecnicos;

-- Ejercicio 10: Tecnicos sin reparaciones asignadas comprobando id que NO estan en reparaciones
SELECT nombre 
FROM tecnicos 
WHERE id NOT IN (
    SELECT DISTINCT tecnico_id 
    FROM reparaciones
);
