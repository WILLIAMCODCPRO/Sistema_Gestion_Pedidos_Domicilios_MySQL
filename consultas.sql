-- Clientes con pedidos entre dos fechas (BETWEEN).

SELECT DISTINCT p.nombre FROM pedido pe INNER JOIN persona p ON pe.id_cliente = p.id WHERE pe.fecha BETWEEN '2025-12-01' AND '2025-12-30';