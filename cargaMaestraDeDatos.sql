Use  GD1C2018
GO

DECLARE @TotalRows int
BEGIN TRANSACTION

SELECT @TotalRows = 0


Select 'Cargando Tabla Cliente'
Exec [dbo].[SP_CargaTablaCliente]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Cliente ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Consumible'
EXEC [dbo].[SP_CargaTablaConsumible]
Select @TotalRows = @TotalRows + @@ROWCOUNT
select 'Fin de Carga Tabla Consumible ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Estadia'
EXEC[dbo].[SP_CargaTablaEstadia]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Estadia ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Factura'
EXEC [dbo].[SP_CargaTablaFactura]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Factura ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Tipo'
EXEC [dbo].[SP_CargaTablaTipo]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Tipo ' + convert(varchar,@TotalRows) + ' Registros Insertados'


Select 'Cargando Tabla Habitacion'
EXEC [dbo].[SP_CargaTablaHabitacion]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Habitacion ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Hotel '
EXEC [dbo].[SP_CargaTablaHotel]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Hotel ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Item'
EXEC [dbo].[SP_CargaTablaItem]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Item ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Regimen'
EXEC [dbo].[SP_CargaTablaRegimen]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Regimen ' + convert(varchar,@TotalRows) + ' Registros Insertados'

Select 'Cargando Tabla Reserva '
EXEC [dbo].[SP_CargaTablaReserva]
Select @TotalRows = @TotalRows + @@ROWCOUNT
Select 'Fin de Carga Tabla Reserva ' + convert(varchar,@TotalRows) + ' Registros Insertados'


IF @TotalRows <> (Select Count(*) from [gd_esquema].[Maestra])
BEGIN
	Select 'No se han podido efectuar la carga de datos ya que la cantidad de registros ' + convert(varchar,@TotalRows) + ' no coincide con el total a insertar de la tabla maestra enviada ' + convert(varchar,(Select Count(*) from [gd_esquema].[Maestra]))
	ROLLBACK TRANSACTION
END
ELSE
BEGIN
	COMMIT TRANSACTION
	Select @TotalRows 'Registros importados'
END
GO
