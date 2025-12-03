-- Vista de resumen de pedidos por cliente (nombre del cliente, cantidad de pedidos, total gastado).

CREATE VIEW resumen_pedidos_clientes AS SELECT p.nombre AS cliente, COUNT(pe.id) AS cantidad_pedidos, SUM(pe.total_pedido) AS total_gastado FROM persona p INNER JOIN pedido pe ON pe.id_cliente = p.id GROUP BY p.nombre;

-- Vista de desempeño de repartidores (número de entregas, tiempo promedio, zona).

CREATE VIEW desempe_repartidores AS SELECT p.nombre AS repartidor, COUNT(pe.id) AS numero_entregas, AVG(TIMESTAMPDIFF(MINUTE, d.hora_salida_repartidor, d.hora_entrega)) AS tiempo_promedio, z.nombre AS zona FROM persona p INNER JOIN pedido pe ON pe.id_repartidor = p.id  INNER JOIN domicilio d ON d.id = pe.id_domicilio INNER JOIN zona z ON z.id = d.id_zona WHERE pe.estado = 'entregado' GROUP BY p.nombre, z.nombre;