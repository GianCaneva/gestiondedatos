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


CREATE TABLE BIG_DATA.Rol (
	idRol NUMERIC (18,0) IDENTITY (1,1) NOT NULL,
	nombreRol NVARCHAR (255),
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
	paisHotel NVARCHAR (255) ,
	fechaDeCreacion DATETIME,
	recargaEstrella NUMERIC (18,0)
	PRIMARY KEY(idHotel),
)

CREATE TABLE BIG_DATA.Usuario (
	username NVARCHAR (255) NOT NULL,
	userpassword NVARCHAR (20),
	idRol NUMERIC (18,0),
	nombre nvarchar (255),
	apellido nvarchar (255),
	tipo_Documento NUMERIC (18,0),
	documento numeric (18,0),
	mail nvarchar (255),
	telefono numeric (18,0),
	direccion nvarchar (255),
	fecha_Nacimiento datetime,
	PRIMARY KEY (username),
	FOREIGN KEY (idRol) REFERENCES BIG_DATA.Rol (idRol),
	FOREIGN KEY (tipo_documento) REFERENCES BIG_DATA.TipoDocumento (idDocumento)
)

CREATE TABLE BIG_DATA.TipoHabitacion (
	idTipo numeric (18,0) IDENTITY (1,1) NOT NULL,
	descripcion nvarchar (255),
	precio numeric(18,2),
	PRIMARY KEY (idTipo)
)


CREATE TABLE BIG_DATA.Cliente (
	idCliente numeric (18,0) IDENTITY (1,1) NOT NULL,
	nombre nvarchar (255),
	apellido nvarchar (255),
	tipo_Documento nvarchar (5),
	documento numeric (18,0),
	nacionalidad nvarchar (255),
	mail nvarchar (255),
	telefono numeric (18,0),
	calle nvarchar (255),
	numero_Calle numeric(18, 0),
	piso numeric(18,0),
	departamento nvarchar(50),
	localidad nvarchar (255),
	Pais nvarchar (255),
	fecha_Nacimiento datetime,
	pasaporte numeric(18,0),
	PRIMARY KEY (idCliente)
)

CREATE TABLE BIG_DATA.Habitacion (
	idHabitacion numeric (18,0) IDENTITY (1,1) NOT NULL,
	numero numeric (18,0),
	piso numeric (18,0),
	vista nvarchar (50),
	idTipo numeric (18,0) ,
	comodidades nvarchar (255),
	porcentual numeric(18, 2),
	PRIMARY KEY (idHabitacion),
	FOREIGN KEY (idTipo) REFERENCES BIG_DATA.Tipo
)

CREATE TABLE BIG_DATA.Reserva (
	idReserva numeric (18,0) IDENTITY (1,1) NOT NULL,
	codigoReserva numeric(18,0),
	cantidadNoches numeric (18,0),
	fecha_Reserva_Realizada datetime,
	fecha_Reserva_Desde datetime,
	fecha_Reserva_Hasta datetime,
	idTipo numeric (18,0),
	idHotel numeric (18,0),
	idRegimen numeric (18,0),
	idHabitacion numeric (18,0),
	idCliente numeric (18,0),
	PRIMARY KEY (idReserva),
	FOREIGN KEY (idTipo) REFERENCES BIG_DATA.Tipo (idTipo),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel),
	FOREIGN KEY (idRegimen) REFERENCES BIG_DATA.Regimen (idRegimen),
	FOREIGN KEY (idHabitacion) REFERENCES BIG_DATA.Habitacion (idHabitacion),
	FOREIGN KEY (idCliente) REFERENCES BIG_DATA.Cliente (idCliente)
)


CREATE TABLE BIG_DATA.Funcion (
	idFuncion numeric (18,0) IDENTITY (1,1) NOT NULL,
	funcionalidad nvarchar (255),
	idRol numeric (18,0),
	PRIMARY KEY (idFuncion),
	FOREIGN KEY (idRol) REFERENCES BIG_DATA.Rol (idRol)
)

CREATE TABLE BIG_DATA.Nacionalidad (
	idNacionalidad numeric (18,0) IDENTITY (1,1) NOT NULL,
	nacionalidad nvarchar (50),
	PRIMARY KEY (idNacionalidad)
)

CREATE TABLE BIG_DATA.TipoDocumento (
	idDocumento numeric (18,0) IDENTITY (1,1) NOT NULL,
	nombreTipoDocumento nvarchar (5),
	PRIMARY KEY (idDocumento)
)

CREATE TABLE BIG_DATA.CierreHotel (
	idCierre numeric (18,0) IDENTITY (1,1) NOT NULL,
	idHotel numeric (18,0),
	fecha_Inicio datetime,
	fecha_Fin datetime,
	descripcion nvarchar (255),
	PRIMARY KEY (idCierre),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel)
)

CREATE TABLE BIG_DATA.Estadia (
	idEstadia numeric (18,0) IDENTITY (1,1) NOT NULL,
	idReserva numeric (18,0),
	fecha_Check_In datetime,
	fecha_Check_Out datetime,
	cantidadDias numeric (18,0),
	PRIMARY KEY (idEstadia),
	FOREIGN KEY (idReserva) REFERENCES BIG_DATA.Reserva (idReserva)
)

CREATE TABLE BIG_DATA.Factura (
	idFactura numeric (18,0) IDENTITY (1,1) NOT NULL,
	idEstadia numeric (18,0),
	numero numeric (18,0),
	fecha datetime,
	total money,
	PRIMARY KEY (idFactura),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia)
)

CREATE TABLE BIG_DATA.Item (
	idItem numeric (18,0) IDENTITY (1,1) NOT NULL,
	idFactura numeric (18,0),
	cantidad numeric (18,0),
	monto money,
	idEstadia numeric (18,0),
	PRIMARY KEY (idItem),
	FOREIGN KEY (idFactura) REFERENCES BIG_DATA.Factura (idFactura),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia)
)


CREATE TABLE BIG_DATA.Consumible (
	idConsumible numeric (18,0) IDENTITY (1,1) NOT NULL,
	codigo numeric (18,0),
	consumible varchar (255),
	precio numeric (18,2),
	PRIMARY KEY (idConsumible)
)

CREATE TABLE BIG_DATA.RegimenXHotel (
	idRegimenHotel numeric (18,0) IDENTITY (1,1) NOT NULL,
	idRegimen numeric (18,0),
	idHotel numeric (18,0),
	PRIMARY KEY (idRegimenHotel),
	FOREIGN KEY (idRegimen) REFERENCES BIG_DATA.Regimen (idRegimen),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel)
)

CREATE TABLE BIG_DATA.UsuarioXHotel (
	idUsuarioHotel numeric (18,0) IDENTITY (1,1) NOT NULL,
	idHotel numeric (18,0),
	username nvarchar (255),
	PRIMARY KEY (idUsuarioHotel),
	FOREIGN KEY (idHotel) REFERENCES BIG_DATA.Hotel (idHotel),
	FOREIGN KEY (username) REFERENCES BIG_DATA.Usuario (username)
)

CREATE TABLE BIG_DATA.RolXFuncion (
	idRolFuncion numeric (18,0) IDENTITY (1,1) NOT NULL,
	idRol numeric (18,0),
	idFuncion numeric (18,0),
	PRIMARY KEY (idRolFuncion),
	FOREIGN KEY (idRol) REFERENCES BIG_DATA.Rol (idRol),
	FOREIGN KEY (idFuncion) REFERENCES BIG_DATA.Funcion (idFuncion)
)

CREATE TABLE BIG_DATA.ConsumibleXEstadia (
	idConsumibleEstadia numeric (18,0) IDENTITY (1,1) NOT NULL,
	idEstadia numeric (18,0),
	idConsumible numeric (18,0),
	PRIMARY KEY (idConsumibleEstadia),
	FOREIGN KEY (idEstadia) REFERENCES BIG_DATA.Estadia (idEstadia),
	FOREIGN KEY (idConsumible) REFERENCES BIG_DATA.Consumible (idConsumible)
)










