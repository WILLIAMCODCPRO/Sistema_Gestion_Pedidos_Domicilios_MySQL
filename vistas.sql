-- Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).

CREATE VIEW resumen_pedidos_clientes AS SELECT p.nombre AS cliente, COUNT(pe.id) AS cantidad_pedidos, SUM(pe.total_pedido) AS total_gastado FROM persona p INNER JOIN pedido pe ON pe.id_cliente = p.id GROUP BY p.nombre;