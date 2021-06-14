use ProyectoFinalVeterinaria
go

------//  CONSULTAS // -----
-- 1.- Consulta que muestra todos los productos en orden ascendente por su precio
 SELECT * FROM Producto ORDER BY precio ASC
 GO
-- 2.- Consulta que muestra todos los servicios en orden ascendente por su precio
 SELECT * FROM Servicio ORDER BY precio ASC
 GO
 -- 3.-Mostrar las consultas que tiene pendientes un empleado en concreto 
 SELECT * FROM Consulta WHERE idEmpleado = 1 ORDER BY fecha ASC 
 GO
 -- 4.-Consulta que muestra los servicios por orden de precio, de una sola categoria o tipo de servicio
 SELECT * FROM Servicio WHERE tipoServicio = 'Limpieza' ORDER BY precio ASC
 GO
 -- 5.-Consulta que muestra los productos por orden de precio, de una sola categoria o tipo de producto
  SELECT * FROM Producto WHERE tipoProducto = 'Accesorios' ORDER BY precio ASC
 GO
 -- 6.-Mostrar la cantidad de mascotas registradas por cada raza 
SELECT idRaza,  count(*) AS 'Cantidad de mascotas registradas' FROM Mascota GROUP BY idRaza 
GO
 -- 7.- Calcular las ganancias totales al sumar los gastos de las facturas
 SELECT SUM(totalPagar) as 'Total de ganancias' FROM Factura
 GO
 -- 8.- Mostrar los productos que se tienen a la venta entre dos cantidades, minima y maxima
 SELECT * FROM Producto  
WHERE precio between 100.00 and 300.00

 -- 9.- Mostrar los servicios que se tienen a la venta entre dos cantidades, minima y maxima
 SELECT * FROM Servicio  
WHERE precio between 100.00 and 300.00

 -- 10.- Calcular la cantidad de tratamientos que cada empleado a aplicado a las mascotas
 SELECT idEmpleado,  count(*) AS 'Cantidad de tratamientos que aplic�' FROM Tratamiento GROUP BY idEmpleado 
GO



 ------//  TRIGGERS  // -----

 -- 1.- Este trigger cambia el estado de stock en la tabla productos, avisando si se cuenta con insuficiente cantidad en stock cuando la cantidad en stock es menor a 5 
If object_id('TR_Modificar_Estado_Stock ') is not null
begin
drop trigger TR_Modificar_Estado_Stock 
end
go
CREATE TRIGGER TR_Modificar_Estado_Stock ON producto AFTER UPDATE 
AS BEGIN 
 -- obtener el �ltimo valor de identificaci�n del registro actualizado
  DECLARE @ID INT, @CantidadStock INT
  SELECT @ID = idProducto, @CantidadStock=stock
  FROM inserted 
 -- 
 if UPDATE (stock)
 begin
  if (@CantidadStock < 5)
  UPDATE Producto 
  set estadoStock = 'Poca cantidad en stock' WHERE idProducto= @ID;
  end
END
GO
UPDATE Producto SET stock= 3 WHERE idProducto=2
select *from Producto

 -- 2.-- Muestra el historial de modificacion de stock en inventario, mostrando la cantidad anterior, la actual y descripcion del estado de stock 
 If object_id('TX_Historial_Inventario_Producto_Modificar ') is not null
begin
drop trigger TX_Historial_Inventario_Producto_Modificar
end
go
CREATE TRIGGER TX_Historial_Inventario_Producto_Modificar
ON Producto
AFTER UPDATE
AS
IF (UPDATE (stock))
BEGIN
SELECT old.idProducto, old.Nombre as 'Nombre del producto modificado en stock', old.stock as 'Cantidad anterior en stock',  new.stock as 'Cantidad actual en stock', new.estadoStock as 'Estado actual de stock'
FROM deleted as old JOIN inserted AS new ON old.idProducto = new.idProducto 
END

UPDATE Producto SET stock = 1 WHERE idProducto=1
SELECT * FROM Producto

 -- 3.- Elimina los espacios iniciales al insertar el nombre de algun due�o de mascota, en caso de que al teclear hayamos dejado espacios antes del nombre
  If object_id('TX_Quitar_Espacios_Iniciales_Due�oMascota ') is not null
begin
drop trigger TX_Quitar_Espacios_Iniciales_Due�oMascota
end
go
CREATE TRIGGER TX_Quitar_Espacios_Iniciales_Due�oMascota
ON Due�oMascota
AFTER insert
AS
  DECLARE @Nombre VARCHAR(200), @idDue�o int
  SELECT @Nombre = nombre, @idDue�o = idDue�oMascota
  FROM inserted 
BEGIN
update Due�oMascota SET nombre =  LTRIM (@Nombre) WHERE idDue�oMascota = @idDue�o
END

INSERT INTO Due�oMascota(nombre, apellidoPaterno, apellidoMaterno, telefono, direccion)
VALUES ('     Prueba', 'AP', 'AM','866-253-48-56', 'DIRECCION')
SELECT * FROM Due�oMascota


 -- 4.- Actualiza la tabla de historial de inventario de productos cada vez que se realizan modificaciones en un registro, o se a�ade uno nuevo
CREATE TABLE HistorialInventarioProductos (Fecha datetime NOT NULL, accion VARCHAR(100),idProducto int ,nombreProducto VARCHAR(100))
GO

 If object_id('TX_Historial_Inventario_Producto_Update ') is not null
begin
drop trigger TX_Historial_Inventario_Producto_Update
end
go
CREATE TRIGGER TX_Historial_Inventario_Producto_Update
ON Producto
AFTER UPDATE
AS
  DECLARE @NombreProducto varchar (100), @idProducto int 
       SELECT @NombreProducto = inserted.nombre, @idProducto = inserted.idProducto FROM INSERTED
     BEGIN 
 insert into HistorialInventarioProductos(fecha, accion, idProducto, nombreProducto)
 values (getdate(), 'Modificacion de los datos en producto', @idProducto ,@NombreProducto)
 end
GO

UPDATE Producto SET stock = 1 WHERE idProducto=1
SELECT * FROM Producto
SELECT * FROM HistorialInventarioProductos


 -- 5.-Actualiza la tabla de historial de inventario de productos cada vez que se realizan insersiones en un registro, o se a�ade uno nuevo
 If object_id('TX_Historial_Inventario_Producto_Insertar ') is not null
begin
drop trigger TX_Historial_Inventario_Producto_Insertar
end
go
CREATE TRIGGER TX_Historial_Inventario_Producto_Insertar
ON Producto
AFTER insert
AS
  DECLARE @NombreProducto varchar (100), @idProducto int 
       SELECT @NombreProducto = inserted.nombre, @idProducto = inserted.idProducto FROM INSERTED
     BEGIN 
 insert into HistorialInventarioProductos(fecha, accion, idProducto, nombreProducto)
 values (getdate(), 'Se insert� el siguiente producto nuevo', @idProducto ,@NombreProducto)
 end
GO

INSERT INTO Producto(nombre, tipoProducto, descripcion, precio, stock, idMarcaProducto, idProveedorProducto,estadoStock)
VALUES ('Prod prueba', 'Higiene', 'Desc', 109.00, 100, 1, 1, 'Suficiente cantidad en stock')

SELECT * FROM Producto
SELECT * FROM HistorialInventarioProductos



 -- 6.-Trigger que nos muestra un mensaje cada vez que realizamos una insersion o una modificacion en la tabla Consulta
 If object_id('TR_MENSAJE_INSERCION_CONSULTA ') is not null
begin
drop trigger TR_MENSAJE_INSERCION_CONSULTA
end
go
 CREATE TRIGGER TR_MENSAJE_INSERCION_CONSULTA
ON Consulta
FOR INSERT, UPDATE
AS
BEGIN
PRINT 'SE HA REALIZADO UNA INSERCION O ACTUALIZACION DE LA TABLA  CONSULTA DE FORMA EXITOSA '
END
GO

 -- 7.-Trigger que nos muestra un mensaje cada vez que realizamos una insersion o una modificacion en la tabla Enfermedad
 If object_id('TR_MENSAJE_INSERCION_ENFERMEDAD ') is not null
begin
drop trigger TR_MENSAJE_INSERCION_ENFERMEDAD
end
go
 CREATE TRIGGER TR_MENSAJE_INSERCION_ENFERMEDAD
ON Enfermedad
FOR INSERT, UPDATE
AS
BEGIN
PRINT 'SE HA REALIZADO UNA INSERCION O ACTUALIZACION DE LA TABLA  ENFERMEDAD DE FORMA EXITOSA '
END
GO
 
 -- 8.-Trigger que nos muestra un mensaje cada vez que realizamos una insersion o una modificacion en la tabla Producto
 If object_id('TR_MENSAJE_INSERCION_PRODUCTO ') is not null
begin
drop trigger TR_MENSAJE_INSERCION_PRODUCTO
end
go
 CREATE TRIGGER TR_MENSAJE_INSERCION_PRODUCTO
ON Producto
FOR INSERT, UPDATE
AS
BEGIN
PRINT 'SE HA REALIZADO UNA INSERCION O ACTUALIZACION DE LA TABLA  Producto DE FORMA EXITOSA '
END
GO
 
 -- 9.- Trigger que nos muestra un mensaje cada vez que realizamos una insersion o una modificacion en la tabla due�o mascota
 If object_id('TR_MENSAJE_INSERCION_MASCOTA ') is not null
begin
drop trigger TR_MENSAJE_INSERCION_MASCOTA
end
go
 CREATE TRIGGER TR_MENSAJE_INSERCION_MASCOTA
ON Mascota
FOR INSERT, UPDATE
AS
BEGIN
PRINT 'SE HA REALIZADO UNA INSERCION O ACTUALIZACION DE LA TABLA  MASCOTA DE FORMA EXITOSA '
END
GO
UPDATE Mascota set nombre = 'Prueba' WHERE idMascota = 1
SELECT *FROM Mascota
 
 -- 10.- Trigger que nos muestra un mensaje cada vez que realizamos una insersion o una modificacion en la tabla due�o mascota
 If object_id('TR_MENSAJE_INSERCION_DUE�OMASCOTA ') is not null
begin
drop trigger TR_MENSAJE_INSERCION_DUE�OMASCOTA 
end
go
 CREATE TRIGGER TR_MENSAJE_INSERCION_DUE�OMASCOTA
ON Due�oMascota
FOR INSERT, UPDATE
AS
BEGIN
PRINT 'SE HA REALIZADO UNA INSERCION O ACTUALIZACION DE LA TABLA DUE�O MASCOTA DE FORMA EXITOSA '
END
GO
UPDATE Due�oMascota set nombre = 'Prueba de modificacion' WHERE idDue�oMascota = 1
SELECT *FROM Due�oMascota





 ------//  PROCEDIMIENTOS ALMACENADOS // -----

 -- 1.-Nos muestra los nombres de las mascotas que tienen una enfermedad en especifico, adjuntando la id y el nombre de su respectivo due�o
create procedure Proc_Mascota_Enfermedad_Due�o
@idEnfermedad int
 as
 Begin
select MasEnf.idMascota, M.nombre, M.longitud, M.peso, Enf.codigoEnfermedad, Enf.nombre,  Enf.descripcion, CONCAT (Due�oMascota.nombre, ' ', Due�oMascota.apellidoPaterno, ' ', Due�oMascota.apellidoMaterno) as 'due�o de mascota' 
from Enfermedad as Enf inner join  MascotaEnfermedad as MasEnf  on  MasEnf.idEnfermedad = Enf.idEnfermedad INNER JOIN Mascota M on MasEnf.idMascota = M.idMascota inner join Due�oMascota on Due�oMascota.idDue�oMascota = M.idDue�oMascota
WHERE MasEnf.idEnfermedad = @idEnfermedad
END
GO

exec Proc_Mascota_Enfermedad_Due�o 1
GO
--//


 -- 2.- Nos muestra las mascotas que tiene un due�o en especifico
 create procedure Proc_Due�o_Y_Mascotas
@idDue�oMascota int
 as
 Begin
 SELECT dm.idDue�oMascota,CONCAT( DM.nombre ,' ', dm.apellidoPaterno, ' ',  dm.apellidoMaterno ) AS 'nombre del due�o' , m.nombre as 'nombre de la mascota', m.sexo, R.nombreRaza as 'raza de la mascota'
 FROM Due�oMascota as DM INNER JOIN Mascota as M ON M.idDue�oMascota = DM.idDue�oMascota INNER JOIN Raza as R ON R.idRaza = M.idRaza
 WHERE DM.idDue�oMascota = @idDue�oMascota
 END
GO

exec Proc_Due�o_Y_Mascotas 1
GO

--//


 -- 3.- Nos muestra a las mascotas que est�n registradas y que son de una categoria de especie especifica 
create procedure Proc_Mascotas_Por_Categoria
@especie varchar(50)
 as
 Begin
 SELECT m.nombre as 'Nombre mascota', r.nombreRaza as 'Raza', m.sexo, m.edad, m.longitud, m.peso, CONCAT (DM.nombre, ' ', DM.apellidoPaterno, ' ', dm.apellidoMaterno) as 'Due�o'
 FROM Mascota as M INNER JOIN Raza as R on M.idRaza = R.idRaza INNER JOIN Due�oMascota as DM  on dm.idDue�oMascota = M.idDue�oMascota
 where r.especie =  @especie
  END
GO

exec Proc_Mascotas_Por_Categoria 'Conejo'
GO
--//


 -- 4.- Obtener el nombre y descripcion de los servicios generales que recibi� una mascota en especifico
create procedure Proc_Mascotas_Y_Servicio_Solicitado
@idMascota varchar(50)
 as
 Begin
SELECT nombre, descripcion FROM Servicio
WHERE idServicio IN (SELECT idServicio FROM MascotaServicio  WHERE  idMascota IN (SELECT idMascota FROM MascotaServicio WHERE idMascota = @idMascota))
  END
GO

exec Proc_Mascotas_Y_Servicio_Solicitado 1
GO
--//


 -- 5.-Nos muestra la informacion de la mascota enferma, la enfermedad con la que cuenta, el tratamiento que est� recibiendo y que empleado lo atiende   
 create procedure Proc_Mascotas_Tratamiento_Empleado
 as
 Begin
 SELECT m.idMascota, m.nombre, m.sexo, m.edad, m.longitud, m.peso, enf.nombre as 'enfermedad padecida',  t.descripcion as 'tratamiento recibido', CONCAT(  emp.nombre,' ', emp.apellidoPaterno, ' ',  emp.apellidoMaterno  ) AS 'empleado que lo atendi�'
 FROM mascota as M INNER JOIN  MascotaEnfermedad as MasEnf on MasEnf.idMascota = m.idMascota INNER JOIN Enfermedad as enf on enf.idEnfermedad = MasEnf.idEnfermedad INNER JOIN Tratamiento as T on t.idMascota =m.idMascota INNER JOIN Empleado as Emp on Emp.idEmpleado = T.idEmpleado
   END
GO

exec Proc_Mascotas_Tratamiento_Empleado 
GO
--//


 -- 6.-Obtener el nombre y descripcion de los productos vendidos por un empleado en especifico  
create procedure Proc_Productos_Vendidos_PorCierto_Empleado
@idEmpleado int
 as
 Begin
SELECT nombre, descripcion FROM Producto
WHERE idProducto IN (SELECT idProducto FROM EmpleadoProducto  WHERE  idEmpleado IN (SELECT idEmpleado FROM EmpleadoProducto WHERE idEmpleado = @idEmpleado))
 END
GO

exec  Proc_Productos_Vendidos_PorCierto_Empleado 6
GO
--//


 -- 7.- obtener datos de facturas que fueron emitidas por un empleado en especifico, adjuntando el nombre del cliente al que atendi�
create procedure Proc_Factura_Empleado_Cliente
@idEmpleado int
 as
 Begin
 SELECT Fact.noFactura, Fact.descripcion, ROUND (totalPagar,2,1) as 'total a pagar', CONCAT (Due�Masc.nombre, ' ', Due�Masc.apellidoPaterno, ' ', Due�Masc.apellidoMaterno) as 'cliente'
 FROM Factura as Fact INNER JOIN Due�oMascota as Due�Masc on Due�Masc.idDue�oMascota = Fact.idDue�oMascota
WHERE idFactura IN (SELECT idFactura FROM FacturaEmpleado  WHERE  idEmpleado IN (SELECT idEmpleado FROM FacturaEmpleado WHERE idEmpleado = @idEmpleado))
 END
GO

exec  Proc_Factura_Empleado_Cliente 6
GO

--//


 -- 8.-Nos muestra la informacion unida de las razas de mascota y sus servicios sugeridos, segun una raza especifica
 create procedure Proc_ServicioSugerido_ParaCierta_Raza
@idRaza int
 as
 Begin
 SELECT rss.idRaza, r.nombreRaza, r.especie, r.tama�oPromedio, r.pesoPromedio, rss.idServicioSugerido, ss.nombre as 'Servicio sugerido', ss.descripcion, round(ss.precio,2,1) as 'Costo'
 FROM RazaServicioSugerido as RSS INNER JOIN Raza as R on r.idRaza = rss.idRaza INNER JOIN ServicioSugerido as SS on ss.idServicioSugerido = rss.idServicioSugerido 
 WHERE r.idRaza =@idRaza
  END
GO

exec  Proc_ServicioSugerido_ParaCierta_Raza 3
GO
--//


 -- 9.- Mostrar las consultas que tienen los empleados en orden por local, adjuntando los datos del cliente que solicit� dicha consulta y los datos del empleado
  create procedure Proc_Consultas_Empleado_Cliente
 as
 Begin
 SELECT  loc.nombre as 'Local',CONCAT(Emp.nombre, ' ', Emp.apellidoPaterno , ' ', Emp.apellidoMaterno) as 'Empleado', CONCAT (Client.nombre, ' ', Client.apellidoPaterno,' ',Client.apellidoMaterno)'Cliente',Con.fecha, con.horaInicio, con.horaFin , Client.telefono as 'Telefono de cliente', Emp.telefono as 'Telefono del empleado', loc.telefono as 'Telefono del local'
 FROM Consulta as Con INNER JOIN Empleado as Emp  on Con.idEmpleado = Emp.idEmpleado  INNER JOIN Due�oMascota as Client on Con.idDue�oMascota = Client.idDue�oMascota INNER JOIN Local as loc on loc.idLocal = Emp.idLocal
 order by loc.idLocal asc, Con.fecha asc

  END
GO

exec Proc_Consultas_Empleado_Cliente
GO

 -- 10.-Mostrar el listado de productos que se tienen, agrupados por proveedor y sus datos 
   create procedure Proc_ProductosProveedor
 as
 Begin
 SELECT  Prov.nombre as 'Proveedor ',prod.nombre as 'Producto', prod.tipoProducto, marc.nombreMarca as 'Marca', prod.descripcion, prod.precio,  Prov.telefono as 'Contacto de proveedor'
 FROM Producto as prod INNER JOIN ProveedorProducto as Prov on prod.idProveedorProducto = Prov.idProveedorProducto INNER JOIN MarcaProducto as marc on  marc.idMarcaProducto = prod.idMarcaProducto
 order by Prov.nombre asc, prod.nombre asc
  END
GO

exec Proc_ProductosProveedor
GO
