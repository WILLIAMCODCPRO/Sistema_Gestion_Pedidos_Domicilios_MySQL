CREATE DATABASE pizzeria_don_piccoro; -- Crear la base de datos

USE pizzeria_don_piccoro; -- Cambiar a la base de datos

-- Crear tabla persona

CREATE TABLE persona (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    telefono VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL
);

-- Crear tabla usuario

CREATE TABLE usuario{
    id INT
    usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id) REFERENCES persona(id)
}

-- Crear tabla cliente

CREATE TABLE cliente (
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES persona(id)
);

-- Crear tabla pizza

CREATE TABLE pizza (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tam VARCHAR(50) NOT NULL,
    precio_actual DOUBLE NOT NULL,
    tipo ENUM('vegetariana','especial','clasica') NOT NULL
);

-- Crear tabla unidad_medida

CREATE TABLE unidad_medida (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear tabla ingrediente

CREATE TABLE ingrediente (
    id INT PRIMARY KEY ,
    nombre VARCHAR(50) NOT NULL, 
    precio DOUBLE NOT NULL,
    stock INT NOT NULL,
    id_unidad_medida INT NOT NULL,
    FOREIGN KEY (id_unidad_medida) REFERENCES unidad_medida(id)
);

-- Crear tabla ingrediente_pizza

CREATE TABLE ingrediente_pizza (
    id INT PRIMARY KEY,
    cantidad_ingrediente DOUBLE NOT NULL,
    id_pizza INT NOT NULL,
    id_ingrediente INT NOT NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizza(id),
    FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id)
);

-- Crear tabla pago

CREATE TABLE pago (
    id INT PRIMARY KEY,
    metodo_pago ENUM('efectivo','tarjeta','app') NOT NULL, 
    estado ENUM('pagado','no pagado') NOT NULL     
);

-- Crear tabla zona

CREATE TABLE zona (
    id INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    costo_metro DOUBLE NOT NULL,
    costo_base DOUBLE NOT NULL
);

-- Crear tabla repartidor

CREATE TABLE repartidor (
    id INT PRIMARY KEY,
    estado ENUM('disponible','no disponible') NOT NULL,
    id_zona INT NOT NULL,
    FOREIGN KEY (id) REFERENCES persona(id),
    FOREIGN KEY (id_zona) REFERENCES zona(id)
);

-- Crear tabla domicilio

CREATE TABLE domicilio (
    id INT PRIMARY KEY,
    distancia DOUBLE NOT NULL,
    hora_salida_repartidor DATETIME,
    hora_entrega DATETIME,
    direccion VARCHAR(50) NOT NULL,
    costo_envio DOUBLE NOT NULL,
    id_zona INT NOT NULL,
    FOREIGN KEY (id_zona) REFERENCES zona(id)
);

-- Crear tabla pedido

CREATE TABLE pedido (
    id INT PRIMARY KEY,
    fecha DATETIME NOT NULL,
    estado ENUM('pendiente','en preparacion','entregado', 'cancelado') NOT NULL,
    total_pedido DOUBLE NOT NULL,
    id_cliente INT NOT NULL,
    id_pago INT NOT NULL,
    id_domicilio INT NOT NULL,
    id_repartidor INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_pago) REFERENCES pago(id),
    FOREIGN KEY (id_domicilio) REFERENCES domicilio(id),
    FOREIGN KEY (id_repartidor) REFERENCES repartidor(id),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Crear tabla detalle_pedido

CREATE TABLE detalle_pedido (
    id INT PRIMARY KEY,
    precio_unitario DOUBLE NOT NULL,
    cantidad INT NOT NULL,
    subtotal DOUBLE NOT NULL,
    id_pedido INT NOT NULL,
    id_pizza INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id),
    FOREIGN KEY (id_pizza) REFERENCES pizza(id)
);

-- Crear tabla historial_precio

CREATE TABLE historial_precio (
    id INT PRIMARY KEY,
    precio_antiguo DOUBLE NOT NULL,
    precio_nuevo DOUBLE NOT NULL
);
