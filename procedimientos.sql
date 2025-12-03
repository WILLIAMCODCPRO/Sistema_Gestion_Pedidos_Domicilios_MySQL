-- Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.

DELIMITER //

CREATE PROCEDURE cambiar_estado_pedido_entregado(IN p_id_domicilio int)

BEGIN
    UPDATE domicilio  SET hora_entrega = NOW() WHERE id = p_id_domicilio;
    UPDATE pedido SET estado = 'entregado' WHERE id_domicilio = p_id_domicilio;
END //

DELIMITER ;

-- Procedimiento para clinetes frecuentes

DELIMITER //

CREATE PROCEDURE clientes_frecuentes(IN p_mes INT, IN p_anho INT, IN p_min_pedidos INT)

BEGIN
    SELECT p.nombre, COUNT(pe.id) AS total_pedidos FROM pedido pe INNER JOIN persona p ON p.id = pe.id_cliente WHERE MONTH(pe.fecha) = p_mes AND YEAR(pe.fecha) = p_anho GROUP BY p.id HAVING COUNT(pe.id) >= p_min_pedidos ORDER BY total_pedidos DESC;
END //

DELIMITER ;

-- Procedimiento  para incerciones

-- Insertar en tabla persona

DELIMITER //

CREATE PROCEDURE insertar_persona(IN p_nombre VARCHAR(50), p_telefono VARCHAR(50), p_correo_electronico VARCHAR(50) )

BEGIN
    INSERT INTO persona(nombre,telefono,correo_electronico) VALUES (p_nombre, p_telefono, p_correo_electronico);
END //

DELIMITER ;

-- Insertar en tabla usuario

DELIMITER //

CREATE PROCEDURE insertar_usuario(IN p_id_persona INT,IN p_usuario VARCHAR(50), IN p_clave VARCHAR(50))

BEGIN
    INSERT INTO usuario(id, usuario, clave) VALUES (p_id_persona,p_usuario, p_clave);
END //

DELIMITER ;

-- Insertar en tabla cliente

DELIMITER //

CREATE PROCEDURE insertar_cliente(IN p_id_persona INT)

BEGIN
    INSERT INTO cliente(id) VALUES (p_id_persona);
END //

DELIMITER ;


-- Insertar en tabla pizza

DELIMITER //

CREATE PROCEDURE insertar_pizza(IN p_nombre VARCHAR(50), IN p_tam VARCHAR(50), IN p_precio_actual DOUBLE, IN p_tipo VARCHAR(50))

BEGIN
    INSERT INTO pizza(nombre, tam, precio_actual, tipo) VALUES (p_nombre, p_tam, p_precio_actual, p_tipo);
END //

DELIMITER ;

-- Insertar en tabla unidad_medida

DELIMITER //

CREATE PROCEDURE insertar_unidad_medida( IN p_nombre VARCHAR(50))

BEGIN
    INSERT INTO unidad_medida(nombre) VALUES (p_nombre);
END //

DELIMITER ;

-- Insertar en tabla ingrediente

DELIMITER //

CREATE PROCEDURE insertar_ingrediente(IN p_nombre VARCHAR(50), IN p_precio DOUBLE, IN p_stock INT ,IN p_id_unidad_medida INT)

BEGIN
    INSERT INTO ingrediente(nombre, precio, stock, id_unidad_medida) VALUES (p_nombre, p_precio, p_stock, p_id_unidad_medida);
END //

DELIMITER ;

-- Insertar en tabla ingrediente_pizza

DELIMITER //

CREATE PROCEDURE insertar_ingrediente_pizza(IN p_cantidad_ingrediente DOUBLE, IN p_id_pizza INT, IN p_id_ingrediente INT)

BEGIN
    INSERT INTO ingrediente_pizza(cantidad_ingrediente, id_pizza, id_ingrediente) VALUES (p_cantidad_ingrediente, p_id_pizza, p_id_ingrediente);
END //

DELIMITER ;

-- Insertar en tabla pago

DELIMITER //

CREATE PROCEDURE insertar_pago(IN p_metodo_pago VARCHAR(50), p_estado VARCHAR(50))

BEGIN
    INSERT INTO pago(metodo_pago, estado) VALUES (p_metodo_pago, p_estado);
END //

DELIMITER ;

-- Insertar en tabla zona

DELIMITER //

CREATE PROCEDURE insertar_zona(IN p_nombre VARCHAR(50), IN p_costo_metro DOUBLE, IN p_costo_base DOUBLE)

BEGIN
    INSERT INTO zona(nombre, costo_metro, costo_base) VALUES (p_nombre, p_costo_metro, p_costo_base);
END //

DELIMITER ;

-- Insertar en tabla repartidor

DELIMITER //

CREATE PROCEDURE insertar_repartidor(IN p_id INT, IN p_estado VARCHAR(50), IN p_id_zona INT)

BEGIN
    INSERT INTO repartidor(id, estado, id_zona) VALUES (p_id, p_estado, p_id_zona);
END //

DELIMITER ;
