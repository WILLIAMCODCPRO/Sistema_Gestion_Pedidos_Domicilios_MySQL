-- Procedimiento para cambiar automáticamente el estado del pedido a “entregado” cuando se registre la hora de entrega.

INSERT INTO domicilio (distancia, hora_salida_repartidor, hora_entrega, direccion, costo_envio, id_zona) VALUES
(600,'2025-01-10 18:45',NULL,'Calle 10 #19-29',2200,2);

INSERT INTO pedido (fecha, estado, total_pedido, id_cliente, id_pago, id_domicilio, id_repartidor, id_usuario) VALUES
('2025-01-10 18:10','pendiente',30000,1,1,21,16,11);

DELIMITER //

CREATE PROCEDURE cambiar_estado_pedido_entregado(IN p_id_domicilio int)

BEGIN
    UPDATE domicilio  SET hora_entrega = NOW() WHERE id = p_id_domicilio;
    UPDATE pedido SET estado = 'entregado' WHERE id_domicilio = p_id_domicilio;
END //

DELIMITER ;

CALL cambiar_estado_pedido_entregado(21);