-- Clientes con pedidos entre dos fechas (BETWEEN).

SELECT p.nombre AS cliente, COUNT(pe.id) AS cantidad_pedidos_reaizados FROM pedido pe INNER JOIN persona p ON pe.id_cliente = p.id WHERE pe.fecha BETWEEN '2025-01-01' AND '2025-01-12' GROUP BY p.nombre ;

-- Pizzas más vendidas (GROUP BY y COUNT).

SELECT p.nombre, SUM(dp.cantidad) AS cantidad_vendida FROM detalle_pedido dp INNER JOIN pizza p ON p.id = dp.id_pizza GROUP BY p.nombre ORDER BY cantidad_vendida DESC LIMIT 5;

-- Pedidos por repartidor (JOIN).

SELECT p.nombre AS repartidor, COUNT(pe.id) AS cantidad_pedidos_repartidos FROM pedido pe INNER JOIN persona p ON p.id = pe.id_repartidor GROUP BY p.nombre ORDER BY cantidad_pedidos_repartidos DESC;