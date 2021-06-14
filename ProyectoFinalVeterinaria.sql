USE MASTER;
GO
IF DB_ID (N'ProyectoFinalVeterinaria') IS NOT NULL
DROP DATABASE ProyectoFinalVeterinaria;
GO
CREATE DATABASE ProyectoFinalVeterinaria
ON 
(NAME = ProyectoFinalVeterinaria_dat,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProyectoFinalVeterinaria.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH =5)
LOG ON
(NAME = ProyectoFinalVeterinaria_log,
FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ProyectoFinalVeterinaria.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH =5MB);
GO
USE ProyectoFinalVeterinaria;
GO
--------------------------------//TABLAS//------------------------------------
CREATE TABLE Local
(
idLocal int IDENTITY(1,1),
nombre varchar (50)NOT NULL,
telefono varchar(20)NOT NULL,
direccion varchar(200) NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_Local PRIMARY KEY (idLocal)
);
--

CREATE TABLE Empleado
(
idEmpleado int IDENTITY(1,1),
rfc varchar(20)NOT NULL,
nombre varchar(50)NOT NULL,
apellidoPaterno varchar(50)NOT NULL,
apellidoMaterno varchar(50)NOT NULL,
telefono varchar (20)NOT NULL,
estatus bit DEFAULT 1,
--Llave foranea, proveniente de la tabla Local
idLocal int NOT NULL

CONSTRAINT PK_Empleado PRIMARY KEY (idEmpleado)
);
--

CREATE TABLE DueñoMascota
(
idDueñoMascota int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
apellidoPaterno varchar(50)NOT NULL,
apellidoMaterno varchar(50)NOT NULL,
telefono varchar (20)NOT NULL,
direccion varchar(200)NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_DueñoMascota PRIMARY KEY (idDueñoMascota)
);
--

CREATE TABLE Servicio
(
idServicio int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
tipoServicio varchar (50) NOT NULL,
descripcion text NOT NULL,
precio  decimal (10,2) NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_Servicio PRIMARY KEY (idServicio)
);
--

CREATE TABLE ProveedorProducto
(
idProveedorProducto int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
direccion varchar(200)NOT NULL,
telefono varchar (20)NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_ProveedorProducto PRIMARY KEY (idProveedorProducto)
);
--
CREATE TABLE MarcaProducto
(
idMarcaProducto int IDENTITY(1,1),
nombreMarca varchar(50)NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_MarcaProducto PRIMARY KEY (idMarcaProducto)
);
--

CREATE TABLE Producto
(
idProducto int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
tipoProducto varchar(50)NOT NULL,
descripcion text NOT NULL,
precio  decimal (10,2) NOT NULL,
stock int NOT NULL,
estadoStock varchar (200),
estatus bit DEFAULT 1,
--Llave foranea, proveniente de la tabla proveedorProducto
idMarcaProducto int NOT NULL,
idProveedorProducto int NOT NULL


CONSTRAINT PK_Producto PRIMARY KEY (idProducto)
);
--

CREATE TABLE Raza
(
idRaza int IDENTITY(1,1),
nombreRaza varchar(50)NOT NULL,
especie varchar(50)NOT NULL,
color varchar(200)NOT NULL,
tamañoPromedio varchar(100)NOT NULL,
pesoPromedio varchar(100)NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_Raza PRIMARY KEY (idRaza)
);
--

CREATE TABLE Mascota
(
idMascota int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
sexo varchar(20)NOT NULL,
edad varchar(20)NOT NULL,
longitud varchar(20)NOT NULL,
peso varchar(20)NOT NULL,
fechaNacimiento date NOT NULL,
estatus bit DEFAULT 1,
--Llaves foraneas provenientes de la tabla dueño mascota y raza 
idDueñoMascota int NOT NULL,
idRaza int NOT NULL

CONSTRAINT PK_Mascota PRIMARY KEY (idMascota)
);
--

CREATE TABLE ServicioSugerido
(
idServicioSugerido int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
descripcion text NOT NULL,
precio  decimal (10,2) NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_ServicioSugerido PRIMARY KEY (idServicioSugerido)
);
--

CREATE TABLE Enfermedad
(
idEnfermedad int IDENTITY(1,1),
codigoEnfermedad varchar(11)NOT NULL,
nombre varchar(50)NOT NULL,
descripcion text NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_Enfermedad PRIMARY KEY (idEnfermedad)
);
--

CREATE TABLE Consulta
(
idConsulta int IDENTITY(1,1),
fecha date NOT NULL,
horaInicio time NOT NULL,
horaFin time NOT NULL,
estatus bit DEFAULT 1,
--Llaves foraneas provenientes de tabla dueño de mascota y empleado
idDueñoMascota int NOT NULL,
idEmpleado int NOT NULL
CONSTRAINT PK_Consulta PRIMARY KEY (idConsulta)
);
--

CREATE TABLE Factura
(
idFactura int IDENTITY(1,1),
noFactura int NOT NULL,
descripcion text NOT NULL,
totalPagar  decimal (10,2) NOT NULL,
estatus bit DEFAULT 1,
--Llave foranea proveniente de tabla dueño de mascota
idDueñoMascota int NOT NULL

CONSTRAINT PK_Factura PRIMARY KEY (idFactura)
);
--

CREATE TABLE Tratamiento
(
idTratamiento int IDENTITY(1,1),
descripcion text NOT NULL,
estatus bit DEFAULT 1,
--llave foranea proveniente de tabla empleado
idEmpleado int NOT NULL,
idMascota int NOT NULL
CONSTRAINT PK_Tratamiento PRIMARY KEY (idTratamiento)
);
--

CREATE TABLE ProveedorMedicina
(
idProveedorMedicina int IDENTITY(1,1),
nombre varchar(50)NOT NULL,
direccion varchar(200)NOT NULL,
telefono varchar (20)NOT NULL,
estatus bit DEFAULT 1

CONSTRAINT PK_ProveedorMedicina PRIMARY KEY (idProveedorMedicina)
);
--

CREATE TABLE Medicina
(
idMedicina int IDENTITY(1,1),
nombre varchar (50)NOT NULL,
descripcion text NOT NULL,
estatus bit DEFAULT 1,
--Llave fornaea proveniente de tabla proveedor de medicina
idProveedorMedicina int NOT NULL
CONSTRAINT PK_Medicina PRIMARY KEY (idMedicina)
);
--

---------------------->TABLAS NM<----------------------
CREATE TABLE EmpleadoServicio
(
idEmpleadoServicio int IDENTITY(1,1),
idEmpleado int NOT NULL,
idServicio int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_EmpleadoServicio PRIMARY KEY (idEmpleadoServicio)
);

--

CREATE TABLE EmpleadoProducto
(
idEmpleadoProducto int IDENTITY(1,1),
idEmpleado int NOT NULL,
idProducto int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_EmpleadoProducto PRIMARY KEY (idEmpleadoProducto)
);

--

CREATE TABLE MascotaServicio
(
idMascotaServicio int IDENTITY(1,1),
idMascota int NOT NULL,
idServicio int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_MascotaServicio PRIMARY KEY (idMascotaServicio)
);

--

CREATE TABLE RazaServicioSugerido
(
idRazaServicioSugerido int IDENTITY(1,1),
idRaza int NOT NULL,
idServicioSugerido int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_RazaServicioSugerido PRIMARY KEY (idRazaServicioSugerido)
);

--

CREATE TABLE MascotaEnfermedad
(
idMascotaEnfermedad int IDENTITY(1,1),
idMascota int NOT NULL,
idEnfermedad int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_MascotaEnfermedad PRIMARY KEY (idMascotaEnfermedad)
);

--

CREATE TABLE FacturaEmpleado
(
idFacturaEmpleado int IDENTITY(1,1),
idFactura int NOT NULL,
idEmpleado int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_FacturaEmpleado PRIMARY KEY (idFacturaEmpleado)
);

--

CREATE TABLE MedicinaTratamiento
(
idMedicinaTratamiento int IDENTITY(1,1),
idMedicina int NOT NULL,
idTratamiento int NOT NULL,
estatus bit DEFAULT 1
CONSTRAINT PK_MedicinaTratamiento PRIMARY KEY (idMedicinaTratamiento)
);

--


-------------------------------///INDEX///-----------------------------
CREATE INDEX  IX_Local ON Local  (idLocal);
GO
CREATE INDEX  IX_Empleado ON Empleado  (idEmpleado);
GO
CREATE INDEX  IX_DueñoMascota ON DueñoMascota  (idDueñoMascota);
GO
CREATE INDEX  IX_Servicio ON Servicio  (idServicio);
GO
CREATE INDEX  IX_ProveedorProducto ON ProveedorProducto  (idProveedorProducto);
GO
CREATE INDEX  IX_MarcaProducto ON MarcaProducto  (idMarcaProducto);
GO
CREATE INDEX  IX_Producto ON Producto  (idProducto);
GO
CREATE INDEX  IX_Raza ON Raza  (idRaza);
GO
CREATE INDEX  IX_Mascota ON Mascota  (idMascota);
GO
CREATE INDEX  IX_ServicioSugerido ON ServicioSugerido  (idServicioSugerido);
GO
CREATE INDEX  IX_Enfermedad ON Enfermedad  (idEnfermedad);
GO
CREATE INDEX  IX_Consulta ON Consulta  (idConsulta);
GO
CREATE INDEX  IX_Factura ON Factura  (idFactura);
GO
CREATE INDEX  IX_Tratamiento ON Tratamiento  (idTratamiento);
GO
CREATE INDEX  IX_ProveedorMedicina ON ProveedorMedicina  (idProveedorMedicina);
GO
CREATE INDEX  IX_Medicina ON Medicina  (idMedicina);
GO

--INDICES DE TABLAS NM--
CREATE INDEX  IX_EmpleadoServicio ON EmpleadoServicio  (idEmpleadoServicio);
GO
CREATE INDEX  IX_EmpleadoProducto ON EmpleadoProducto  (idEmpleadoProducto);
GO
CREATE INDEX  IX_MascotaServicio ON MascotaServicio  (idMascotaServicio);
GO
CREATE INDEX  IX_RazaServicioSugerido ON RazaServicioSugerido  (idRazaServicioSugerido);
GO
CREATE INDEX  IX_MascotaEnfermedad ON MascotaEnfermedad  (idMascotaEnfermedad);
GO
CREATE INDEX  IX_FacturaEmpleado ON FacturaEmpleado  (idFacturaEmpleado);
GO
CREATE INDEX  IX_MedicinaTratamiento ON MedicinaTratamiento  (idMedicinaTratamiento);
GO

---------------------------///RELACIONES///-----------------
ALTER TABLE Empleado
ADD CONSTRAINT FK_EmpleadoLocal
FOREIGN KEY (idLocal) REFERENCES Local (idLocal);
GO
ALTER TABLE Producto
ADD CONSTRAINT FK_ProductoMarcaProducto
FOREIGN KEY (idMarcaProducto) REFERENCES MarcaProducto (idMarcaProducto);
GO
ALTER TABLE Producto
ADD CONSTRAINT FK_ProductoProveedorProducto
FOREIGN KEY (idProveedorProducto) REFERENCES ProveedorProducto (idProveedorProducto);
GO
ALTER TABLE Mascota
ADD CONSTRAINT FK_MascotaDueñoMascota
FOREIGN KEY (idDueñoMascota) REFERENCES DueñoMascota (idDueñoMascota);
GO
ALTER TABLE Mascota
ADD CONSTRAINT FK_MascotaRaza
FOREIGN KEY (idRaza) REFERENCES Raza (idRaza);
GO
ALTER TABLE Consulta
ADD CONSTRAINT FK_ConsultaDueñoMascota
FOREIGN KEY (idDueñoMascota) REFERENCES DueñoMascota (idDueñoMascota);
GO
ALTER TABLE Consulta
ADD CONSTRAINT FK_ConsultaEmpleado
FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado);
GO
ALTER TABLE Factura
ADD CONSTRAINT FK_FacturaDueñoMascota
FOREIGN KEY (idDueñoMascota) REFERENCES DueñoMascota (idDueñoMascota);
GO
ALTER TABLE Tratamiento
ADD CONSTRAINT FK_TratamientoEmpleado
FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado);
GO
ALTER TABLE Tratamiento
ADD CONSTRAINT FK_TratamientoMascota
FOREIGN KEY (idMascota) REFERENCES Mascota (idMascota);
GO
ALTER TABLE Medicina
ADD CONSTRAINT FK_MedicinaProveedorMedicina
FOREIGN KEY (idProveedorMedicina) REFERENCES ProveedorMedicina (idProveedorMedicina);
GO
------TABLAS NM --------
ALTER TABLE EmpleadoServicio
ADD CONSTRAINT FK_EmpleadoServicioEmpleado
FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado);
GO
ALTER TABLE EmpleadoServicio
ADD CONSTRAINT FK_EmpleadoServicioServicio
FOREIGN KEY (idServicio) REFERENCES Servicio (idServicio);
GO
--
ALTER TABLE EmpleadoProducto
ADD CONSTRAINT FK_EmpleadoProductoEmpleado
FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado);
GO
ALTER TABLE EmpleadoProducto
ADD CONSTRAINT FK_EmpleadoProductoProducto
FOREIGN KEY (idProducto) REFERENCES Producto (idProducto);
GO
--
ALTER TABLE MascotaServicio
ADD CONSTRAINT FK_MascotaServicioMascota
FOREIGN KEY (idMascota) REFERENCES Mascota (idMascota);
GO
ALTER TABLE MascotaServicio
ADD CONSTRAINT FK_MascotaServicioServicio
FOREIGN KEY (idServicio) REFERENCES Servicio (idServicio);
GO
--
ALTER TABLE RazaServicioSugerido
ADD CONSTRAINT FK_RazaServicioSugeridoRaza
FOREIGN KEY (idRaza) REFERENCES Raza (idRaza);
GO
ALTER TABLE RazaServicioSugerido
ADD CONSTRAINT FK_RazaServicioSugeridoServicioSugerido
FOREIGN KEY (idServicioSugerido) REFERENCES ServicioSugerido (idServicioSugerido);
GO
--
ALTER TABLE MascotaEnfermedad
ADD CONSTRAINT FK_MascotaEnfermedadMascota
FOREIGN KEY (idMascota) REFERENCES Mascota (idMascota);
GO
ALTER TABLE MascotaEnfermedad
ADD CONSTRAINT FK_MascotaEnfermedadEnfermedad
FOREIGN KEY (idEnfermedad) REFERENCES Enfermedad (idEnfermedad);
GO
--
ALTER TABLE FacturaEmpleado
ADD CONSTRAINT FK_FacturaEmpleadoFactura
FOREIGN KEY (idFactura) REFERENCES Factura (idFactura);
GO
--
ALTER TABLE FacturaEmpleado
ADD CONSTRAINT FK_FacturaEmpleadoEmpleado
FOREIGN KEY (idEmpleado) REFERENCES Empleado (idEmpleado);
GO
--
ALTER TABLE MedicinaTratamiento
ADD CONSTRAINT FK_MedicinaTratamientoMedicina
FOREIGN KEY (idMedicina) REFERENCES Medicina (idMedicina);
GO
--
ALTER TABLE MedicinaTratamiento
ADD CONSTRAINT FK_MedicinaTratamientoTratamiento
FOREIGN KEY (idTratamiento) REFERENCES Tratamiento (idTratamiento);
GO
--

------------------------------//POBLACION//------------------------------------
INSERT INTO Local(nombre,telefono, direccion)
values ('PetsHealt Condesa I', '555-564-55-95', 'Avenida de los Insurgentes Sur 345 CDMX, C.P. 06170'),
('PetsHealt Parque La Mexicana', '555-929-20-10 ', 'Lomas de Santa Fe Contadero CDMX, C.P. 01219'),
('PetsHealt Miyana', '555-545-00-43 ', 'Avenida Ejército Nacional #769 Miguel Hidalgo CDMX,  C.P. 11520'),
('PetsHealt Paseo Hipódromo', ' 555-925-80-65 ', 'Avenida del Conscripto 360 CDMX, C.P. 53900'),
('PetsHealt Echegaray', '555-204-60-81', 'Hacienda de la Encarnación 6 CDMX, C.P. 53300')

INSERT INTO Empleado (rfc, nombre, apellidoPaterno, apellidoMaterno, telefono,idLocal)
VALUES ('GOMM8305281H0', ' Miguel Angel','Gomez','Martinez', '866-136-36-36', 1), --v
('JIRM8987281M0', ' Maria Pilar','Jimenez','Ruiz', '866-154-25-20', 1), --A
('FETH5551921P2', 'Hector raul', 'Fernandez','Tejera', '866-192-25-25', 2), --V
('PEAH8305281H3', 'Juan carlos', 'Pereira', 'Acuña', '866-127-23-23', 2), --A
('HUEFV999981O0', 'Veronica', 'Huertas', 'Fuentes', '866-123-23-22', 3), --V
('AMRM7092771U7', 'María luisa', 'Amonte', 'Rodriguez', '866-134-62-82', 3), --A
('CLMR8777781U8', 'Rosanna Elizabeth', 'Cilento','Machado', '866-136-00-01', 4), --V
('DEGL8382281N7', ' Luis leonardo ', 'De maría', ' Gonzalez' , '866-111-60-82', 4),--A
('DACD8305281V0',  'Darnel ', '  D´alexandre ' , ' Covarrubias ', '866-222-22-82', 5),--V
('GOIL8305282H0', 'Luis', 'Gonzalez', 'Iguini' , '866-333-33-33', 5)--A


INSERT INTO DueñoMascota(nombre, apellidoPaterno, apellidoMaterno, telefono, direccion)
VALUES ('Adil', 'Luna', 'Nieto','866-253-48-56', 'Miguel Hidalgo #268, Leandro Valle'),--1
('Mariana', 'Mellado', 'Diaz','866-388-48-28', 'AV Universidad #610, Universidad sur'),--2
('Arely Aide','Covarrubias', 'Garcia', '866-136-60-09', 'Abasolo #543, Zona Centro'),--3
( 'Arisbeth','Leija','Garza','866-168-16-56', 'Ocampo #233, Guadalupe Norte'),--4
('Humberto ramàn', 'Laluz','Torres','866-898-01-03', 'AV Nueva España #4007, Tres de Mayo'),--5
('Daniel', 'Rodriguez', 'Martino','866-136-60-82', 'Lazaro Cardenas #525, Durango Centro'), --6
('Maria Graciela', 'Hernandez', 'Gimenez','866-982-99-99', ' Miguel Aranda #611, Zona Centro'), --7
('Silvana  jacquline', 'Nuñez', 'Sosa','866-982-99-09', 'Blvd Norte #4212, Las Cuartillas'),--8
('Gerardo', 'Bonilla', 'Cabrera','866-665-79-09', 'Lazaro Cardenas #1727, Del Sur'),--9
('Gabriela', 'Seade', 'Sosa','866-002-09-09', ' AV Insurgentes NO. 43 S/N, Hornos Insurgentes,'),--10
('Alejandro andres', 'Ferrari', 'Gutierrez','866-178-99-09', 'AV Rio San Pedro Norte 604-A, Zona Centro'),--11
('Jose Luis', 'Madera', 'Madera','866-999-48-56', ' Lazaro Cardenas #424, Durango Centro'),--12
('Jose Antonio', 'Barboza','Silva','866-198-01-02', 'Lazaro Cardenas #426, Durango Centro'),--13
('Vanessa', 'Suarez', 'Navarro','866-982-99-09', 'Lorenzo Garza 2880, Del Prado')--14

INSERT INTO Servicio(nombre, tipoServicio, descripcion, precio)
VALUES('Limpieza dental', 'Limpieza', 'DESC', 2000),
('Grooming (CH) ', 'Limpieza', 'Baño y corte de pelo para razas pequeñas ', 200),
('Grooming (M)', 'Limpieza', 'Baño y corte de pelo para razas medianas ', 300),
('Grooming (G)', 'Limpieza', 'Baño y corte de pelo para razas grandes ', 550),
('Corte de uñas', 'Estetica', 'Corte de uñas para gatos y perros', 70),
('Limpieza de orejas', 'Limpieza', 'Limpieza de orejas para perros y gatos',50),
('Vacunación cuadro completo', 'Salud',' Parvovirus , Tetravalente y Rabia',700),
('Vacunación', 'Salud',' Parvovirus , Tetravalente (no incluye rabia)',500),
('Consulta medica', 'Salud', 'Consulta medica para mascotas',200),
('Pensión con alimento', 'Salud', 'Hospedaje y alimento, el costo es por dia',450),
('Esterilizacion', 'Salud','Esterilizacion para mascotas',2000)

INSERT INTO ProveedorProducto (nombre,direccion, telefono)
VALUES('Petco', 'Boulevard Toluca Metepec 505 Toluca, Estado de México', '722-238-29-50'), --limpieza
('SuperPets', 'Avenida Ejército Nacional #769 Miguel Hidalgo CDMX', '722-866-232-09-21'), -- Accesorios
('PetsFood', 'Blvd Norte #4212, Las Cuartillas, CDMX', '722-238-023-223-32'), --Comida
('PetNaturals', 'Lazaro Cardenas #1727, Del Sur, CDMX', '722-238-023-444-32')--Entrenamiento

INSERT INTO MarcaProducto(nombreMarca)
VALUES('Vetriderm'),--Higiene 1
('TropiClean'), --Higiene 2
('Furminator'), --Higiene 3
('Kaytee'), --Accesorio 4
('You & Me'),--Accesorio 5
('Bond & Co'), --Accesorio 6
('Royal Canin'), -- Alimento  7
('Pro Plan')-- Alimento 8

INSERT INTO Producto(nombre, tipoProducto, descripcion, precio, stock, idMarcaProducto, idProveedorProducto,estadoStock)
VALUES
('Jabón Dermatológico para Perro y Gato 100g', 'Higiene', 'Disminuye la cantidad de bacterias y hongos presentes en la piel.', 109.00, 100, 1, 1, 'Suficiente cantidad en stock'),
('Shampoo Terapéutico para Perro y Gato  350 ml', 'Higiene', 'Ideal para mascotas con piel sensible, elimina bacterias', 225.00, 100, 1, 1, 'Suficiente cantidad en stock'),
('Espuma Baño en Seco para Perro y Gato, 400 ml', 'Higiene', 'Combate hongos y bacterias en la piel.', 255.00, 100, 2, 1, 'Suficiente cantidad en stock'),
('Colonia con Aroma a Talco para Perro y Gato', 'Higiene', 'Mantiene un buen aroma en las mascotas y desenrella el pelo', 15.00, 100, 2, 1, 'Suficiente cantidad en stock'),
('Deslanador de Pelo Corto para Perros Raza Mediana', 'Higiene', 'Elimina hasta el 99 % del pelo suelto procedente de la muda. ', 799.00, 100, 3, 1, 'Suficiente cantidad en stock'),
('Deslanador de Pelo Corto para Perros Raza Grande', 'Higiene', 'Elimina hasta el 99 % del pelo suelto procedente de la muda. ', 855.00, 100, 3, 1, 'Suficiente cantidad en stock'),

('Arnés y Correa Elástica', 'Accesorios', 'Arnés comodo y elástico para pasear, tamaño mediano', 240.00, 100, 4, 2, 'Suficiente cantidad en stock'),
('Bebedero, 946 ml', 'Accesorios', 'Ideal para hámster, chinchilla, rata, hurón u otro animal pequeño', 135.00, 100, 4, 2, 'Suficiente cantidad en stock'),
('Plato de Cerámica Blanco', 'Accesorios', 'Plato de cerámica para mascotas', 76.00, 100, 5, 2, 'Suficiente cantidad en stock'),
('Mochila Floral Rosa, Grande', 'Accesorios', 'Diseño con abertura en la parte superior para ser usado con correa.', 162.00, 100, 6, 2, 'Suficiente cantidad en stock'),
('Set Cascabel para Collar de Gato', 'Accesorios', '2 Piezas, Fija fácilmente a su collar.', 45.00, 100, 6, 2, 'Suficiente cantidad en stock'),
('Cama Dona, 16.5 cm Diámetro', 'Accesorios', 'Para perros y gatos', 250.00, 100, 5, 2, 'Suficiente cantidad en stock'),

('Alimento Seco para Perro Adulto 6.3 kg', 'Alimento', 'Alimento hecho para razas pequeñas de no mas de 10 kg de peso en su edad adulta', 948.00, 100, 7, 3, 'Suficiente cantidad en stock'),
('Alimento natural para todas las edades, 11 kg', 'Alimento', ' Alimento Natural para todas las Etapas de Vida Receta Salmón y Chícharo', 1200.00, 100, 7, 3, 'Suficiente cantidad en stock'),
('Alimento Seco para Gato Adulto, 3kg', 'Alimento', 'Alimento para gato adulto, ayuda a acidificar la orina para disolver los cálculos de estruvita.', 680.00, 100, 8, 3, 'Suficiente cantidad en stock'),
('Alimento Natural para Gato Todas las Edades 5.4 kg', 'Alimento', 'Alimento Natural para Gato Receta de Pollo, su fórmula incluye antioxidantes y probióticos felinos', 770.00, 100, 8, 3, 'Suficiente cantidad en stock'),
('Alimento en Hojuelas para Peces Tropicales, 200 g', 'Alimento', 'contiene nutrientes esenciales y vitamina C para pez tropical', 452.00, 100, 8, 3, 'Suficiente cantidad en stock'),
('Alimento Balanceado para Periquitos, 800 g', 'Alimento', 'Nutribird B 14 es un alimento completo y equilibrado para periquitos pequeños y otros psitácidos en etapa de mantenimiento.', 210.00, 100, 8, 3, 'Suficiente cantidad en stock'),

('Masticables Calmantes para Perro ', 'Entrenamiento', 'Para mascotas expuestas a un aumento de estresores ambientales.', 295.00, 100, 5, 4, 'Suficiente cantidad en stock'),
('Tranquilizante para Mascotas, 59 ml', 'Entrenamiento', 'Trata eficazmente la ansiedad y el estrés de corto plazo en todo tipo de mascotas', 209.00, 100, 5, 4, 'Suficiente cantidad en stock')

INSERT INTO Raza(nombreRaza, especie, color, tamañoPromedio, pesoPromedio)
VALUES
('Teckel', 'Perro', ' rojo, rojo-amarillo, amarillo, bicolores negro o marrón y fuego', 'Entre 17 y 25 cm', 'Entre 3 y 9 kg'), --1
('Bichón frisé', 'Perro', 'Blanco puro', 'Entre 23 y 30 cm', 'Entre 4 y 7 kg'), --2
('Pomerania', 'Perro', 'blanco, marrón o negro, anaranjado, gris ', 'Entre 18 y 55 cm', 'Entre 3 y 20 kg'), --3
('Komondor', 'Perro', 'Marfil', 'Entre 65 y 70 cm (Hembras) y Entre 70 y 80 cm (Machos)', 'Entre 40 y 50 kg (Hembras), Entre 50 y 60 kg (Machos)'), --4
('Border collie', 'Perro', 'Manto bicolor blanco y negro, azul mirlo, rojo mirlo o rojo y blanco,', 'Entre 48 y 52 cm (Hembra), entre 50 y 55 cm (Macho)', 'Entre 15 y 20 kg'), --5

('Siamés', 'Gato', 'Foca, azul, chocolate, lila, canela, cervato', 'Aproximadamente 30 cm', 'Entre 2 y 5 kg'), --6
('Maine Coon', 'Gato', 'COLOR', 'Entre 20 y 36 cm (Hembra), entre 25 y 40 cm (Macho)', 'Entre 4 y 6 kg (Hembra), entre 5 y 8 kg (Macho)'), --7
('Bengala', 'Gato', 'Marrón atigrado, foca/sepia atigrado, foca/lince point, negro/plateado atigrado, foca/plateado/sepia atigrado, foca/plateado/mink atigrado', 'Aproximadamente 35 cm', 'Entre 4 y 6 kg (Hembra), Entre 5 y 7 kg (Macho)'),--8
('Bosque de Noruega', 'Gato', 'Negro, azul/gris pizarra, pelirrojo, crema, blanco, ámbar.', 'Entre 30 y 35 cm (Hembra), entre 35 y 40 cm (Macho)', 'Entre 4 y 6 kg (Hembra)Entre 5 y 8 kg (Macho)'), --9

('Conejo enano o toy', 'Conejo', 'Gris, negro, blanco o marrón', '25 cm Aproximadamete', '1.5 kg Aproximadamente'), --10
('Conejo Angora Inglés', 'Conejo', 'Blanco, canela o gris', '35 cm Aproximadamente', 'Entre 2,5 y 4 kg  Aproximadamente'), --11
('Conejo belier', 'Conejo', 'Blanco, canela, marrón y el gris o mezclas de dichos tonos', '34 a 50 cm Aproximadamente ', '1 a 3 kg Aproximadamente'),--12
('Conejo chinchilla', 'Conejo', ' Nace con un pelaje oscuro y pasando por un tono ceniza que culmina en un azul gisáceo', '25 cm Aproximadamente', 'Entre 1 y 2 kilogramos (Hembras), Entre 2 y 4 kg (Machos)')--13


INSERT INTO Mascota(nombre, sexo, edad, longitud, peso, fechaNacimiento, idDueñoMascota, idRaza)
VALUES('Hegel', 'Macho', '4 años', ' 45 cm', '10 kg', '2017-04-07', 2, 1),
('Brownie', 'Hembra', '3 años', '25 cm', '5 kg', '2018-06-17', 3, 2),
('Zowie', 'Hembra', '3 años', '25 cm', '4 kg', '2018-06-17', 3, 2),
('Jakie', 'Macho', '6', '55 cm', '20 kg', '2015-05-04', 1, 3),
('Arelo', 'Hembra', '5', '65 cm', '45 kg', '2014-07-12', 2, 4),
('Petrov', 'Macho', '2 meses', '15cm', '400 gr', '2021-04-04', 4, 5),

('Hanna', 'Hembra', '4 años', '25 cm', '4 kg', '2017-05-05', 7, 6),
('Collie', 'Macho', '1 año', '36 cm', '5 kg', '2020-01-04', 5, 7),
('Angora', 'Macho', '10 años', '38 cm', '6 kg', '2011-05-04', 6, 8),
('Lina', 'Hembra', '6', '35 cm', '5 kg', '2015-03-12', 9, 9),

('Conejo', 'Macho', '1 año', '25 cm', '1.5 kg', '2020-01-20', 12, 10),
('Wally', 'Macho', '10 años', '38 cm', '5 kg', '2011-05-04', 8, 11),
('Merry', 'Hembra', '8 años', '34 cm', '2 kg', '2013-05-04', 10, 12),
('Max', 'Macho', '1 año', '20cm', '900 gr', '2020-01-04', 11, 13),
('Ruby', 'Hembra', '1 año', '25cm', '1 kg', '2020-01-04', 11, 13),

('Henrry', 'Macho', '2 años', '25 cm', '9 kg', '2021-05-04', 13, 1),
('Canela', 'Hembra', '2 años', '17 cm', '5 kg ', '2019-01-04', 14, 1)


INSERT INTO ServicioSugerido(nombre, descripcion, precio)
VALUES('Desparacitación gato pequeño', ' Aplicación de una pipeta desparasitante que elimina parásitos en la piel, en los órganos internos y ayuda a prevenir el gusano del corazón.', 420.00),
('Desparacitación gato mediano', ' Aplicación de una pipeta desparasitante que elimina parásitos en la piel, en los órganos internos y ayuda a prevenir el gusano del corazón.', 450.00),
('Desparacitación perro pequeño', ' Aplicación de una pipeta desparasitante que elimina parásitos en la piel, en los órganos internos y ayuda a prevenir el gusano del corazón.', 420.00),
('Desparacitación perro mediano', ' El servicio de desparasitación consiste en la aplicación de pastilla o pasta desparasitante de una sola toma.', 180.00),
('Desparacitación perro grande', ' El servicio de desparasitación consiste en la aplicación de pastilla o pasta desparasitante de una sola toma.', 250.00),
('Desparacitación perro gigante', ' El servicio de desparasitación consiste en la aplicación de pastilla o pasta desparasitante de una sola toma.', 390.00)

INSERT INTO Enfermedad(codigoEnfermedad, nombre, descripcion)
VALUES
('ENFANIMAL01','Rabia', 'Enfermedad viral que puede afectar al cerebro y la médula espinal de todos los mamíferos, incluidos perros, gatos y personas.'), 
('ENFANIMAL02','Parvovirus', 'El virus ataca a las células que se están reproduciendo, como las del tracto intestinal, y se propaga a través de las heces. Es contagiosa'),
('ENFANIMAL03','Bordetella canina', 'Afecta principalmente al aparato respiratorio provocando tos, vomito, fiebre, letargo, perdida de apetito'),
('ENFANIMAL04','Giardia canina ', 'Provoca diarreas malolientes especialmente en perros jóvenes, mientras que los más mayores no suelen presentar síntomas'),
('ENFANIMAL05','Moquillo', 'Enfermedad muy contagiosa en perros debido a un virus parecido al del sarampión humano'),

--cats
('ENFANIMAL06','cistitis idiopática felina', 'Diagnóstico más común en gatos menores de 10 años de edad que padecen la enfermedad del tracto urinarioinferior'),
('ENFANIMAL07','Estreñimiento por bola de pelo en felinos', 'Ausencia de defecación, Vientre tenso y/o dolor abdominal'),
--
('ENFANIMAL08','Otitis o infeccion en oido', ' Afecta, primero al oído medio y luego al interno, produciendo inflamación, picor y dolor.'),
('ENFANIMAL09','Alopecia', 'Ausencia total o parcial de cabello en las zonas donde normalmente debería estar presente.')


--
INSERT INTO Consulta(fecha, horaInicio, horaFin, idDueñoMascota, idEmpleado)
VALUES ('2021-06-1', '9:30:00', '10:00:00', 1,1),
       ('2021-06-1', '10:30:00', '11:00:00', 2, 1),
	   ('2021-06-1', '11:00:00', '11:30:00', 3, 3),
	   ('2021-06-2', '9:30:00', '10:00:00', 4, 5),
	   ('2021-07-1', '10:30:00', '11:00:00', 5, 7),
	   ('2021-07-1', '12:30:59', '13:59:59', 6, 9),
	   ('2021-07-2', '12:30:59', '13:59:59', 7, 9),
	   ('2021-06-3', '9:30:00', '10:00:00', 8, 5),
	   ('2021-07-3', '10:30:00', '11:00:00', 9, 3),
	   ('2021-07-4', '7:30:59', '8:59:59', 10, 1),
	   ('2021-07-4', '9:30:59', '10:59:59', 11, 7),
	   ('2021-06-3', '10:30:00', '11:00:00', 12, 9),
	   ('2021-06-4', '10:30:00', '11:00:00', 13, 1),
	   ('2021-07-5', '12:30:59', '13:59:59', 14, 3)

--

INSERT INTO Factura(noFactura, descripcion, totalPagar, idDueñoMascota)
VALUES
(011, 'Factura1', 15.00, 1),
(012, 'Factura2', 2000.00, 2),
(013, 'Factura3', 1500.00, 3),
(014, 'Factura4', 300.00, 4),
(015, 'Factura2', 400.00, 5),
(016, 'Factura3', 200.00, 6),
(017, 'Factura4', 2000.00, 7),
(018, 'Factura2', 2000.00, 8),
(019, 'Factura3', 800.00, 9),
(0110, 'Factura4', 850.00, 10),
(0111, 'Factura5', 1500.00, 11),
(0112, 'Factura6', 2500.00, 12),
(0113, 'Factura7', 2500.00, 13),
(0114, 'Factura8', 1500.00, 14)

INSERT INTO Tratamiento(descripcion, idEmpleado, idMascota)
VALUES
('Aplicar vacuna para rabia canina', 1,5),
('Aplicar vacuna para rabia canina', 5,6),
('Aplicar vacuna contra el parvovirus', 1,16),
('Aplicar vacuna contra bordetella', 3,17),
('Aplicar vacuna contra moquillo', 1,1),
('Aplicar vacuna contra moquillo', 3,3),
('Aplicar vacuna contra moquillo', 1,4),
('Tratamiento de infeccion de tracto urinario. 20 gotas, 1 vez al dia por un mes', 9,7),
('Tratamiento de infeccion de tracto urinario. 20 gotas, 3 veces al dia por un mes', 1,9),
('Tratamiento laxante para felinos. 7.5 ml, 3 cucharadas al dia por 3 dias',7,8),
('Tratamiento laxante para felinos. 7.5 ml, 3 cucharadas al dia por 3 dias', 3,10),
('Tratamiento de gotas para otitis. 20 gotas 3 veces al dia durante un mes', 3,2),
('Tratamiento de gotas para otitis. 10 gotas diarias durante un mes', 9,11),
('Tratamiento de gotas para otitis. 8 gotas diarias durante un mes', 5,12),
('Tratamiento contra para la alopecia. Aplicar shampoo durante el baño, una vez por semana', 1,13),
('Tratamiento contra para la alopecia. Aplicar shampoo durante el baño, una o dos veces cada dos semanas', 7,14),
('Tratamiento contra para la alopecia. Aplicar shampoo durante el baño, una o dos veces por semana', 7,15)


INSERT INTO ProveedorMedicina( nombre, direccion, telefono)
VALUES('Virbac','Boulevard Toluca Metepec 505 Toluca, Estado de México', '722-238-29-50'), --Medicina canina
('ZoonGu','Avenida Ejército Nacional #769 Miguel Hidalgo CDMX', '722-866-232-09-21'), --Medicina canina
('BestLife4Pets','Blvd Norte #4212, Las Cuartillas, CDMX', '722-238-023-223-32'), --Medicina Felina
('Pets & Healt','Lazaro Cardenas #1727, Del Sur, CDMX', '722-238-023-444-32') 


INSERT INTO Medicina(nombre, descripcion, idProveedorMedicina)
VALUES('Vacuna contra rabia canina', 'Esquema de vacunación inicial para cachorros de 10 a 12 semanas y sirve como refuerzo para perros adultos (mayores a 1 año).', 1),
('Vacuna contra rabia felina', 'Esquema de vacunación inicial para cachorros de 3 a 4 meses y sirve como refuerzo para gatos adultos (mayores a 1 año).', 1),
('Vacuna contra parvovirus canino', 'Inmunización activa de perros sanos contra la parvovirosis, desde las 8 semanas de edad', 1),
('Vacuna contra bordetella canina', 'Esquema de vacunación inicial para cachorros de 14 a 16 semanas y sirve como refuerzo para perros adultos (mayores a 1 año).', 2),
('Vacuna contra la Giardia canina', 'Esquema de vacunación inicial para cachorros de 12 a 14 semanas y sirve como refuerzo para perros adultos (mayores a 1 año).', 2),
('Vacuna contra moquillo canino', 'Esquema de vacunación inicial para cachorros de 6 semanas y sirve como refuerzo a los 2,3,4 y 12 meses', 1),

('Gotas para Infección Tracto Urinario Gatos ', 'Tratamiento de un solo mes para gatos de todos los tamaños y edades', 3),
('Laxante para gatos', 'tratamiento y prevención de la constipación o colitis provocada por obstrucción del tracto gastrointestinal con bolas de pelo en felinos.', 3),

('Gotas para oidos omeopatia ', 'Tratamiento de solo un mes para curar infecciones en el oido en mascotas', 4),
('Shampoo contra la perdida de pelo en mascotas', 'Ayuda a reducir la caida de pelo y estimular el crecimiento del manto piloso', 4)

-- TABLAS NM ---
INSERT INTO EmpleadoServicio(idEmpleado, idServicio)
VALUES(2,1),
(4,1),
(6,1),
(8,1),
(10,1),
(2,2),
(4,2),
(6,2),
(8,2),
(10,2),
(2,3),
(4,3),
(6,3),
(8,3),
(10,3),
(2,4),
(4,4),
(6,4),
(8,4),
(10,4),
(2,5),
(4,5),
(6,5),
(8,5),
(10,6),
(2,6),
(4,6),
(6,11),
(8,11),
(10,11),
(2,10),
(4,10),
(6,10),
(8,10),
(10,10),
(1,7),
(3,7),
(5,7),
(7,7),
(9,7),
(1,8),
(3,8),
(5,8),
(7,8),
(1,9),
(3,9),
(5,9),
(7,9),
(9,9),
(1,11),
(3,11),
(5,11)


INSERT INTO EmpleadoProducto(idEmpleado, idProducto)
VALUES(2,1),
(4,2),
(6,3),
(6,4),
(8,5),
(10,6),
(2,7),
(4,8),
(2,9),
(10,10)

INSERT INTO MascotaServicio(idMascota, idServicio)
VALUES(1,3),
(2,1),
(3,1),
(11,6),
(12,6),
(1,6),
(1,3),
(2,2),
(4, 4),
(3,4),
(1,8),
(2,8),
(3,8),
(4,8)




INSERT INTO RazaServicioSugerido(idRaza, idServicioSugerido)
VALUES --Gatosyperrosporahora
(1,4),
(2,3),
(3,5),
(4,6),
(5,6),
(6,1),
(7,2),
(8,2),
(9,2)

INSERT INTO MascotaEnfermedad(idMascota, idEnfermedad)
VALUES(1,5),
(2,8),
(3,5),
(4,5),
(5,1),
(6,1),
(7,6),
(8,7),
(9,6),
(10,7),
(11,8),
(12,8),
(13,9),
(14,9),
(15,9),
(16,2),
(17,3)

INSERT INTO FacturaEmpleado(idFactura, idEmpleado)
VALUES(1,2),
(2,2),
(3,4),
(4,6),
(5,8),
(6,10),
(7,10),
(8,6),
(9,4),
(10,2),
(11,8),
(12,10),
(13,2),
(14,4)

INSERT INTO MedicinaTratamiento(idMedicina, idTratamiento)
VALUES(1,1),
(2,1),
(3,2),
(4,3),
(5,4),
(6,5),
(7,6),
(8,7),
(9, 8),
(10, 9)






SELECT * FROM Local
SELECT * FROM Empleado
SELECT * FROM DueñoMascota
SELECT * FROM Servicio
SELECT * FROM ProveedorProducto
SELECT * FROM Producto
SELECT * FROM Raza
SELECT * FROM Mascota
SELECT * FROM ServicioSugerido
SELECT * FROM Enfermedad
SELECT * FROM Consulta
SELECT * FROM Factura
SELECT * FROM Tratamiento
SELECT * FROM ProveedorMedicina
SELECT * FROM Medicina
--tablas nm
SELECT * FROM EmpleadoServicio
SELECT * FROM EmpleadoProducto
SELECT * FROM MascotaServicio
SELECT * FROM RazaServicioSugerido
SELECT * FROM MascotaEnfermedad
SELECT * FROM FacturaEmpleado
SELECT * FROM MedicinaTratamiento
