DROP DATABASE IF EXISTS universal;
CREATE DATABASE universal;
use universal;

-- ####################################################################
-- I. ENTIDADES DE CONTENIDO Y OPERACIÓN (CORE)
-- ####################################################################

CREATE TABLE Parque (
    Parque_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Parque VARCHAR(100) NOT NULL UNIQUE,
    Ubicacion VARCHAR(100) NOT NULL
);

CREATE TABLE Cliente (
    Cliente_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(150) NOT NULL,
    Email VARCHAR(150) UNIQUE NOT NULL,
    Telefono VARCHAR(20)
);

CREATE TABLE Hotel (
    Hotel_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL UNIQUE,
    Categoria_Precio VARCHAR(50) NOT NULL, -- Ej: Premier, Prime Value
    Beneficios_Express_Gratis BOOLEAN NOT NULL,
    Costo_Base_Noche DECIMAL(10, 2) NOT NULL
);

-- ####################################################################
-- II. ENTIDADES DE CONTENIDO (RELACIONES 1:N CON PARQUE)
-- ####################################################################

CREATE TABLE Atraccion (
    Atraccion_ID INT PRIMARY KEY AUTO_INCREMENT,
    Parque_ID INT NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Tipo VARCHAR(50),
    Restriccion_Altura INT, -- En cm
    Tiempo_Fila_Promedio TIME, -- HH:MM:SS
    FOREIGN KEY (Parque_ID) REFERENCES Parque(Parque_ID)
);

CREATE TABLE Evento (
    Evento_ID INT PRIMARY KEY AUTO_INCREMENT,
    Parque_ID INT NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    Tipo_Evento VARCHAR(50), -- Ej: Desfile, Show, Festival
    Requiere_Boleto_Adicional BOOLEAN NOT NULL,
    FOREIGN KEY (Parque_ID) REFERENCES Parque(Parque_ID)
);

-- ####################################################################
-- III. ENTIDADES DE HORARIO (RELACIONES 1:N CON CONTENIDO)
-- ####################################################################

CREATE TABLE Horario_Parque (
    Horario_PK INT PRIMARY KEY AUTO_INCREMENT,
    Parque_ID INT NOT NULL,
    Dia_Semana VARCHAR(10) NOT NULL, -- Ej: Lunes, Martes
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    FOREIGN KEY (Parque_ID) REFERENCES Parque(Parque_ID),
    UNIQUE KEY UQ_Horario_Parque (Parque_ID, Dia_Semana) -- Un parque solo tiene 1 horario por día
);

CREATE TABLE Horario_Evento (
    Horario_EK INT PRIMARY KEY AUTO_INCREMENT,
    Evento_ID INT NOT NULL,
    Dia_Semana VARCHAR(10) NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    FOREIGN KEY (Evento_ID) REFERENCES Evento(Evento_ID)
);

-- ####################################################################
-- IV. ENTIDADES DE PRODUCTO
-- ####################################################################

CREATE TABLE Paquete (
    Paquete_ID INT PRIMARY KEY AUTO_INCREMENT,
    Hotel_ID INT,
    Nombre_Paquete VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT,
    Descuento_Aplicado DECIMAL(5, 2), -- Porcentaje de descuento
    Precio_Base DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES hotel(Hotel_ID)
);

CREATE TABLE Boleto (
    Boleto_ID INT PRIMARY KEY AUTO_INCREMENT,
    Paquete_ID INT, -- Opcional: FK si el boleto es parte de un paquete
    Tipo_Boleto VARCHAR(50) NOT NULL, -- Ej: 1 Día, 3 Días
    Opcion_ParkToPark BOOLEAN NOT NULL,
    Precio_Base DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Paquete_ID) REFERENCES Paquete(Paquete_ID)
);

-- ####################################################################
-- V. TABLAS DE UNIÓN (RELACIONES N:M Y TRANSACCIONES)
-- ####################################################################

-- 1. Acceso_Boleto_Parque: Define qué parques cubre un tipo de Boleto
CREATE TABLE Acceso_Boleto_Parque (
    Acceso_ID INT PRIMARY KEY AUTO_INCREMENT,
    Boleto_ID INT NOT NULL,
    Parque_ID INT NOT NULL,
    Dias_Incluidos INT NOT NULL, -- Cuántos días de parque incluye este tipo de boleto
    FOREIGN KEY (Boleto_ID) REFERENCES Boleto(Boleto_ID),
    FOREIGN KEY (Parque_ID) REFERENCES Parque(Parque_ID),
    UNIQUE KEY UQ_Boleto_Acceso (Boleto_ID, Parque_ID)
);

-- 2. Compra_Boleto: Transacción de venta de boletos individuales
CREATE TABLE Compra_Boleto (
    Compra_ID INT PRIMARY KEY AUTO_INCREMENT,
    Cliente_ID INT NOT NULL,
    Boleto_ID INT NOT NULL,
    Fecha_Compra DATE NOT NULL,
    Monto_Pagado DECIMAL(10, 2) NOT NULL,
    Metodo_Pago VARCHAR(50),
    Nm_Boletos INT NOT NULL,
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(Cliente_ID),
    FOREIGN KEY (Boleto_ID) REFERENCES Boleto(Boleto_ID)
);

-- 3. Compra_Paquete: Transacción de venta de paquetes (liga Cliente, Paquete y Hotel)
CREATE TABLE Compra_Paquete (
    Transaccion_ID INT PRIMARY KEY AUTO_INCREMENT,
    Cliente_ID INT NOT NULL,
    Paquete_ID INT NOT NULL,
    Fecha_CheckIn DATE NOT NULL,
    Fecha_CheckOut DATE NOT NULL,
    Monto_Total DECIMAL(10, 2) NOT NULL,
    Metodo_Pago VARCHAR(50),
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(Cliente_ID),
    FOREIGN KEY (Paquete_ID) REFERENCES Paquete(Paquete_ID)
);