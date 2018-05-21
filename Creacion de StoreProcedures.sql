--crea un store procedure de la tabla Hotel
CREATE PROCEDURE SP_CargaTablaHotel
AS
BEGIN
	insert into [BIG_DATA].[Hotel] (ciudadHotel,direccionHotel,numeroCalle,cantidadDeEstrellas,recargaEstrella)
	select distinct Hotel_Ciudad,Hotel_Calle,Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella
	from [gd_esquema].[Maestra]
END
GO


--crea un store procedure de la tabla Tipo
CREATE PROCEDURE SP_CargaTablaTipo
AS
BEGIN
	SET IDENTITY_INSERT [BIG_DATA].[Tipo] ON
	insert into [BIG_DATA].[Tipo] (idTipo,descripcion,precio)
	select distinct Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion,Habitacion_Tipo_Porcentual
	from [gd_esquema].[Maestra]
	SET IDENTITY_INSERT [BIG_DATA].[Tipo] OFF
END
GO

--crea un store procedure de la tabla Habitacion
CREATE PROCEDURE SP_CargaTablaHabitacion
AS
BEGIN
	insert into [BIG_DATA].[Habitacion](numero,piso,vista,idTipo,comodidades,porcentual)
	select distinct Habitacion_Numero,Habitacion_Piso,Habitacion_Frente,Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion,Habitacion_Tipo_Porcentual
	from [gd_esquema].[Maestra]
END
GO


--crea un store procedure de la tabla Regimen
CREATE PROCEDURE SP_CargaTablaRegimen
AS
BEGIN
	insert into [BIG_DATA].[Regimen](descripcion,precio)
	select distinct Regimen_Descripcion,Regimen_Precio
	from [gd_esquema].[Maestra]
END
GO



--crea un store procedure de la tabla Reserva
CREATE PROCEDURE SP_CargaTablaReserva
AS
BEGIN
	insert into [BIG_DATA].[Reserva](fecha_Reserva_Desde,codigoReserva,cantidadNoches)
	select distinct Reserva_Fecha_Inicio,Reserva_Codigo,Reserva_Cant_Noches
	from [gd_esquema].[Maestra]
END
GO


--crea un store procedure de la tabla Estadia
CREATE PROCEDURE SP_CargaTablaEstadia
AS
BEGIN
	insert into [BIG_DATA].[Estadia](fecha_Check_In,cantidadDias)
	select distinct Estadia_Fecha_Inicio,Estadia_Cant_Noches
	from [gd_esquema].[Maestra]
END
GO


--crea un store procedure de la tabla Consumible
CREATE PROCEDURE SP_CargaTablaConsumible
AS
BEGIN
	insert into [BIG_DATA].[Consumible](codigo,consumible,precio)
	select distinct Consumible_Codigo,Consumible_Descripcion,Consumible_Precio
	from [gd_esquema].[Maestra]
END
GO



--crea un store procedure de la tabla Item
CREATE PROCEDURE SP_CargaTablaItem
AS
BEGIN
	insert into [BIG_DATA].[Item](cantidad,monto)
	select distinct Item_Factura_Cantidad,Item_Factura_Monto
	from [gd_esquema].[Maestra]
END
GO



----crea un store procedure de la tabla Factura
CREATE PROCEDURE SP_CargaTablaFactura
AS
BEGIN
	insert into [BIG_DATA].[Factura](numero,fecha,total)
	select distinct Factura_Nro,Factura_Fecha,Factura_Total
	from [gd_esquema].[Maestra]
END
GO


----crea un store procedure de la tabla Cliente
CREATE PROCEDURE SP_CargaTablaCliente
AS
BEGIN
	insert into [BIG_DATA].[Cliente](documento,apellido,nombre,fecha_Nacimiento,mail,calle,numero_Calle,piso,departamento,nacionalidad)
	select distinct Cliente_Pasaporte_Nro,Cliente_Apellido,Cliente_Nombre,Cliente_Fecha_Nac,Cliente_Mail,Cliente_Dom_Calle,Cliente_Nro_Calle,Cliente_Piso,Cliente_Depto,Cliente_Nacionalidad
	from [gd_esquema].[Maestra]
END
GO


-- query para ejecutar SP
--SP_CargaTablaNOMBREDELATABLA



