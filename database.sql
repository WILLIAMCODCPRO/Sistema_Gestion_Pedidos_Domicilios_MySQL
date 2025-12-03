CREATE DATABASE pizzeria_don_piccoro; -- Crear la base de datos

USE pizzeria_don_piccoro; -- Cambiar a la base de datos

-- Crear tabla persona

CREATE TABLE persona (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- Crear tabla usuario

CREATE TABLE usuario(
    id INT NOT NULL,
    usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id)
);

-- Crear tabla cliente

CREATE TABLE cliente (
    id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id)
);

-- Crear tabla pizza

CREATE TABLE pizza (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    tam ENUM('Grande','Mediana','pequeña') NOT NULL,
    precio_actual DOUBLE NOT NULL,
    tipo ENUM('vegetariana','especial','clasica') NOT NULL,
    PRIMARY KEY (id)
);

-- Crear tabla unidad_medida

CREATE TABLE unidad_medida (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- Crear tabla ingrediente

CREATE TABLE ingrediente (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    precio DOUBLE NOT NULL,
    stock INT NOT NULL,
    stock_minimo INT NOT NULL,
    id_unidad_medida INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_unidad_medida) REFERENCES unidad_medida(id)
);

-- Crear tabla ingrediente_pizza

CREATE TABLE ingrediente_pizza (
    id INT NOT NULL AUTO_INCREMENT,
    cantidad_ingrediente DOUBLE NOT NULL,
    id_pizza INT NOT NULL,
    id_ingrediente INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_pizza) REFERENCES pizza(id),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id)
);

-- Crear tabla pago

CREATE TABLE pago (
    id INT NOT NULL AUTO_INCREMENT,
    metodo_pago ENUM('efectivo','tarjeta','app') NOT NULL, 
    estado ENUM('pagado','no pagado') NOT NULL,
    PRIMARY KEY (id)
);

-- Crear tabla zona

CREATE TABLE zona (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    costo_metro DOUBLE NOT NULL,
    costo_base DOUBLE NOT NULL,
    PRIMARY KEY (id)
);

-- Crear tabla repartidor

CREATE TABLE repartidor (
    id INT NOT NULL,
    estado ENUM('disponible','no disponible') NOT NULL,
    id_zona INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (id_zona) REFERENCES zona(id)
);

-- Crear tabla domicilio

CREATE TABLE domicilio (
    id INT NOT NULL AUTO_INCREMENT,
    distancia DOUBLE NOT NULL,
    hora_salida_repartidor DATETIME,
    hora_entrega DATETIME,
    direccion VARCHAR(50) NOT NULL,
    costo_envio DOUBLE NOT NULL,
    id_zona INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_zona) REFERENCES zona(id)
);

-- Crear tabla pedido

CREATE TABLE pedido (
    id INT NOT NULL AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    estado ENUM('pendiente','en preparacion','entregado', 'cancelado') NOT NULL,
    total_pedido DOUBLE NOT NULL,
    id_cliente INT NOT NULL,
    id_pago INT NOT NULL,
    id_domicilio INT NOT NULL,
    id_repartidor INT NOT NULL,
    id_usuario INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_pago) REFERENCES pago(id),
    FOREIGN KEY (id_domicilio) REFERENCES domicilio(id),
    FOREIGN KEY (id_repartidor) REFERENCES repartidor(id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Crear tabla detalle_pedido

CREATE TABLE detalle_pedido (
    id INT NOT NULL AUTO_INCREMENT,
    precio_unitario DOUBLE NOT NULL,
    cantidad INT NOT NULL,
    subtotal DOUBLE NOT NULL,
    id_pedido INT NOT NULL,
    id_pizza INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    FOREIGN KEY (id_pizza) REFERENCES pizza(id)
);

-- Crear tabla historial_precio

CREATE TABLE historial_precio (
    id INT NOT NULL AUTO_INCREMENT,
    precio_antiguo DOUBLE NOT NULL,
    precio_nuevo DOUBLE NOT NULL,
    id_pizza INT NOT NULL, 
    fecha_cambio DATETIME DEFAULT NOW() NOT NULL, 
    PRIMARY KEY (id),
    FOREIGN KEY (id_pizza) REFERENCES pizza(id)
);


-- Incercion datos de prueba

-- tabla unidad_medida
INSERT INTO unidad_medida (nombre) VALUES
('gramos'),
('mililitros'),
('unidades');

-- tabla zona
INSERT INTO zona (nombre, costo_metro, costo_base) VALUES
('Centro', 0.50, 2000),
('Norte', 0.65, 2500),
('Sur', 0.40, 1800),
('Oriente', 0.55, 2200);

-- tabla pago
INSERT INTO pago (metodo_pago, estado) VALUES
('tarjeta', 'pagado'),
('efectivo', 'pagado'),
('app', 'pagado'),
('tarjeta', 'pagado'); 

-- tabla pizza
INSERT INTO pizza (nombre, tam, precio_actual, tipo) VALUES
('Margarita Clásica', 'Grande', 25000.00, 'clasica'),
('Vegetariana Suprema', 'Mediana', 28000.00, 'vegetariana'),
('Pepperoni Explosiva', 'Grande', 32000.00, 'especial'),
('Hawaiana Estándar', 'Mediana', 24000.00, 'clasica');

-- tabla ingrediente
INSERT INTO ingrediente (nombre, precio, stock, stock_minimo, id_unidad_medida) VALUES
('Harina', 2000.00, 15000, 5000, 1),
('Queso Mozzarella', 5000.00, 3000, 1000, 1),
('Salsa de Tomate', 1500.00, 80, 20, 2),
('Pepperoni', 8000.00, 500, 100, 3),
('Piña', 4000.00, 100, 50, 3),
('Champiñones', 6000.00, 8, 10, 3);

-- tabla persona 
INSERT INTO persona (nombre, telefono, correo_electronico) VALUES
('Ana García', '3001112233', 'ana.garcia@mail.com'),         -
('Juan Pérez', '3004445566', 'juan.perez@mail.com'),         
('María López', '3007778899', 'maria.lopez@mail.com'),       
('Carlos Díaz', '3001234567', 'carlos.diaz@mail.com'),       
('Felipe Rojas', '3009876543', 'felipe.rojas@mail.com'),     
('Laura Montes', '3110000006', 'laura.montes@mail.com'),
('Ricardo Sosa', '3110000007', 'ricardo.sosa@mail.com'),
('Sofía Torres', '3110000008', 'sofia.torres@mail.com'),
('Andrés Milla', '3110000009', 'andres.milla@mail.com'),
('Paola Castro', '3110000010', 'paola.castro@mail.com'),
('Jorge Vidal', '3110000011', 'jorge.vidal@mail.com'),
('Camila Ríos', '3110000012', 'camila.rios@mail.com'),
('David Soto', '3110000013', 'david.soto@mail.com'),
('Elena Pinto', '3110000014', 'elena.pinto@mail.com'),
('Sebastián Mora', '3110000015', 'sebastian.mora@mail.com'),
('Valentina Ruiz', '3110000016', 'valentina.ruiz@mail.com'),
('Fernando Gil', '3110000017', 'fernando.gil@mail.com'),
('Natalia Silva', '3110000018', 'natalia.silva@mail.com'),
('Javier Cruz', '3110000019', 'javier.cruz@mail.com'),
('Marta Vega', '3110000020', 'marta.vega@mail.com'),
('Daniel Reyes', '3110000021', 'daniel.reyes@mail.com'),
('Lorena Ortiz', '3110000022', 'lorena.ortiz@mail.com'),
('Pedro Núñez', '3110000023', 'pedro.nunez@mail.com'),
('Miguel Ángel', '3110000024', 'miguel.angel@mail.com'),
('Sara Bernal', '3110000025', 'sara.bernal@mail.com'),
('Roberto Paz', '3110000026', 'roberto.paz@mail.com'),
('Luisa Flores', '3110000027', 'luisa.flores@mail.com'),
('Héctor Velez', '3110000028', 'hector.velez@mail.com'),
('Inés Osorio', '3110000029', 'ines.osorio@mail.com'),
('Nicolás Rico', '3110000030', 'nicolas.rico@mail.com');

-- tabla cliente 
INSERT INTO cliente (id) VALUES
(1), (4), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23);

-- tabla usuario 
INSERT INTO usuario (id, usuario, clave) VALUES
(3, 'mlopez', '12345'),
(2, 'jperez', 'repartidor1'),
(24, 'mangel', 'user24'),
(29, 'iosorio', 'user29'),
(30, 'nrico', 'user30');

--  tabla repartidor 
INSERT INTO repartidor (id, estado, id_zona) VALUES
(2, 'disponible', 1),
(5, 'no disponible', 3),
(25, 'disponible', 4),
(26, 'disponible', 2),
(27, 'no disponible', 1),
(28, 'disponible', 3);

-- tabla domicilio 
INSERT INTO domicilio (distancia, hora_salida_repartidor, hora_entrega, direccion, costo_envio, id_zona) VALUES
(3.5, '2025-11-20 18:00:00', '2025-11-20 18:20:00', 'Calle 50 # 10-15', 3750.00, 1),
(12.0, '2025-11-20 19:10:00', '2025-11-20 19:45:00', 'Carrera 30 # 100-2', 9800.00, 2),
(5.0, '2025-11-21 12:05:00', '2025-11-21 12:25:00', 'Avenida Principal # 1-1', 4500.00, 1), 
(6.2, '2025-11-21 13:00:00', '2025-11-21 13:30:00', 'Carrera 8 # 5-1', 5000.00, 4), 
(1.8, '2025-11-21 15:05:00', '2025-11-21 15:15:00', 'Calle 100 # 30-5', 3000.00, 1), 
(8.0, '2025-11-21 17:30:00', '2025-11-21 18:00:00', 'Avenida Los Cerezos', 6000.00, 2), 
(4.5, '2025-11-21 20:05:00', '2025-11-21 20:25:00', 'Diagonal 45 Sur', 4000.00, 3), 
(10.5, '2025-11-22 10:00:00', '2025-11-22 10:40:00', 'Boulevard Principal', 7000.00, 2), 
(2.1, '2025-11-22 11:30:00', '2025-11-22 11:45:00', 'Calle del Sol # 2-2', 3500.00, 1), 
(7.5, '2025-11-22 14:00:00', '2025-11-22 14:35:00', 'Vía al Mar', 5500.00, 4),
(15.0, '2025-11-22 16:35:00', '2025-11-22 17:20:00', 'Finca El Tesoro', 12000.00, 3), 
(3.0, '2025-11-23 18:00:00', '2025-11-23 18:15:00', 'Edificio Central', 3600.00, 1), 
(5.5, '2025-11-23 19:30:00', '2025-11-23 20:00:00', 'Sector Industrial', 4800.00, 2), 
(9.1, '2025-11-24 11:00:00', '2025-11-24 11:30:00', 'Conjunto Residencial A', 6500.00, 3), 
(0.9, '2025-11-24 12:45:00', '2025-11-24 13:00:00', 'Plaza Mayor', 2800.00, 1), 
(4.0, '2025-11-24 14:30:00', '2025-11-24 15:00:00', 'Parque de la 93', 4000.00, 4), 
(11.2, '2025-11-24 16:05:00', '2025-11-24 16:50:00', 'Reserva Natural', 10000.00, 2), 
(1.5, '2025-11-25 20:00:00', '2025-11-25 20:10:00', 'Barrio Los Pinos', 3000.00, 1), 
(6.0, '2025-11-25 21:30:00', '2025-11-25 22:00:00', 'Zona Franca', 5200.00, 3), 
(8.8, '2025-11-26 14:00:00', '2025-11-26 14:40:00', 'Centro Comercial', 6800.00, 4), 
(2.5, '2025-11-26 16:30:00', '2025-11-26 16:45:00', 'Calle 70 # 5-5', 3800.00, 1),
(10.0, '2025-11-27 18:00:00', '2025-11-27 18:45:00', 'Villa Olímpica', 8500.00, 2), 
(4.2, '2025-11-27 20:05:00', '2025-11-27 20:30:00', 'Conjunto Residencial B', 4200.00, 3), 
(7.0, '2025-11-28 19:30:00', '2025-11-28 20:00:00', 'Barrio El Lago', 5800.00, 4), 
(1.0, '2025-11-28 21:00:00', '2025-11-28 21:10:00', 'Torres Gemelas', 2900.00, 1), 
(9.5, '2025-11-29 10:00:00', '2025-11-29 10:35:00', 'Zona de Playas', 7500.00, 2),
(3.2, '2025-11-29 12:30:00', '2025-11-29 12:45:00', 'Calle 10 # 10-10', 3900.00, 3),
(6.5, '2025-11-29 14:30:00', '2025-11-29 15:00:00', 'Vereda Las Palmas', 5500.00, 4), 
(2.8, '2025-11-29 16:35:00', '2025-11-29 16:50:00', 'Cerca al Hospital', 3500.00, 1), 
(13.0, '2025-11-30 18:00:00', '2025-11-30 18:50:00', 'Afueras de la Ciudad', 10500.00, 2), 
(5.0, '2025-12-01 19:00:00', '2025-12-01 19:25:00', 'Conjunto Sol Naciente', 4500.00, 3), 
(7.8, '2025-12-01 21:00:00', '2025-12-01 21:40:00', 'Parque Industrial', 6000.00, 4),
(0.5, '2025-12-02 12:00:00', '2025-12-02 12:05:00', 'Edificio Torres Blancas', 2500.00, 1), 
(11.5, '2025-12-02 13:05:00', '2025-12-02 13:45:00', 'Finca La Esperanza', 9000.00, 2), 
(3.8, '2025-12-02 14:30:00', '2025-12-02 14:50:00', 'Barrio Jardín', 4100.00, 3),
(5.2, '2025-12-02 16:00:00', '2025-12-02 16:25:00', 'Avenida Libertadores', 4600.00, 4),
(1.1, '2025-12-02 18:30:00', '2025-12-02 18:40:00', 'Calle Principal', 2800.00, 1), 
(8.5, '2025-12-02 20:05:00', '2025-12-02 20:45:00', 'Cabañas del Bosque', 7000.00, 2), 
(4.8, '2025-12-03 10:00:00', '2025-12-03 10:25:00', 'Urbanización Nueva', 4400.00, 3), 
(6.0, '2025-12-03 12:30:00', '2025-12-03 13:00:00', 'Sector El Carmen', 5200.00, 4); 

-- tabla pedido
INSERT INTO pedido (fecha, estado, total_pedido, id_cliente, id_pago, id_domicilio, id_repartidor, id_usuario) VALUES
('2025-11-20 17:45:00', 'entregado', 28750.00, 1, 1, 1, 2, 3),
('2025-11-20 19:00:00', 'entregado', 41800.00, 4, 2, 2, 5, 3),
('2025-11-21 12:00:00', 'entregado', 30500.00, 1, 3, 3, 2, 3), 
('2025-11-21 12:40:00', 'entregado', 34500.00, 6, 4, 4, 25, 3),
('2025-11-21 14:50:00', 'entregado', 27000.00, 7, 1, 5, 2, 24),
('2025-11-21 17:00:00', 'entregado', 40000.00, 8, 2, 6, 26, 2),
('2025-11-21 20:00:00', 'entregado', 29000.00, 9, 3, 7, 28, 29), 
('2025-11-22 09:45:00', 'entregado', 52000.00, 10, 1, 8, 26, 30),
('2025-11-22 11:15:00', 'entregado', 26000.00, 11, 2, 9, 2, 3),
('2025-11-22 13:40:00', 'entregado', 38000.00, 12, 4, 10, 25, 24),
('2025-11-22 16:30:00', 'entregado', 60000.00, 13, 1, 11, 5, 29), 
('2025-11-23 17:30:00', 'entregado', 33600.00, 14, 2, 12, 2, 30),
('2025-11-23 19:15:00', 'entregado', 45800.00, 15, 3, 13, 26, 3),
('2025-11-24 10:45:00', 'entregado', 55000.00, 16, 1, 14, 28, 24),
('2025-11-24 12:30:00', 'entregado', 26800.00, 17, 2, 15, 2, 29),
('2025-11-24 14:15:00', 'entregado', 34000.00, 18, 4, 16, 25, 30),
('2025-11-24 16:00:00', 'entregado', 41000.00, 19, 1, 17, 26, 3), 
('2025-11-25 19:40:00', 'entregado', 28000.00, 20, 2, 18, 2, 24),
('2025-11-25 21:10:00', 'entregado', 43000.00, 21, 3, 19, 28, 2),
('2025-11-26 13:45:00', 'entregado', 38800.00, 22, 1, 20, 25, 29),
('2025-11-26 16:15:00', 'entregado', 27800.00, 23, 2, 21, 2, 30),
('2025-11-27 17:40:00', 'entregado', 42000.00, 1, 4, 22, 26, 3),
('2025-11-27 20:00:00', 'entregado', 36000.00, 4, 1, 23, 28, 24), 
('2025-11-28 19:10:00', 'entregado', 31800.00, 6, 2, 24, 25, 2),
('2025-11-28 20:45:00', 'entregado', 26900.00, 7, 3, 25, 2, 29),
('2025-11-29 09:45:00', 'entregado', 45500.00, 8, 1, 26, 26, 30),
('2025-11-29 12:15:00', 'entregado', 32900.00, 9, 2, 27, 28, 3),
('2025-11-29 14:15:00', 'entregado', 37500.00, 10, 4, 28, 25, 24),
('2025-11-29 16:30:00', 'entregado', 29500.00, 11, 1, 29, 2, 2), 
('2025-11-30 17:45:00', 'entregado', 55500.00, 12, 2, 30, 26, 29),
('2025-12-01 18:40:00', 'entregado', 38500.00, 13, 3, 31, 28, 30),
('2025-12-01 20:45:00', 'entregado', 44000.00, 14, 1, 32, 25, 3),
('2025-12-02 11:45:00', 'entregado', 27500.00, 15, 2, 33, 2, 24),
('2025-12-02 13:00:00', 'entregado', 35000.00, 16, 4, 34, 26, 2), 
('2025-12-02 14:15:00', 'entregado', 39100.00, 17, 1, 35, 28, 29),
('2025-12-02 15:45:00', 'entregado', 41200.00, 18, 2, 36, 25, 30),
('2025-12-02 18:15:00', 'entregado', 26800.00, 19, 3, 37, 2, 3),
('2025-12-02 20:00:00', 'entregado', 35000.00, 20, 4, 38, 26, 24), 
('2025-12-03 09:45:00', 'entregado', 36400.00, 21, 1, 39, 28, 2),
('2025-12-03 12:10:00', 'entregado', 42200.00, 22, 2, 40, 25, 29);

-- tabla ingrediente_pizza 
INSERT INTO ingrediente_pizza (cantidad_ingrediente, id_pizza, id_ingrediente) VALUES
(200.0, 1, 1),
(50.0, 1, 2),
(2.0, 4, 5),
(100.0, 2, 2),
(15.0, 3, 4),
(20.0, 3, 3),
(5.0, 4, 5),
(50.0, 2, 6);

-- tabla detalle_pedido 
INSERT INTO detalle_pedido (precio_unitario, cantidad, subtotal, id_pedido, id_pizza) VALUES
(25000.00, 1, 25000.00, 1, 1),
(32000.00, 1, 32000.00, 2, 3),
(24000.00, 1, 24000.00, 3, 4),
(28000.00, 1, 28000.00, 4, 2),
(32000.00, 1, 32000.00, 5, 3),
(25000.00, 1, 25000.00, 6, 1),
(28000.00, 1, 28000.00, 7, 2),
(32000.00, 1, 32000.00, 8, 3),
(24000.00, 1, 24000.00, 9, 4),
(25000.00, 1, 25000.00, 10, 1),
(32000.00, 1, 32000.00, 11, 3),
(24000.00, 1, 24000.00, 12, 4),
(28000.00, 1, 28000.00, 13, 2),
(32000.00, 1, 32000.00, 14, 3),
(25000.00, 1, 25000.00, 15, 1),
(28000.00, 1, 28000.00, 16, 2),
(32000.00, 1, 32000.00, 17, 3),
(24000.00, 1, 24000.00, 18, 4),
(25000.00, 1, 25000.00, 19, 1),
(28000.00, 1, 28000.00, 20, 2),
(32000.00, 1, 32000.00, 21, 3),
(24000.00, 1, 24000.00, 22, 4),
(25000.00, 1, 25000.00, 23, 1),
(28000.00, 1, 28000.00, 24, 2),
(32000.00, 1, 32000.00, 25, 3),
(24000.00, 1, 24000.00, 26, 4),
(25000.00, 1, 25000.00, 27, 1),
(28000.00, 1, 28000.00, 28, 2),
(32000.00, 1, 32000.00, 29, 3),
(24000.00, 1, 24000.00, 30, 4),
(25000.00, 1, 25000.00, 31, 1),
(28000.00, 1, 28000.00, 32, 2),
(32000.00, 1, 32000.00, 33, 3),
(24000.00, 1, 24000.00, 35, 4),
(25000.00, 1, 25000.00, 36, 1),
(28000.00, 1, 28000.00, 37, 2),
(32000.00, 1, 32000.00, 38, 3),
(24000.00, 1, 24000.00, 39, 4),
(25000.00, 1, 25000.00, 40, 1),
(28000.00, 1, 28000.00, 4, 2),
(24000.00, 1, 24000.00, 6, 4),
(25000.00, 1, 25000.00, 8, 1),
(28000.00, 1, 28000.00, 11, 2),
(24000.00, 1, 24000.00, 14, 4),
(25000.00, 1, 25000.00, 16, 1),
(24000.00, 1, 24000.00, 20, 4),
(32000.00, 1, 32000.00, 22, 3),
(28000.00, 1, 28000.00, 26, 2),
(25000.00, 1, 25000.00, 30, 1),
(28000.00, 1, 28000.00, 35, 2);

-- tabla historial_precio
INSERT INTO historial_precio (precio_antiguo, precio_nuevo, id_pizza, fecha_cambio) VALUES
(22000.00, 25000.00, 1, '2025-10-01 10:00:00'),
(28000.00, 32000.00, 3, '2025-11-05 09:00:00'),
(25000.00, 28000.00, 2, '2025-11-10 14:00:00');