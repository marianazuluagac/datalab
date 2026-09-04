
| Tabla                   | Descripción                                                                                                                                                  |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **area_laboral**        | Almacena las áreas laborales o campos de especialización en los que trabajan los científicos de datos.                                                       |
| **cientifico_datos**    | Registra la información personal, académica y laboral de los científicos de datos que participan en los proyectos.                                           |
| **proyecto**            | Contiene la información de los proyectos de ciencia de datos, incluyendo su nombre, descripción, fechas, estado y presupuesto.                               |
| **participacion**       | Registra la participación de los científicos de datos en cada proyecto, indicando su rol, porcentaje de participación, fecha de asignación y estado.         |
| **dataset**             | Almacena la información de los conjuntos de datos utilizados en los proyectos y experimentos, como su fuente, tamaño, tipo de datos, licencia y repositorio. |
| **experimento**         | Registra los experimentos realizados dentro de los proyectos, incluyendo el científico responsable, configuración, fechas, estado y resultados obtenidos.    |
| **experimento_dataset** | Registra qué datasets son utilizados en cada experimento, indicando el rol que cumplen, la versión utilizada y las observaciones correspondientes.           |
| **modelo**              | Almacena los modelos de aprendizaje automático creados a partir de los experimentos, incluyendo su algoritmo, versión, estado y rendimiento general.         |
| **metrica**             | Registra las métricas utilizadas para evaluar el rendimiento de los modelos, incluyendo su valor, unidad, tipo y fecha de cálculo.                           |

# Especificación de la Base de Datos

 Tabla               | Columna                     | Tipo de dato  | Restricciones                              |
| ------------------- | --------------------------- | ------------- | ------------------------------------------ |
| area_laboral        | id_area **(PK)**            | INT           | NOT NULL, Solo números                     |
| area_laboral        | nombre_area                 | VARCHAR(100)  | NOT NULL, Solo caracteres                  |
| area_laboral        | descripcion                 | TEXT          | Solo caracteres                            |
| area_laboral        | sector                      | VARCHAR(100)  | Solo caracteres                            |
| cientifico_datos    | id_cientifico **(PK)**      | INT           | NOT NULL, Solo números                     |
| cientifico_datos    | nombre_completo             | VARCHAR(150)  | NOT NULL, Solo caracteres                  |
| cientifico_datos    | fecha_nacimiento            | DATE          | Fecha válida                               |
| cientifico_datos    | genero                      | VARCHAR(30)   | Solo caracteres                            |
| cientifico_datos    | correo                      | VARCHAR(150)  | NOT NULL, UNIQUE, Formato de correo válido |
| cientifico_datos    | telefono                    | VARCHAR(20)   | Solo números y símbolos telefónicos        |
| cientifico_datos    | universidad                 | VARCHAR(150)  | Solo caracteres                            |
| cientifico_datos    | carrera                     | VARCHAR(150)  | Solo caracteres                            |
| cientifico_datos    | fecha_ingreso               | DATE          | Fecha válida                               |
| cientifico_datos    | titulo_academico            | VARCHAR(150)  | Solo caracteres                            |
| cientifico_datos    | id_area **(FK)**            | INT           | NOT NULL, Solo números                     |
| proyecto            | id_proyecto **(PK)**        | INT           | NOT NULL, Solo números                     |
| proyecto            | nombre_proyecto             | VARCHAR(150)  | NOT NULL, Solo caracteres                  |
| proyecto            | descripcion                 | TEXT          | Solo caracteres                            |
| proyecto            | fecha_inicio                | DATE          | Fecha válida                               |
| proyecto            | fecha_fin                   | DATE          | Fecha válida                               |
| proyecto            | estado                      | VARCHAR(50)   | DEFAULT 'Activo', Solo caracteres          |
| proyecto            | presupuesto                 | DECIMAL(12,2) | CHECK >= 0, Solo números                   |
| participacion       | id_cientifico **(PK, FK)**  | INT           | NOT NULL, Solo números                     |
| participacion       | id_proyecto **(PK, FK)**    | INT           | NOT NULL, Solo números                     |
| participacion       | rol_en_proyecto             | VARCHAR(100)  | Solo caracteres                            |
| participacion       | fecha_asignacion            | DATE          | Fecha válida                               |
| participacion       | porcentaje_participacion    | DECIMAL(5,2)  | CHECK entre 0 y 100, Solo números          |
| participacion       | estado                      | VARCHAR(50)   | DEFAULT 'Activo', Solo caracteres          |
| dataset             | id_dataset **(PK)**         | INT           | NOT NULL, Solo números                     |
| dataset             | nombre                      | VARCHAR(150)  | NOT NULL, Solo caracteres                  |
| dataset             | descripcion                 | TEXT          | Solo caracteres                            |
| dataset             | fuente                      | VARCHAR(200)  | Solo caracteres                            |
| dataset             | fecha_carga                 | DATE          | Fecha válida                               |
| dataset             | tamano_filas                | INT           | CHECK >= 0, Solo números                   |
| dataset             | tamano_columnas             | INT           | CHECK >= 0, Solo números                   |
| dataset             | tipo_datos                  | VARCHAR(100)  | Solo caracteres                            |
| dataset             | licencia                    | VARCHAR(100)  | Solo caracteres                            |
| dataset             | url_repositorio             | VARCHAR(500)  | Formato URL válido                         |
| experimento         | id_experimento **(PK)**     | INT           | NOT NULL, Solo números                     |
| experimento         | id_proyecto **(FK)**        | INT           | NOT NULL, Solo números                     |
| experimento         | id_cientifico **(FK)**      | INT           | NOT NULL, Solo números                     |
| experimento         | nombre_experimento          | VARCHAR(150)  | NOT NULL, Solo caracteres                  |
| experimento         | descripcion                 | TEXT          | Solo caracteres                            |
| experimento         | fecha_ejecucion             | DATE          | Fecha válida                               |
| experimento         | fecha_fin                   | DATE          | Fecha válida                               |
| experimento         | configuracion               | TEXT          | Solo caracteres                            |
| experimento         | estado                      | VARCHAR(50)   | DEFAULT 'Activo', Solo caracteres          |
| experimento         | resultado_resumen           | TEXT          | Solo caracteres                            |
| experimento_dataset | id_experimento **(PK, FK)** | INT           | NOT NULL, Solo números                     |
| experimento_dataset | id_dataset **(PK, FK)**     | INT           | NOT NULL, Solo números                     |
| experimento_dataset | rol_en_experimento          | VARCHAR(100)  | Solo caracteres                            |
| experimento_dataset | fecha_uso                   | DATE          | Fecha válida                               |
| experimento_dataset | version_dataset             | VARCHAR(50)   | Solo caracteres                            |
| experimento_dataset | observaciones               | TEXT          | Solo caracteres                            |
| modelo              | id_modelo **(PK)**          | INT           | NOT NULL, Solo números                     |
| modelo              | id_experimento **(FK)**     | INT           | UNIQUE, NOT NULL, Solo números             |
| modelo              | nombre                      | VARCHAR(150)  | NOT NULL, Solo caracteres                  |
| modelo              | version                     | VARCHAR(50)   | Solo caracteres                            |
| modelo              | algoritmo                   | VARCHAR(100)  | Solo caracteres                            |
| modelo              | descripcion                 | TEXT          | Solo caracteres                            |
| modelo              | fecha_creacion              | DATE          | Fecha válida                               |
| modelo              | estado                      | VARCHAR(50)   | DEFAULT 'Activo', Solo caracteres          |
| modelo              | rendimiento_general         | DECIMAL(10,4) | Solo números                               |
| metrica             | id_metrica **(PK)**         | INT           | NOT NULL, Solo números                     |
| metrica             | id_modelo **(FK)**          | INT           | NOT NULL, Solo números                     |
| metrica             | nombre                      | VARCHAR(100)  | NOT NULL, Solo caracteres                  |
| metrica             | descripcion                 | TEXT          | Solo caracteres                            |
| metrica             | valor                       | DECIMAL(10,4) | Solo números                               |
| metrica             | unidad                      | VARCHAR(50)   | Solo caracteres                            |
| metrica             | fecha_calculo               | DATE          | Fecha válida                               |
| metrica             | tipo                        | VARCHAR(50)   | Solo caracteres                            |
