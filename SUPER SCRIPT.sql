
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------ELIMINAR TODO-----------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

DECLARE @Sql VARCHAR(MAX)
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

PRINT @Sql

ALTER TABLE BIG_DATA.CierreHotel drop constraint FK__CierreHot__idHot__2CDD9F46;ALTER TABLE BIG_DATA.Cliente drop constraint FK__Cliente__tipo_Do__15FA39EE;ALTER TABLE BIG_DATA.Cliente drop constraint FK__Cliente__naciona__16EE5E27;ALTER TABLE BIG_DATA.Cliente drop constraint FK__Cliente__paisOri__17E28260;ALTER TABLE BIG_DATA.ConsumibleXEstadia drop constraint FK__Consumibl__idEst__469D7149;ALTER TABLE BIG_DATA.ConsumibleXEstadia drop constraint FK__Consumibl__idCon__47919582;ALTER TABLE BIG_DATA.Estadia drop constraint FK__Estadia__idReser__2FBA0BF1;ALTER TABLE BIG_DATA.Factura drop constraint FK__Factura__idEstad__3296789C;ALTER TABLE BIG_DATA.FuncionXRol drop constraint FK__FuncionXR__idRol__42CCE065;ALTER TABLE BIG_DATA.FuncionXRol drop constraint FK__FuncionXR__idFun__43C1049E;ALTER TABLE BIG_DATA.Habitacion drop constraint FK__Habitacio__idTip__1CA7377D;ALTER TABLE BIG_DATA.Hotel drop constraint FK__Hotel__paisHotel__0D64F3ED;ALTER TABLE BIG_DATA.Item drop constraint FK__Item__idFactura__3572E547;ALTER TABLE BIG_DATA.Item drop constraint FK__Item__idEstadia__36670980;ALTER TABLE BIG_DATA.RegimenXHotel drop constraint FK__RegimenXH__idReg__3B2BBE9D;ALTER TABLE BIG_DATA.RegimenXHotel drop constraint FK__RegimenXH__idHot__3C1FE2D6;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idTipoH__2354350C;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idHotel__24485945;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idRegim__253C7D7E;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idHabit__2630A1B7;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idClien__2724C5F0;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idEstad__2818EA29;ALTER TABLE BIG_DATA.Usuario drop constraint FK__Usuario__idRol__10416098;ALTER TABLE BIG_DATA.Usuario drop constraint FK__Usuario__tipo_Do__113584D1;ALTER TABLE BIG_DATA.UsuarioXHotel drop constraint FK__UsuarioXH__idHot__3EFC4F81;ALTER TABLE BIG_DATA.UsuarioXHotel drop constraint FK__UsuarioXH__usern__3FF073BA;DROP TABLE BIG_DATA.[CierreHotel];DROP TABLE BIG_DATA.[Cliente];DROP TABLE BIG_DATA.[Consumible];DROP TABLE BIG_DATA.[ConsumibleXEstadia];DROP TABLE BIG_DATA.[Estadia];DROP TABLE BIG_DATA.[EstadoReserva];DROP TABLE BIG_DATA.[Factura];DROP TABLE BIG_DATA.[Funcion];DROP TABLE BIG_DATA.[FuncionXRol];DROP TABLE BIG_DATA.[Habitacion];DROP TABLE BIG_DATA.[Hotel];DROP TABLE BIG_DATA.[Item];DROP TABLE BIG_DATA.[PaisNacionalidad];DROP TABLE BIG_DATA.[Regimen];DROP TABLE BIG_DATA.[RegimenXHotel];DROP TABLE BIG_DATA.[Reserva];DROP TABLE BIG_DATA.[Rol];DROP TABLE BIG_DATA.[TipoDocumento];DROP TABLE BIG_DATA.[TipoHabitacion];DROP TABLE BIG_DATA.[Usuario];DROP TABLE BIG_DATA.[UsuarioXHotel];




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

CREATE TABLE BIG_DATA.Regimen (
	idRegimen NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	nombre NVARCHAR (255),
	descripcion NVARCHAR (255),
	precio MONEY,
	estado BIT,
	PRIMARY KEY (idRegimen)
)


CREATE TABLE BIG_DATA.PaisNacionalidad (
	idPaisNacionalidad NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	pais NVARCHAR (50),
	nacionalidad NVARCHAR (50),
	PRIMARY KEY (idPaisNacionalidad)
)

CREATE TABLE BIG_DATA.TipoDocumento (
	idDocumento NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	tipoDocumentoDesc NVARCHAR (5),
	PRIMARY KEY (idDocumento)
)


CREATE TABLE BIG_DATA.Rol (
	idRol NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	rolDesc NVARCHAR (255),
	PRIMARY KEY (idRol)
)

CREATE TABLE BIG_DATA.Hotel (
	idHotel NUMERIC(18,0) IDENTITY (1,1) NOT NULL,
	nombreHotel NVARCHAR (255),
	mailHotel NVARCHAR (255),
	telefonoHotel NUMERIC (18,0),
	direccionHotel NVARCHAR(255) ,
	cantidadDeEstrellas NUMERIC (18,0),
	ciudadHotel NVARCHAR (255) ,
	numeroCalle NUMERIC (18,0),
	paisHotel NUMERIC (18,0),
	fechaDeCreacion DATETIME,
	recargaEstrella NUMERIC (18,0)
	PRIMARY KEY(idHotel),
	FOREIGN KEY (paisHotel) REFERENCES [BIG_DATA].[PaisNacionalidad](idPaisNacionalidad),
)

CREATE TABLE BIG_DATA.Usuario (
	username NVARCHAR (255) NOT NULL,
	userpassword NVARCHAR (20),
	idRol NUMERIC (18,0),
	nombre NVARCHAR (255),
	apellido NVARCHAR (255),
	tipo_Documento NUMERIC (18,0),
	documento NUMERIC (18,0),
	mail NVARCHAR (255),
	telefono NUMERIC (18,0),
	direccion NVARCHAR (255),
	fecha_Nacimiento DATETIME,
	PRIMARY KEY (username),
	FOREIGN KEY (idRol) REFERENCES BIG_DATA.Rol (idRol),
	FOREIGN KEY (tipo_documento) REFERENCES BIG_DATA.TipoDocumento (idDocumento)
)

CREATE TABLE BIG_DATA.TipoHabitacion (
	idTipoHabitacion NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	descripcion NVARCHAR (255),
	precio NUMERIC(18,2),
	porcentual NUMERIC(18, 2),
	PRIMARY KEY (idTipoHabitacion)
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
	numero_Calle NVARCHAR(255),
	piso NUMERIC(18,0),
	departamento NVARCHAR(50),
	localidad NVARCHAR (255),
	paisOrigen NUMERIC (18,0),
	fecha_Nacimiento DATETIME,
	pasaporte NUMERIC(18,0),
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


CREATE TABLE BIG_DATA.EstadoReserva (
	idEstadoReserva NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	estadoReservaDesc VARCHAR (255),
	PRIMARY KEY (idEstadoReserva)
)

CREATE TABLE BIG_DATA.Reserva (
	idReserva NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	codigoReserva NUMERIC(18,0) NOT NULL,
	cantidadNoches NUMERIC (18,0),
	fecha_Reserva_Realizada DATETIME DEFAULT (getdate()),
	fecha_Reserva_Desde DATETIME,
	fecha_Reserva_Hasta DATETIME,
	idTipoHabitacion NUMERIC (18,0) NOT NULL,
	idHotel NUMERIC (18,0) NOT NULL,
	idRegimen NUMERIC (18,0),
	idHabitacion NUMERIC (18,0),
	idCliente NUMERIC (18,0),
	idEstadoReserva NUMERIC (18,0),
	ultimaModificacionPor NVARCHAR (255) DEFAULT (suser_name()),
	PRIMARY KEY (idReserva),
	FOREIGN KEY (idTipoHabitacion) REFERENCES BIG_DATA.TipoHabitacion (idTipoHabitacion),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel),
	FOREIGN KEY (idRegimen) REFERENCES BIG_DATA.Regimen (idRegimen),
	FOREIGN KEY (idHabitacion) REFERENCES BIG_DATA.Habitacion (idHabitacion),
	FOREIGN KEY (idCliente) REFERENCES BIG_DATA.Cliente (idCliente),
	FOREIGN KEY (idEstadoReserva) REFERENCES BIG_DATA.EstadoReserva (idEstadoReserva)
)



CREATE TABLE BIG_DATA.Funcion (
	idFuncion NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	funcionDesc NVARCHAR (255),
	PRIMARY KEY (idFuncion),
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
	idEstadia NUMERIC (18,0),
	numero NUMERIC (18,0),
	fecha DATETIME,
	total MONEY,
	PRIMARY KEY (idFactura),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia)
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


CREATE TABLE BIG_DATA.Consumible (
	idConsumible NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	codigo NUMERIC (18,0),
	consumible VARCHAR (255),
	precio NUMERIC (18,2),
	PRIMARY KEY (idConsumible)
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

CREATE TABLE BIG_DATA.ConsumibleXEstadia (
	idConsumibleEstadia NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	idEstadia NUMERIC (18,0),
	idConsumible NUMERIC (18,0),
	PRIMARY KEY (idConsumibleEstadia),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia),
	FOREIGN KEY (idConsumible) REFERENCES BIG_DATA.Consumible (idConsumible)
)

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------MIGRACION DE LOS DATOS--------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

--Migracion Tabla Tipo Habitacion
SET IDENTITY_INSERT [BIG_DATA].[TipoHabitacion] ON
	insert into [BIG_DATA].[TipoHabitacion] (idTipoHabitacion,descripcion,precio)
	select distinct Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion,Habitacion_Tipo_Porcentual
	from [gd_esquema].[Maestra]
	WHERE [Habitacion_Tipo_Codigo] IS NOT NULL
	SET IDENTITY_INSERT [BIG_DATA].[TipoHabitacion] OFF

--Migracion Tabla Hotel
insert into [BIG_DATA].[Hotel] (ciudadHotel,direccionHotel,numeroCalle,cantidadDeEstrellas,recargaEstrella)
	select distinct Hotel_Ciudad,Hotel_Calle,Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella
	from [gd_esquema].[Maestra]
	WHERE [Hotel_Ciudad] IS NOT NULL

--Migracion Tabla Habitacion
insert into [BIG_DATA].[Habitacion](numeroHab,piso,vistaFrente,idTipo)
	select distinct Habitacion_Numero,Habitacion_Piso,Habitacion_Frente,Habitacion_Tipo_Codigo
	from [gd_esquema].[Maestra]
	WHERE [Habitacion_Numero] IS NOT NULL

	----UNA O LA OTRA 

	insert into [BIG_DATA].[Habitacion](idHotel,numeroHab,piso,vistaFrente,idTipo)
	VALUES (select idHotel from [BIG_DATA].[Hotel],[gd_esquema].[Maestra] where (Hotel_Ciudad=ciudadHotel and Hotel_Calle=direccionHotel and Hotel_Nro_Calle=numeroCalle,)
	select distinct Habitacion_Numero,Habitacion_Piso,Habitacion_Frente,Habitacion_Tipo_Codigo
	from [gd_esquema].[Maestra]
	WHERE [Habitacion_Numero] IS NOT NULL

	
	
	
	




AGREGAR EL ID DEL HOTEL AL QUE PERTENECE

	*/




--Migracion Tabla Regimen
insert into [BIG_DATA].[Regimen](descripcion,precio)
	select distinct Regimen_Descripcion,Regimen_Precio
	from [gd_esquema].[Maestra] 
	WHERE [Regimen_Descripcion] IS NOT NULL

--Migracion Tabla Reserva
insert into [BIG_DATA].[Reserva](fecha_Reserva_Desde,codigoReserva,cantidadNoches)
	select distinct Reserva_Fecha_Inicio,Reserva_Codigo,Reserva_Cant_Noches
	from [gd_esquema].[Maestra]
	WHERE  [Reserva_Codigo] IS NOT NULL
	/*

	AGREGAR IDTIPOHABITACION
	*/
	
--Migracion Tabla Estadia
insert into [BIG_DATA].[Estadia](fecha_Check_In,cantidadDias)
	select distinct Estadia_Fecha_Inicio,Estadia_Cant_Noches
	from [gd_esquema].[Maestra]
	WHERE [Estadia_Fecha_Inicio] IS NOT NULL

--Migracion Tabla Consumible
insert into [BIG_DATA].[Consumible](codigo,consumible,precio)
	select distinct Consumible_Codigo,Consumible_Descripcion,Consumible_Precio
	from [gd_esquema].[Maestra]
	WHERE [Consumible_Codigo]IS NOT NULL

--Migracion Tabla Item
insert into [BIG_DATA].[Item](cantidad,monto)
	select distinct Item_Factura_Cantidad,Item_Factura_Monto
	from [gd_esquema].[Maestra]
	WHERE [Item_Factura_Cantidad]IS NOT NULL

--Migracion Tabla Factura	
insert into [BIG_DATA].[Factura](numero,fecha,total)
	select distinct Factura_Nro,Factura_Fecha,Factura_Total
	from [gd_esquema].[Maestra]
	WHERE [Factura_Nro] IS NOT NULL

	
--Migracion Tabla Cliente
insert into [BIG_DATA].[Cliente](documento,apellido,nombre,fecha_Nacimiento,mail,calle,numero_Calle,piso,departamento,nacionalidad)
	select distinct Cliente_Pasaporte_Nro,Cliente_Apellido,Cliente_Nombre,Cliente_Fecha_Nac,Cliente_Mail,Cliente_Dom_Calle,Cliente_Nro_Calle,Cliente_Piso,Cliente_Depto,Cliente_Nacionalidad
	from [gd_esquema].[Maestra]
	WHERE [Cliente_Pasaporte_Nro] IS NOT NULL

	/*
		- VER COMO HACER PARA AGREGARLE A TODOS LOS REGISTROS EN EL CAMPO ID_TIPO DNI EL NUMERO 2 QUE ES EL NUMERO DE PASAPORTE

	*/

	
--Adicion Valores Tabla Rol
INSERT INTO [BIG_DATA].[Rol] (rolDesc)
	VALUES ('Administrador'),('Recepcionista'),('Guest')

--Adicion Valores Tabla Funcion
INSERT INTO [BIG_DATA].[Funcion] (funcionDesc)
	VALUES ('ABM de Rol'),('Login y Seguridad'),('ABM de Usuario'),('ABM de Cliente'),('ABM de Hotel'),('ABM de Habitacion'),('ABM Regimen de Estadia'),('Generar O Modificar una Reserva'),('Cancelar Reserva'),('Registrar Estadia'),('Registrar Consumibles'),('Facturar Estadia'),('Listado Estadistico')

--Adicion Valores Tabla TipoDocumento
INSERT INTO [BIG_DATA].TipoDocumento (tipoDocumentoDesc)
	VALUES ('Documento Nacional'),('Pasaporte'),('Libreta Civil'),('Licencia'),('Libreta de Enrolamiento'),('Cuit'),('Cuil')


--Adicion Valores Tabla Usuario
INSERT INTO [BIG_DATA].[Usuario] (username,userpassword,idRol,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
	Values ('Administrador',ENCRYPTBYPASSPHRASE('MOAP','Administrador'),1,'NombreAdministrador','ApellidoAdministrador', 1, 11111111,'Administrador@administrador.com',1511111111,'CalleAdministrador',01/01/1900),	
	('Recepcionista',ENCRYPTBYPASSPHRASE('MOAP','Recepcionista'),2,'NombreRecepcionista','ApellidoRecepcionista', 1, 22222222,'Recepcionista@recepcionista.com',1522222222,'CalleRecepcionista',01/01/1900),	
	('Guest',ENCRYPTBYPASSPHRASE('MOAP','Guest'),1,'NombreGuest','ApellidoGuest', 3, 33333333,'Guest@guest.com',3333333333,'CalleGuest',01/01/1900)	


--Adicion Valores Tabla PaisNacionalidad
INSERT INTO BIG_DATA.PaisNacionalidad (pais)
	VALUES ('Afganistán'),
('Albania'),
('Alemania'),
('Andorra'),
('Angola'),
('Antigua y Barbuda'),
('Arabia Saudita'),
('Argelia'),
('Argentina'),
('Armenia'),
('Australia'),
('Austria'),
('Azerbaiyán'),
('Bahamas'),
('Bangladés'),
('Barbados'),
('Baréin'),
('Bélgica'),
('Belice'),
('Benín'),
('Bielorrusia'),
('Birmania'),
('Bolivia'),
('Bosnia y Herzegovina'),
('Botsuana'),
('Brasil'),
('Brunéi'),
('Bulgaria'),
('Burkina Faso'),
('Burundi'),
('Bután'),
('Cabo Verde'),
('Camboya'),
('Camerún'),
('Canadá'),
('Catar'),
('Chad'),
('Chile'),
('China'),
('Chipre'),
('Ciudad del Vaticano'),
('Colombia'),
('Comoras'),
('Corea del Norte'),
('Corea del Sur'),
('Costa de Marfil'),
('Costa Rica'),
('Croacia'),
('Cuba'),
('Dinamarca'),
('Dominica'),
('Ecuador'),
('Egipto'),
('El Salvador'),
('Emiratos Árabes Unidos'),
('Eritrea'),
('Eslovaquia'),
('Eslovenia'),
('España'),
('Estados Unidos'),
('Estonia'),
('Etiopía'),
('Filipinas'),
('Finlandia'),
('Fiyi'),
('Francia'),
('Gabón'),
('Gambia'),
('Georgia'),
('Ghana'),
('Granada'),
('Grecia'),
('Guatemala'),
('Guyana'),
('Guinea'),
('Guinea ecuatorial'),
('Guinea-Bisáu'),
('Haití'),
('Honduras'),
('Hungría'),
('India'),
('Indonesia'),
('Irak'),
('Irán'),
('Irlanda'),
('Islandia'),
('Islas Marshall'),
('Islas Salomón'),
('Israel'),
('Italia'),
('Jamaica'),
('Japón'),
('Jordania'),
('Kazajistán'),
('Kenia'),
('Kirguistán'),
('Kiribati'),
('Kuwait'),
('Laos'),
('Lesoto'),
('Letonia'),
('Líbano'),
('Liberia'),
('Libia'),
('Liechtenstein'),
('Lituania'),
('Luxemburgo'),
('Madagascar'),
('Malasia'),
('Malaui'),
('Maldivas'),
('Malí'),
('Malta'),
('Marruecos'),
('Mauricio'),
('Mauritania'),
('México'),
('Micronesia'),
('Moldavia'),
('Mónaco'),
('Mongolia'),
('Montenegro'),
('Mozambique'),
('Namibia'),
('Nauru'),
('Nepal'),
('Nicaragua'),
('Níger'),
('Nigeria'),
('Noruega'),
('Nueva Zelanda'),
('Omán'),
('Países Bajos'),
('Pakistán'),
('Palaos'),
('Panamá'),
('Papúa Nueva Guinea'),
('Paraguay'),
('Perú'),
('Polonia'),
('Portugal'),
('Reino Unido'),
('República Centroafricana'),
('República Checa'),
('República de Macedonia'),
('República del Congo'),
('República Democrática del Congo'),
('República Dominicana'),
('República Sudafricana'),
('Ruanda'),
('Rumanía'),
('Rusia'),
('Samoa'),
('San Cristóbal y Nieves'),
('San Marino'),
('San Vicente y las Granadinas'),
('Santa Lucía'),
('Santo Tomé y Príncipe'),
('Senegal'),
('Serbia'),
('Seychelles'),
('Sierra Leona'),
('Singapur'),
('Siria'),
('Somalia'),
('Sri Lanka'),
('Suazilandia'),
('Sudán'),
('Sudán del Sur'),
('Suecia'),
('Suiza'),
('Surinam'),
('Tailandia'),
('Tanzania'),
('Tayikistán'),
('Timor Oriental'),
('Togo'),
('Tonga'),
('Trinidad y Tobago'),
('Túnez'),
('Turkmenistán'),
('Turquía'),
('Tuvalu'),
('Ucrania'),
('Uganda'),
('Uruguay'),
('Uzbekistán'),
('Vanuatu'),
('Venezuela'),
('Vietnam'),
('Yemen'),
('Yibuti'),
('Zambia'),
('Zimbabue'),
('Otro')

INSERT INTO BIG_DATA.PaisNacionalidad (nacionalidad)
VALUES ('angoleña'),
('argelina'),
('camerunesa'),
('etíope'),
('ecuatoguineana'),
('egipcia'),
('liberiana'),
('libia'),
('marroquí'),
('namibia'),
('nigeriana'),
('saharaui'),
('senegalesa'),
('sudafricana'),
('togolesa'),
('canadiense'),
('estadounidense'),
('mexicana'),
('beliceña'),
('costarricense'),
('guatemalteca'),
('hondureña'),
('nicaragüense'),
('panameña'),
('salvadoreña'),
('cubana'),
('arubana'),
('bahameña'),
('barbadense'),
('dominiquesa'),
('dominicana'),
('haitiana'),
('jamaiquina'),
('puertorriqueña'),
('sancristobaleña'),
('santaluciana'),
('sanvicentina'),
('argentina'),
('boliviana'),
('brasileña'),
('chilena'),
('colombiana'),
('ecuatoriana'),
('guyanesa'),
('paraguaya'),
('peruana'),
('surinamesa'),
('uruguaya'),
('venezolana'),
('europea'),
('albanesa'),
('alemana'),
('andorrana'),
('armenia'),
('austríaca'),
('belga'),
('bielorrusa'),
('bosnia'),
('búlgara'),
('checa'),
('chipriota'),
('croata'),
('danesa'),
('escocesa'),
('eslovaca'),
('eslovena'),
('española'),
('estonia'),
('finlandesa'),
('francesa'),
('griega'),
('holandesa'),
('húngara'),
('británica'),
('irlandesa'),
('italiana'),
('letona'),
('lituana'),
('luxemburguesa'),
('maltesa'),
('moldava'),
('monegasca'),
('montenegrina'),
('noruega'),
('polaca'),
('portuguesa'),
('rumana'),
('rusa'),
('serbia'),
('sueca'),
('suiza'),
('turca'),
('ucraniana'),
('australiana'),
('neozelandesa'),
('Otra')



--Adicion Valores Tabla Usuario
INSERT INTO [BIG_DATA].[Usuario] (username,userpassword,idRol,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
	Values ('Administrador',ENCRYPTBYPASSPHRASE('MOAP','Administrador'),1,'NombreAdministrador','ApellidoAdministrador', 1, 11111111,'Administrador@administrador.com',1511111111,'CalleAdministrador',01/01/1900),	
	('Recepcionista',ENCRYPTBYPASSPHRASE('MOAP','Recepcionista'),2,'NombreRecepcionista','ApellidoRecepcionista', 1, 22222222,'Recepcionista@recepcionista.com',1522222222,'CalleRecepcionista',01/01/1900),	
	('Guest',ENCRYPTBYPASSPHRASE('MOAP','Guest'),1,'NombreGuest','ApellidoGuest', 3, 33333333,'Guest@guest.com',3333333333,'CalleGuest',01/01/1900)	



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


--Adicion Valores Tabla UsuarioXHotel
INSERT INTO [BIG_DATA].[UsuarioXHotel]
SELECT idHotel,username
	FROM [BIG_DATA].[Usuario],[BIG_DATA].[Hotel]
	WHERE (username='Administrador' AND idHotel=1) OR
	(username='Recepcionista' AND idHotel=1) OR
	(username='Guest' AND idHotel=1)


--Adicion Valores Tabla RegimenXHotel
INSERT INTO [BIG_DATA].[RegimenXHotel]
SELECT distinct idHotel,Regimen_Descripcion
FROM [BIG_DATA].[Hotel],[gd_esquema].[Maestra] 
WHERE(direccionHotel=Hotel_Calle AND ciudadHotel=Hotel_Ciudad AND numeroCalle=Hotel_Nro_Calle) 


--Adicion Valores Tabla ConsumiblesXEstadia
INSERT INTO [BIG_DATA].[ConsumibleXEstadia]

SELECT idEstadia,idConsumible
FROM [BIG_DATA].[Consumible],[BIG_DATA].[Estadia],[gd_esquema].[Maestra] 

SELECT * FROM [BIG_DATA].[Consumible]

SELECT * FROM [BIG_DATA].[Estadia]

SELECT * FROM [gd_esquema].[Maestra]
 WHERE Estadia_Fecha_Inicio IS NOT NULL AND Consumible_Codigo IS NOT NULL
 

	Select distinct Hotel_Ciudad,Hotel_Calle,Hotel_Nro_Calle,Regimen_Descripcion
	from [gd_esquema].[Maestra] 
	



	

------
------

	



