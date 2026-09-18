-- =========================================================
-- DataLab — Script de creación de tablas (DDL) — PLANTILLA DE TRABAJO
-- Semana 5 — Hito 2
-- Motor: MySQL 8.x (ENGINE=InnoDB obligatorio para soportar FOREIGN KEY)
--
-- Instrucciones: las primeras 3 tablas ya están resueltas como ejemplo,
-- porque no tienen dependencias (no llevan FOREIGN KEY). Completen las
-- 5 tablas restantes siguiendo el mismo patrón y respetando el orden
-- de dependencias explicado en la guía. Reemplacen cada bloque "-- TODO"
-- por la sentencia CREATE TABLE completa.
-- =========================================================

CREATE DATABASE IF NOT EXISTS datalab;
USE datalab;

-- ---------------------------------------------------------
-- Tablas sin dependencias (resueltas como ejemplo)
-- ---------------------------------------------------------

CREATE TABLE cientifico_datos (
    id_cientifico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_institucional VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE proyecto (
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_proyecto VARCHAR(150) NOT NULL,
    descripcion TEXT
) ENGINE=InnoDB;

CREATE TABLE dataset (
    id_dataset INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    fuente VARCHAR(20) NOT NULL,
    fecha_carga DATE NOT NULL,
    tamanio_filas INT,
    CONSTRAINT chk_dataset_fuente CHECK (fuente IN ('interna','externa')),
    CONSTRAINT chk_dataset_tamanio CHECK (tamanio_filas >= 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- TODO 1 — Tabla experimento
-- Depende de: proyecto, cientifico_datos
-- Columnas: id_experimento (PK, auto), id_proyecto (FK), id_cientifico (FK),
--           fecha_ejecucion (DATE, NOT NULL, DEFAULT hoy), configuracion (TEXT)
-- Política ON DELETE definida en la Semana 4 para cada FK.
-- ---------------------------------------------------------

CREATE TABLE experimento (
    id_experimento INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    id_cientifico INT NOT NULL,
    fecha_ejecucion DATE NOT NULL DEFAULT (CURRENT_DATE),
    configuracion TEXT,
    CONSTRAINT fk_experimento_proyecto
        FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto)
        ON DELETE RESTRICT,
    CONSTRAINT fk_experimento_cientifico
        FOREIGN KEY (id_cientifico) REFERENCES cientifico_datos(id_cientifico)
        ON DELETE RESTRICT
) ENGINE=InnoDB;


-- ---------------------------------------------------------
-- TODO 2 — Tabla modelo
-- Depende de: experimento
-- Recuerden: la FK a experimento debe ser UNIQUE (fuerza la cardinalidad 1:1,
-- ver Semana 3).
-- Columnas: id_modelo (PK, auto), id_experimento (FK, UNIQUE), nombre,
--           version, algoritmo.
-- ---------------------------------------------------------

CREATE TABLE modelo (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    id_experimento INT NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    version VARCHAR(50) NOT NULL,
    algoritmo VARCHAR(100) NOT NULL,
    CONSTRAINT fk_modelo_experimento
        FOREIGN KEY (id_experimento) REFERENCES experimento(id_experimento)
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- ---------------------------------------------------------
-- TODO 3 — Tabla metrica
-- Depende de: modelo
-- Columnas: id_metrica (PK, auto), id_modelo (FK), nombre_metrica, valor
--           (con su CHECK del rango permitido), fecha_calculo.
-- ---------------------------------------------------------

CREATE TABLE metrica (
    id_metrica INT AUTO_INCREMENT PRIMARY KEY,
    id_modelo INT NOT NULL,
    nombre_metrica VARCHAR(100) NOT NULL,
    valor DECIMAL(10,4) NOT NULL,
    fecha_calculo DATE NOT NULL,
    CONSTRAINT chk_metrica_valor CHECK (valor >= 0 AND valor <= 1),
    CONSTRAINT fk_metrica_modelo
        FOREIGN KEY (id_modelo) REFERENCES modelo(id_modelo)
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- ---------------------------------------------------------
-- TODO 4 — Tabla puente participacion
-- Depende de: cientifico_datos, proyecto
-- Llave primaria compuesta por las dos FK.
-- ---------------------------------------------------------

CREATE TABLE participacion (
    id_cientifico INT NOT NULL,
    id_proyecto INT NOT NULL,
    PRIMARY KEY (id_cientifico, id_proyecto),
    CONSTRAINT fk_participacion_cientifico
        FOREIGN KEY (id_cientifico) REFERENCES cientifico_datos(id_cientifico)
        ON DELETE CASCADE,
    CONSTRAINT fk_participacion_proyecto
        FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- TODO 5 — Tabla puente uso_dataset
-- Depende de: dataset, experimento
-- Llave primaria compuesta por las dos FK.
-- ---------------------------------------------------------

CREATE TABLE uso_dataset (
    id_dataset INT NOT NULL,
    id_experimento INT NOT NULL,
    PRIMARY KEY (id_dataset, id_experimento),
    CONSTRAINT fk_uso_dataset_dataset
        FOREIGN KEY (id_dataset) REFERENCES dataset(id_dataset)
        ON DELETE CASCADE,
    CONSTRAINT fk_uso_dataset_experimento
        FOREIGN KEY (id_experimento) REFERENCES experimento(id_experimento)
        ON DELETE CASCADE
) ENGINE=InnoDB;


-- =========================================================
-- Cuando terminen: ejecuten el script completo contra su base `datalab`
-- y verifiquen con SHOW TABLES; que las 8 tablas se crearon correctamente.
-- =========================================================
