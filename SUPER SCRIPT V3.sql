---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------GENERACION DE QUERY-----------------------------------------------
---------------------------------------PARA BORRADO MASIVO-----------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

DECLARE @Sql NVARCHAR(MAX)
      , @Schema varchar(20)
	  ,@test varchar(2500)

SET @Schema = 'BIG_DATA' --put your schema name between these quotes
--si le pongo dbo borra los store

select @Sql = COALESCE(@Sql,'') + 'ALTER TABLE %SCHEMA%.' + t.name + ' drop constraint ' + 
OBJECT_NAME(d.constraint_object_id)  + ';' + CHAR(13)
from sys.tables t 
    join sys.foreign_key_columns d on d.parent_object_id = t.object_id 
    inner join sys.schemas s on t.schema_id = s.schema_id
where s.name = @Schema
ORDER BY t.name;

--tables
SELECT @Sql = COALESCE(@Sql,'') + 'DROP TABLE %SCHEMA%.' + QUOTENAME(TABLE_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = @Schema
    AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME

--views
SELECT @Sql = COALESCE(@Sql,'') + 'DROP VIEW %SCHEMA%.' + QUOTENAME(TABLE_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = @Schema
    AND TABLE_TYPE = 'VIEW'
ORDER BY TABLE_NAME

--Procedures
SELECT @Sql = COALESCE(@Sql,'') + 'DROP PROCEDURE %SCHEMA%.' + QUOTENAME(ROUTINE_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = @Schema
    AND ROUTINE_TYPE = 'PROCEDURE'
ORDER BY ROUTINE_NAME

--Functions
SELECT @Sql = COALESCE(@Sql,'') + 'DROP FUNCTION %SCHEMA%.' + QUOTENAME(ROUTINE_NAME) + ';' + CHAR(13)
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_SCHEMA = @Schema
    AND ROUTINE_TYPE = 'FUNCTION'
ORDER BY ROUTINE_NAME

SELECT @Sql = COALESCE(REPLACE(@Sql,'%SCHEMA%',@Schema), '')

EXECUTE sp_executesql @Sql




---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------CREACION DE TABLAS---------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

use [GD1C2018]
GO

--Crea el Schema--

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'BIG_DATA')

BEGIN
	EXEC ('CREATE SCHEMA BIG_DATA AUTHORIZATION gdHotel2018')
END

--Creacion de tablas--

---Tablas sin FK
CREATE TABLE BIG_DATA.Regimen (
	idRegimen NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	descripcion NVARCHAR (255) NOT NULL,
	precio MONEY,
	estado BIT DEFAULT 1,
	
	PRIMARY KEY (idRegimen)
)

CREATE TABLE BIG_DATA.TipoHabitacion (
	idTipoHabitacion NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	descripcion NVARCHAR (255),
	precio NUMERIC(18,2),
	porcentual NUMERIC(18, 2),
	
	PRIMARY KEY (idTipoHabitacion)
)

CREATE TABLE BIG_DATA.PaisNacionalidad (
	idPaisNacionalidad NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	pais NVARCHAR (50),
	nacionalidad NVARCHAR (50),
	
	PRIMARY KEY (idPaisNacionalidad)
)

CREATE TABLE BIG_DATA.TipoDocumento (
	idDocumento NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	tipoDocumentoDesc NVARCHAR (255),
	
	PRIMARY KEY (idDocumento)
)


CREATE TABLE BIG_DATA.Rol (
	idRol NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	rolDesc NVARCHAR (255),
	estadoRol BIT,

	PRIMARY KEY (idRol)
)

CREATE TABLE BIG_DATA.EstadoReserva (
	idEstadoReserva NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	estadoReservaDesc VARCHAR (255),
	
	PRIMARY KEY (idEstadoReserva)
)

CREATE TABLE BIG_DATA.Consumible (
	idConsumible NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	consumibleDesc VARCHAR (255),
	consumiblePrecio NUMERIC (18,2),
	
	PRIMARY KEY (idConsumible)
)


CREATE TABLE BIG_DATA.Funcion (
	idFuncion NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	funcionDesc NVARCHAR (255),
	
	PRIMARY KEY (idFuncion),
)


CREATE TABLE BIG_DATA.Ciudad (
	idCiudad NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idPaisNacionalidad NUMERIC (18,0) NOT NULL,
	ciudadNombre NVARCHAR (255) NOT NULL,

	PRIMARY KEY (idCiudad),
	FOREIGN KEY (idPaisNacionalidad) REFERENCES BIG_DATA.PaisNacionalidad
	)


CREATE TABLE BIG_DATA.Hotel (
	idHotel NUMERIC(18,0) IDENTITY (1,1) NOT NULL,
	nombreHotel NVARCHAR (255),
	mailHotel NVARCHAR (255),
	telefonoHotel NUMERIC (18,0),
	direccionHotel NVARCHAR(255) ,
	cantidadDeEstrellas NUMERIC (18,0),
	idCiudad NUMERIC (18,0),
	numeroCalle NUMERIC (18,0),
	paisHotel NUMERIC (18,0),
	fechaDeCreacion DATETIME DEFAULT (getdate()),
	recargaEstrella NUMERIC (18,0)
	
	PRIMARY KEY(idHotel),
	FOREIGN KEY (paisHotel) REFERENCES [BIG_DATA].[PaisNacionalidad] (idPaisNacionalidad),
	FOREIGN KEY (idCiudad) REFERENCES [BIG_DATA].[Ciudad] (idCiudad)
)

CREATE TABLE BIG_DATA.Usuario (
	username NVARCHAR (255) NOT NULL,
	userpassword NVARCHAR (20),
	nombre NVARCHAR (255),
	apellido NVARCHAR (255),
	tipo_Documento NUMERIC (18,0),
	documento NUMERIC (18,0),
	mail NVARCHAR (255),
	telefono NUMERIC (18,0),
	direccion NVARCHAR (255),
	fecha_Nacimiento DATETIME,
	estadoUsuario NUMERIC(18,0) DEFAULT 1 NOT NULL,
	user_intentos_fallidos NUMERIC(18,0) DEFAULT 0 NOT NULL
	
	PRIMARY KEY (username),
	FOREIGN KEY (tipo_documento) REFERENCES BIG_DATA.TipoDocumento (idDocumento)
)


CREATE TABLE BIG_DATA.Cliente (
	idCliente NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	nombre NVARCHAR (255) NOT NULL,
	apellido NVARCHAR (255) NOT NULL,
	tipo_Documento NUMERIC (18,0) NOT NULL,
	documento NUMERIC (18,0) NOT NULL,
	nacionalidad NUMERIC (18,0),
	mail NVARCHAR (255) NOT NULL,
	telefono NUMERIC (18,0),
	calle NVARCHAR (255),
	numero_Calle numeric(18, 0),
	piso NUMERIC(18,0),
	departamento NVARCHAR(50),
	localidad NVARCHAR (255),
	paisOrigen NUMERIC (18,0),
	fecha_Nacimiento DATETIME,
	estadoCliente BIT
	
	PRIMARY KEY (idCliente),
	FOREIGN KEY (tipo_documento) REFERENCES BIG_DATA.TipoDocumento (idDocumento),
	FOREIGN KEY (nacionalidad) REFERENCES BIG_DATA.PaisNacionalidad (idPaisNacionalidad),
	FOREIGN KEY (paisOrigen) REFERENCES BIG_DATA.PaisNacionalidad (idPaisNacionalidad)
)

CREATE TABLE BIG_DATA.Habitacion (
	idHabitacion numeric (18,0) IDENTITY (1,1) NOT NULL,
	idHotel NUMERIC(18,0) NOT NULL,
	numeroHab NUMERIC (18,0) NOT NULL,
	piso NUMERIC (18,0),
	vistaFrente CHAR (1),
	idTipo NUMERIC (18,0) ,
	comodidades NVARCHAR (255),
	habitacionActiva BIT DEFAULT 1,
	habitacionOcupada BIT DEFAULT 0,

	PRIMARY KEY (idHabitacion),
	FOREIGN KEY (idTipo) REFERENCES BIG_DATA.TipoHabitacion (idTipoHabitacion)
)



CREATE TABLE BIG_DATA.Reserva (
	idReserva NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	cantidadNoches NUMERIC (18,0),
	fecha_Reserva_Realizada DATETIME DEFAULT (getdate()),
	fecha_Reserva_Desde DATETIME NOT NULL,
	fecha_Reserva_Hasta DATETIME,
	idTipoHabitacion NUMERIC (18,0) NOT NULL,
	idHotel NUMERIC (18,0) NOT NULL,
	idRegimen NUMERIC (18,0) NOT NULL,
	idHabitacion NUMERIC (18,0) NOT NULL,
	idCliente NUMERIC (18,0) NOT NULL,
	idEstadoReserva NUMERIC (18,0) NOT NULL,
	ultimaModificacionPor NVARCHAR (255) DEFAULT (suser_name()),

	PRIMARY KEY (idReserva),
	FOREIGN KEY (idTipoHabitacion) REFERENCES BIG_DATA.TipoHabitacion (idTipoHabitacion),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel),
	FOREIGN KEY (idRegimen) REFERENCES BIG_DATA.Regimen (idRegimen),
	FOREIGN KEY (idHabitacion) REFERENCES BIG_DATA.Habitacion (idHabitacion),
	FOREIGN KEY (idCliente) REFERENCES BIG_DATA.Cliente (idCliente),
	FOREIGN KEY (idEstadoReserva) REFERENCES BIG_DATA.EstadoReserva (idEstadoReserva)
)


CREATE TABLE BIG_DATA.CierreHotel (
	idCierre NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idHotel NUMERIC (18,0),
	fecha_Inicio DATETIME,
	fecha_Fin DATETIME,
	descripcion NVARCHAR (255),

	PRIMARY KEY (idCierre),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel)
)

CREATE TABLE BIG_DATA.Estadia (
	idEstadia NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idReserva NUMERIC (18,0),
	fecha_Check_In DATETIME,
	fecha_Check_Out DATETIME,
	cantidadDias NUMERIC (18,0),

	PRIMARY KEY (idEstadia),
	FOREIGN KEY (idReserva) REFERENCES BIG_DATA.Reserva (idReserva)
)

CREATE TABLE BIG_DATA.Factura (
	idFactura NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	numero NUMERIC (18,0),
	fecha DATETIME,
	total MONEY,
	idCliente NUMERIC (18,0),

	PRIMARY KEY (idFactura),
	FOREIGN KEY (idCliente) REFERENCES BIG_DATA.Cliente (idCliente)
)

CREATE TABLE BIG_DATA.Item (
	idItem NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idFactura NUMERIC (18,0),
	cantidad NUMERIC (18,0),
	monto MONEY,
	idEstadia NUMERIC (18,0),

	PRIMARY KEY (idItem),
	FOREIGN KEY (idFactura) REFERENCES BIG_DATA.Factura (idFactura),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia)
)


CREATE TABLE BIG_DATA.RegimenXHotel (
	idRegimenHotel NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idRegimen NUMERIC (18,0),
	idHotel NUMERIC (18,0),

	PRIMARY KEY (idRegimenHotel),
	FOREIGN KEY (idRegimen) REFERENCES BIG_DATA.Regimen (idRegimen),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel)
)

CREATE TABLE BIG_DATA.UsuarioXHotel (
	idUsuarioHotel NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idHotel NUMERIC (18,0),
	username NVARCHAR (255),

	PRIMARY KEY (idUsuarioHotel),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel),
	FOREIGN KEY (username) REFERENCES BIG_DATA.Usuario (username)
)

CREATE TABLE BIG_DATA.FuncionXRol (
	idFuncionRol NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idRol NUMERIC (18,0),
	idFuncion NUMERIC (18,0),

	PRIMARY KEY (idFuncionRol),
	FOREIGN KEY (idRol) REFERENCES BIG_DATA.Rol (idRol),
	FOREIGN KEY (idFuncion) REFERENCES BIG_DATA.Funcion (idFuncion)
)

CREATE TABLE BIG_DATA.UsuarioXRol (
	idUsuarioXRol NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	username NVARCHAR(255),
	idRol NUMERIC (18,0),

	PRIMARY KEY (idUsuarioXRol),
	FOREIGN KEY (username) REFERENCES BIG_DATA.Usuario (username),
	FOREIGN KEY (idRol) REFERENCES BIG_DATA.Rol (idRol)
)

CREATE TABLE BIG_DATA.ConsumibleXEstadia (
	idConsumibleEstadia NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idEstadia NUMERIC (18,0),
	idConsumible NUMERIC (18,0),

	PRIMARY KEY (idConsumibleEstadia),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia),
	FOREIGN KEY (idConsumible) REFERENCES BIG_DATA.Consumible (idConsumible)
)

GO

CREATE TRIGGER [BIG_DATA].[Estadia_CheckOut_Trigger]
ON [BIG_DATA].[Estadia]
INSTEAD OF INSERT
AS
INSERT INTO [BIG_DATA].[Estadia](fecha_Check_In,cantidadDias, idReserva, fecha_Check_Out)
SELECT fecha_Check_In,cantidadDias,idReserva,(fecha_check_in + cantidadDias) FROM INSERTED
GO


CREATE TRIGGER [BIG_DATA].[Reserva_fechaHasta_Trigger]
ON [BIG_DATA].[Reserva]
INSTEAD OF INSERT
AS
INSERT INTO [BIG_DATA].[Reserva] (idReserva,fecha_Reserva_Desde,cantidadNoches,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente,idEstadoReserva,fecha_Reserva_Hasta)
SELECT idReserva,fecha_Reserva_Desde,cantidadNoches,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente,idEstadoReserva,(fecha_Reserva_Desde + cantidadNoches) FROM INSERTED
GO



---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------MIGRACION DE LOS DATOS--------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------


--Migracion Tabla Regimen
	INSERT INTO [BIG_DATA].[Regimen](descripcion,precio)
		SELECT DISTINCT Regimen_Descripcion,Regimen_Precio
		FROM [gd_esquema].[Maestra] 
		WHERE [Regimen_Descripcion] IS NOT NULL


--Migracion Tabla Tipo Habitacion
	SET IDENTITY_INSERT [BIG_DATA].[TipoHabitacion] ON

	INSERT INTO [BIG_DATA].[TipoHabitacion] (idTipoHabitacion,descripcion,precio)
		SELECT DISTINCT Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion,Habitacion_Tipo_Porcentual
		FROM [gd_esquema].[Maestra]
		WHERE [Habitacion_Tipo_Codigo] IS NOT NULL
	
	SET IDENTITY_INSERT [BIG_DATA].[TipoHabitacion] OFF

--Adicion Valores Tabla EstadoReserva
	INSERT INTO [BIG_DATA].[EstadoReserva] (estadoReservaDesc) 
		VALUES('Reserva Correcta'),('Reserva Modificada'), ('Reserva Cancelada por Recepcion'),
		('Reserva Cancelada por Cliente'),('Reserva Cancelada por No-Show'),('Reserva con Ingreso')

--Adicion Valores Tabla PaisNacionalidad NUEVO
	INSERT INTO BIG_DATA.PaisNacionalidad (pais,nacionalidad)
		VALUES ('ARGENTINA','ARGENTINO'),('BRASIL','BRASILE�O'),('CHILE','CHILENO'),('URUGUAY','URUGUAYO'),('MEXICO','MEXICANO'),('COLOMBIA','COLOMBIANO'),('BOLIVIA','BOLIVIANO'),
		('ESTADOS UNIDOS','ESTADOUNIDENSE'),('ALEMANIA','ALEMAN'),('CHINA','CHINO'),('JAPON','JAPONES'),
		--('OTRO EUROPA','EUROPEO'),('OTRO ASIA','ASIATICO'),('OTRO AFRICA','AFRICANO'),('OTRO OCEANIA','OCEANICO'),('OTRO AMERICA','AMERICANO')
		('OTRO','OTRA')

--Adicion Valores Tabla TipoDocumento
	INSERT INTO [BIG_DATA].TipoDocumento (tipoDocumentoDesc)
		VALUES ('Documento Nacional'),('Pasaporte'),('Libreta Civil'),('Licencia'),('Libreta de Enrolamiento'),('Cuit'),('Cuil')

--Adicion Valores Tabla Rol
	INSERT INTO [BIG_DATA].[Rol] (rolDesc)
		VALUES ('Administrador'),('Recepcionista'),('Guest')
	
--Adicion Valores Tabla Funcion
	INSERT INTO [BIG_DATA].[Funcion] (funcionDesc)
		VALUES ('ABM de Rol'),('Login y Seguridad'),('ABM de Usuario'),('ABM de Cliente'),('ABM de Hotel'),('ABM de Habitacion'),('ABM Regimen de Estadia'),('Generar O Modificar una Reserva'),('Cancelar Reserva'),('Registrar Estadia'),('Registrar Consumibles'),('Facturar Estadia'),('Listado Estadistico')

--Adicion Valores Tabla Usuario
/*	INSERT INTO [BIG_DATA].[Usuario] (username,userpassword,idRol,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
		VALUES ('Administrador',ENCRYPTBYPASSPHRASE('MOAP','Administrador'),1,'NombreAdministrador','ApellidoAdministrador', 1, 11111111,'Administrador@administrador.com',1511111111,'CalleAdministrador',01/01/1900),	
		('Recepcionista',ENCRYPTBYPASSPHRASE('MOAP','Recepcionista'),2,'NombreRecepcionista','ApellidoRecepcionista', 1, 22222222,'Recepcionista@recepcionista.com',1522222222,'CalleRecepcionista',01/01/1900),	
		('Guest',ENCRYPTBYPASSPHRASE('MOAP','Guest'),1,'NombreGuest','ApellidoGuest', 3, 33333333,'Guest@guest.com',3333333333,'CalleGuest',01/01/1900)	
		*/

INSERT INTO [BIG_DATA].[Usuario] (username,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento,estadoUsuario,user_intentos_fallidos,userpassword)
		VALUES ('Administrador','NombreAdministrador','ApellidoAdministrador', 1, 11111111,'Administrador@administrador.com',1511111111,'CalleAdministrador',01/01/1900,1,0,HASHBYTES('SHA2_256', CONVERT(nvarchar(255), 'Administrador'))),
		('Recepcionista','NombreRecepcionista','ApellidoRecepcionista', 1, 22222222,'Recepcionista@recepcionista.com',1522222222,'CalleRecepcionista',01/01/1900,1,0,HASHBYTES('SHA2_256', CONVERT(nvarchar(255), 'Recepcionista'))),
		('Guest','NombreGuest','ApellidoGuest', 1, 33333333,'Guest@guest.com',1533333333,'CalleGuest',01/01/1900,1,0,HASHBYTES('SHA2_256', CONVERT(nvarchar(255), 'Guest')))

--Migracion Tabla Consumible
	SET IDENTITY_INSERT [BIG_DATA].[Consumible] ON

	INSERT INTO [BIG_DATA].[Consumible] (idConsumible,consumibleDesc,consumiblePrecio)
		SELECT DISTINCT Consumible_Codigo,Consumible_Descripcion,Consumible_Precio
		FROM [gd_esquema].[Maestra]
		WHERE	[Consumible_Codigo]IS NOT NULL

	SET IDENTITY_INSERT [BIG_DATA].[Consumible] OFF

--Migracion Tabla Ciudad
	INSERT INTO [BIG_DATA].[Ciudad] (ciudadNombre,idPaisNacionalidad)
		SELECT DISTINCT Hotel_Ciudad,idPaisNacionalidad
		FROM	[gd_esquema].[Maestra],
				[BIG_DATA].[PaisNacionalidad]
		WHERE	pais = 'ARGENTINA'

--Migracion Tabla Hotel
	INSERT INTO [BIG_DATA].[Hotel] (idCiudad,direccionHotel,numeroCalle,cantidadDeEstrellas,recargaEstrella,fechaDeCreacion,paisHotel)
		SELECT DISTINCT idCiudad,Hotel_Calle,Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella,MIN(Reserva_Fecha_Inicio),idPaisNacionalidad
		FROM	[gd_esquema].[Maestra],
				[BIG_DATA].[Ciudad]
		WHERE	[Hotel_Ciudad] IS NOT NULL
				AND Hotel_Calle IS NOT NULL
				AND Hotel_Nro_Calle IS NOT NULL
				AND Hotel_Ciudad = ciudadNombre
		GROUP BY idCiudad,Hotel_Calle,Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella,idPaisNacionalidad

--Migracion Tabla Cliente
	INSERT INTO [BIG_DATA].[Cliente] (documento,tipo_Documento,apellido,nombre,fecha_Nacimiento,mail,calle,numero_Calle,piso,departamento,nacionalidad)
		SELECT DISTINCT Cliente_Pasaporte_Nro,t.idDocumento,Cliente_Apellido,Cliente_Nombre,Cliente_Fecha_Nac,Cliente_Mail,Cliente_Dom_Calle,Cliente_Nro_Calle,Cliente_Piso,Cliente_Depto,n.idPaisNacionalidad
		FROM [gd_esquema].[Maestra] m,BIG_DATA.PaisNacionalidad n,BIG_DATA.TipoDocumento t
		WHERE	[Cliente_Pasaporte_Nro] IS NOT NULL 
				AND (m.Cliente_Nacionalidad = n.nacionalidad)
				AND (t.tipoDocumentoDesc='Pasaporte')

--Migracion Tabla Habitacion
	INSERT INTO [BIG_DATA].[Habitacion] (idHotel,numeroHab,piso,vistaFrente,idTipo)
		SELECT DISTINCT A.idHotel, B.Habitacion_Numero, B.Habitacion_Piso, B.Habitacion_Frente, B.Habitacion_Tipo_codigo
		FROM	[BIG_DATA].[Hotel] A, 
				[gd_esquema].[Maestra] B,
				[BIG_DATA].[TipoHabitacion] C,
				[BIG_DATA].[Ciudad] D
		WHERE B.Hotel_Ciudad= D.ciudadNombre
			AND B.Hotel_Calle= A.direccionHotel
			AND B.Hotel_Nro_Calle= A.numeroCalle 
			AND B.Habitacion_Numero IS NOT NULL
			AND B.Habitacion_Tipo_Codigo = c.idTipoHabitacion
	 
	
--Migracion Tabla Reserva 
	SET IDENTITY_INSERT [BIG_DATA].[Reserva] ON

	INSERT INTO [BIG_DATA].[Reserva] (idReserva,fecha_Reserva_Desde,cantidadNoches,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente,idEstadoReserva)
		SELECT distinct m.Reserva_Codigo,m.Reserva_Fecha_Inicio,m.Reserva_Cant_Noches,t.idTipoHabitacion,h.idHotel,r.idRegimen,hab.idHabitacion,cl.idCliente,"er.idEstadoReserva"=
		(
		CASE WHEN m.Reserva_Fecha_Inicio < GETDATE()
			THEN 6
			ELSE 1
		END
		)
		FROM [gd_esquema].[Maestra] m,BIG_DATA.TipoHabitacion t, BIG_DATA.Hotel h,BIG_DATA.Ciudad c,BIG_DATA.Regimen r,BIG_DATA.Habitacion hab,BIG_DATA.Cliente cl,BIG_DATA.EstadoReserva er
		WHERE Habitacion_Tipo_Codigo=t.idTipoHabitacion AND
		(Hotel_Ciudad=c.ciudadNombre AND m.Hotel_Calle=h.direccionHotel AND m.Hotel_Nro_Calle=h.numeroCalle) AND
		(m.Regimen_Descripcion=r.descripcion) AND
		(m.Habitacion_Numero=hab.numeroHab and m.Habitacion_Piso=hab.piso and m.Habitacion_Frente=hab.vistaFrente and hab.idHotel=h.idHotel and Hotel_Ciudad=c.ciudadNombre AND m.Hotel_Calle=h.direccionHotel AND m.Hotel_Nro_Calle=h.numeroCalle) and
		(m.Cliente_Pasaporte_Nro=cl.documento and m.Cliente_Apellido=cl.apellido and m.Cliente_Nombre=cl.nombre)

	SET IDENTITY_INSERT [BIG_DATA].[Reserva] OFF


--Migracion Tabla Estadia
	INSERT INTO [BIG_DATA].[Estadia](fecha_Check_In,cantidadDias, idReserva)
		SELECT DISTINCT m.Estadia_Fecha_Inicio,m.Estadia_Cant_Noches, r.idReserva
		FROM [gd_esquema].[Maestra] M,BIG_DATA.Hotel H,BIG_DATA.Reserva R, BIG_DATA.Ciudad c
		WHERE M.Reserva_Codigo=R.idReserva AND [Estadia_Fecha_Inicio] IS NOT NULL AND m.Reserva_Codigo IS NOT NULL
	

--Migracion Tabla Factura	
	INSERT INTO [BIG_DATA].[Factura](numero,fecha,total,idCliente)
		SELECT DISTINCT m.Factura_Nro,m.Factura_Fecha,m.Factura_Total,c.idCliente
		FROM [gd_esquema].[Maestra] m,BIG_DATA.Reserva r, BIG_DATA.Cliente c,BIG_DATA.Hotel h,BIG_DATA.Ciudad cd
		WHERE m.Reserva_Codigo = r.idReserva and r.idHotel=h.idHotel and m.Factura_Nro IS NOT NULL and r.idCliente=c.idCliente 

	
--Migracion Tabla Item
	INSERT INTO [BIG_DATA].[Item](cantidad,monto,idFactura,idEstadia)
		SELECT DISTINCT Item_Factura_Cantidad,Item_Factura_Monto,f.idFactura,e.idEstadia
		FROM [gd_esquema].[Maestra] m,BIG_DATA.Factura f ,BIG_DATA.Estadia e, BIG_DATA.Reserva r
		WHERE m.Factura_Nro = f.numero AND r.idReserva = e.idReserva AND r.idReserva = m.Reserva_Codigo

	
--Adicion Valores Tabla RegimenXHotel
	INSERT INTO [BIG_DATA].[RegimenXHotel]
		SELECT distinct r.idRegimen,h.idHotel
		FROM [BIG_DATA].[Hotel] h,[gd_esquema].[Maestra] m, BIG_DATA.Regimen r, [BIG_DATA].[Ciudad] c
		WHERE(direccionHotel=Hotel_Calle AND c.ciudadNombre=Hotel_Ciudad AND numeroCalle=Hotel_Nro_Calle) 


--Adicion Valores Tabla UsuarioXHotel
	INSERT INTO [BIG_DATA].[UsuarioXHotel]
		SELECT idHotel,username
		FROM [BIG_DATA].[Usuario],[BIG_DATA].[Hotel]
		WHERE (username='Administrador' AND idHotel=1) OR
		(username='Recepcionista' AND idHotel=1) OR
		(username='Guest' AND idHotel=1)


--Adicion Valores Tabla FuncionXRol
	INSERT INTO [BIG_DATA].[FuncionXRol]
		SELECT idRol,idFuncion
		FROM [BIG_DATA].[Funcion],[BIG_DATA].[Rol]
		WHERE (rolDesc='Recepcionista' AND 
		funcionDesc IN ('ABM de Rol','Generar O Modificar una Reserva'))
		OR
		(rolDesc='Guest' AND 
		funcionDesc IN ('Generar O Modificar una Reserva'))
		OR
		(rolDesc='Administrador' AND 
		funcionDesc LIKE '%')


--Adicion Valores Tabla UsuarioXRol
	INSERT INTO [BIG_DATA].[UsuarioXRol] (username,idRol)
	SELECT u.username, r.idRol
	FROM [BIG_DATA].[Usuario] u,[BIG_DATA].[Rol] r
	WHERE (u.username='Administrador' and r.idRol=1) or 
	(u.username='Recepcionista' and r.idRol=2) or 
	(u.username='Guest' and r.idRol=3)or
	(u.username='Administrador' and r.idRol=2)

--Adicion Valores Tabla ConsumiblesXEstadia
	INSERT INTO [BIG_DATA].[ConsumibleXEstadia]
		SELECT e.idEstadia,c.idConsumible
		FROM [BIG_DATA].[Consumible] c,[BIG_DATA].[Estadia] e,[gd_esquema].[Maestra] m,BIG_DATA.Reserva r
		WHERE (m.Consumible_Codigo=c.idConsumible) AND (m.Reserva_Codigo = r.idReserva  and
		e.idReserva = r.idReserva and m.Factura_Nro IS NOT NULL)

GO

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------CREACION STORED PROCEDURES----------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

--Rol

CREATE PROCEDURE BIG_DATA.crear_rol
	@nombreRol nvarchar(255),
	@funcionalidad1 nvarchar(255),
	@funcionalidad2 nvarchar(255),
	@funcionalidad3 nvarchar(255),
	@funcionalidad4 nvarchar(255),
	@funcionalidad5 nvarchar(255),
	@funcionalidad6 nvarchar(255),
	@funcionalidad7 nvarchar(255),
	@funcionalidad8 nvarchar(255),
	@funcionalidad9 nvarchar(255),
	@funcionalidad10 nvarchar(255),
	@funcionalidad11 nvarchar(255),
	@funcionalidad12 nvarchar(255),
	@funcionalidad13 nvarchar(255),
	@estado bit
AS
BEGIN
	DECLARE @idRol numeric (18,0)
	IF NOT EXISTS (SELECT * FROM BIG_DATA.Rol WHERE rolDesc = @nombreRol)
BEGIN
	INSERT INTO BIG_DATA.Rol (rolDesc,estadoRol) VALUES (@nombreRol,@estado)
END

ELSE
BEGIN
	RAISERROR('Ya existe el rol.',16,1)
END
	SET @idRol = SCOPE_IDENTITY();
	INSERT INTO BIG_DATA.FuncionXRol (idRol,idFuncion) VALUES (@idRol,@funcionalidad1)
/*Se podria seguir asi pero algunas van a ser nulas y va a tirar error.. y lo que tmb estaba pensando 
es que capaz al declarar 13 funcionalidades.. capaz espera las 13 y tira error si lellegan menos*/
END
GO


--Quitar funcionalidad Rol

CREATE PROCEDURE BIG_DATA.quitar_funcionalidad
	@nombreRol nvarchar(255),
	@funcionalidad nvarchar(255)
AS
BEGIN
	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)
	DECLARE @idFuncion numeric (18,0) = (select idFuncion from BIG_DATA.Funcion f where f.funcionDesc = @funcionalidad)
	
	DELETE
	FROM BIG_DATA.FuncionXRol
	where idRol = @idRol AND idFuncion = @idFuncion
END
GO

--Agregar funcionalidad a Rol
CREATE PROCEDURE BIG_DATA.agregar_funcionalidad
	@nombreRol nvarchar(255),
	@funcionalidad nvarchar(255)

AS
BEGIN
	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)
	DECLARE @idFuncion numeric (18,0) = (select idFuncion from BIG_DATA.Funcion f where f.funcionDesc = @funcionalidad)

INSERT INTO BIG_DATA.FuncionXRol VALUES (@idRol,@idFuncion)

END

GO
--Eliminacion de Rol

CREATE PROCEDURE BIG_DATA.eliminar_rol
	@nombreRol nvarchar(255)

AS
BEGIN
	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)

	UPDATE BIG_DATA.Rol
	SET estadoRol = 0
	where idRol = @idRol
END

GO
--Habilitar Rol

CREATE PROCEDURE BIG_DATA.habilitar_rol
	@nombreRol nvarchar(255)

AS
BEGIN
	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)

	UPDATE BIG_DATA.Rol
	SET estadoRol = 1
	where idRol = @idRol
END

GO
--Mostrar roles para filtrado

CREATE PROCEDURE get_roles --ACA QUIZAS ALLA QUE PONER UNA VARIABLE TIPO TABLA COMO OUTPUT PARA Q FUNCIONE QUIZAS.. AUNQUE CAPAZ ASI FUNCIONA PARA EL C#
AS
BEGIN	
	select rolDesc from BIG_DATA.Rol
END

GO
--Crear Administrador o recepcionista

CREATE PROCEDURE BIG_DATA.crear_usuario
	@Username nvarchar(255),
	@Password nvarchar(20),
	@Rol numeric (18,0),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@TipoDocumento numeric(18, 0), 
	@Nrodocumento numeric (18,0),
	@Mail nvarchar(255),
	@Tel�fono numeric (18,0),
	@Direcci�n nvarchar (255),
	@FechaNacimiento datetime,
	@Hotel numeric(18, 0) --ACA HAY QUE VER SI MANEJAMOS NOMBRE DE HOTEL (POR AHORA NO TENEMOS NIGUNO) O BUSCAMOS POR VARIOS CAMPOS
	--DEPENDIENDO QUE USEMOS HAY QUE AGREGAR UN SEGUNDO INSERT COMO HICE EN EL PRIMER SP (despues del end catch), para agrgar a la tabla intermedia, no termina aca.
AS
BEGIN
	DECLARE @passwordEncriptada nvarchar(255) = cast((SELECT HASHBYTES('SHA2_256',@Password)) AS nvarchar(255))
	BEGIN TRY
			INSERT INTO BIG_DATA.Usuario (username,userpassword,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
	VALUES (@Username,@passwordEncriptada,@Rol,@Nombre,@Apellido,@TipoDocumento,@Nrodocumento,@Mail,@Tel�fono,@Direcci�n,@FechaNacimiento)


	INSERT INTO [BIG_DATA].[UsuarioXRol] (username,idRol) VALUES (@Username,@Rol)

	INSERT INTO [BIG_DATA].[UsuarioXHotel] (idHotel,username) VALUES (@Hotel,@Username)



	END TRY
	
	BEGIN CATCH
			RAISERROR('Campo invalido',16,1) --POR SI TIRA ERROR DE USERNAME O DE MAIL Q TIENEN Q SER UNICOS
	END CATCH
END

GO
--Crear Guest/Cliente

CREATE PROCEDURE BIG_DATA.crear_usuario_guest
	@Username nvarchar(255),
	@Password nvarchar(20),
	@Rol nvarchar(255),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@TipoDocumento numeric(18,0), 
	@Nrodocumento numeric (18,0),
	@Mail nvarchar(255),
	@Tel�fono numeric (18,0),
	@Direcci�n nvarchar (255),
	@FechaNacimiento datetime
AS
BEGIN
	DECLARE @passwordEncriptada nvarchar(255) = cast((SELECT HASHBYTES('SHA2_256',@Password)) AS nvarchar(255))
	BEGIN TRY
			INSERT INTO BIG_DATA.Usuario (username,userpassword,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
	VALUES (@Username,@passwordEncriptada,@Nombre,@Apellido,@TipoDocumento,@Nrodocumento,@Mail,@Tel�fono,@Direcci�n,@FechaNacimiento)
	INSERT INTO [BIG_DATA].[UsuarioXRol] (username,idRol) VALUES (@Username,@Rol)

	END TRY
	
	BEGIN CATCH
			RAISERROR('Campo invalido',16,1) --POR SI TIRA ERROR DE USERNAME O DE MAIL Q TIENEN Q SER UNICOS
	END CATCH
END

GO

--Modificar Password Usuario

CREATE PROCEDURE BIG_DATA.modificar_password

	@username nvarchar(255),
	@NuevoPassword nvarchar(20)
AS
BEGIN
	DECLARE @NuevoPasswordEncriptado nvarchar(20) = cast((SELECT HASHBYTES('SHA2_256',@NuevoPassword)) AS nvarchar(20))
	UPDATE BIG_DATA.Usuario
	SET userpassword = @NuevoPasswordEncriptado
	where username = @username

END

GO
--Baja Usuario

CREATE PROCEDURE BIG_DATA.baja_usuario

	@username nvarchar(255)

AS
BEGIN
	
	UPDATE BIG_DATA.Usuario
	SET estadoUsuario = 0
	WHERE username = @username

END

GO
--Habilitar Usuario

CREATE PROCEDURE BIG_DATA.alta_usuario

	@username nvarchar(255)

AS
BEGIN

	UPDATE BIG_DATA.Usuario
	SET estadoUsuario = 1
	WHERE username = @username

END

GO

--Login Usuario

CREATE PROCEDURE BIG_DATA.login_usuario
	
	@username nvarchar(255), 
	@password_ingresada nvarchar(20)

AS
BEGIN

	DECLARE @password nvarchar(20),
			@passwordEncriptada nvarchar(20),
			@intentos tinyint,
			@existe_usuario int,
			@usuario_habilitado bit

	SELECT @existe_usuario = COUNT(*)
	FROM BIG_DATA.Usuario
	WHERE username = @username


	IF @existe_usuario = 0
		BEGIN
			RAISERROR('El usuario no existe o los datos ingresados son incorrectos.', 16, 1)
			RETURN
		END


	SELECT @usuario_habilitado = estadoUsuario
	FROM BIG_DATA.Usuario
	WHERE username = @username

	IF @usuario_habilitado = 0
		BEGIN
			RAISERROR('El usuario ha sido inhabilitado. Por favor, cont�ctese con un administrador', 16, 1)
			RETURN
		END


	SELECT @password = userpassword
	FROM BIG_DATA.Usuario
	WHERE username = @username

	SELECT @passwordEncriptada = cast(HASHBYTES('SHA2_256',@password_ingresada) AS nvarchar(20))

	IF @password <> @passwordEncriptada
		BEGIN
			RAISERROR('Contrase�a incorrecta.', 16, 1)

			UPDATE BIG_DATA.Usuario
			SET user_intentos_fallidos = user_intentos_fallidos + 1
			WHERE username =  @username

			SELECT @intentos = user_intentos_fallidos
			FROM BIG_DATA.Usuario
			WHERE username = @username

			IF @intentos >= 3
			BEGIN
				RAISERROR('Ha ingresado la contrase�a 3 veces de forma incorrecta. El usuario ha sido inhabilitado', 16, 1)

				UPDATE BIG_DATA.Usuario
				SET estadoUsuario = 0
				WHERE username = @username

				RETURN
			END
		
		END
	ELSE
		BEGIN
			UPDATE BIG_DATA.Usuario
			SET user_intentos_fallidos = 0
			WHERE username = @username
			RETURN
		END
END

GO

--Crear Cliente

CREATE PROCEDURE BIG_DATA.crear_cliente

	@nombre nvarchar(255),
	@apellido nvarchar(255),
	@tipoDocumento numeric(18, 0),
	@numeroDocumento numeric (18,0),
	@mail nvarchar(255),
	@telefono numeric(18,0),
	@calle nvarchar(255),
	@nroCalle numeric(18,0),
	@departamento nvarchar(50),
	@piso numeric(18,0),
	@localidad nvarchar(255),
	@paisOrigen numeric(18, 0),
	@fechaNacimiento datetime,
	@nacionalidad numeric(18, 0)

AS
BEGIN
	DECLARE @existe_cliente INT

	SELECT @existe_cliente = COUNT(*)
	FROM BIG_DATA.Cliente
	WHERE tipo_Documento = @tipoDocumento AND documento = @numeroDocumento


	IF @existe_cliente = 1
		BEGIN
			RAISERROR('El cliente ya existe.', 16, 1)
			RETURN
		END

	BEGIN TRY

		
		INSERT INTO BIG_DATA.Cliente (nombre,apellido,tipo_Documento,documento,nacionalidad,
		mail,telefono,calle,numero_Calle,piso,departamento,localidad,paisOrigen,fecha_Nacimiento)
	
		VALUES (@nombre,@apellido,@tipoDocumento,@numeroDocumento,@nacionalidad,@mail,@telefono,
		@calle,@nroCalle,@piso,@departamento,@localidad,@paisOrigen,@fechaNacimiento) 

	END TRY
	
	BEGIN CATCH
			RAISERROR('Campo invalido',16,1) --DE MAIL Q TIENE Q SER UNICO
	END CATCH

END
GO

--Modificar Nombre
CREATE PROCEDURE BIG_DATA.modificar_nombre_Cliente
	@nombre nvarchar(255),
	@tipoDocumento numeric (18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET nombre = @nombre
	where tipo_Documento = @tipoDocumento AND documento = @documento
END
GO
--Modificar Apellido
CREATE PROCEDURE BIG_DATA.modificar_apellido_Cliente
	@apellido nvarchar(255),
	@tipoDocumento numeric (18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET apellido = @apellido
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO
--Modificar Tipo de identificacion
CREATE PROCEDURE BIG_DATA.modificar_tipoDocumento_Cliente
	@tipoDocumentoNuevo numeric(18,0),
	@tipoDocumentoViejo numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET tipo_Documento = @tipoDocumentoNuevo
	where tipo_Documento = @tipoDocumentoViejo AND documento = @documento

END
GO

--Modificar Numero de documento
CREATE PROCEDURE BIG_DATA.modificar_numeroDocumento_Cliente
	@documentoNuevo numeric(18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET documento = @documentoNuevo
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar Telefono
CREATE PROCEDURE BIG_DATA.modificar_telefono_Cliente
	@telefono numeric(18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)

AS
BEGIN
	
	UPDATE BIG_DATA.Cliente
	SET telefono = @telefono
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar Calle
CREATE PROCEDURE BIG_DATA.modificar_calle_Cliente
	@calle nvarchar(255),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	
	UPDATE BIG_DATA.Cliente
	SET calle = @calle
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar NroCalle
CREATE PROCEDURE BIG_DATA.modificar_numeroCalle_Cliente
	@numero numeric(18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET numero_Calle = @numero
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar dpto
CREATE PROCEDURE BIG_DATA.modificar_departamento_Cliente
	@dpto numeric(18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET departamento = @dpto
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar piso
CREATE PROCEDURE BIG_DATA.modificar_piso_Cliente
	@piso numeric (18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET piso = @piso
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar localidad
CREATE PROCEDURE BIG_DATA.modificar_localidad_Cliente
	@localidad nvarchar(255),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET localidad = @localidad
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO


--Modificar pais de origen
CREATE PROCEDURE BIG_DATA.modificar_paisOrigen_Cliente
	@pais numeric(18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET paisOrigen = @pais
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar fecha de nacimiento
CREATE PROCEDURE BIG_DATA.modificar_nacimiento_Cliente
	@nacimiento datetime,
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET fecha_Nacimiento = @nacimiento
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO

--Modificar nacionalidad
CREATE PROCEDURE BIG_DATA.modificar_nacionalidad_Cliente
	@nacionalidad numeric(18,0),
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0)
AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET nacionalidad = @nacionalidad
	where tipo_Documento = @tipoDocumento AND documento = @documento

END
GO


--Modificar Mail Cliente

CREATE PROCEDURE BIG_DATA.modificar_mail_Cliente
@tipoDocumento numeric (18,0),
@documento numeric(18,0),
@mail nvarchar(255)
AS
BEGIN
	BEGIN TRY
		UPDATE BIG_DATA.Cliente
		SET mail = @mail
		WHERE tipo_Documento = @tipoDocumento AND documento = @documento
	END TRY

	BEGIN CATCH
			RAISERROR('Mail invalido',16,1) --MAIL Q TIENE Q SER UNICO Y REBOTA POR EL UNIQUE DE LA TABLA
	END CATCH
END

GO
--habilitacion/Deshabilitar Cliente

CREATE PROCEDURE BIG_DATA.habilitacion_cliente
	
	@tipoDocumento numeric(18,0),
	@documento numeric(18,0),
	@estado bit

AS
BEGIN
	UPDATE BIG_DATA.Cliente
	SET estadoCliente = @estado
	WHERE tipo_Documento = @tipoDocumento AND documento = @documento
END
GO

--FALTA EL SELECCIONAR UN CLIENTE

--Filtrar cliente por nombre (Hay que ver si lo hacemos por parte del nombre o nombre exacto.. porque dice campo libre)

CREATE PROCEDURE BIG_DATA.filtrar_Cliente_Nombre
@nombre nvarchar(255)

AS 
BEGIN

SELECT idCliente, nombre, apellido, tipo_documento, documento
FROM BIG_DATA.Cliente
WHERE nombre LIKE '%'+@nombre+'%'

END
GO


--Filtrar cliente por apellido (Hay que ver si lo hacemos por parte del nombre o nombre exacto.. porque dice campo libre)

CREATE PROCEDURE BIG_DATA.filtrar_Cliente_Apellido
@apellido nvarchar(255)

AS 
BEGIN

SELECT idCliente, nombre, apellido, tipo_documento, documento
FROM BIG_DATA.Cliente
WHERE apellido LIKE '%'+@apellido+'%'

END
GO


--filtrar Cliente por tipo documento
CREATE PROCEDURE BIG_DATA.filtrar_Tipo_Documento
@tipoDocumento  numeric(18,0)

AS
BEGIN

SELECT idCliente, nombre, apellido, tipo_documento, documento
FROM BIG_DATA.Cliente
WHERE @tipoDocumento = tipo_Documento

END
GO

--filtrar Cliente por numero documento
CREATE PROCEDURE BIG_DATA.filtrar_Nro_Documento
@numero numeric (18,0)

AS
BEGIN

SELECT idCliente, nombre, apellido, tipo_documento, documento
FROM BIG_DATA.Cliente
WHERE documento LIKE ('%'+@numero+'%')

END
GO

--filtrar CLiente por mail (es unico)

CREATE PROCEDURE BIG_DATA.filtrar_CLiente_Mail

@mail nvarchar(255)

AS
BEGIN

SELECT idCliente, nombre, apellido, tipo_documento, documento
FROM BIG_DATA.Cliente
WHERE mail LIKE ('%'+@mail+'%')

END
GO








