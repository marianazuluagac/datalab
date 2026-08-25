# Decisiones de diseño

- ALGORITMO se considera un atributo de MODELO porque describe una característica del modelo.
- DATASET es una entidad fuerte porque tiene un identificador propio.
- EXPERIMENTO se modela como entidad porque tiene atributos propios.
- CIENTIFICO_DATOS y PROYECTO tienen una relación N:M mediante PARTICIPA.
- CIENTIFICO_DATOS y EXPERIMENTO tienen una relación 1:N mediante EJECUTA.
- DATASET y EXPERIMENTO tienen una relación 1:N mediante SE USA EN.
- EXPERIMENTO y MODELO tienen una relación 1:1 mediante PRODUCE.
- MODELO y METRICA tienen una relación 1:N mediante SE EVALÚA EN.   

## Semana 2

- Se creó la tabla PARTICIPACION para resolver la relación N:M entre CIENTIFICO_DATOS y PROYECTO.
- PARTICIPACION tiene id_cientifico e id_proyecto.
- En EXPERIMENTO quedaron las llaves foráneas de PROYECTO, CIENTIFICO_DATOS y DATASET.
- En MODELO quedó id_experimento para relacionarlo con EXPERIMENTO.
- En METRICA quedó id_modelo para relacionarla con MODELO.