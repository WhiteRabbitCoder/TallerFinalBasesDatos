-- Eliminar y crear la base de datos
DROP DATABASE IF EXISTS tallerfinalbd;
CREATE DATABASE IF NOT EXISTS tallerfinalbd;
USE tallerfinalbd;

-- Tabla usuarios
CREATE TABLE usuarios (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre_usuario TEXT NOT NULL,
  contraseña TEXT NOT NULL,
  tipo_usuario TEXT NOT NULL CHECK (
    tipo_usuario IN ('profesor', 'estudiante', 'administrador')
  )
);

-- Tabla estudiantes
CREATE TABLE estudiantes (
  id BIGINT PRIMARY KEY,
  fecha_nacimiento DATE,
  apellido_paterno TEXT,
  apellido_materno TEXT,
  nombre TEXT,
  email TEXT,
  genero TEXT,
  folio TEXT,
  referencia_bancaria TEXT,
  matricula TEXT,
  FOREIGN KEY (id) REFERENCES usuarios (id)
);

-- Tabla profesores
CREATE TABLE profesores (
  id BIGINT PRIMARY KEY,
  apellido_paterno TEXT,
  apellido_materno TEXT,
  nombre TEXT,
  numero_personal TEXT,
  cedula_profesional TEXT,
  telefono TEXT,
  email TEXT,
  FOREIGN KEY (id) REFERENCES usuarios (id)
);

-- Tabla administradores
CREATE TABLE administradores (
  id BIGINT PRIMARY KEY,
  apellido_paterno TEXT,
  apellido_materno TEXT,
  nombre TEXT,
  email TEXT,
  FOREIGN KEY (id) REFERENCES usuarios (id)
);

-- Tabla cursos
CREATE TABLE cursos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  nombre TEXT,
  categoria TEXT,
  ruta_contenido TEXT,
  fecha_inicio DATE,
  fecha_fin DATE,
  costo NUMERIC,
  profesor_id BIGINT,
  FOREIGN KEY (profesor_id) REFERENCES profesores (id)
);

-- Tabla tareas
CREATE TABLE tareas (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  curso_id BIGINT,
  nombre TEXT,
  descripcion TEXT,
  fecha_creacion TIMESTAMP,
  fecha_entrega TIMESTAMP,
  puntaje NUMERIC,
  archivo_estudiante TEXT,
  FOREIGN KEY (curso_id) REFERENCES cursos (id) ON UPDATE CASCADE
);

-- Tabla actividades_no_evaluables
CREATE TABLE actividades_no_evaluables (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  curso_id BIGINT,
  nombre TEXT,
  descripcion TEXT,
  fecha_creacion TIMESTAMP,
  fecha_terminacion TIMESTAMP,
  FOREIGN KEY (curso_id) REFERENCES cursos (id) ON UPDATE CASCADE
);

-- Tabla examenes
CREATE TABLE examenes (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  curso_id BIGINT,
  nombre TEXT,
  calificacion NUMERIC,
  puntaje NUMERIC,
  FOREIGN KEY (curso_id) REFERENCES cursos (id) ON UPDATE CASCADE
);

-- Tabla reactivos
CREATE TABLE reactivos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  examen_id BIGINT,
  contenido TEXT,
  FOREIGN KEY (examen_id) REFERENCES examenes (id)
);

-- Tabla criterios_evaluacion
CREATE TABLE criterios_evaluacion (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  curso_id BIGINT,
  nombre_criterio TEXT,
  porcentaje NUMERIC,
  FOREIGN KEY (curso_id) REFERENCES cursos (id) ON UPDATE CASCADE
);

-- Tabla inscripciones
CREATE TABLE inscripciones (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  estudiante_id BIGINT,
  curso_id BIGINT,
  fecha_inscripcion TIMESTAMP,
  FOREIGN KEY (estudiante_id) REFERENCES estudiantes (id),
  FOREIGN KEY (curso_id) REFERENCES cursos (id) ON UPDATE CASCADE
);

-- Tabla pagos
CREATE TABLE pagos (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  estudiante_id BIGINT,
  curso_id BIGINT,
  fecha_pago TIMESTAMP,
  monto NUMERIC,
  metodo_pago VARCHAR(50),
  estado VARCHAR(50),
  referencia_transaccion VARCHAR(100),
  FOREIGN KEY (estudiante_id) REFERENCES estudiantes (id),
  FOREIGN KEY (curso_id) REFERENCES cursos (id) ON UPDATE CASCADE
);

-- Estudiantes
INSERT INTO usuarios (nombre_usuario, contraseña, tipo_usuario) VALUES
('jdoe', 'password123', 'estudiante'),
('asmith', 'password123', 'estudiante'),
('bwayne', 'password123', 'estudiante'),
('ckent', 'password123', 'estudiante'),
('dprince', 'password123', 'estudiante'),
('hpotter', 'password123', 'estudiante'),
('rgranger', 'password123', 'estudiante'),
('hgranger', 'password123', 'estudiante'),
('fweasley', 'password123', 'estudiante'),
('gmalfoy', 'password123', 'estudiante');

-- Profesores
INSERT INTO usuarios (nombre_usuario, contraseña, tipo_usuario) VALUES
('eallen', 'password123', 'profesor'),
('fqueen', 'password123', 'profesor'),
('ggordon', 'password123', 'profesor'),
('cstorm', 'password123', 'profesor'),
('hmccoy', 'password123', 'profesor'),
('jhowlett', 'password123', 'profesor'),
('ooctavius', 'password123', 'profesor'),
('elektra', 'password123', 'profesor'),
('banner', 'password123', 'profesor'),
('tstark', 'password123', 'profesor');

-- Administradores
INSERT INTO usuarios (nombre_usuario, contraseña, tipo_usuario) VALUES
('hwest', 'password123', 'administrador'),
('iroman', 'password123', 'administrador'),
('jjarvis', 'password123', 'administrador'),
('nkingsley', 'password123', 'administrador'),
('blongbottom', 'password123', 'administrador'),
('mmcgonagall', 'password123', 'administrador'),
('ssnape', 'password123', 'administrador'),
('jblack', 'password123', 'administrador'),
('rlupin', 'password123', 'administrador'),
('abumbledore', 'password123', 'administrador');

INSERT INTO estudiantes (id, fecha_nacimiento, apellido_paterno, apellido_materno, nombre, email, genero, folio, referencia_bancaria, matricula) VALUES
(1, '2001-01-15', 'Doe', 'Smith', 'John', 'jdoe@example.com', 'Masculino', 'F123', 'RB123', 'MAT2023001'),
(2, '2002-02-16', 'Smith', 'Johnson', 'Alice', 'asmith@example.com', 'Femenino', 'F124', 'RB124', 'MAT2023002'),
(3, '2003-03-17', 'Wayne', 'Gordon', 'Bruce', 'bwayne@example.com', 'Masculino', 'F125', 'RB125', 'MAT2023003'),
(4, '2000-04-18', 'Kent', 'Lane', 'Clark', 'ckent@example.com', 'Masculino', 'F126', 'RB126', 'MAT2023004'),
(5, '1999-05-19', 'Prince', 'Trevor', 'Diana', 'dprince@example.com', 'Femenino', 'F127', 'RB127', 'MAT2023005'),
(6, '2001-06-20', 'Potter', 'Evans', 'Harry', 'hpotter@example.com', 'Masculino', 'F128', 'RB128', 'MAT2023006'),
(7, '2002-07-21', 'Granger', 'Wilkins', 'Ronald', 'rgranger@example.com', 'Masculino', 'F129', 'RB129', 'MAT2023007'),
(8, '2003-08-22', 'Granger', 'Wilkins', 'Hermione', 'hgranger@example.com', 'Femenino', 'F130', 'RB130', 'MAT2023008'),
(9, '2004-09-23', 'Weasley', 'Prewett', 'Fred', 'fweasley@example.com', 'Masculino', 'F131', 'RB131', 'MAT2023009'),
(10, '2000-10-24', 'Malfoy', 'Greengrass', 'Draco', 'gmalfoy@example.com', 'Masculino', 'F132', 'RB132', 'MAT2023010');

INSERT INTO profesores (id, apellido_paterno, apellido_materno, nombre, numero_personal, cedula_profesional, telefono, email) VALUES
(11, 'Allen', 'Walker', 'Ethan', 'NP001', 'CP123', '555-1111', 'eallen@example.com'),
(12, 'Queen', 'Merida', 'Felicity', 'NP002', 'CP124', '555-2222', 'fqueen@example.com'),
(13, 'Gordon', 'Brown', 'Gillian', 'NP003', 'CP125', '555-3333', 'ggordon@example.com'),
(14, 'Storm', 'Monroe', 'Charles', 'NP004', 'CP126', '555-4444', 'cstorm@example.com'),
(15, 'McCoy', 'Hank', 'Henry', 'NP005', 'CP127', '555-5555', 'hmccoy@example.com'),
(16, 'Howlett', 'Logan', 'James', 'NP006', 'CP128', '555-6666', 'jhowlett@example.com'),
(17, 'Octavius', 'Otto', 'Olivia', 'NP007', 'CP129', '555-7777', 'ooctavius@example.com'),
(18, 'Elektra', 'Natchios', 'Elektra', 'NP008', 'CP130', '555-8888', 'elektra@example.com'),
(19, 'Banner', 'Bruce', 'David', 'NP009', 'CP131', '555-9999', 'banner@example.com'),
(20, 'Stark', 'Tony', 'Anthony', 'NP010', 'CP132', '555-1010', 'tstark@example.com');

INSERT INTO administradores (id, apellido_paterno, apellido_materno, nombre, email) VALUES
(21, 'West', 'Allen', 'Harrison', 'hwest@example.com'),
(22, 'Romanoff', 'Natalia', 'Natasha', 'iroman@example.com'),
(23, 'Jarvis', 'Edwin', 'J.A.R.V.I.S.', 'jjarvis@example.com'),
(24, 'Kingsley', 'Shacklebolt', 'Kingsley', 'nkingsley@example.com'),
(25, 'Longbottom', 'Neville', 'Frank', 'blongbottom@example.com'),
(26, 'McGonagall', 'Minerva', 'Jean', 'mmcgonagall@example.com'),
(27, 'Snape', 'Severus', 'Prince', 'ssnape@example.com'),
(28, 'Black', 'Sirius', 'Orion', 'jblack@example.com'),
(29, 'Lupin', 'Remus', 'John', 'rlupin@example.com'),
(30, 'Dumbledore', 'Albus', 'Percival', 'abumbledore@example.com');

INSERT INTO cursos (nombre, categoria, ruta_contenido, fecha_inicio, fecha_fin, costo, profesor_id) VALUES
('Matemáticas Básicas', 'Educación', '/cursos/matematicas', '2024-01-10', '2024-06-30', 3500.00, 11),
('Historia Universal', 'Educación', '/cursos/historia', '2024-02-05', '2024-07-20', 3000.00, 12),
('Física Avanzada', 'Educación', '/cursos/fisica', '2024-03-01', '2024-08-30', 3200.00, 13),
('Química Básica', 'Educación', '/cursos/quimica', '2024-04-10', '2024-09-25', 3100.00, 14),
('Filosofía Moderna', 'Educación', '/cursos/filosofia', '2024-05-05', '2024-10-15', 2800.00, 15),
('Psicología General', 'Educación', '/cursos/psicologia', '2024-06-01', '2024-11-10', 2900.00, 16),
('Administración de Empresas', 'Administración', '/cursos/administracion', '2024-07-01', '2024-12-15', 4500.00, 17),
('Marketing Digital', 'Negocios', '/cursos/marketing', '2024-08-15', '2024-12-20', 3600.00, 18),
('Gestión de Proyectos', 'Negocios', '/cursos/proyectos', '2024-09-01', '2024-12-30', 5000.00, 19),
('Finanzas Personales', 'Administración', '/cursos/finanzas', '2024-10-01', '2025-03-01', 4000.00, 20);
update cursos set id = 3421 where id = 9;
update cursos set id = 7865 where id = 10;

INSERT INTO tareas (curso_id, nombre, descripcion, fecha_creacion, fecha_entrega, puntaje, archivo_estudiante) VALUES
(1, 'Tarea 1: Operaciones Básicas', 'Resolver 10 ejercicios básicos de matemáticas.', '2024-01-15 08:00:00', '2024-01-20 23:59:59', 10, 'archivo1.pdf'),
(2, 'Tarea 1: Revolución Francesa', 'Escribir un ensayo sobre los orígenes de la Revolución Francesa.', '2024-02-15 08:00:00', '2024-02-20 23:59:59', 10, 'archivo2.pdf'),
(3, 'Tarea 1: Movimiento Rectilíneo', 'Resolver problemas relacionados con velocidad y aceleración.', '2024-03-15 08:00:00', '2024-03-20 23:59:59', 10, 'archivo3.pdf'),
(4, 'Tarea 1: Reacciones Químicas', 'Balancear las ecuaciones químicas proporcionadas.', '2024-04-15 08:00:00', '2024-04-20 23:59:59', 10, 'archivo4.pdf'),
(5, 'Tarea 1: Teoría del Conocimiento', 'Escribir un ensayo sobre el conocimiento empírico.', '2024-05-15 08:00:00', '2024-05-20 23:59:59', 10, 'archivo5.pdf'),
(6, 'Tarea 1: Psicología Infantil', 'Realizar un análisis de un caso práctico.', '2024-06-15 08:00:00', '2024-06-20 23:59:59', 10, 'archivo6.pdf'),
(7, 'Tarea 1: Plan de Negocios', 'Diseñar un plan para una startup.', '2024-07-15 08:00:00', '2024-07-20 23:59:59', 10, 'archivo7.pdf'),
(8, 'Tarea 1: Marketing Digital', 'Crear una campaña básica para redes sociales.', '2024-08-15 08:00:00', '2024-08-20 23:59:59', 10, 'archivo8.pdf'),
(3421, 'Tarea Única', 'Tarea especial para consulta.', '2024-02-01 10:00:00', '2024-02-10 23:59:59', 100, 'archivo_unico.pdf');

INSERT INTO actividades_no_evaluables (curso_id, nombre, descripcion, fecha_creacion, fecha_terminacion) VALUES
(1, 'Foro de Discusión 1', 'Introducción a las operaciones básicas en matemáticas.', '2024-01-10 10:00:00', '2024-01-20 23:59:59'),
(2, 'Foro de Discusión 2', 'Debate sobre los derechos humanos en la Revolución Francesa.', '2024-02-10 10:00:00', '2024-02-20 23:59:59'),
(3, 'Chat de Dudas', 'Preguntas y respuestas sobre movimiento rectilíneo.', '2024-03-10 10:00:00', '2024-03-20 23:59:59'),
(4, 'Foro de Socialización', 'Compartir experimentos de reacciones químicas.', '2024-04-10 10:00:00', '2024-04-20 23:59:59'),
(5, 'Foro Filosófico', 'Discusión sobre conceptos de conocimiento filosófico.', '2024-05-10 10:00:00', '2024-05-20 23:59:59'),
(6, 'Chat de Psicología', 'Dudas y preguntas sobre el análisis de casos.', '2024-06-10 10:00:00', '2024-06-20 23:59:59'),
(7, 'Foro de Negocios', 'Comparte ideas sobre startups.', '2024-07-10 10:00:00', '2024-07-20 23:59:59'),
(3421, 'Foro Especial', 'Actividad de socialización sobre el curso especial.', '2024-02-05 10:00:00', '2024-02-15 23:59:59');

INSERT INTO examenes (curso_id, nombre, calificacion, puntaje) VALUES
(1, 'Examen Parcial', 90, 100),
(2, 'Examen Final', 85, 100),
(3, 'Examen Práctico', 88, 100),
(3421, 'Examen Único Especial', 95, 100),
(7865, 'Examen Avanzado', 100, 100);

INSERT INTO reactivos (examen_id, contenido) VALUES
(1, '¿Cuánto es 5 + 3?'),
(1, 'Resuelve: 10 x 2'),
(2, 'Describe el impacto de la Revolución Francesa.'),
(3, 'Pregunta especial del curso único.'),
(4, 'Define el concepto avanzado de gestión de proyectos.');

INSERT INTO inscripciones (estudiante_id, curso_id, fecha_inscripcion) VALUES
(1, 1, '2024-01-05 10:00:00'),
(2, 2, '2024-02-05 10:00:00'),
(3, 3, '2024-03-05 10:00:00'),
(4, 3421, '2024-02-01 12:00:00'),
(5, 7865, '2024-02-01 12:30:00');

INSERT INTO pagos (estudiante_id, curso_id, fecha_pago, monto, metodo_pago, estado, referencia_transaccion) VALUES
(1, 1, '2024-01-10 12:00:00', 3500.00, 'Tarjeta de Crédito', 'Completado', 'REF12345'),
(2, 2, '2024-02-10 14:30:00', 3000.00, 'Transferencia Bancaria', 'Completado', 'REF12346'),
(3, 3, '2024-03-10 16:00:00', 3200.00, 'Pago en Efectivo', 'Pendiente', 'REF12347'),
(4, 3421, '2024-02-15 10:00:00', 3000.00, 'Tarjeta de Crédito', 'Completado', 'REF12348');

#1.	Listar todos los estudiantes (nombre, apellido paterno, materno, matrícula) de la base de datos ordenados alfabéticamente por apellido paterno.
SELECT nombre,  apellido_materno, matricula
FROM estudiantes
ORDER BY apellido_paterno;

#2.	Listar todos los estudiantes (nombre, apellido paterno, materno, matrícula, nombre del curso) de la base de datos y los cursos que tienen asignados.
SELECT e.nombre, e.apellido_paterno, e.apellido_materno, e.matricula, c.nombre AS curso
FROM estudiantes e
JOIN inscripciones i ON e.id = i.estudiante_id
JOIN cursos c ON i.curso_id = c.id;

#3.	Listar los profesores (número de personal, nombre, apellido materno, apellido materno, curso) y los cursos que tiene asignados.
SELECT p.numero_personal, p.nombre, p.apellido_materno, c.nombre AS curso
FROM profesores p
JOIN cursos c ON p.id = c.profesor_id;

#4.	Listar todos los estudiantes y las calificaciones que han obtenido en cada curso (nombre, apellido paterno, materno, matrícula, nombre del curso, calificación).
SELECT e.nombre, e.apellido_paterno, e.apellido_materno, e.matricula, c.nombre AS curso, ex.calificacion
FROM estudiantes e
JOIN inscripciones i ON e.id = i.estudiante_id
JOIN cursos c ON i.curso_id = c.id
JOIN examenes ex ON c.id = ex.curso_id;

#5.	Listar todos los cursos ordenados por categoría. (nombre del curso, categoría).
SELECT nombre, categoria
FROM cursos
ORDER BY categoria;

#6.	Listar los cursos con un precio entre 2000 y 4000 pesos.
SELECT nombre, costo
FROM cursos
WHERE costo BETWEEN 2000 AND 4000;

#7.	Listar todas las personas que se registraron pero no realizaron sus pagos y los cursos que seleccionaron. (nombre, apellido paterno, apellido materno, email, curso, fecha de registro).
SELECT e.nombre, e.apellido_paterno, e.apellido_materno, e.email, c.nombre AS curso, i.fecha_inscripcion
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id = i.estudiante_id
JOIN cursos c ON i.curso_id = c.id
LEFT JOIN pagos p ON e.id = p.estudiante_id AND i.curso_id = p.curso_id
WHERE p.id IS NULL OR p.estado = 'Pendiente';

#8.	Listar los cursos que se encuentran en la categoría Administración.
SELECT nombre
FROM cursos
WHERE categoria = 'Administración';

#9.	Listar las tareas que los alumnos deben realizar en el curso con identificador 3421.
SELECT nombre, descripcion, fecha_entrega
FROM tareas
WHERE curso_id = 3421;

#10.	Listar los exámenes que se aplican en el curso con id 7865.
SELECT nombre, calificacion, puntaje
FROM examenes
WHERE curso_id = 7865;


