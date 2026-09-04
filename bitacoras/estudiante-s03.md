# Semana 3 — Guía del Estudiante

## Tablas, Columnas, Dominios, Restricciones y Llaves (3.3–3.4)
### Caso hilo conductor: DataLab

---

## Objetivos de la semana

Al final de esta semana estarán en capacidad de:

- Definir con precisión qué es un dominio y asignar el tipo de dato correcto a cada columna de un esquema relacional.
- Aplicar restricciones a nivel de columna y de tabla: `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK`.
- Formalizar las reglas de llave primaria (simple y compuesta) y llave foránea, incluyendo el caso especial de `UNIQUE + FK` para forzar una relación 1:1.
- Dejar el esquema relacional de DataLab completamente tipado y con restricciones, listo para crearse en un motor real en la Semana 5.

    **Equipo:**
    Mariana Zuluaga Cantor
    Laura Sofia Guarnizo Dominguez
    Donovan García 

---

## BLOQUE 1 — Formalización (2 horas, sin PC)

### Retomar la Semana 2

Muestren brevemente al resto del curso el nombre que le dieron a sus tablas puente.

### Dominios y tipos de datos

Completen la tabla mientras el docente explica, con un ejemplo propio de DataLab para cada tipo:

| Tipo | Uso típico | Ejemplo en DataLab |
|---|---|---|
| `INT` | Números enteros | id_modelo |
| `VARCHAR(n)` | Texto corto con longitud máxima | nombre_modelo |
| `TEXT` | Texto largo | descripcion de un proyecto |
| `DATE` | Fechas | fecha_creacion |
| `DECIMAL(p,e)` | Números decimales con precisión definida | valor_metrica |
| `BOOLEAN` | Valores verdadero/falso | activo |

**a)** ¿Cuál es la diferencia entre el tipo de dato de una columna y una restricción sobre esa columna?

El tipo de dato define qué clase de información puede almacenar una columna, por ejemplo un número, texto, fecha o valor decimal. Una restricción define qué reglas debe cumplir ese dato, por ejemplo que no pueda ser nulo, que sea único o que esté dentro de un rango determinado.

### Restricciones

Completen con un ejemplo propio de DataLab para cada restricción:

| Restricción | Qué garantiza | Ejemplo en DataLab |
|---|---|---|
| `NOT NULL` | Que la columna obligatoriamente tenga un valor. No puede quedar vacía (NULL).  | nombre_metrica VARCHAR(50) NOT NULL|
| `UNIQUE` | Que no se repitan los valores de esa columna. | correo VARCHAR(100) UNIQUE |
| `DEFAULT` | Que si no se proporciona un valor al insertar una fila, la base de datos coloque automáticamente un valor predeterminado. | activo BOOLEAN DEFAULT TRUE |
| `CHECK` | Que el valor cumpla una condición determinada. | valor_f1 DECIMAL(5,4) CHECK (valor_f1 BETWEEN 0 AND 1) |

**b)** ¿Todas las métricas de desempeño de un modelo caben bien en un `CHECK (valor BETWEEN 0 AND 1)`? Piensen en al menos una métrica que no encajaría y expliquen por qué.

No. Por ejemplo, el RMSE (Root Mean Squared Error) no necesariamente está entre 0 y 1, ya que su valor depende de la escala de los datos. Por lo tanto, no sería correcto imponerle un CHECK (valor BETWEEN 0 AND 1).

### Llaves primarias y foráneas, formalizadas

**c)** ¿Qué significa que una llave primaria sea "compuesta"? Den un ejemplo del esquema de DataLab.

Una llave primaria compuesta es una llave que está formada por dos o más columnas juntas. La combinación de esos valores identifica de manera única cada fila.

**d)** La relación EXPERIMENTO–produce–MODELO es 1:1 con participación parcial en EXPERIMENTO. Si `modelo.id_experimento` es FK pero no tiene `UNIQUE`, ¿qué error de diseño se podría colar? (piensen: ¿cuántas filas de `modelo` podrían terminar apuntando al mismo experimento?)

Una llave primaria es compuesta cuando está formada por dos o más columnas que, combinadas, identifican de manera única cada registro. En DataLab, por ejemplo, una tabla puente modelo_dataset puede tener como llave primaria compuesta (id_modelo, id_dataset).

### Ejercicio en papel

Para cada tabla de su esquema (de la Semana 2), completen esta ficha:

| Tabla | Columna | Tipo de dato | Restricciones |
|---|---|---|---|
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |
| | | | |

*(Agreguen filas según necesiten — deben quedar las 8 tablas: 6 entidades + 2 puente.)*

---

## BLOQUE 2 — Laboratorio (3 horas, con PC)

### Retomar (20 min)

### Digitalizar el esquema tipado (50 min)

En dbdiagram.io (continuando el archivo de la Semana 2) o MySQL Workbench, agreguen tipos de dato y restricciones a todas las columnas.

**Herramienta usada:** dbdiagram.io

> 💡 En DBML, las restricciones se escriben así:
> ```
> Table metrica {
>   id_metrica int [pk]
>   id_modelo int [ref: > modelo.id_modelo, not null]
>   nombre_metrica varchar(50) [not null]
>   valor decimal(5,4) [not null, note: 'CHECK valor BETWEEN 0 AND 1']
>   fecha_calculo date [not null]
> }
> ```

### Descanso (15 min)

### Ficha de especificación completa (50 min)

Traduzcan el esquema digitalizado a una tabla de especificación completa en `documentacion/diccionario_datos.md`, con columnas: **tabla, columna, tipo de dato, restricciones, referencia (si es FK)**. Este documento va a ser la fuente de verdad para escribir el `CREATE TABLE` real en la Semana 5.
(DICCIONARIO)
### Comentario sobre el uso de IA

Para realizar esta actividad utilicé **ChatGPT como herramienta de apoyo**. Le proporcioné la información de mi proyecto y el esquema de la base de datos para que me ayudara principalmente a **organizar la información** de una manera más clara y ordenada. Me ayudo a ordenar los tipos de datos y restricciones, y presentar la información en tablas para facilitar su comprensión.

La información y estructura principal de la base de datos corresponden a mi proyecto. **La última tabla, que contiene los nombres de las tablas y sus respectivas descripciones, sí fue elaborada por ChatGPT**, tomando como referencia el contenido y propósito de cada tabla dentro del proyecto.



**Ejercicio aplicado (sin ejecutar SQL todavía):** si intentaran insertar en `experimento` una fila con `id_proyecto = 999` y ese proyecto no existe en la tabla `proyecto`, ¿qué debería pasar? Respondan como decisión de diseño, no como sintaxis.

______________________________________________________________________________

### Revisión cruzada final (30 min)

Intercambien su ficha de especificación con otro equipo y verifiquen:

*a)* ¿Cada FK tiene claramente indicada su tabla y columna de referencia?

Sí. Cada llave foránea tiene indicada la tabla y la columna a la que hace referencia.

---

*b)* ¿Encontraron algún NOT NULL que debería ser opcional, o viceversa?

No. Los campos marcados como NOT NULL son obligatorios y los demás pueden ser opcionales.

---

### Commit y cierre (15 min)

* Exporten el esquema tipado a diagramas/relacional/s03-esquema-tipado.png (guarden también el .dbml fuente si lo usaron).
* Commit: git commit -m "modelo: esquema relacional de DataLab con tipos de dato y restricciones".

---

## Verificación de comprensión — antes de salir

*1.* ¿Cuál es la diferencia entre un tipo de dato y una restricción?

El tipo de dato indica qué clase de información puede almacenar una columna, mientras que una restricción indica qué reglas deben cumplir los valores almacenados. 

---

*2.* ¿Por qué modelo.id_experimento necesita ser UNIQUE además de FK?

Porque la FK establece la relación con la tabla experimento, mientras que UNIQUE evita que varios modelos se relacionen con el mismo experimento y permite garantizar una relación 1:1. 

---

*3.* Si dataset.tamanio_filas tuviera un valor negativo, ¿qué restricción lo habría evitado?

La restricción CHECK (tamanio_filas >= 0). 

---

## Avance hacia el Hito 2

* [ ] Esquema relacional tipado y con restricciones en diagramas/relacional/s03-esquema-tipado.png.
* [ ] documentacion/diccionario_datos.md con la ficha de especificación completa de las 8 tablas.
* [ ] Commit realizado con el mensaje sugerido.

(El Hito 2 completo — normalización + creación en motor real — se cierra en la Semana 5.)
