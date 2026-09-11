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

## Semana 4

### Políticas de integridad referencial

| Tabla | Llave foránea (FK) | Política ON DELETE | Justificación |
|---|---|---|---|
| `cientifico_datos` | `id_area → area_laboral.id_area` | `RESTRICT` | Evita eliminar un área laboral que todavía tenga científicos asociados. |
| `experimento` | `id_proyecto → proyecto.id_proyecto` | `RESTRICT` | Evita eliminar un proyecto que tenga experimentos relacionados y permite conservar su historial. |
| `experimento` | `id_cientifico → cientifico_datos.id_cientifico` | `RESTRICT` | Evita eliminar un científico que tenga experimentos asociados. |
| `modelo` | `id_experimento → experimento.id_experimento` | `CASCADE` | Si se elimina un experimento, se elimina automáticamente el modelo que depende de él. |
| `metrica` | `id_modelo → modelo.id_modelo` | `CASCADE` | Las métricas dependen del modelo, por lo que se eliminan junto con él. |
| `participacion` | `id_cientifico → cientifico_datos.id_cientifico` | `CASCADE` | Si se elimina un científico, se eliminan sus registros de participación en proyectos. |
| `participacion` | `id_proyecto → proyecto.id_proyecto` | `CASCADE` | Si se elimina un proyecto, se eliminan automáticamente sus registros de participación. |
| `experimento_dataset` | `id_dataset → dataset.id_dataset` | `RESTRICT` | Evita eliminar un dataset que esté siendo utilizado en experimentos. |
| `experimento_dataset` | `id_experimento → experimento.id_experimento` | `CASCADE` | Si se elimina un experimento, se eliminan los registros que relacionan ese experimento con sus datasets. |

### Auditoría de normalización

Se revisaron las tablas de DataLab para verificar el cumplimiento de la primera, segunda y tercera forma normal.

Se confirmó que los datos de las columnas son atómicos, por lo que las tablas cumplen con 1FN. También se revisaron las dependencias de los atributos respecto a las llaves primarias y no se encontraron dependencias parciales, por lo que se cumple con 2FN. Finalmente, se revisaron las dependencias entre atributos y no se encontraron dependencias transitivas, por lo que se cumple con 3FN.

No fue necesario realizar ajustes en el esquema actual, ya que las tablas se encuentran organizadas de acuerdo con las entidades y relaciones del proyecto.x