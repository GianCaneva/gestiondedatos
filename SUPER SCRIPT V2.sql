---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------GENERACION DE QUERY-----------------------------------------------
---------------------------------------PARA BORRADO MASIVO-----------------------------------------------
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


---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------QUERY PARA BORRADO MASIVO ----------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
ALTER TABLE BIG_DATA.CierreHotel drop constraint FK__CierreHot__idHot__7C1A6C5A;ALTER TABLE BIG_DATA.Ciudad drop constraint FK__Ciudad__idPaisNa__5E8A0973;ALTER TABLE BIG_DATA.Cliente drop constraint FK__Cliente__naciona__69FBBC1F;ALTER TABLE BIG_DATA.Cliente drop constraint FK__Cliente__paisOri__6AEFE058;ALTER TABLE BIG_DATA.Cliente drop constraint FK__Cliente__tipo_Do__690797E6;ALTER TABLE BIG_DATA.ConsumibleXEstadia drop constraint FK__Consumibl__idCon__14E61A24;ALTER TABLE BIG_DATA.ConsumibleXEstadia drop constraint FK__Consumibl__idEst__13F1F5EB;ALTER TABLE BIG_DATA.Estadia drop constraint FK__Estadia__idReser__7EF6D905;ALTER TABLE BIG_DATA.Factura drop constraint FK__Factura__idEstad__01D345B0;ALTER TABLE BIG_DATA.FuncionXRol drop constraint FK__FuncionXR__idFun__11158940;ALTER TABLE BIG_DATA.FuncionXRol drop constraint FK__FuncionXR__idRol__10216507;ALTER TABLE BIG_DATA.Habitacion drop constraint FK__Habitacio__idTip__6FB49575;ALTER TABLE BIG_DATA.Hotel drop constraint FK__Hotel__paisHotel__6166761E;ALTER TABLE BIG_DATA.Hotel drop constraint FK__Hotel__idCiudad__625A9A57;ALTER TABLE BIG_DATA.Item drop constraint FK__Item__idEstadia__05A3D694;ALTER TABLE BIG_DATA.Item drop constraint FK__Item__idFactura__04AFB25B;ALTER TABLE BIG_DATA.RegimenXHotel drop constraint FK__RegimenXH__idHot__09746778;ALTER TABLE BIG_DATA.RegimenXHotel drop constraint FK__RegimenXH__idReg__0880433F;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idRegim__76619304;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idTipoH__74794A92;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idEstad__793DFFAF;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idHotel__756D6ECB;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idClien__7849DB76;ALTER TABLE BIG_DATA.Reserva drop constraint FK__Reserva__idHabit__7755B73D;ALTER TABLE BIG_DATA.Usuario drop constraint FK__Usuario__idRol__65370702;ALTER TABLE BIG_DATA.Usuario drop constraint FK__Usuario__tipo_Do__662B2B3B;ALTER TABLE BIG_DATA.UsuarioXHotel drop constraint FK__UsuarioXH__idHot__0C50D423;ALTER TABLE BIG_DATA.UsuarioXHotel drop constraint FK__UsuarioXH__usern__0D44F85C;DROP TABLE BIG_DATA.[CierreHotel];DROP TABLE BIG_DATA.[Ciudad];DROP TABLE BIG_DATA.[Cliente];DROP TABLE BIG_DATA.[Consumible];DROP TABLE BIG_DATA.[ConsumibleXEstadia];DROP TABLE BIG_DATA.[Estadia];DROP TABLE BIG_DATA.[EstadoReserva];DROP TABLE BIG_DATA.[Factura];DROP TABLE BIG_DATA.[Funcion];DROP TABLE BIG_DATA.[FuncionXRol];DROP TABLE BIG_DATA.[Habitacion];DROP TABLE BIG_DATA.[Hotel];DROP TABLE BIG_DATA.[Item];DROP TABLE BIG_DATA.[PaisNacionalidad];DROP TABLE BIG_DATA.[Regimen];DROP TABLE BIG_DATA.[RegimenXHotel];DROP TABLE BIG_DATA.[Reserva];DROP TABLE BIG_DATA.[Rol];DROP TABLE BIG_DATA.[TipoDocumento];DROP TABLE BIG_DATA.[TipoHabitacion];DROP TABLE BIG_DATA.[Usuario];DROP TABLE BIG_DATA.[UsuarioXHotel];







---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------CREACION DE TABLAS---------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------



	

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------MIGRACION DE LOS DATOS--------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------


--Migracion Tabla Regimen
insert into [BIG_DATA].[Regimen](descripcion,precio)
	select distinct Regimen_Descripcion,Regimen_Precio
	from [gd_esquema].[Maestra] 
	WHERE [Regimen_Descripcion] IS NOT NULL


--Migracion Tabla Tipo Habitacion
SET IDENTITY_INSERT [BIG_DATA].[TipoHabitacion] ON
	insert into [BIG_DATA].[TipoHabitacion] (idTipoHabitacion,descripcion,precio)
	select distinct Habitacion_Tipo_Codigo,Habitacion_Tipo_Descripcion,Habitacion_Tipo_Porcentual
	from [gd_esquema].[Maestra]
	WHERE [Habitacion_Tipo_Codigo] IS NOT NULL
	SET IDENTITY_INSERT [BIG_DATA].[TipoHabitacion] OFF

	

/*
--Adicion Valores Tabla PaisNacionalidad
INSERT INTO BIG_DATA.PaisNacionalidad (pais)
	VALUES ('Afganistán'),('Albania'),('Alemania'),('Andorra'),('Angola'),('Antigua y Barbuda'),('Arabia Saudita'),('Argelia'),
('Argentina'),('Armenia'),('Australia'),('Austria'),('Azerbaiyán'),('Bahamas'),('Bangladés'),('Barbados'),('Baréin'),('Bélgica'),
('Belice'),('Benín'),('Bielorrusia'),('Birmania'),('Bolivia'),('Bosnia y Herzegovina'),('Botsuana'),('Brasil'),('Brunéi'),('Bulgaria'),
('Burkina Faso'),('Burundi'),('Bután'),('Cabo Verde'),('Camboya'),('Camerún'),('Canadá'),('Catar'),('Chad'),('Chile'),('China'),('Chipre'),
('Ciudad del Vaticano'),('Colombia'),('Comoras'),('Corea del Norte'),('Corea del Sur'),('Costa de Marfil'),('Costa Rica'),('Croacia'),('Cuba'),('Dinamarca'),
('Dominica'),('Ecuador'),('Egipto'),('El Salvador'),('Emiratos Árabes Unidos'),('Eritrea'),('Eslovaquia'),('Eslovenia'),('España'),('Estados Unidos'),('Estonia'),
('Etiopía'),('Filipinas'),('Finlandia'),('Fiyi'),('Francia'),('Gabón'),('Gambia'),('Georgia'),('Ghana'),('Granada'),('Grecia'),('Guatemala'),('Guyana'),('Guinea'),('Guinea ecuatorial'),
('Guinea-Bisáu'),('Haití'),('Honduras'),('Hungría'),('India'),('Indonesia'),('Irak'),('Irán'),('Irlanda'),('Islandia'),('Islas Marshall'),('Islas Salomón'),
('Israel'),('Italia'),('Jamaica'),('Japón'),('Jordania'),('Kazajistán'),('Kenia'),('Kirguistán'),('Kiribati'),('Kuwait'),('Laos'),('Lesoto'),('Letonia'),('Líbano'),('Liberia'),
('Libia'),('Liechtenstein'),('Lituania'),('Luxemburgo'),('Madagascar'),('Malasia'),('Malaui'),('Maldivas'),('Malí'),('Malta'),('Marruecos'),('Mauricio'),('Mauritania'),
('México'),('Micronesia'),('Moldavia'),('Mónaco'),('Mongolia'),('Montenegro'),('Mozambique'),('Namibia'),('Nauru'),('Nepal'),('Nicaragua'),('Níger'),('Nigeria'),('Noruega'),
('Nueva Zelanda'),('Omán'),('Países Bajos'),('Pakistán'),('Palaos'),('Panamá'),('Papúa Nueva Guinea'),('Paraguay'),('Perú'),('Polonia'),('Portugal'),('Reino Unido'),('República Centroafricana'),
('República Checa'),('República de Macedonia'),('República del Congo'),('República Democrática del Congo'),('República Dominicana'),('República Sudafricana'),('Ruanda'),('Rumanía'),
('Rusia'),('Samoa'),('San Cristóbal y Nieves'),('San Marino'),('San Vicente y las Granadinas'),('Santa Lucía'),('Santo Tomé y Príncipe'),('Senegal'),('Serbia'),('Seychelles'),('Sierra Leona'),
('Singapur'),('Siria'),('Somalia'),('Sri Lanka'),('Suazilandia'),('Sudán'),('Sudán del Sur'),('Suecia'),('Suiza'),('Surinam'),('Tailandia'),('Tanzania'),('Tayikistán'),
('Timor Oriental'),('Togo'),('Tonga'),('Trinidad y Tobago'),('Túnez'),('Turkmenistán'),('Turquía'),('Tuvalu'),('Ucrania'),('Uganda'),('Uruguay'),('Uzbekistán'),('Vanuatu'),('Venezuela'),
('Vietnam'),('Yemen'),('Yibuti'),('Zambia'),('Zimbabue'),('Otro')
 
INSERT INTO BIG_DATA.PaisNacionalidad (nacionalidad)
VALUES ('angoleña'),('argelina'),('camerunesa'),('etíope'),('ecuatoguineana'),('egipcia'),('liberiana'),('libia'),('marroquí'),('namibia'),('nigeriana'),('saharaui'),('senegalesa'),('sudafricana'),
('togolesa'),('canadiense'),('estadounidense'),('mexicana'),('beliceña'),('costarricense'),('guatemalteca'),('hondureña'),('nicaragüense'),('panameña'),('salvadoreña'),('cubana'),
('arubana'),('bahameña'),('barbadense'),('dominiquesa'),('dominicana'),('haitiana'),('jamaiquina'),('puertorriqueña'),('sancristobaleña'),('santaluciana'),('sanvicentina'),
('ARGENTINO'),('boliviana'),('brasileña'),('chilena'),('colombiana'),('ecuatoriana'),('guyanesa'),('paraguaya'),('peruana'),('surinamesa'),('uruguaya'),('venezolana'),('europea'),('albanesa'),
('alemana'),('andorrana'),('armenia'),('austríaca'),('belga'),('bielorrusa'),('bosnia'),('búlgara'),('checa'),('chipriota'),('croata'),('danesa'),('escocesa'),('eslovaca'),('eslovena'),
('española'),('estonia'),('finlandesa'),('francesa'),('griega'),('holandesa'),('húngara'),('británica'),('irlandesa'),('italiana'),
('letona'),('lituana'),('luxemburguesa'),('maltesa'),('moldava'),('monegasca'),('montenegrina'),('noruega'),('polaca'),('portuguesa'),
('rumana'),('rusa'),('serbia'),('sueca'),('suiza'),('turca'),('ucraniana'),('australiana'),('neozelandesa'),('Otra')
*/

--Adicion Valores Tabla PaisNacionalidad NUEVO
INSERT INTO BIG_DATA.PaisNacionalidad (pais,nacionalidad)
	VALUES ('ARGENTINA','ARGENTINO'),('BRASIL','BRASILEÑO'),--Seguir colocando algunos <
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
INSERT INTO [BIG_DATA].[Usuario] (username,userpassword,idRol,nombre,apellido,tipo_Documento,documento,mail,telefono,direccion,fecha_Nacimiento)
	Values ('Administrador',ENCRYPTBYPASSPHRASE('MOAP','Administrador'),1,'NombreAdministrador','ApellidoAdministrador', 1, 11111111,'Administrador@administrador.com',1511111111,'CalleAdministrador',01/01/1900),	
	('Recepcionista',ENCRYPTBYPASSPHRASE('MOAP','Recepcionista'),2,'NombreRecepcionista','ApellidoRecepcionista', 1, 22222222,'Recepcionista@recepcionista.com',1522222222,'CalleRecepcionista',01/01/1900),	
	('Guest',ENCRYPTBYPASSPHRASE('MOAP','Guest'),1,'NombreGuest','ApellidoGuest', 3, 33333333,'Guest@guest.com',3333333333,'CalleGuest',01/01/1900)	

--Adicion Valores Tabla Estado Reserva
INSERT INTO [BIG_DATA].[EstadoReserva] (estadoReservaDesc) values('Reserva Correcta'),('Reserva Modificada'), ('Reserva Cancelada por Recepcion'),('Reserva Cancelada por Cliente'),('Reserva Cancelada por No-Show'),('Reserva con Ingreso')



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
INSERT INTO [BIG_DATA].[Hotel] (idCiudad,direccionHotel,numeroCalle,cantidadDeEstrellas,recargaEstrella)
	SELECT DISTINCT idCiudad,Hotel_Calle,Hotel_Nro_Calle,Hotel_CantEstrella,Hotel_Recarga_Estrella
	FROM	[gd_esquema].[Maestra],
			[BIG_DATA].[Ciudad]
	WHERE	[Hotel_Ciudad] IS NOT NULL
			AND Hotel_Calle IS NOT NULL
			AND Hotel_Nro_Calle IS NOT NULL
			AND Hotel_Ciudad = ciudadNombre
	
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
	  
	
	  --////////sdfsdfdf/sf/s//fs//s/fDADSA //////FALTA ESTO MIGRACION TAVBLA RESERVA//////
	--  ////// CORREGI HASTA ACÁ
	   

--Migracion Tabla Reserva
INSERT INTO [BIG_DATA].[Reserva] (codigoReserva,fecha_Reserva_Desde,cantidadNoches,idTipoHabitacion,idHotel,idRegimen,idHabitacion,idCliente)
SELECT DISTINCT Reserva_Codigo,Reserva_Fecha_Inicio,Reserva_Cant_Noches,Habitacion_Tipo_Codigo,h.idHotel,r.idRegimen,hab.idHabitacion,c.idCliente
		from 
		[gd_esquema].[Maestra],
		[BIG_DATA].[TipoHabitacion],
		[BIG_DATA].[Hotel] h,
		[BIG_DATA].[Regimen] r,
		[BIG_DATA].[Habitacion] hab,
		[BIG_DATA].[Cliente] c,
		[BIG_DATA].[Ciudad] ciu
		

	WHERE	Reserva_Codigo IS NOT NULL
			AND (Habitacion_Tipo_Codigo=idTipoHabitacion)
			AND (Hotel_Ciudad=ciu.ciudadNombre )
			AND	(Regimen_Descripcion=r.descripcion)
			AND (c.documento = Cliente_Pasaporte_Nro)
			AND (Habitacion_Numero = hab.numeroHab)
			AND (hab.idHotel = h.idHotel)

			
		/*	SELECT DISTINCT Reserva_Codigo,Reserva_Fecha_Inicio,Reserva_Cant_Noches,Habitacion_Tipo_Codigo,h.idHotel,count(Reserva_Codigo) 			 			
			
			from	[gd_esquema].[Maestra],[BIG_DATA].[Hotel] h, [BIG_DATA].[Ciudad] ciu, [BIG_DATA].[Cliente] cli
						
			where Hotel_Calle = h.direccionHotel and Hotel_Nro_Calle = h.numeroCalle and Hotel_Ciudad = ciu.ciudadNombre and Cliente_Pasaporte_Nro = cli.documento  					 					
			
			group by Reserva_Cant_Noches,Reserva_Codigo,Reserva_Fecha_Inicio,Habitacion_Tipo_Codigo,h.idHotel
			*/




/*
			SELECT DISTINCT Reserva_Codigo,Reserva_Fecha_Inicio,Reserva_Cant_Noches,Habitacion_Tipo_Codigo,h.idHotel,count(Reserva_Codigo)
			
			from	[gd_esquema].[Maestra],
					[BIG_DATA].[Hotel] h,
					[BIG_DATA].[Ciudad] ciu
					--[BIG_DATA].[Cliente] cli

					where Hotel_Calle = h.direccionHotel and
							Hotel_Nro_Calle = h.numeroCalle and
							Hotel_Ciudad = ciu.ciudadNombre --and
							--Cliente_Pasaporte_Nro = cli.documento

					
					group by Reserva_Codigo,Reserva_Fecha_Inicio,Reserva_Cant_Noches,Habitacion_Tipo_Codigo,h.idHotel

							
			AND Hotel_Nro_Calle IS NOT NULL
			AND Hotel_Ciudad = ciudadNombre







	SELECT DISTINCT (DOCUMENTO),COUNT(DOCUMENTO) A FROM [BIG_DATA].[Cliente]  GROUP BY DOCUMENTO
	SELECT * FROM BIG_DATA.Cliente WHERE MAIL = 'zunilda_Vera@gmail.com'
	

	select distinct idHabitacion
	from [gd_esquema].[Maestra],BIG_DATA.Habitacion
	where 

	/*

	SELECT * FROM [gd_esquema].[Maestra]
	AGREGAR IDTIPOHABITACION
	*/

	*/
--Migracion Tabla Estadia
INSERT into [BIG_DATA].[Estadia](fecha_Check_In,cantidadDias)
	SELECT m.Estadia_Fecha_Inicio,m.Estadia_Cant_Noches
	FROM [gd_esquema].[Maestra] M,BIG_DATA.Hotel H,BIG_DATA.Reserva R
	WHERE M.Reserva_Codigo=R.codigoReserva AND 
	(Hotel_Ciudad=ciudadHotel AND Hotel_Calle=direccionHotel AND Hotel_Nro_Calle=numeroCalle) AND [Estadia_Fecha_Inicio] IS NOT NULL

	
	  ////////sdfsdfdf/sf/s//fs//s/fDADSA //////FALTA ESTO MIGRACION TAVBLA FACTURA//////
--Migracion Tabla Factura	
insert into [BIG_DATA].[Factura](numero,fecha,total,idEstadia)
	select distinct Factura_Nro,Factura_Fecha,Factura_Total,e.idEstadia
	from [gd_esquema].[Maestra],BIG_DATA.Estadia e
	WHERE [Factura_Nro] IS NOT NULL 
	


	select e.idEstadia
	from [gd_esquema].[Maestra] m,[BIG_DATA].[Estadia] e,[BIG_DATA].[Reserva] r, BIG_DATA.Hotel h
	where m.Reserva_Codigo=r.codigoReserva and (m.Hotel_Ciudad=h.ciudadHotel AND m.Hotel_Calle=h.direccionHotel AND m.Hotel_Nro_Calle=h.numeroCalle) AND e.idReserva=r.idReserva

	select distinct Reserva_Codigo, count (reserva_codigo)
	from gd_esquema.Maestra
	group by (Reserva_Codigo)

--Migracion Tabla Item
insert into [BIG_DATA].[Item](cantidad,monto,idFactura)
	select distinct Item_Factura_Cantidad,Item_Factura_Monto,f.idFactura
	from [gd_esquema].[Maestra],BIG_DATA.Factura f
	WHERE [Item_Factura_Cantidad]IS NOT NULL AND Factura_Nro=numero

	
--Adicion Valores Tabla RegimenXHotel
INSERT INTO [BIG_DATA].[RegimenXHotel]
SELECT distinct r.idRegimen,h.idHotel
FROM [BIG_DATA].[Hotel] h,[gd_esquema].[Maestra] m, BIG_DATA.Regimen r
WHERE(direccionHotel=Hotel_Calle AND ciudadHotel=Hotel_Ciudad AND numeroCalle=Hotel_Nro_Calle) 


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
	

//////error
--Adicion Valores Tabla ConsumiblesXEstadia
INSERT INTO [BIG_DATA].[ConsumibleXEstadia]
SELECT idEstadia,idConsumible
FROM [BIG_DATA].[Consumible] c,[BIG_DATA].[Estadia] e,[gd_esquema].[Maestra] m
WHERE (Consumible_Codigo=C.codigo AND 

SELECT * FROM [gd_esquema].[Maestra] 




SELECT * FROM [BIG_DATA].[Consumible]

SELECT * FROM [BIG_DATA].[Estadia]

SELECT * FROM [gd_esquema].[Maestra]
 WHERE Estadia_Fecha_Inicio IS NOT NULL AND Consumible_Codigo IS NOT NULL
 

	Select distinct Hotel_Ciudad,Hotel_Calle,Hotel_Nro_Calle,Regimen_Descripcion
	from [gd_esquema].[Maestra] 
	



	

------
------



