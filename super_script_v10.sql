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
	estadoRol BIT DEFAULT 1,

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
	FOREIGN KEY (idPaisNacionalidad) REFERENCES BIG_DATA.PaisNacionalidad (idPaisNacionalidad)
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
	estadoCliente BIT DEFAULT 1
	
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
	fecha_Reserva_Hasta AS (fecha_Reserva_Desde+cantidadNoches),
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
	medioDePago NVARCHAR (255) DEFAULT 1,

	PRIMARY KEY (idFactura),
	FOREIGN KEY (idCliente) REFERENCES BIG_DATA.Cliente (idCliente),

)


CREATE TABLE BIG_DATA.TarjetaDeCredito (
	tarjetaDeCredito NUMERIC (16,0) NOT NULL,
	titular NVARCHAR(255),
	operadora NVARCHAR(255),
	idFactura NUMERIC (18,0) NOT NULL,

	PRIMARY KEY (TarjetaDeCredito,idFactura),
	FOREIGN KEY (idFactura) REFERENCES BIG_DATA.Factura (idFactura)
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
	cantidad int default 1,

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

/*
CREATE TRIGGER [BIG_DATA].[Reserva_fechaHasta_Trigger]
ON [BIG_DATA].[Reserva]
INSTEAD OF INSERT
AS
INSERT INTO [BIG_DATA].[Reserva] (fecha_Reserva_Desde,cantidadNoches,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente,idEstadoReserva,fecha_Reserva_Hasta,ultimaModificacionPor)
SELECT fecha_Reserva_Desde,cantidadNoches,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente,idEstadoReserva,(fecha_Reserva_Desde + cantidadNoches),ultimaModificacionPor FROM INSERTED
GO*/



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
		VALUES ('ARGENTINA','ARGENTINO'),('BRASIL','BRASILEÑO'),('CHILE','CHILENO'),('URUGUAY','URUGUAYO'),('MEXICO','MEXICANO'),('COLOMBIA','COLOMBIANO'),('BOLIVIA','BOLIVIANO'),
		('ESTADOS UNIDOS','ESTADOUNIDENSE'),('ALEMANIA','ALEMAN'),('CHINA','CHINO'),('JAPON','JAPONES'),
		--('OTRO EUROPA','EUROPEO'),('OTRO ASIA','ASIATICO'),('OTRO AFRICA','AFRICANO'),('OTRO OCEANIA','OCEANICO'),('OTRO AMERICA','AMERICANO')
		('OTRO','OTRA')

--Adicion Valores Tabla TipoDocumento
	INSERT INTO [BIG_DATA].TipoDocumento (tipoDocumentoDesc)
		VALUES ('Documento'),('Pasaporte'),('L.Civil'),('Licencia'),('Enrolamiento'),('Cuit'),('Cuil')

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

		UPDATE Big_data.hotel set nombreHotel = 'Hotel ' + convert(nvarchar,idHotel) FROM [BIG_DATA].[Hotel] --Hardcodeo de nombres hoteles

	
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

--Se da de alta un nuevo rol disponible.
GO
CREATE PROCEDURE [BIG_DATA].[Crear_Rol]
	@nombreRol nvarchar(255),
	@estado bit
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM BIG_DATA.Rol WHERE rolDesc = @nombreRol)
		BEGIN
			INSERT INTO BIG_DATA.Rol (rolDesc,estadoRol) VALUES (@nombreRol,@estado)
		END

	ELSE
		BEGIN
			RAISERROR('Ya existe el rol.',16,1)
		END
END

--Agrega una funcionalidad a un rol determinado.
GO
CREATE PROCEDURE [BIG_DATA].[Agregar_Funcionalidad]
	@nombreRol nvarchar(255),
	@funcionalidad nvarchar(255)

AS
BEGIN

	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)
	DECLARE @idFuncion numeric (18,0) = (select idFuncion from BIG_DATA.Funcion f where f.funcionDesc = @funcionalidad)
	
	IF NOT EXISTS (SELECT * FROM BIG_DATA.FuncionXRol WHERE idRol = @idRol AND idFuncion = @idFuncion)
	BEGIN
		INSERT INTO BIG_DATA.FuncionXRol VALUES (@idRol,@idFuncion)
	END
	ELSE
	BEGIN
		RAISERROR('El rol ya posee la funcionalidad.',16,1)
	END
END

--Quita una funcionalidad a un rol determinado.
GO
CREATE PROCEDURE BIG_DATA.Quitar_Funcionalidad
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


--Elimina un rol existente.
GO
CREATE PROCEDURE BIG_DATA.Eliminar_Rol
	@nombreRol nvarchar(255)
AS
BEGIN
	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)

	UPDATE BIG_DATA.Rol
	SET estadoRol = 0
	where idRol = @idRol
END


--Habilita o deshabilita un rol determinado.
GO
CREATE PROCEDURE BIG_DATA.Habilitar_Rol
	@nombreRol nvarchar(255)

AS
BEGIN
	DECLARE @idRol numeric(18,0) = (select idRol from BIG_DATA.Rol r where r.rolDesc = @nombreRol)

	UPDATE BIG_DATA.Rol
	SET estadoRol = 1
	where idRol = @idRol
END


--Crea un usuario según lo ingresado en ABM de Usuario
GO
CREATE PROCEDURE [BIG_DATA].[Crear_Usuario]
	@Username nvarchar(255),
	@Password nvarchar(20),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@TipoDocumento numeric(18, 0), 
	@Nrodocumento numeric (18,0),
	@Mail nvarchar(255),
	@Telefono numeric (18,0),
	@Dirección nvarchar (255),
	@FechaNacimiento datetime
AS
BEGIN
	DECLARE @passwordEncriptada nvarchar(255) = cast((SELECT HASHBYTES('SHA2_256',@Password)) AS nvarchar(255))
	BEGIN TRY
	
			INSERT INTO BIG_DATA.Usuario (username,userpassword,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
			VALUES (@Username,@passwordEncriptada,@Nombre,@Apellido,@TipoDocumento,@Nrodocumento,@Mail,@Telefono,@Dirección,@FechaNacimiento)

	END TRY
	
	BEGIN CATCH
			RAISERROR('El usuario ya se encuentra registrado',16,1) 
	END CATCH
END


--Modifica la password del usuario.
GO
CREATE PROCEDURE BIG_DATA.Modificar_Password

	@username nvarchar(255),
	@NuevoPassword nvarchar(20)
AS
BEGIN
	DECLARE @NuevoPasswordEncriptado nvarchar(20) = cast((SELECT HASHBYTES('SHA2_256',@NuevoPassword)) AS nvarchar(20))
	UPDATE BIG_DATA.Usuario
	SET userpassword = @NuevoPasswordEncriptado
	where username = @username

END



--Da de baja(lógica) a un Usuario determinado.
GO
CREATE PROCEDURE BIG_DATA.Baja_Usuario

	@username nvarchar(255)

AS
BEGIN
	
	UPDATE BIG_DATA.Usuario
	SET estadoUsuario = 0
	WHERE username = @username

END



--Da de alta (lógica) a un usuario determinado.
GO
CREATE PROCEDURE BIG_DATA.Alta_Usuario
	@username nvarchar(255)
AS
BEGIN

	UPDATE BIG_DATA.Usuario
	SET estadoUsuario = 1
	WHERE username = @username

END



--Permite el login de un Usuario al sistema.
GO
CREATE PROCEDURE BIG_DATA.Login_Usuario	
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
			RAISERROR('El usuario ha sido inhabilitado. Por favor, contáctese con un administrador', 16, 1)
			RETURN
		END


	SELECT @password = userpassword
	FROM BIG_DATA.Usuario
	WHERE username = @username

	SELECT @passwordEncriptada = cast(HASHBYTES('SHA2_256',@password_ingresada) AS nvarchar(20))

	IF @password <> @passwordEncriptada
		BEGIN
			RAISERROR('Contraseña incorrecta.', 16, 1)

			UPDATE BIG_DATA.Usuario
			SET user_intentos_fallidos = user_intentos_fallidos + 1
			WHERE username =  @username

			SELECT @intentos = user_intentos_fallidos
			FROM BIG_DATA.Usuario
			WHERE username = @username

			IF @intentos >= 3
			BEGIN
				RAISERROR('Ha ingresado la contraseña 3 veces de forma incorrecta. El usuario ha sido inhabilitado', 16, 1)

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

--Permite modificar el nombre de usuario de un usuario determinado.
GO
CREATE PROCEDURE [BIG_DATA].[Modificar_Usuario]
	@Username nvarchar(255),
	@NewUsername nvarchar (255),
	@Nombre nvarchar(255),
	@Apellido nvarchar(255),
	@TipoDocumento numeric(18, 0), 
	@Nrodocumento numeric (18,0),
	@Mail nvarchar(255),
	@Telefono numeric (18,0),
	@Dirección nvarchar (255),
	@FechaNacimiento datetime
AS
BEGIN
	DECLARE @existe int = 0

	IF @NewUsername != @Username
	BEGIN
		SET @existe = (SELECT COUNT(*) FROM BIG_DATA.Usuario WHERE username = @NewUsername)
	END

	IF (@existe > 0)
	BEGIN 
		RAISERROR('El nombre de usuario que se intenta asignar ya se encuentra registrado',16,1)
		RETURN
	END
	ELSE
	BEGIN
		DELETE BIG_DATA.UsuarioXHotel WHERE username = @Username
		DELETE BIG_DATA.UsuarioXRol WHERE username = @Username
		UPDATE BIG_DATA.Usuario
		   SET username = @NewUsername, nombre = @Nombre, apellido = @Apellido, tipo_Documento = @TipoDocumento, documento = @Nrodocumento, mail = @Mail, telefono = @Telefono, direccion = @Dirección, @FechaNacimiento = @FechaNacimiento
		 WHERE username = @Username
	END
END

--Le asigna un rol a un usuario en particular.
GO
CREATE PROCEDURE [BIG_DATA].[Asignar_Rol_Usuario]

	@username NVARCHAR(255),
	@Rol NVARCHAR(255)
AS
BEGIN
	
	DECLARE @idRol NUMERIC (18,0) = (SELECT idRol FROM BIG_DATA.Rol WHERE rolDesc = @Rol)
	INSERT INTO BIG_DATA.UsuarioXRol VALUES (@username, @idRol)

END

--Le da de alta a un nuevo hotel a un usuario en particular.
GO
CREATE PROCEDURE BIG_DATA.Asignar_Hotel_Usuario

	@username NVARCHAR(255),
	@Hotel NVARCHAR(255)
AS
BEGIN
	
	DECLARE @idHotel NUMERIC (18,0) = (SELECT idHotel FROM BIG_DATA.Hotel WHERE nombreHotel = @Hotel)
	INSERT INTO BIG_DATA.UsuarioXHotel VALUES (@idHotel, @username)

END



--Crea un Cliente según ABM de Cliente.
GO
CREATE PROCEDURE [BIG_DATA].[Crear_Cliente]

	@nombre nvarchar(255),
	@apellido nvarchar(255),
	@tipoDocumento nvarchar(255),
	@numeroDocumento numeric (18,0),
	@mail nvarchar(255),
	@telefono numeric(18,0),
	@calle nvarchar(255),
	@nroCalle numeric(18,0),
	@departamento nvarchar(50),
	@piso numeric(18,0),
	@localidad nvarchar(255),
	@paisOrigen nvarchar(255),
	@fechaNacimiento datetime,
	@nacionalidad nvarchar(255)

AS
BEGIN
	DECLARE @existe_cliente INT
	DECLARE @existe_mail INT
	DECLARE @tipoDoc numeric(18,0) = (SELECT idDocumento FROM BIG_DATA.TipoDocumento WHERE tipoDocumentoDesc = @tipoDocumento)

	SET @existe_cliente = (SELECT COUNT(*) FROM BIG_DATA.Cliente WHERE tipo_Documento = @tipoDoc AND documento = @numeroDocumento)

	IF @existe_cliente = 1
	BEGIN
		RAISERROR('El cliente ya se encuentra registrado en el sistema.', 16, 1)
		RETURN
	END

	SET @existe_mail = (SELECT COUNT(*) FROM BIG_DATA.Cliente WHERE mail = @mail)
	
	IF @existe_mail = 1
	BEGIN
		RAISERROR('El mail que intenta asignar ya se encuentra asociado a un cliente.', 16, 1)
		RETURN
	END
	
	BEGIN TRY
		
		IF @paisOrigen IS NOT NULL DECLARE @idPais NUMERIC (18,0) = (SELECT idPaisNacionalidad FROM BIG_DATA.PaisNacionalidad WHERE pais = @paisOrigen)
		DECLARE @idNacionalidad NUMERIC (18,0) = (SELECT idPaisNacionalidad FROM BIG_DATA.PaisNacionalidad WHERE nacionalidad = @nacionalidad)
		
		INSERT INTO BIG_DATA.Cliente (nombre,apellido,tipo_Documento,documento,nacionalidad,
		mail,telefono,calle,numero_Calle,piso,departamento,localidad,paisOrigen,fecha_Nacimiento)
	
		VALUES (@nombre,@apellido,@tipoDoc,@numeroDocumento,@idNacionalidad,@mail,@telefono,
		@calle,@nroCalle,@piso,@departamento,@localidad,@idPais,@fechaNacimiento) 

	END TRY
	
	BEGIN CATCH
			RAISERROR('Campo invalido',16,1) --DE MAIL Q TIENE Q SER UNICO
	END CATCH

END

--Obtiene todos los datos del cliente a través de su id.
GO
CREATE PROCEDURE [BIG_DATA].[Obtener_Cliente]
	@idCliente numeric (18,0)
AS
BEGIN
	
	SELECT nombre, apellido, tipoDocumentoDesc, documento, N.nacionalidad, mail, telefono, calle, numero_Calle, piso, departamento, localidad, paisOrigen, fecha_Nacimiento, estadoCliente 
	  FROM BIG_DATA.Cliente C, BIG_DATA.TipoDocumento, BIG_DATA.PaisNacionalidad N
	 WHERE idCliente = @idCliente AND N.idPaisNacionalidad = C.nacionalidad

END


--Modifica el/los campos del Cliente.
GO
CREATE PROCEDURE [BIG_DATA].[Modificar_Cliente] (
	@nombre nvarchar(255),
	@idCliente numeric(18,0),
	@apellido nvarchar(255),
	@tipoDocumento nvarchar(255),
	@documento numeric(18,0),
	@telefono numeric(18,0),
	@calle nvarchar(255),
	@numeroCalle numeric(18,0),
	@departamento nvarchar(50),
	@piso numeric(18,0),
	@localidad nvarchar(255),
	@paisOrigen nvarchar(50),
	@fechaNacimiento datetime,
	@nacionalidad nvarchar(50),
	@mail nvarchar(255)
	)
AS
BEGIN

	DECLARE @tipoDoc numeric(18,0) = (SELECT idDocumento FROM BIG_DATA.TipoDocumento WHERE tipoDocumentoDesc = @tipoDocumento)
	DECLARE @idDocumento NUMERIC(18,0) = (SELECT idDocumento FROM BIG_DATA.TipoDocumento WHERE tipoDocumentoDesc = @tipoDocumento)
	
	
	IF ((SELECT COUNT(*) FROM BIG_DATA.Cliente WHERE mail = @mail AND idCliente <> @idCliente) >  0) 
	BEGIN
		RAISERROR('El mail que se intenta asignar ya se encuentra registrado',16,1)
		RETURN
	END
	
	IF ((SELECT COUNT(*) FROM BIG_DATA.Cliente WHERE tipo_Documento = @idDocumento AND documento = @documento AND idCliente <> @idCliente) > 0)
	BEGIN
			RAISERROR('El tipo y numero de documento que se intentan asignar ya se encuentran registrados',16,1)
			RETURN
	END

	DECLARE @idNacionalidad NUMERIC(18,0) = (SELECT idPaisNacionalidad FROM BIG_DATA.PaisNacionalidad WHERE nacionalidad = @nacionalidad) 
	DECLARE @idPais NUMERIC(18,0) = (SELECT idPaisNacionalidad FROM BIG_DATA.PaisNacionalidad WHERE pais = @paisOrigen) 


	UPDATE BIG_DATA.Cliente
	SET nombre = @nombre, apellido = @apellido, tipo_Documento = @idDocumento, documento = @documento, mail = @mail, nacionalidad = @idNacionalidad, telefono = @telefono, calle = @calle, numero_Calle = @numeroCalle, piso = @piso, departamento = @departamento, localidad = @localidad, paisOrigen = @idPais, fecha_Nacimiento = @fechaNacimiento
	WHERE idCliente = @idCliente

END


--Habilita o deshabilita un Cliente.
GO
CREATE PROCEDURE BIG_DATA.Habilitacion_Cliente
	
	@tipoDocumento nvarchar(255),
	@documento numeric(18,0),
	@estado bit

AS
BEGIN
DECLARE @tipoDoc numeric(18,0) = (SELECT idDocumento FROM BIG_DATA.TipoDocumento WHERE tipoDocumentoDesc = @tipoDocumento)
	UPDATE BIG_DATA.Cliente
	SET estadoCliente = @estado
	WHERE tipo_Documento = @tipoDoc AND documento = @documento
END


--Filtra clientes por nombre.
GO
CREATE PROCEDURE BIG_DATA.Filtrar_Cliente_Nombre
@nombre nvarchar(255)

AS 
BEGIN

SELECT idCliente, nombre, apellido, tipoDocumentoDesc, documento
FROM BIG_DATA.Cliente c JOIN BIG_DATA.TipoDocumento td ON (c.tipo_Documento = td.idDocumento)
WHERE nombre LIKE '%'+@nombre+'%'

END



--Filtra clientes por apellido.
GO
CREATE PROCEDURE BIG_DATA.filtrar_Cliente_Apellido
@apellido nvarchar(255)

AS 
BEGIN

SELECT idCliente, nombre, apellido, tipoDocumentoDesc, documento
FROM BIG_DATA.Cliente c JOIN BIG_DATA.TipoDocumento td ON (c.tipo_Documento = td.idDocumento)
WHERE nombre LIKE '%'+@apellido+'%'
END


--Filtra clientes por tipo de documento.
GO
CREATE PROCEDURE BIG_DATA.Filtrar_Tipo_Documento
@tipoDocumento  nvarchar(255)

AS
BEGIN

SELECT idCliente, nombre, apellido, tipoDocumentoDesc, documento
FROM BIG_DATA.Cliente c JOIN BIG_DATA.TipoDocumento td ON (c.tipo_Documento = td.idDocumento)
WHERE @tipoDocumento = tipo_Documento

END


--Filtra clientes por número de documento.
GO
CREATE PROCEDURE BIG_DATA.filtrar_Nro_Documento
@numero numeric (18,0)

AS
BEGIN

SELECT idCliente, nombre, apellido, tipoDocumentoDesc, documento
FROM BIG_DATA.Cliente c JOIN BIG_DATA.TipoDocumento td ON (c.tipo_Documento = td.idDocumento)
WHERE documento LIKE ('%'+@numero+'%')

END


--Filtra clientes por mail.
GO
CREATE PROCEDURE BIG_DATA.filtrar_Cliente_Mail

@mail nvarchar(255)

AS
BEGIN

SELECT idCliente, nombre, apellido, tipoDocumentoDesc, documento
FROM BIG_DATA.Cliente c JOIN BIG_DATA.TipoDocumento td ON (c.tipo_Documento = td.idDocumento)
WHERE mail LIKE ('%'+@mail+'%')

END


--Crea un Hotel según ABM de Hotel.
GO
CREATE PROCEDURE BIG_DATA.Crear_Hotel
@nombre nvarchar(255),
@mail nvarchar(255),
@telefono numeric(18,0),
@direccion nvarchar(255),
@numeroCalle numeric(18,0),
@cantidadEstrellas numeric(18,0),
@ciudad numeric(18,0),
@pais numeric(18,0),
@fechaCreacion datetime,
@recarga numeric(18,0)

AS
BEGIN

IF NOT EXISTS (SELECT 1 FROM BIG_DATA.Hotel WHERE nombreHotel=@nombre)
	
	BEGIN
		BEGIN TRY
		INSERT INTO BIG_DATA.Hotel VALUES (@nombre,@mail,@telefono,@direccion,@cantidadEstrellas,@ciudad,@numeroCalle,@pais,@fechaCreacion,@recarga)	
		END TRY

		BEGIN CATCH
			RAISERROR('Error en carga',16,1)
		END CATCH
	END

ELSE
	BEGIN
		RAISERROR('El hotel ya existe',16,1)
	END

END
GO


--Agregar Regimen de Hotel
GO
CREATE PROCEDURE BIG_DATA.Agregar_Regimen
@Hotel nvarchar(255),
@Regimen nvarchar (255)

AS
BEGIN

DECLARE @idHotel NUMERIC (18,0) = (SELECT idHotel FROM BIG_DATA.Hotel WHERE nombreHotel = @hotel)
DECLARE @idRegimen NUMERIC (18,0) = (SELECT idRegimen FROM BIG_DATA.Regimen WHERE descripcion = @Regimen)
IF NOT EXISTS (SELECT 1 FROM BIG_DATA.RegimenXHotel WHERE idHotel = @idHotel AND idRegimen = @idRegimen)
	BEGIN TRY
	BEGIN	
		INSERT INTO BIG_DATA.RegimenXHotel VALUES(@idRegimen,@idHotel)
	END
	END TRY

	BEGIN CATCH
		RAISERROR('Error de carga',16,1)
	END CATCH
ELSE
	BEGIN
		RAISERROR('El hotel ya posee el regimen',16,1)
	END

END


--Modifica el/los campos del hotel.
GO
CREATE PROCEDURE BIG_DATA.Modificar_Hotel (
	@nombre nvarchar(255),
	@nuevoNombre nvarchar(255),
	@mail nvarchar(255),
	@telefono numeric(18,0),
	@direccion nvarchar(255),
	@cantidadEstrellas numeric(18,0),
	@ciudad nvarchar(255),
	@numeroCalle numeric(18,0),
	@pais nvarchar(50),
	@fecha datetime,
	@recarga numeric(18,0)
)

AS
BEGIN
	DECLARE @paisOrigen numeric(18,0) = (SELECT idPaisNacionalidad FROM BIG_DATA.PaisNacionalidad WHERE pais = @pais)
	DECLARE @ciudadHotel numeric(18,0) = (SELECT idCiudad FROM BIG_DATA.Ciudad WHERE  idPaisNacionalidad = @paisOrigen AND ciudadNombre = @ciudad)

	UPDATE BIG_DATA.Hotel
	SET nombreHotel = @nuevoNombre, mailHotel = @mail, telefonoHotel = @telefono, direccionHotel = @direccion,
	cantidadDeEstrellas = @cantidadEstrellas, idCiudad = @ciudadHotel, numeroCalle = @numeroCalle, paisHotel = @paisOrigen,
	fechaDeCreacion = @fecha
	WHERE nombreHotel = @nombre
END


--Quita un Régimen específico del hotel.
GO
CREATE PROCEDURE BIG_DATA.Quitar_Regimen_Hotel

@Hotel nvarchar(255),
@Regimen nvarchar(255)
AS
BEGIN

	DECLARE @idHotel NUMERIC (18,0) = (SELECT idHotel FROM BIG_DATA.Hotel WHERE nombreHotel = @hotel)
	DECLARE @idRegimen NUMERIC (18,0) = (SELECT idRegimen FROM BIG_DATA.Regimen WHERE descripcion = @Regimen)

	IF NOT EXISTS (SELECT 1 FROM BIG_DATA.RegimenXHotel WHERE idHotel = @idHotel AND idRegimen  =  @idRegimen)
	BEGIN
			RAISERROR('El hotel no posee ese regimen',16,1)
	END
	ELSE
	BEGIN	
			DELETE FROM BIG_DATA.RegimenXHotel
			WHERE idHotel = @idHotel AND idRegimen  =  @idRegimen
	END
END
	
	
--Da de baja (lógica) a un hotel.
GO
CREATE PROCEDURE BIG_DATA.Baja_Hotel

@FechaDesde datetime,
@FechaHasta datetime,
@Hotel nvarchar(255),
@Description nvarchar (255)

AS
BEGIN

	DECLARE @idHotel NUMERIC (18,0) = (SELECT idHotel FROM BIG_DATA.Hotel WHERE nombreHotel = @hotel)

	IF EXISTS (SELECT 1 FROM BIG_DATA.Reserva WHERE idHotel = @idHotel and 
	(
	(@FechaDesde BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
	(@FechaHasta BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
	(@FechaDesde <= fecha_Reserva_Desde AND @FechaHasta >= fecha_Reserva_Hasta)
	)
	)
	BEGIN
			RAISERROR('El hotel posee reservas activas para el rango de fechas indicados',16,1)
	END
	ELSE
	BEGIN	
			INSERT INTO BIG_DATA.CierreHotel (idHotel,fecha_Inicio,fecha_Fin,descripcion)
			VALUES(@idHotel,@FechaDesde,@FechaHasta,@Description)
	END
END


--Da de alta una nueva habitación en un hotel.
GO
CREATE PROCEDURE [BIG_DATA].[Crear_Habitacion]
@HotelID numeric(18,0),
@RoomNumber numeric(18,0),
@FloorNumber numeric(18,0),
@FrontView char(1),
@tipoHabitacion nvarchar(255),
@Comodidades nvarchar(255)
AS
BEGIN
	
	IF  EXISTS (SELECT 1 FROM BIG_DATA.Habitacion WHERE idHotel = @HotelID and numeroHab = @RoomNumber ) 

	BEGIN
		DECLARE @HabitacionNumeroString VARCHAR(50)
		SELECT @HabitacionNumeroString = CAST(@RoomNumber AS VARCHAR)
		RAISERROR('El hotel ya posee la habitacion %s en el sistema' ,16,1,@HabitacionNumeroString)
	END
	ELSE
	BEGIN	
		DECLARE @idTipo numeric(18,0) = (SELECT idTipoHabitacion FROM BIG_DATA.TipoHabitacion WHERE descripcion = @tipoHabitacion)

		INSERT INTO BIG_DATA.Habitacion (idHotel,numeroHab,piso,vistaFrente,idTipo,comodidades)
		VALUES(@HotelID,@RoomNumber,@FloorNumber,@FrontView,@idTipo,@Comodidades)
	END
END


--Modifica el/los campos de la habitación.
GO
CREATE PROCEDURE BIG_DATA.Modificar_Habitacion
@HotelID numeric(18,0),
@RoomNumber numeric(18,0),
@FloorNumber numeric(18,0),
@FrontView char(1),
@Comodidades nvarchar(255)
AS
BEGIN
	UPDATE BIG_DATA.Habitacion SET piso=@FloorNumber ,vistaFrente=@FrontView ,comodidades=@FrontView
	where idHotel=@HotelID and numeroHab=@RoomNumber
END


--Obtiene los datos de una habitacion para un hotel en particular.
GO
CREATE PROCEDURE BIG_DATA.Obtener_Habitacion
@hotel NUMERIC (18,0),
@numeroHab NUMERIC(18,0)
AS
BEGIN
	SELECT piso, vistaFrente, descripcion, comodidades, habitacionActiva 
	  FROM BIG_DATA.Habitacion A, BIG_DATA.TipoHabitacion B
	 WHERE idTipo = idTipoHabitacion AND A.idHotel = @hotel AND A.numeroHab = @numeroHab

END


--Da de baja una habitación del hotel.
GO
CREATE PROCEDURE BIG_DATA.Baja_Habitacion

@HotelID numeric(18,0),
@RoomNumber numeric(18,0)

AS
BEGIN
	UPDATE BIG_DATA.Habitacion SET habitacionActiva = 0
	where idHotel=@HotelID and numeroHab=@RoomNumber
END

--Habilita una habitación para que se muestre como disponible para su uso.
GO
CREATE PROCEDURE BIG_DATA.Habilitar_habitacion

@HotelID numeric(18,0),
@RoomNumber numeric(18,0)

AS
BEGIN
	UPDATE BIG_DATA.Habitacion SET habitacionActiva = 1
	where idHotel=@HotelID and numeroHab=@RoomNumber
END


--Cancela una reserva realizada.
GO
CREATE PROCEDURE BIG_DATA.Cancelar_Reserva (
@numeroReserva numeric(18,0),
@motivo nvarchar (255),
@fechaCancelacion datetime,
@username nvarchar(255)
)

AS 
BEGIN

	DECLARE @estadoReserva numeric(18,0) = (SELECT idEstadoREserva FROM BIG_DATA.EstadoReserva WHERE estadoReservaDesc = @motivo)

	DECLARE @fechaReserva datetime = (SELECT fecha_Reserva_Desde FROM BIG_DATA.Reserva WHERE idReserva = @numeroReserva)
	IF(@fechaCancelacioN >= @fechaReserva)
		BEGIN
		RAISERROR('Ya es tarde para cancelar reserva',16,1)
		END
	ELSE
		BEGIN
	
	UPDATE BIG_DATA.Reserva
	SET idEstadoReserva = @estadoReserva, fecha_Reserva_Realizada=@fechaCancelacion
	WHERE idReserva = @numeroReserva
	END
END


--Muestra para los filtros aplicados cuales son las habitaciones disponibles y los precios.
GO
CREATE PROCEDURE BIG_DATA.Registrar_Reserva

	@HotelId numeric(18,0),
	@FechaDesde datetime,
	@FechaHasta datetime,
	@tipoHabitacion numeric(18,0),
	@regimen numeric(18,0)

	AS
	BEGIN

	if @regimen IS NULL

	BEGIN

	
		SELECT distinct h.nombreHotel, hab.numeroHab as HABITACION, r.descripcion AS REGIMEN, CONVERT(NUMERIC(16,2),(th.precio * recargaEstrella * r.precio)) as 'Precio por Noche', CONVERT(NUMERIC(16,2),(th.precio * recargaEstrella * r.precio * ABS(DATEDIFF(day,@fechaHasta,@FechaDesde)))) as 'Precio Total'
		from big_data.habitacion hab,big_data.hotel h,big_data.TipoHabitacion th,BIG_DATA.regimen r,big_data.RegimenXHotel rxh--,BIG_DATA.Reserva res
		WHERE idHabitacion not in
		(select idHabitacion from big_data.reserva where 
		(@FechaDesde BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
		(@FechaHasta BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
		(@FechaDesde <= fecha_Reserva_Desde AND @FechaHasta >= fecha_Reserva_Hasta)
		)
		AND h.idHotel not in
		(select idHotel from big_data.CierreHotel where
		(@FechaDesde BETWEEN fecha_Inicio AND fecha_Fin) OR 
		(@FechaHasta BETWEEN fecha_Inicio AND fecha_Fin) OR 
		(@FechaDesde <= fecha_Inicio AND @FechaHasta >= fecha_Fin)
		)
		AND
		idTipo = @tipoHabitacion
	
		AND hab.idHotel = h.idHotel
		AND hab.idTipo = th.idTipoHabitacion
		AND hab.idHotel = rxh.idHotel
		AND rxh.idRegimen = r.idRegimen
		AND hab.habitacionActiva = 1
		AND h.idHotel = @HotelId
		--OR (hab.idHabitacion=Re.idHabitacion AND res.idEstadoReserva in(3,4,5))

	END

	ELSE

	BEGIN

	
		SELECT distinct h.nombreHotel,hab.numeroHab as HABITACION, r.descripcion AS REGIMEN, CONVERT(NUMERIC(16,2),(th.precio * recargaEstrella * r.precio)) as 'Precio por Noche', CONVERT(NUMERIC(16,2),(th.precio * recargaEstrella * r.precio * ABS(DATEDIFF(day,@fechaHasta,@FechaDesde)))) as 'Precio Total'
		from big_data.habitacion hab,big_data.hotel h,big_data.TipoHabitacion th,BIG_DATA.regimen r,big_data.RegimenXHotel rxh 
		WHERE idHabitacion not in
		(select idHabitacion from big_data.reserva where 
		(@FechaDesde BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
		(@FechaHasta BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
		(@FechaDesde <= fecha_Reserva_Desde AND @FechaHasta >= fecha_Reserva_Hasta)
		)

		AND h.idHotel not in
		(select idHotel from big_data.CierreHotel where
		(@FechaDesde BETWEEN fecha_Inicio AND fecha_Fin) OR 
		(@FechaHasta BETWEEN fecha_Inicio AND fecha_Fin) OR 
		(@FechaDesde <= fecha_Inicio AND @FechaHasta >= fecha_Fin)
		)
				
		AND
		idTipo = @tipoHabitacion
		AND hab.idHotel = h.idHotel
		AND hab.idTipo = th.idTipoHabitacion
		AND hab.idHotel = rxh.idHotel
		AND rxh.idRegimen = r.idRegimen
		AND rxh.idRegimenHotel = @regimen
		AND hab.habitacionActiva = 1
		AND rxh.idRegimen = @regimen
		AND h.idHotel = @HotelId

	END
END


--Inserta (o da de alta) una reserva.
GO
CREATE PROCEDURE BIG_DATA.Insertar_Reserva

	@HotelId numeric(18,0),
	@FechaDesde datetime,
	@FechaHasta datetime,
	@FechaReservaRealizada datetime,
	@numeroHab numeric(18,0),
	@idRegimen numeric(18,0),
	@idTipoHab numeric(18,0),
	@idCliente numeric(18,0),
	@ultimaModificacionUsuario NVARCHAR(255)

AS
BEGIN

	INSERT INTO BIG_DATA.Reserva (cantidadNoches,fecha_Reserva_Desde,fecha_Reserva_Realizada,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente,idEstadoReserva,ultimaModificacionPor)
	VALUES
	( ABS(DATEDIFF(day,@FechaHasta,@FechaDesde)),@FechaDesde,@FechaReservaRealizada,@idTipoHab,@HotelId,@idRegimen,(select idHabitacion from BIG_DATA.Habitacion where numeroHab=@numeroHab and idHotel=@HotelId),@idCliente,1,@ultimaModificacionUsuario)

	SELECT MAX(idReserva) as NumeroReserva FROM BIG_DATA.Reserva
END


--Listado de los hoteles con máxima cantidad de reservas.
GO
CREATE PROCEDURE BIG_DATA.Hoteles_Max_Reservas

	@FechaDesde datetime,
	@FechaHasta datetime

	AS 
	BEGIN

select top 5 h.nombreHotel, Count(r.idEstadoReserva) as 'Cantidad Reservas Canceladas' from big_data.Reserva r inner join big_data.Hotel h on (h.idHotel=r.idHotel)
where idEstadoReserva in (3,4,5)
and (
(@FechaDesde BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
		(@FechaHasta BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
		(@FechaDesde <= fecha_Reserva_Desde AND @FechaHasta >= fecha_Reserva_Hasta))
		
Group By h.nombreHotel
Order by 2 Desc

END

--Listado de hoteles con máxima cantidad de consumibles.
GO
CREATE PROCEDURE BIG_DATA.Hoteles_Max_Consumibles

	@FechaDesde datetime,
	@FechaHasta datetime

	AS 
	BEGIN

select top 5 h.nombreHotel,count(c.idConsumible) as 'Cantidad Consumibles Adquiridos' from big_data.hotel h, big_data.ConsumibleXEstadia ce, big_data.Estadia e, big_data.Reserva r, big_data.consumible c

where
ce.idEstadia = e.idEstadia
and e.idReserva = r.idReserva
and r.idHotel = h.idhotel
and
(
(@FechaDesde BETWEEN fecha_Check_In AND fecha_Check_Out) OR 
		(@FechaHasta BETWEEN fecha_Check_In AND fecha_Check_Out) OR 
		(@FechaDesde <= fecha_Check_In AND @FechaHasta >= fecha_Check_Out))

group by h.nombreHotel
Order by 2 Desc

END

--Listado de hoteles con máxima cantidad de días fuera de servicio.
GO
CREATE PROCEDURE BIG_DATA.Hoteles_Max_FueraDeServicio
	@FechaDesde datetime,
	@FechaHasta datetime

AS 
BEGIN

select top 5 h.nombreHotel,count(ch.idHotel) as 'Cantidad de Cierres' from BIG_DATA.hotel h, BIG_DATA.CierreHotel ch
where ch.idHotel=h.idHotel
and(
(@FechaDesde BETWEEN fecha_inicio AND fecha_Fin) OR 
		(@FechaHasta BETWEEN fecha_inicio AND fecha_Fin) OR 
		(@FechaDesde <= fecha_inicio AND @FechaHasta >= fecha_Fin))
group by h.nombreHotel
Order by 2 Desc

END

--Listado de habitaciones con máxima cantidad de días que fueron ocupadas.
GO
CREATE PROCEDURE BIG_DATA.Habitaciones_Stats
@FechaDesde datetime,
@FechaHasta datetime

AS 
BEGIN

	select distinct top 5 hab.numeroHab, h.nombreHotel,  sum(r.cantidadNoches) as 'Cantidad de dias ocupada', count( r.idHabitacion) as 'Cantidad de veces Ocupada' from big_data.reserva r, big_data.Hotel h, big_data.Habitacion hab
	where h.idHotel=r.idHotel
	and hab.idHabitacion = r.idHabitacion
	AND(
	(@FechaDesde BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
			(@FechaHasta BETWEEN fecha_Reserva_Desde AND fecha_Reserva_Hasta) OR 
			(@FechaDesde <= fecha_Reserva_Desde AND @FechaHasta >= fecha_Reserva_Hasta))
	group by h.nombreHotel,hab.numeroHab
	order by 3 DESC ,4 desc

END


--Confirma la presencia del cliente para la reserva realizada.
GO
CREATE PROCEDURE BIG_DATA.Ingresar_Check_In 
@idReserva numeric (18,0),
@fecha_ing datetime,
@username nvarchar(255),
@idHotel numeric(18, 0)
AS
BEGIN

if (select count(uh.idHotel) from [BIG_DATA].[UsuarioXHotel] uh where uh.idHotel=@idHotel and uh.idUsuarioHotel=@username )>0
	begin	
	
		IF NOT EXISTS (SELECT 1 FROM BIG_DATA.Reserva WHERE idReserva = @idReserva)
			BEGIN
				RAISERROR('La reserva no existe',16,1)
				return
			END
	
		ELSE IF ((SELECT fecha_Reserva_Desde FROM BIG_DATA.Reserva WHERE idReserva = @idReserva) >= @fecha_ing)
			BEGIN
			INSERT INTO BIG_DATA.Estadia(idReserva,fecha_Check_In) VALUES (@idReserva,@fecha_ing)
			UPDATE [BIG_DATA].[Reserva] SET idEstadoReserva=6 WHERE idReserva=@idReserva	

			END
		ELSE
			BEGIN
			RAISERROR('La reserva quedo sin validez',16,1)
			return
			END
	end
	else
	begin
		RAISERROR('El usuario no esta habilitado para ejecutar cambios en este hotel',16,1);
		return
	end


END

--Se procede a realizar la salida del cliente del hotel, realizando los cambios como para dejar por sentado que finalizó su estadía en el hotel.
GO
CREATE PROCEDURE BIG_DATA.Ingresar_Check_Out 
@idReserva numeric(18,0),
@fecha_eg datetime,
@username nvarchar(255),
@idHotel numeric(18, 0)
AS
BEGIN

	if (select count(uh.idHotel) from [BIG_DATA].[UsuarioXHotel] uh where uh.idHotel=@idHotel and uh.idUsuarioHotel=@username )>0
	begin	
			if ((select e.fecha_Check_Out from [BIG_DATA].[Estadia] e where e.idReserva=@idReserva)=null and 
			(select e.fecha_Check_In from [BIG_DATA].[Estadia] e where e.idReserva=@idReserva)!=NULL)
	
			begin

				DECLARE @fechaIn datetime = (SELECT fecha_Check_In FROM BIG_DATA.Estadia WHERE idReserva = @idReserva)
				DECLARE @cantidadDias numeric (18,0) = (CAST(DATEDIFF(day,@fechaIn,GETDATE()) AS numeric(18,0)))


				UPDATE BIG_DATA.Estadia
				SET fecha_Check_Out = @fecha_eg, cantidadDias = @cantidadDias
				WHERE idReserva = @idReserva
			
			end
			else
			begin
				RAISERROR('No se puede realizar el chekout de una reserva sin haber hecho el check-in',16,1);
				return
			end
	end
	else
	begin
		RAISERROR('El usuario no esta habilitado para ejecutar cambios en este hotel',16,1);
		return
	end
end


--Se procede a registrar cada uno de los consumibles que consumió el cliente mientras se hospedó en el hotel.
GO
CREATE PROCEDURE BIG_DATA.Registrar_Consumible
@idReserva numeric(18, 0),
@consumibleDesc varchar(255),
@cantidad int
as 
begin

	declare @idEstadia numeric(18, 0)
	select @idEstadia  =e.idEstadia from [BIG_DATA].[Estadia] e where e.idReserva= @idReserva

	declare @idConsumible numeric(18,0)
	select @idConsumible=c.idConsumible from [BIG_DATA].[Consumible] c where c.consumibleDesc=@consumibleDesc

	insert into [BIG_DATA].[ConsumibleXEstadia](idEstadia,idConsumible,cantidad) values (@idEstadia, @idConsumible,@cantidad)
	

end

--Se procede a realizar el conteo de la cantidad de días que el cliente permaneció en el hotel , si cumplió con el total del tiempo reservado o cuantos días antes se fue.
GO
CREATE procedure [BIG_DATA].[Obtener_Dias]
@idReserva numeric (18,0)
as
begin

	
	declare @idEstadia numeric (18,0)
	select @idEstadia=e.idEstadia from BIG_DATA.Estadia e where e.idReserva=@idReserva

	
	SELECT 'Dias alojado' AS DESCRIPCION, CONVERT(NUMERIC(16,2),(R.precio * T.precio * H.cantidadDeEstrellas) * E.cantidadDias) AS TOTAL, e.cantidadDias AS CANTIDAD
	  FROM BIG_DATA.TipoHabitacion T, BIG_DATA.Regimen R, BIG_DATA.Hotel H, BIG_DATA.Reserva RE, BIG_DATA.Estadia E 
	  where e.idReserva=re.idReserva and re.idHotel=h.idHotel and r.idRegimen=re.idRegimen and re.idTipoHabitacion=t.idTipoHabitacion and e.idReserva=@idReserva
	UNION
	SELECT 'Dias no alojado'AS DESCRIPCION, ISNULL(CONVERT(NUMERIC(16,2),(R.precio * T.precio * H.cantidadDeEstrellas) * (ABS(DATEDIFF(day,re.fecha_Reserva_Hasta,e.fecha_Check_Out)))),0) AS TOTAL, ISNULL(ABS(DATEDIFF(day,re.fecha_Reserva_Hasta,e.fecha_Check_Out)),0) as cantidad
	FROM BIG_DATA.TipoHabitacion T, BIG_DATA.Regimen R, BIG_DATA.Hotel H, BIG_DATA.Reserva RE, BIG_DATA.Estadia E 
	  where e.idReserva=re.idReserva and re.idHotel=h.idHotel and r.idRegimen=re.idRegimen and re.idTipoHabitacion=t.idTipoHabitacion and e.idReserva=@idReserva
	 UNION		
	SELECT c.consumibleDesc AS DESCRIPCION, (c.consumiblePrecio*ce.cantidad) AS TOTAL,ce.cantidad AS CANTIDAD
	 FROM BIG_DATA.ConsumibleXEstadia ce inner join BIG_DATA.Consumible c on c.idConsumible=ce.idConsumible 
	 WHERE ce.idEstadia=@idEstadia
	UNION 
	SELECT 'Descuento por regimen de estadia', SUM(c.consumiblePrecio*ce.cantidad) * -1 AS TOTAL, SUM(ce.cantidad) AS CANTIDAD 
	FROM BIG_DATA.ConsumibleXEstadia ce, BIG_DATA.Consumible c,  BIG_DATA.Estadia es, BIG_DATA.Reserva r
	WHERE ce.idConsumible = c.idConsumible AND ce.idEstadia = es.idEstadia AND es.idReserva = r.idReserva AND ce.idEstadia=@idEstadia
	  AND r.idRegimen = 4
	GROUP BY es.idEstadia
end



---Selecciona que consumibles se consumieron en una determinada estadía.
GO
create procedure BIG_DATA.Consumibles_Reservas
@idReserva numeric (18,0)
as
BEGIN
	
	declare @idEstadia numeric (18,0)
	select @idEstadia=e.idEstadia from BIG_DATA.Estadia e where e.idReserva=@idReserva


	SELECT c.consumibleDesc,ce.cantidad,(c.consumiblePrecio*ce.cantidad) as total
	FROM BIG_DATA.ConsumibleXEstadia ce inner join BIG_DATA.Consumible c on c.idConsumible=ce.idConsumibleEstadia WHERE ce.idEstadia=@idEstadia

END



--Carga los diferentes ítems que se mostrarán en una factura para una estadía determinada.
GO
CREATE PROCEDURE BIG_DATA.Insertar_Items
@idReserva numeric (18,0),
@monto numeric(18, 2),
@cantidad numeric(18, 0)
as
begin
			
	declare @idEstadia numeric (18,0)
	select @idEstadia=e.idEstadia from BIG_DATA.Estadia e where e.idReserva=@idReserva

	declare @idFactura numeric(18, 0)
	select   @idFactura=max(f.idFactura) from [BIG_DATA].[Factura] f 

	insert into [BIG_DATA].[Item] values (@idFactura,@cantidad,@monto,@idEstadia)

END

--Crea una nueva factura para una estadía determinada.
GO
create procedure BIG_DATA.Crear_Factura
@idReserva numeric (18,0),
@total numeric(18, 2),
@fecha datetime,
@medioDePago NVARCHAR(255),
@tarjetaDeCredito NUMERIC (16,0),
@titular NVARCHAR(255),
@operadora NVARCHAR(255)
	
as 
BEGIN

	declare @idEstadia numeric (18,0)
	select @idEstadia=e.idEstadia from BIG_DATA.Estadia e where e.idReserva=@idReserva

	declare @idCliente numeric (18,0)
	select @idcliente=r.idCliente from [BIG_DATA].[Reserva] r where r.idReserva=@idReserva

	insert into [BIG_DATA].[Factura] values ((select top 1 numero from Factura order by numero desc)+1,@fecha,@total,@idCliente,@medioDePago)

	if @medioDePago='TARJETA DE CREDITO'
	begin
		insert into BIG_DATA.TarjetaDeCredito values (@tarjetaDeCredito,@titular,@operadora,(select max(f.idFactura) from [BIG_DATA].[Factura] f))
	end

END
	

