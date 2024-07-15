USE BDWEB
GO

--INSERTAR ROL
INSERT INTO ROL(Descripcion) VALUES
('ADMINISTRADOR'),
('DOCENTE'),
('ALUMNO')

GO

--INSERTAR MENU
INSERT INTO MENU(Nombre,Icono) VALUES
('Configuraciones',''),
('Usuarios',''),
('Alumnos',''),
('Docentes',''),
('Cursos',''),
('Matricula','')

GO

--INSERTAR SUBMENU

INSERT INTO SUBMENU(IdMenu,Nombre,NombreFormulario,Accion) VALUES
((SELECT IdMenu FROM MENU WHERE Nombre = 'Usuarios'),'Crear Usuario','Usuario','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Usuarios'),'Crear Rol','Rol','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Usuarios'),'Asignar rol permisos','RolPermiso','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Alumnos'),'Crear Alumnos','Alumno','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Alumnos'),'Consulta y Reporte','Alumno','Reporte'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Docentes'),'Crear Docentes','Docente','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Docentes'),'Agregar Curricula','Docente','Curricula'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Docentes'),'Agregar Calificacion','Docente','Calificacion'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Cursos'),'Crear Cursos','Curso','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Matricula'),'Crear Matricula','Matricula','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Matricula'),'Consulta y Reporte','Matricula','Reporte'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Periodo','Periodo','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Nivel Academico','NivelAcademico','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Grados y Secciones','GradoSeccion','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Grados por Niveles','GradoporNivel','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Cursos por Niveles','Curso','Asignar'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Vacantes','Vacante','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Crear Horario','Horario','Crear'),
((SELECT IdMenu FROM MENU WHERE Nombre = 'Configuraciones'),'Asignar Docentes por Cursos','Docente','Asignar')

go


--INSERTAR USUARIO
insert into USUARIO(Nombres,Apellidos,IdRol,LoginUsuario,LoginClave,DescripcionReferencia,IdReferencia)
values('Diego','Espinoza',(select TOP 1 IdRol from ROL where Descripcion = 'ADMINISTRADOR'),'Admin','Admin123','NINGUNA',0)

go

--INSERTAR PERMISOS
INSERT INTO PERMISOS(IdRol,IdSubMenu)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'ADMINISTRADOR'), IdSubMenu FROM SUBMENU
GO
INSERT INTO PERMISOS(IdRol,IdSubMenu,Activo)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'DOCENTE'),IdSubMenu,0 FROM SUBMENU
GO
INSERT INTO PERMISOS(IdRol,IdSubMenu,Activo)
SELECT (select TOP 1 IdRol from ROL where Descripcion = 'ALUMNO'),IdSubMenu,0 FROM SUBMENU

GO

update p set p.Activo = 1 from PERMISOS p
inner join SUBMENU sm on sm.IdSubMenu = p.IdSubMenu
where sm.NombreFormulario in ('frmAgregarCurricula','frmAgregarCalificacion') and p.IdRol = (select TOP 1 IdRol from ROL where Descripcion = 'DOCENTE')

go


--INSERTAR PERIODOS
insert into PERIODO(Descripcion,FechaInicio,FechaFin,Activo) values
('PERIODOVERANO 2024', '2024-01-02', '2024-03-20', 0),
('PERIODO1 2024', '2024-03-10', '2024-07-13', 0),
('PERIODO2 2024', '2024-08-10', '2024-12-17', 1);

GO
--INSERTAR NIVELES
insert into NIVEL(IdPeriodo,DescripcionNivel,DescripcionTurno,HoraInicio,HoraFin,Activo) values
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO-VERANO 2024'),
'Clase1','MAÑANA','08:30:00.0000000','12:35:00.0000000',0
),
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO-1 2024'),
'Clase2','TARDE','13:00:00.0000000','18:00:00.0000000',0
),
((select IdPeriodo from PERIODO where Descripcion = 'PERIODO-2 2024'),
'Clase3','NOCHE','18:30:00.0000000','23:35:00.0000000',1
)


GO
--INSERTAR GRADO_SECCION
INSERT INTO GRADO_SECCION(DescripcionGrado,DescripcionSeccion) VALUES
('SECCION','A'),
('SECCION','B'),
('SECCION','C'),
('SECCION','D'),
('SECCION','F'),
('SECCION','H'),
('SECCION','I'),
('SECCION','J'),
('SECCION','K')

GO
-- INSERTAR NIVEL DETALLE

INSERT INTO NIVEL_DETALLE(IdNivel,IdGradoSeccion,TotalVacantes,VacantesDisponibles,VacantesOcupadas)
select 
(select top 1 IdNivel from NIVEL where IdPeriodo = 3 ),
IdGradoSeccion,30,30,0
from GRADO_SECCION where IdGradoSeccion in (1,2,3)


GO
--INSERTAR CURSOS
INSERT INTO CURSO(Descripcion) VALUES
('CALCULO-1'),
('CALCULO-2'),
('CALCULO-3'),
('CALCULO-4'),
('ALGEBRA LINEAL'),
('FISICA'),
('PROGRAMACION'),
('MATEMATICA BASICA')

GO
--INSERTAR NIVEL_DETALLE

 INSERT INTO NIVEL_DETALLE_CURSO(IdNivelDetalle,IdCurso) VALUES
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),1),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),2),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),3),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),4),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),5),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),6),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),7),
((SELECT IdNivelDetalle FROM NIVEL_DETALLE WHERE IdNivel = 3 AND IdGradoSeccion = 1),8)


GO
--INSERTAR HORARIO

 insert into HORARIO(IdNivelDetalleCurso,DiaSemana,HoraInicio,HoraFin) values
(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 1),
 'Lunes','08:30:00.0000000','09:30:00.0000000'),

(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 2),
 'Lunes','09:30:00.0000000','10:30:00.0000000'),

(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 3),
 'Lunes','10:30:00.0000000','11:30:00.0000000'),
 
(( select top 1 ndc.IdNivelDetalleCurso from NIVEL_DETALLE_CURSO ndc
 inner join NIVEL_DETALLE nd on nd.IdNivelDetalle = ndc.IdNivelDetalle
 where nd.IdNivel = 3 and nd.IdGradoSeccion = 1 and ndc.IdCurso = 4),
 'Lunes','11:30:00.0000000','12:35:00.0000000')

 GO
 --REGISTRAR DOCENTE
INSERT INTO DOCENTE (ValorCodigo, Codigo, DocumentoIdentidad, Nombres, Apellidos, Email, NumeroTelefono) VALUES
 (1, '22140364', '70405822', 'JHANILDE', 'POZO', 'jhanilde.pozo@unmsm.edu.pe', '936798490'),
 (2, '22140327', '75065290', 'JIMENA', 'CARRILLO', 'jimena.carrillo@unmsm.edu.pe', '987654321'),
 (3, '22140311', '70727255', 'XIOMARA', 'YEPEZ', 'angellina.yepez@unmsm.edu.pe', '964852100');

GO

--REGISTRAR ALUMNO
INSERT INTO ALUMNO (ValorCodigo, Codigo, Nombres, Apellidos, DocumentoIdentidad) VALUES
 (1, '22140346', 'RODRIGO', 'AGUADO', '75110405'),
 (2, '22140100', 'PIERO', 'ALONZO', '77430313'),
 (3, '22140340', 'SERGIO', 'ALVARADO', '72050355'),
 (4, '22140355', 'JESUS', 'ALZAMORA', '70580271'),
 (5, '22140352', 'GIANMARCO', 'BARRANZUELA', '71314237'),
 (6, '22140101', 'ARTURO', 'BECERRA', '76344140'),
 (7, '22140353', 'ALEXANDER LENIN', 'BENAVENTE ARESTEGUI', '71411048'),
 (8, '22140102', 'JOSUE ANTONIO', 'BERROCAL ROMANI', '75128913'),
 (9, '22140328', 'GOJAN VICTOR', 'CARBAJAL MELGAREJO', '75388462'),
 (10, '22140330', 'JAROL', 'CARRASCAL MEJIA', '72811481'),
 (12, '22140103', 'FARIDH', 'CASTILLO JARAMILLO', '74218014'),
 (13, '22140360', 'LUIS GABRIEL', 'CASTRO SANDOVAL', '73891411'),
 (14, '22140105', 'CIELO ESTRELLA', 'CRUZ SALINAS', '75130841'),
 (15, '22140362', 'PIERO FAUSTO', 'CUETO LUNA', '71696558'),
 (16, '22140325', 'SALVADOR MESIAS', 'DAMIAN NAVARRO', '21122100'),
 (17, '22140341', 'LUIS LENNON', 'DE LA CRUZ ANCCO', '77272293'),
 (18, '22140320', 'JOSE ALEXIS', 'DELGADO PEREZ', '72773621'),
 (19, '22140350', 'AARON EMANUEL', 'DIAZ AVALOS', '70552190'),
 (20, '22140344', 'MARIO CESAR', 'EGUILUZ POMA', '09850237'),
 (21, '22140106', 'DIEGO ALEXHANDER', 'ESPINOZA HUAMAN', '76137917'),
 (23, '22140343', 'JESUS DANIEL', 'FLORES MUCHA', '71576554'),
 (24, '22140107', 'RODRIGO GABINO', 'GALICIA MERMA', '78568988'),
 (25, '22140318', 'BECKHAM LUIS', 'GONZALES MORALES', '75969769'),
 (26, '22140110', 'JULIO CESAR', 'GUTIERREZ VELASQUEZ', '72806218'),
 (27, '22140322', 'DENNIS RAFAEL', 'HEREDIA REYNOSO', '75915846'),
 (28, '22140310', 'LUIS ENRIQUE', 'HUAYTA HUILLCAHUARE', '74948861'),
 (29, '22140361', 'DANNY', 'ISMAIL FLORES', '48970153'),
 (30, '22140111', 'ENRIQUE', 'JULCA DELGADO', '73663328'),
 (31, '22140333', 'SEAN JEREMY', 'LEIVA RAMIREZ', '72156957'),
 (32, '22140367', 'ANDER RAFAEL', 'LINARES ROJAS', '73805176'),
 (33, '22140351', 'LEONEL', 'LIZARBE ALMEYDA', '72089841'),
 (34, '22140363', 'JESÚS ELÍAS', 'LUQUE PILLACA', '72575599'),
 (35, '22140321', 'KARLA PATRICIA', 'MADRID LLANOS', '74717017'),
 (36, '22140354', 'DAN CALEB', 'MELO GUTIERREZ', '76175741'),
 (37, '22140112', 'PAULO SEBASTIAN', 'MERCADO RAMIREZ', '74720198'),
 (38, '22140326', 'GRETEL ITALA', 'MESTANZA SANCHEZ', '71174774'),
 (39, '22140331', 'JORGE ALBERTO', 'PEREZ FLORES', '70478084'),
 (40, '22140357', 'SEBASTIAN AARON', 'PORRAS ANCO', '74177857'),
 (42, '22140113', 'MARK CHRISTIAN', 'QUISPE GONZALES', '72566599'),
 (43, '22140358', 'OLIVER', 'RAMIREZ BARRANTES', '72042510'),
 (44, '22140116', 'FRANCO DAVID', 'SOLIMANO CURE', '75172465'),
 (45, '22140336', 'BRUNO ALESSANDRO', 'SOLORZANO RIVERA', '73227357'),
 (46, '22140117', 'DIEGO ALEJANDRO', 'SOTELO ATUNCAR', '72472626'),
 (47, '22140118', 'DIEGO ALBERTO', 'SUYON LEON', '70247463'),
 (48, '22140335', 'MATHEUS LOUIGGI', 'TANAKA', '77534711'),
 (49, '22140316', 'DAVID ALEJANDRO', 'TEJADA OSSIO', '72809659'),
 (50, '22140120', 'CHRISTIAN DAVID', 'TISNADO YARLEQUE', '75125916'),
 (51, '22140323', 'PABLO GERARDO', 'VALDIVIA ALIPAZAGA', '76478239'),
 (52, '22140366', 'LUIS ANGELO', 'VIDAL CABRERA', '72893035'),
 (53, '22140319', 'MATIAS ALONSO', 'VILCA PALMA', '72873372'),
 (54, '22140122', 'YOSHIRO CARDICH', 'VILCHEZ QUISPE', '76313454'),
 (55, '22140312', 'JUNIOR ALBERTO', 'YANAC MINAYA', '76025145');

GO

--REGISTRAR DONCENTES CURSOS
 INSERT INTO DOCENTE_NIVELDETALLE_CURSO(IdNivelDetalleCurso,IdDocente) values
(1,1),
(2,2)

GO

--REGISTRAR CURRICULA
INSERT INTO CURRICULA(IdDocenteNivelDetalleCurso,Descripcion) VALUES
(1,'EVALUACION 001'),
(1,'EVALUACION 002'),
(1,'EVALUACION 003')

