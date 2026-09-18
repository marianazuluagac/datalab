# Semana 4 — Guía del Estudiante

## Integridad Referencial y Normalización Básica (3.5–3.6)
### Caso hilo conductor: DataLab

---

## Objetivos de la semana

Al final de esta semana estarán en capacidad de:

- Explicar qué es la integridad referencial y qué política aplicar ante un `DELETE` o `UPDATE` sobre una fila referenciada.
- Elegir y justificar, para cada llave foránea de DataLab, una política `ON DELETE`.
- Diagnosticar violaciones de 1FN, 2FN y 3FN en un diseño dado, y corregirlas.
- Auditar su propio esquema de DataLab y confirmar (o corregir) que cumple con la normalización básica.

**Equipo:** MARIANA ZULUGA 
LAURA GUARNIZO
DONOVAN GARCÍA

---

## BLOQUE 1 — Formalización (2 horas, sin PC)

### Retomar la Semana 3

Recuerden su respuesta escrita de la semana pasada: ¿qué debería pasar si se intenta insertar un experimento con un `id_proyecto` que no existe?

La inserción debe ser rechazada porque id_proyecto es una llave foránea que debe hacer referencia a un proyecto existente. Esto garantiza la integridad referencial de la base de datos.

### Integridad referencial

**a)** ¿Qué garantiza la integridad referencial? Expliquenlo en sus propias palabras.

La integridad referencial garantiza que las relaciones entre las tablas sean válidas, evitando que una llave foránea haga referencia a un registro que no existe en la tabla relacionada.

Completen la tabla de políticas mientras el docente explica:

| Política | Qué hace | Cuándo tiene sentido |
|---|---|---|
| `RESTRICT` | Impide eliminar el registro padre si existen registros relacionados. | Cuando no queremos perder información relacionada al eliminar un registro.|
| `CASCADE` | Elimina automáticamente los registros relacionados cuando se elimina el registro padre.| Cuando los registros hijos dependen completamente del registro padre. |
| `SET NULL` | Cuando se elimina el registro padre, la llave foránea relacionada queda en NULL. | Cuando el registro hijo puede seguir existiendo aunque ya no tenga un registro padre asociado.|

**b)** Si borramos un `MODELO`, ¿qué debería pasar con sus filas en `METRICA`? Argumenten antes de que el docente dé la respuesta.

Las filas relacionadas en METRICA deberían eliminarse automáticamente, por lo que elegiríamos CASCADE. Las métricas dependen del modelo al que pertenecen y no tendrían sentido si ese modelo ya no existe.

### Ejercicio: política para cada FK de DataLab

Para cada llave foránea de su esquema, elijan una política `ON DELETE` y justifíquenla:

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

### Primera forma normal (1FN)

Analicen este diseño:

```
metrica_mala(id_metrica, id_modelo, metricas_registradas)
```
donde `metricas_registradas` guarda `"accuracy:0.95, f1:0.89, precision:0.91"` en una sola columna de texto.

**c)** ¿Qué problema tiene este diseño si quisieran buscar todos los modelos con accuracy mayor a 0.90?

El problema es que metricas_registradas contiene varios valores dentro de una sola columna. Esto dificulta buscar, comparar y consultar individualmente cada métrica, por ejemplo, encontrar todos los modelos con accuracy mayor a 0.90.

**d)** ¿Cómo lo corregirían? (Pista: ya tienen la respuesta en su propio esquema de la Semana 2)

Se debe separar cada métrica en un registro independiente de la tabla metrica. Así, cada fila puede almacenar el nombre de la métrica, su valor, unidad, fecha de cálculo y tipo, cumpliendo con la primera forma normal.

### Segunda forma normal (2FN)

Analicen este diseño, con llave primaria compuesta `(id_dataset, id_experimento)`:

```
uso_dataset_malo(id_dataset, id_experimento, nombre_dataset, fecha_ejecucion)
```

**e)** `nombre_dataset`, ¿depende de las dos columnas de la llave o de solo una? ¿Y `fecha_ejecucion`?

nombre_dataset depende únicamente de id_dataset, mientras que fecha_ejecucion depende únicamente de id_experimento. Por lo tanto, ninguno de los dos depende de la llave primaria completa (id_dataset, id_experimento), lo que genera una dependencia parcial.

**f)** ¿Cómo se corrige esta dependencia parcial?

Se deben separar los atributos que pertenecen a cada entidad. nombre_dataset debe estar en la tabla dataset y fecha_ejecucion debe estar en la tabla experimento. La tabla experimento_dataset debe contener solamente la información relacionada con la asociación entre ambos.

### Tercera forma normal (3FN)

Analicen este diseño:

```
experimento_malo(id_experimento, id_proyecto, nombre_proyecto, fecha_ejecucion)
```

**g)** `nombre_proyecto`, ¿depende directamente de `id_experimento`, o depende de `id_proyecto`? ¿Cómo se llama esa cadena de dependencia?

nombre_proyecto depende de id_proyecto y no directamente de id_experimento. Esto genera una dependencia transitiva.

**h)** ¿Cómo se corrige?

Se debe eliminar nombre_proyecto de la tabla experimento y mantenerlo únicamente en la tabla proyecto. En experimento solo se conserva id_proyecto como llave foránea para relacionarlo con el proyecto correspondiente.

**i)** Si construyeron correctamente su esquema desde la Semana 2 (siguiendo las reglas de conversión E-R→relacional), ¿por qué sería esperable que ya esté en 3FN?

Porque al convertir correctamente el modelo E-R al modelo relacional, cada entidad se transforma en una tabla y sus atributos se mantienen en la tabla correspondiente. Además, las relaciones se representan mediante llaves foráneas, evitando repetir información y reduciendo las dependencias parciales y transitivas.

---

## BLOQUE 2 — Laboratorio (3 horas, con PC)

### Retomar (20 min)

¿Alguno de los tres ejemplos "malos" de la formalización les recordó algo de un borrador anterior de su propio esquema?

Sí. Los ejemplos muestran problemas que pueden aparecer cuando se colocan varios datos en una misma columna o cuando se repite información de otras tablas. Al revisar nuestro esquema, vimos que la información está sepa

### Auditoría de normalización del propio esquema (50 min)

Revisen, tabla por tabla, su esquema real de DataLab (Semana 3) y respondan para cada una:

| Tabla | ¿Cumple 1FN? | ¿Cumple 2FN? | ¿Cumple 3FN? | Justificación |
|---|---|---|---|---|
| `cientifico_datos` | Sí | Sí | Sí | Los valores son atómicos y los atributos dependen directamente de la llave primaria. |
| `proyecto` | Sí | Sí | Sí | Los datos son atómicos y no existen dependencias parciales ni transitivas. |
| `dataset` | Sí | Sí | Sí | Cada columna contiene un valor individual y los atributos dependen de la llave primaria. |
| `experimento` | Sí | Sí | Sí | Los datos están organizados de forma atómica y no presentan dependencias parciales ni transitivas. |
| `modelo` | Sí | Sí | Sí | Los atributos dependen directamente del modelo y no existen dependencias parciales ni transitivas. |
| `metrica` | Sí | Sí | Sí | Cada métrica se registra como un valor individual y sus atributos dependen de la llave primaria. |
| `participacion` | Sí | Sí | Sí | Los valores son atómicos y los atributos dependen de la llave primaria compuesta completa. |
| `experimento_dataset` | Sí | Sí | Sí | Los valores son atómicos y los atributos dependen de la combinación completa de las llaves. |
| `area_laboral` | Sí | Sí | Sí | Los valores son atómicos y los atributos dependen directamente de la llave primaria. |

### Descanso (15 min)

### Aplicar las políticas de integridad referencial en el diagrama (50 min)

Actualicen su archivo `.dbml` (o el modelo en MySQL Workbench) agregando la política `ON DELETE` que decidieron en el Bloque 1.

> 💡 En DBML:
> ```
> Ref: metrica.id_modelo > modelo.id_modelo [delete: cascade]
> Ref: experimento.id_proyecto > proyecto.id_proyecto [delete: restrict]
> ```

### Documentación (30 min)

1. Registren en `documentacion/decisiones.md` la política `ON DELETE` de cada una de las 8 FK, con su justificación.
2. Registren el resultado de su auditoría de normalización: qué revisaron, qué confirmaron, y si algo se ajustó.

### Commit y cierre (15 min)

- Exporten el esquema actualizado a `diagramas/relacional/s04-esquema-integridad.png` (o actualicen el `.dbml`).
- Commit: `git commit -m "modelo: políticas de integridad referencial y auditoría de normalización de DataLab"`.

---

## Respuestas de verificación de comprensión

**1. ¿Cuál es la diferencia entre `RESTRICT` y `CASCADE`?**

`RESTRICT` impide eliminar un registro padre cuando existen registros relacionados, mientras que `CASCADE` elimina automáticamente los registros relacionados cuando se elimina el registro padre.

**2. ¿Por qué 2FN solo importa cuando la llave primaria es compuesta?**

Porque la 2FN busca evitar dependencias parciales. Estas ocurren cuando un atributo depende solamente de una parte de una llave primaria compuesta. Si la llave primaria tiene una sola columna, no puede existir una dependencia parcial.

**3. Si su esquema fue construido correctamente a partir del modelo E-R, ¿por qué es esperable que ya esté en 3FN?**

Porque al convertir correctamente el modelo E-R al modelo relacional, cada entidad tiene su propia tabla y sus atributos correspondientes, mientras que las relaciones se representan mediante llaves foráneas. Esto evita repetir información y reduce las dependencias transitivas entre los atributos.

---

## Cierre de la actividad

Se completó la revisión de integridad referencial y normalización del esquema de DataLab. Se definieron las políticas `ON DELETE` para las llaves foráneas, se realizó la auditoría de 1FN, 2FN y 3FN y se confirmó que las tablas actuales cumplen con la normalización básica.

También se debe actualizar el archivo `.dbml` con las políticas de eliminación definidas y exportar el diagrama actualizado como:

`diagramas/relacional/s04-esquema-integridad.png`

Finalmente, se realizará el commit correspondiente:

`git commit -m "modelo: políticas de integridad referencial y auditoría de normalización de DataLab"`


---

## Preguntas de análisis adicionales

### ¿Por qué podría ser importante impedir que se elimine un proyecto que todavía tiene experimentos?

Porque los experimentos dependen del proyecto y conservan información relacionada con él. Si se eliminara el proyecto, se podría perder la relación y el historial de los experimentos. Por eso `RESTRICT` permite proteger la información y evitar eliminaciones que afecten datos relacionados.

### ¿Qué información se perdería y qué información se conservaría en un escenario con `SET NULL`?

Se perdería la relación entre el registro hijo y el registro padre, ya que la llave foránea pasaría a ser `NULL`. Sin embargo, se conservaría la información propia del registro hijo, siempre que este pueda existir sin el registro padre.

---

# Preguntas de profundización

### Pregunta 1

**Si `metrica.id_modelo` utiliza `ON DELETE CASCADE`, ¿qué riesgo existe si un usuario elimina accidentalmente un modelo?**

El riesgo es que todas las métricas relacionadas con ese modelo se eliminen automáticamente. Esto podría provocar pérdida de información que podría ser útil para conservar el historial y analizar el rendimiento del modelo.

### Pregunta 2

**¿Por qué podría ser preferible `RESTRICT` para una relación entre `proyecto` y `experimento`?**

Porque evita eliminar un proyecto mientras existan experimentos relacionados con él. De esta manera se protege la información histórica y se evita perder la relación entre los experimentos y el proyecto al que pertenecen.

### Pregunta 3

**¿Por qué guardar `"accuracy:0.95, f1:0.89"` como texto dificulta el trabajo analítico?**

Porque varias métricas están almacenadas dentro de una sola columna de texto. Esto dificulta realizar consultas, filtros, comparaciones y operaciones sobre cada métrica de manera independiente.

### Pregunta 4

**¿Por qué `nombre_dataset` pertenece conceptualmente a `dataset` y no a `uso_dataset`?**

Porque `nombre_dataset` describe directamente al dataset y depende de `id_dataset`. `uso_dataset` representa la relación entre un dataset y un experimento, por lo que debe contener los datos propios de esa asociación y no repetir información del dataset.

### Pregunta 5

**¿Qué anomalía de actualización podría aparecer si `nombre_proyecto` estuviera repetido en muchos registros de `experimento`?**

Podría ocurrir una anomalía de actualización, ya que al cambiar el nombre de un proyecto sería necesario modificarlo en varios registros de `experimento`. Si alguno no se actualiza, quedarían datos inconsistentes.

### Pregunta 6

**¿Cuál es la relación entre una correcta transformación E-R → relacional y la normalización?**

Una correcta transformación E-R → relacional mantiene los atributos en las entidades a las que pertenecen y representa las relaciones mediante llaves foráneas o tablas puente. Esto ayuda a evitar la repetición de información y reduce la posibilidad de dependencias parciales y transitivas, facilitando el cumplimiento de la normalización.

---

# Reto de cierre — Explicación con Feynman

### ¿Cómo sé si mi tabla de DataLab está correctamente normalizada y qué debería pasar si elimino un registro que tiene otras tablas relacionadas?

Para saber si una tabla está correctamente normalizada se deben revisar las formas normales.

La **integridad referencial** garantiza que las relaciones entre las tablas sean válidas. Para esto se utilizan las **llaves foráneas (FK)**, que deben hacer referencia a registros existentes en la tabla relacionada.

Cuando se elimina un registro que tiene otras tablas relacionadas, la base de datos debe aplicar la política definida para esa relación:

- `RESTRICT`: impide eliminar el registro padre si existen registros relacionados.
- `CASCADE`: elimina automáticamente los registros relacionados.
- `SET NULL`: coloca la llave foránea en `NULL`, siempre que la columna permita valores nulos.

En cuanto a la normalización:

- **1FN:** cada celda debe contener un valor atómico y no debe almacenar listas o varios valores en una sola columna.
- **2FN:** los atributos no clave deben depender de toda la llave primaria. Es especialmente importante cuando existe una llave primaria compuesta.
- **3FN:** los atributos no clave deben depender directamente de la llave primaria y no de otros atributos no clave.

Por ejemplo, en DataLab, la tabla `metrica` almacena cada métrica en un registro independiente, relacionada mediante `id_modelo` con la tabla `modelo`. Esto permite consultar y analizar cada métrica individualmente y evita almacenar varias métricas dentro de una sola columna.

---

# Evidencias y cierre del repositorio

Para finalizar la actividad se debe:

- [ ] Actualizar el archivo `.dbml` con las políticas `ON DELETE`.
- [ ] Exportar el esquema actualizado como `diagramas/relacional/s04-esquema-integridad.png`.
- [ ] Actualizar `documentacion/decisiones.md`.
- [ ] Realizar `git add .`.
- [ ] Realizar el commit con el mensaje:

`git commit -m "modelo: políticas de integridad referencial y auditoría de normalización de DataLab"`

- [ ] Realizar `git push`.
- [ ] Verificar que la contribución individual de cada integrante pueda identificarse en Git.

---

# Relación con la Semana 5

La Semana 4 deja preparado el modelo para pasar al diseño físico. La secuencia del proyecto queda así:

**Modelo E-R → Modelo relacional → Tablas, columnas y tipos → Integridad referencial → Normalización → Diseño físico → CREATE TABLE → Base de datos ejecutada en un motor real.**

Las decisiones tomadas sobre las llaves foráneas, las políticas `ON DELETE` y la normalización servirán como base para la creación de las tablas mediante DDL en la Semana 5.

## Avance hacia el Hito 2

- [ ] Políticas `ON DELETE` definidas y aplicadas en el diagrama para las 8 FK.
- [ ] Auditoría de normalización completa (1FN, 2FN, 3FN) registrada.
- [ ] Decisiones documentadas en `documentacion/decisiones.md`.
- [ ] Commit realizado con el mensaje sugerido.

*(El Hito 2 completo — diseño físico + creación en motor real — se cierra en la Semana 5.)*
