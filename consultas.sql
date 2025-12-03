-- Clientes con pedidos entre dos fechas (BETWEEN).

SELECT DISTINCT p.nombre FROM pedido pe INNER JOIN persona p ON pe.id_cliente = p.id WHERE pe.fecha BETWEEN '2025-12-01' AND '2025-12-30';

-- Pizzas más vendidas (GROUP BY y COUNT).

SELECT p.nombre, SUM(dp.cantidad) AS cantidad_vendida FROM detalle_pedido dp INNER JOIN pizza p ON p.id = dp.id_pizza GROUP BY p.nombre ORDER BY cantidad_vendida DESC LIMIT 5;