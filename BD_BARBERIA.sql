CREATE DATABASE BD_BARBERIA IF NOT EXIST

CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nombreUsuario NVARCHAR(100),
    correo NVARCHAR(100) UNIQUE,
    contrasena NVARCHAR(255),
    telefono NVARCHAR(20) UNIQUE
    rol ENUM('admin', 'barbero', 'cliente') NOT NULL
);

CREATE TABLE Productos (
    idProducto INT PRIMARY KEY AUTO_INCREMENT,
    nombreProducto NVARCHAR(100),
    descripcion TEXT,
    precioProducto DECIMAL(10,2),
    stock INT
);

CREATE TABLE Servicios (
    idServicio INT PRIMARY KEY AUTO_INCREMENT,
    nombreServicio NVARCHAR(100),
    descripcion TEXT,
    precioServicio DECIMAL(10,2),
    duracion INT
);

CREATE TABLE Ventas (
    idVenta INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
);

CREATE TABLE Citas (
    idCita INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    idBarbero INT NOT NULL,
    idServicio INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    estado ENUM('pendiente', 'confirmada', 'cancelada', 'completada') DEFAULT 'pendiente',
    notas TEXT,
    FOREIGN KEY (idCliente) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idBarbero) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idServicio) REFERENCES Servicios(idServicio),
    CHECK (idCliente <> idBarbero)
);

CREATE TABLE DetalleVentaProducto (
    idDetalle INT PRIMARY KEY AUTO_INCREMENT,
    idVenta INT,
    idProducto INT,
    cantidad INT,
    precioUnitario DECIMAL(10,2),
    FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta),
    FOREIGN KEY (idVroducto) REFERENCES Productos(idProducto)
);

CREATE TABLE DetalleVentaServicio (
    idDetalle INT PRIMARY KEY AUTO_INCREMENT,
    idVenta INT,
    idServicio INT,
    precioServicio DECIMAL(10,2),
    FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta),
    FOREIGN KEY (idServicio) REFERENCES Servicios(idServicio)
);

