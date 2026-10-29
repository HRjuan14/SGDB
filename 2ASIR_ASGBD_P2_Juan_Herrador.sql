# Parte 2
-- Consulta 1
SELECT articulos.nombre, fabricantes.nombre
FROM articulos
JOIN fabricantes ON articulos.fabricante_id = fabricantes.id
WHERE articulos.precio > 100;

-- Consulta 2: Todos los fabricantes y sus artículos
SELECT fabricantes.nombre, articulos.nombre
FROM fabricantes
LEFT JOIN articulos ON fabricantes.id = articulos.fabricante_id;

-- Consulta 4
SELECT reparaciones.descripcion_averia, reparaciones.coste_reparacion, tecnicos.nombre
FROM reparaciones
JOIN tecnicos ON reparaciones.tecnico_id = tecnicos.id
ORDER BY reparaciones.coste_reparacion DESC;

-- Consulta 5
SELECT tecnicos.nombre
FROM tecnicos
LEFT JOIN reparaciones ON tecnicos.id = reparaciones.tecnico_id
WHERE reparaciones.id IS NULL;

-- Consulta 7
SELECT articulos.nombre, fabricantes.nombre
FROM articulos
JOIN fabricantes ON articulos.fabricante_id = fabricantes.id
WHERE fabricantes.pais = 'Estados Unidos'
   OR fabricantes.pais = 'Taiwán';

-- Consulta 9
SELECT fabricantes.nombre, COUNT(articulos.id)
FROM fabricantes
JOIN articulos ON fabricantes.id = articulos.fabricante_id
GROUP BY fabricantes.id
HAVING COUNT(articulos.id) >= 2;


