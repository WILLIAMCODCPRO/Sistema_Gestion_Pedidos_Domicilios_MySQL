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
    tam tipo ENUM('Grande','Mediana','pequeña') NOT NULL,
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
    id INT NOT NULL AUTO_INCREMENT ,
    nombre VARCHAR(50) NOT NULL, 
    precio DOUBLE NOT NULL,
    stock INT NOT NULL,
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

-- Tabla persona

INSERT INTO persona (id, nombre, telefono, correo_electronico) VALUES

(1,'María Gómez','3001111111','maria.gomez@gmail.com'),
(2,'Carlos Ruiz','3001111112','carlos.ruiz@gmail.com'),
(3,'Ana Torres','3001111113','ana.torres@gmail.com'),
(4,'Pedro López','3001111114','pedro.lopez@gmail.com'),
(5,'Luisa Fernández','3001111115','luisa.fernandez@gmail.com'),
(6,'Jorge Salas','3001111116','jorge.salas@gmail.com'),
(7,'Diana Mendoza','3001111117','diana.mendoza@gmail.com'),
(8,'Felipe Castro','3001111118','felipe.castro@gmail.com'),
(9,'Valeria Ortiz','3001111119','valeria.ortiz@gmail.com'),
(10,'Santiago Reyes','3001111120','santiago.reyes@gmail.com'),
(11,'Camilo Moreno','3012222221','camilo.moreno@pizzeria.com'),
(12,'Andrea Rojas','3012222222','andrea.rojas@pizzeria.com'),
(13,'Héctor Salgado','3012222223','hector.salgado@pizzeria.com'),
(14,'Lucía Paredes','3012222224','lucia.paredes@pizzeria.com'),
(15,'Óscar Martínez','3012222225','oscar.martinez@pizzeria.com'),
(16,'Daniel Vega','3023333331','daniel.vega@pizzeria.com'),
(17,'Juliana Pérez','3023333332','juliana.perez@pizzeria.com'),
(18,'Mateo Rincón','3023333333','mateo.rincon@pizzeria.com'),
(19,'Laura Ibarra','3023333334','laura.ibarra@pizzeria.com'),
(20,'Samuel Pardo','3023333335','samuel.pardo@pizzeria.com');

-- tabla cliente

INSERT INTO cliente (id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

-- Tabal usuario

INSERT INTO usuario (id, usuario, clave) VALUES
(11,'cmoreno','1234'),
(12,'arojas','1234'),
(13,'hsalgado','1234'),
(14,'lparedes','1234'),
(15,'omartinez','1234');

-- Tabla zona

INSERT INTO zona (id, nombre, costo_metro, costo_base) VALUES
(1,'Centro',0.012,1500),
(2,'Norte',0.015,2000),
(3,'Sur',0.014,1800),
(4,'Oriente',0.016,2200),
(5,'Occidente',0.013,1700);


-- Tabla repartidor

INSERT INTO repartidor (id, estado, id_zona) VALUES
(16,'disponible',1),
(17,'disponible',2),
(18,'no disponible',3),
(19,'disponible',4),
(20,'no disponible',5);

-- Tabla unidad_medida

INSERT INTO unidad_medida (id, nombre) VALUES
(1,'gramos'),
(2,'litros'),
(3,'unidades'),
(4,'mililitros'),
(5,'kilogramos'),
(6,'piezas'),
(7,'onzas'),
(8,'tazas'),
(9,'cucharadas'),
(10,'cucharaditas'),
(11,'bolsas'),
(12,'cajas'),
(13,'porciones'),
(14,'botes'),
(15,'paquetes'),
(16,'rodajas'),
(17,'rebanadas'),
(18,'ml'),
(19,'latas'),
(20,'barras');

-- Tabla ingrediente

INSERT INTO ingrediente (nombre, precio, stock, id_unidad_medida) VALUES
('Queso mozzarella',12.5,300,1),
('Jamón',9.2,200,1),
('Pepperoni',11.0,250,1),
('Piña',4.3,150,1),
('Tocino',13.0,180,1),
('Salsa de tomate',3.2,500,4),
('Champiñones',5.8,120,1),
('Cebolla',2.5,400,1),
('Pimiento',3.1,350,1),
('Pollo',10.5,220,1),
('Carne molida',11.5,210,1),
('Aceitunas',6.4,180,1),
('Maíz',2.7,160,1),
('Queso parmesano',14.0,100,1),
('Orégano',1.5,80,1),
('Ajo',1.2,90,1),
('Salami',10.8,140,1),
('Tomate fresco',3.5,180,1),
('Albahaca',2.4,50,1),
('Extra queso',12.0,300,1);

-- Tabla pizza

INSERT INTO pizza (nombre, tam, precio_actual, tipo) VALUES
('Margarita','Mediana',18000,'clasica'),
('Pepperoni','Grande',28000,'clasica'),
('Hawaiana','Mediana',23000,'especial'),
('Mixta','Grande',30000,'especial'),
('Vegetariana','Grande',26000,'vegetariana'),
('Carnes','Grande',32000,'especial'),
('Pollo BBQ','Mediana',24000,'especial'),
('Mexicana','Grande',31000,'especial'),
('Napolitana','Mediana',20000,'clasica'),
('Triple Queso','Grande',27000,'clasica'),
('Criolla','Mediana',23000,'especial'),
('Suprema','Grande',33000,'especial'),
('Italiana','Mediana',25000,'especial'),
('Campesina','Grande',27000,'clasica'),
('Picante','Mediana',24000,'especial'),
('Del Chef','Grande',34000,'especial'),
('Primavera','Mediana',22000,'vegetariana'),
('Mediterránea','Grande',29000,'vegetariana'),
('Doble Carne','Grande',35000,'especial'),
('Clásica','Mediana',19000,'clasica');

-- Tabla ingrediente  pizza

INSERT INTO ingrediente_pizza (cantidad_ingrediente, id_pizza, id_ingrediente) VALUES
(80,1,1),(20,1,6),(10,1,15),
(90,2,1),(40,2,3),(10,2,15),
(80,3,1),(30,3,3),(30,3,4),
(100,4,1),(40,4,3),(40,4,7),
(70,5,1),(40,5,8),(20,5,9),
(90,6,1),(40,6,10),(40,6,11),
(80,7,1),(40,7,10),(20,7,5);


-- Tabla pago

INSERT INTO pago (metodo_pago, estado) VALUES
('efectivo','pagado'),
('tarjeta','pagado'),
('app','no pagado'),
('efectivo','pagado'),
('tarjeta','no pagado'),
('app','pagado'),
('efectivo','pagado'),
('tarjeta','pagado'),
('app','no pagado'),
('efectivo','pagado'),
('efectivo','pagado'),
('tarjeta','pagado'),
('app','pagado'),
('tarjeta','no pagado'),
('efectivo','pagado'),
('app','pagado'),
('efectivo','no pagado'),
('tarjeta','pagado'),
('app','pagado'),
('efectivo','pagado');

-- Tabla domicilio

INSERT INTO domicilio (distancia, hora_salida_repartidor, hora_entrega, direccion, costo_envio, id_zona) VALUES
(500,'2025-01-10 18:00','2025-01-10 18:10','Calle 1 #10-20',2000,1),
(800,'2025-01-10 18:05','2025-01-10 18:20','Calle 2 #11-21',2600,2),
(1200,'2025-01-10 18:10','2025-01-10 18:30','Calle 3 #12-22',3000,3),
(400,'2025-01-10 18:15','2025-01-10 18:25','Calle 4 #13-23',1800,1),
(700,'2025-01-10 18:20','2025-01-10 18:35','Calle 5 #14-24',2500,2),
(900,'2025-01-10 18:25','2025-01-10 18:40','Calle 6 #15-25',2800,3),
(1300,'2025-01-10 18:30','2025-01-10 18:55','Calle 7 #16-26',3300,4),
(300,'2025-01-10 18:35','2025-01-10 18:45','Calle 8 #17-27',1700,5),
(500,'2025-01-10 18:40','2025-01-10 18:50','Calle 9 #18-28',2000,1),
(600,'2025-01-10 18:45','2025-01-10 18:57','Calle 10 #19-29',2200,2),

(900,'2025-01-11 12:10','2025-01-11 12:25','Calle 11 #10-20',2800,3),
(1100,'2025-01-11 12:15','2025-01-11 12:35','Calle 12 #11-21',3100,4),
(400,'2025-01-11 12:20','2025-01-11 12:30','Calle 13 #12-22',1800,1),
(500,'2025-01-11 12:25','2025-01-11 12:40','Calle 14 #13-23',2000,2),
(750,'2025-01-11 12:30','2025-01-11 12:45','Calle 15 #14-24',2600,3),
(650,'2025-01-11 12:35','2025-01-11 12:48','Calle 16 #15-25',2400,4),
(950,'2025-01-11 12:40','2025-01-11 13:00','Calle 17 #16-26',2900,5),
(1200,'2025-01-11 12:45','2025-01-11 13:05','Calle 18 #17-27',3300,4),
(300,'2025-01-11 12:50','2025-01-11 13:00','Calle 19 #18-28',1700,2),
(450,'2025-01-11 12:55','2025-01-11 13:05','Calle 20 #19-29',1900,1);

-- Tabla pedido

INSERT INTO pedido (fecha, estado, total_pedido, id_cliente, id_pago, id_domicilio, id_repartidor, id_usuario)
VALUES
('2025-01-10 18:10','entregado',30000,1,1,1,16,11),
('2025-01-10 18:20','entregado',28000,2,2,2,17,11),
('2025-01-10 18:30','entregado',33000,3,3,3,18,12),
('2025-01-10 18:25','entregado',24000,4,4,4,16,12),
('2025-01-10 18:35','en preparacion',26000,5,5,5,17,11),
('2025-01-10 18:40','pendiente',31000,6,6,6,18,14),
('2025-01-10 18:55','entregado',34000,7,7,7,19,14),
('2025-01-10 18:45','entregado',22000,8,8,8,20,11),
('2025-01-10 18:50','entregado',27000,9,9,9,16,13),
('2025-01-10 18:57','pendiente',30000,10,10,10,17,15),

('2025-01-11 12:25','entregado',26000,1,11,11,18,11),
('2025-01-11 12:35','entregado',28000,2,12,12,19,12),
('2025-01-11 12:30','entregado',33000,3,13,13,20,12),
('2025-01-11 12:40','en preparacion',25000,4,14,14,16,13),
('2025-01-11 12:45','pendiente',29000,5,15,15,17,13),
('2025-01-11 12:48','entregado',32000,6,16,16,18,14),
('2025-01-11 13:00','entregado',31000,7,17,17,19,14),
('2025-01-11 13:05','entregado',35000,8,18,18,20,15),
('2025-01-11 13:00','entregado',20000,9,19,19,16,11),
('2025-01-11 13:05','pendiente',27000,10,20,20,17,11);

-- Tabla detalle_pedido

INSERT INTO detalle_pedido (precio_unitario, cantidad, subtotal, id_pedido, id_pizza) VALUES
(18000,1,18000,1,1),
(28000,1,28000,2,2),
(33000,1,33000,3,4),
(24000,1,24000,4,7),
(26000,1,26000,5,5),
(31000,1,31000,6,8),
(34000,1,34000,7,16),
(22000,1,22000,8,17),
(27000,1,27000,9,10),
(30000,1,30000,10,19),

(26000,1,26000,11,5),
(28000,1,28000,12,9),
(33000,1,33000,13,12),
(25000,1,25000,14,13),
(29000,1,29000,15,18),
(32000,1,32000,16,6),
(31000,1,31000,17,11),
(35000,1,35000,18,20),
(20000,1,20000,19,1),
(27000,1,27000,20,15);
