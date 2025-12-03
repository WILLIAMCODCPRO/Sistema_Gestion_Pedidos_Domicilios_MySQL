-- Trigger de actualización automática de stock de ingredientes cuando se realiza un pedido.

DELIMITER //

CREATE TRIGGER actualizar_stock_despues_pedido
AFTER INSERT ON detalle_pedido FOR EACH ROW

BEGIN
    DECLARE v_id_pizza_vendida INT;
    DECLARE v_cantidad_vendida INT;

    SET v_id_pizza_vendida = NEW.id_pizza;
    SET v_cantidad_vendida = NEW.cantidad;

    UPDATE ingrediente i INNER JOIN ingrediente_pizza ip ON ip.id_ingrediente = i.id SET i.stock = i.stock - (v_cantidad_vendida * ip.cantidad_ingrediente) WHERE ip.id_pizza = v_id_pizza_vendida;
END //

DELIMITER ;

INSERT INTO detalle_pedido (precio_unitario, cantidad, subtotal, id_pedido, id_pizza) VALUES
(15.00, 3, 45.00, 26, 1);

INSERT INTO domicilio (distancia, hora_salida_repartidor, hora_entrega, direccion, costo_envio, id_zona) VALUES 
(2.5, NOW(), NULL, 'Avenida Siempre Viva 742', 3.00, 1);

INSERT INTO pedido ( fecha, estado, total_pedido, id_cliente, id_pago, id_domicilio, id_repartidor, id_usuario) VALUES 
(NOW(), 'entregado', 0.00, 2, 1, 2, 16, 11);
