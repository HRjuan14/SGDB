##Parte 2

SELECT a.nombre, f.nombre AS fabricante
FROM articulos a
INNER JOIN fabricantes f
    ON a.fabricante_id = f.id
WHERE a.precio > 100.00;


-- Consulta 2: Todos los fabricantes y sus artículos,
-- incluidos los fabricantes sin artículos
SELECT f.nombre AS fabricante, a.nombre AS articulo
FROM fabricantes f
LEFT JOIN articulos a
    ON f.id = a.fabricante_id;


-- Consulta 3: Fabricantes cuya media de precios
-- supera los 150 euros
SELECT f.nombre AS fabricante,
       AVG(a.precio) AS precio_medio
FROM fabricantes f
INNER JOIN articulos a
    ON f.id = a.fabricante_id
GROUP BY f.id, f.nombre
HAVING AVG(a.precio) > 150.00;
