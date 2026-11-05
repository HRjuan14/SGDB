-- Juan Herrador Rello


-- Tarea 1: Creación de usuarios y políticas de conexión y caducidad

-- Una contraseña para ser segura debe contener mayusculas, numeros, simbolos. No usar contraseñas faciles ni repetir contraseña
-- Creacion de usuarios
CREATE USER 'gestor_tienda'@'localhost' IDENTIFIED BY 'gTienda1234+';
CREATE USER 'auditor_externo'@'%' IDENTIFIED BY 'AuditorExter2026*';

-- Hacemos que la contraseña del usuario expire a los 30 dias
ALTER USER 'auditor_externo'@'%' PASSWORD EXPIRE INTERVAL 30 DAY;

-- El usuario no puede usar mas de 1h las conexciones activas
SET BLOBAL wait_timeout = 3600; 



-- Tarea 2: Creación y asignación de roles

CREATE ROLE 'rol_consultor';

-- Permisos de solo lectura al rol_consultor
GRAND SELECT ON tienda_informatica.* TO 'rol_consultor';

-- Darle el Rol al usuario auditor_externo
GRAND 'rol_consultor' TO 'auditor_externo'@'%'



-- Tarea 3: Seguridad mediante Vistas y Privilegios Granulares

-- Creacion de una vista
CREATE VIEW v_tecnicos_activos AS
SELECT id, nombre, especialidad
FROM tecnicos;

-- Concecemos exclusivamente los permisos SELECT de la vista
GRAND SELECT ON v_tecnicos_activos TO gestor_tienda;

-- Tarea 4: Consistencia y control con WITH CHECK OPTION

