-- Función para calcular el total de un pedido (sumando precios de pizzas + costo de envío + IVA).

DELIMITER //

CREATE FUNCTION total_pedido(p_id_pedido INT)
RETURNS DOUBLE
DETERMINISTIC
READS SQL DATA

BEGIN
    DECLARE v_subtotal_pizza DOUBLE;
    DECLARE v_envio DOUBLE;
    DECLARE iva  DOUBLE DEFAULT 0.19;
    DECLARE total DOUBLE;

    SELECT SUM(dp.subtotal) INTO v_subtotal_pizza FROM detalle_pedido dp WHERE dp.id_pedido = p_id_pedido ;
    SELECT d.costo_envio INTO v_envio FROM pedido p INNER JOIN domicilio d ON d.id = p.id_domicilio WHERE p.id = p_id_pedido ;
    SET total = (v_subtotal_pizza + v_envio) * (1 + iva);
    RETURN total;
END //

DELIMITER ;

-- Función para calcular la ganancia neta diaria (ventas - costos de ingredientes).

DELIMITER //

CREATE FUNCTION ganancia_neta_diaria(p_fecha DATE)
RETURNS DOUBLE
DETERMINISTIC
READS SQL DATA

BEGIN
   DECLARE v_ganancia_neta_diaria DOUBLE;
   DECLARE v_subtotal_pizza DOUBLE;
   DECLARE v_costos_ingredientes DOUBLE;

   SELECT SUM(dp.subtotal) INTO v_subtotal_pizza FROM detalle_pedido dp INNER JOIN pedido p ON p.id = dp.id_pedido WHERE DATE(p.fecha) = p_fecha AND p.estado = 'entregado';
   SELECT SUM(dp.cantidad * ip.cantidad_ingrediente * i.precio) INTO v_costos_ingredientes FROM detalle_pedido dp INNER JOIN pedido p ON p.id = dp.id_pedido INNER JOIN ingrediente_pizza ip ON ip.id = dp.id_pizza INNER JOIN ingrediente i ON i.id = ip.id_ingrediente WHERE DATE(p.fecha) = p_fecha AND p.estado = 'entregado';
   SET v_ganancia_neta_diaria = (v_subtotal_pizza - v_costos_ingredientes);
   RETURN v_ganancia_neta_diaria;

END //

DELIMITER ;