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

-- Trigger de auditoría que registre en una tabla historial_precios cada vez que se modifique el precio de una pizza.

DELIMITER //

CREATE TRIGGER auditoría
BEFORE UPDATE ON pizza FOR EACH ROW
BEGIN
    IF OLD.precio_actual <> NEW.precio_actual THEN INSERT INTO historial_precio (precio_antiguo, precio_nuevo,id_pizza ) VALUES (OLD.precio_actual, NEW.precio_actual, OLD.id); 
    END IF;
END //

DELIMITER ;