Semana 1 — Guía del Estudiante
Modelado Conceptual y Diseño Entidad-Relación (2.1–2.8)
Caso hilo conductor: DataLab

MARIANA ZULUAGA 
LAURA GUARNIZO
DONOVAN GARCÍA
___

BLOQUE 1 — Laboratorio
Actividad 1 — Lectura y extracción cruda

a) ¿De qué "cosas" del negocio de DataLab se necesita guardar información?

Se necesita guardar información sobre:

Científicos de datos.
Áreas laborales.
Proyectos.
Participaciones de los científicos en los proyectos.
Datasets.
Experimentos.
Uso de datasets en los experimentos.
Modelos entrenados.
Métricas de desempeño de los modelos.

b) ¿Qué preguntas le harían al equipo de ciencia de datos antes de empezar a modelar?

¿Un científico de datos puede participar en varios proyectos?
¿Un proyecto puede tener varios científicos de datos?
¿Un dataset puede utilizarse en varios experimentos?
¿Un experimento puede utilizar varios datasets?
¿Cada experimento produce un solo modelo o puede producir varios?
¿Un modelo puede tener varias métricas de desempeño?
¿Qué información se necesita guardar de cada proyecto?
¿Qué información se necesita guardar de cada experimento?
¿Qué datos identifican de forma única a un científico, proyecto, dataset, experimento y modelo?

c) Reto Feynman: ¿Qué es un "Experimento" en DataLab?

Un experimento es una ejecución realizada dentro de un proyecto de ciencia de datos en la que un científico utiliza datos y una configuración determinada, como los hiperparámetros, para obtener un resultado y posiblemente generar un modelo.

Actividad 2 — Primer boceto

Herramienta usada: draw.io

El primer boceto contiene las entidades principales del proyecto DataLab, sus atributos y las relaciones entre ellas.

Actividad 3 — Puesta en común

a) ¿En qué se parece su boceto al de otros equipos?

Nuestro boceto se parece al de otros equipos porque identificamos las mismas entidades principales del caso DataLab, como CIENTIFICO_DATOS, PROYECTO, DATASET, EXPERIMENTO, MODELO y METRICA, además de las relaciones entre ellas.

b) ¿En qué se diferencia? ¿Alguna diferencia les genera dudas?

Se diferencia principalmente en la forma de representar algunas relaciones y en la cantidad de atributos incluidos en cada entidad. Algunas diferencias nos generaron dudas sobre la cardinalidad entre DATASET y EXPERIMENTO y sobre la relación entre EXPERIMENTO y MODELO.

c) Preguntas abiertas que les quedan después de ver otros bocetos:

¿La relación entre DATASET y EXPERIMENTO es 1:N o N:M?
¿Un experimento puede producir más de un modelo?
¿Un modelo puede pertenecer a más de un experimento?
¿Todos los atributos identificados son necesarios?
Actividad 4 — Commit del boceto

Archivo: diagramas/e-r/s01-boceto-inicial.png

Commit:

git commit -m "modelo: boceto inicial del diagrama E-R de DataLab"
BLOQUE 2 — Formalización
Niveles de modelado — verificación rápida
Frase	Nivel
"Un experimento puede producir, como máximo, un modelo"	Conceptual
"La tabla EXPERIMENTO tiene una llave foránea id_dataset"	Lógico
"La columna fecha_ejecucion es de tipo DATE"	Físico
Corrección del boceto con notación de Chen

a) ¿algoritmo en su boceto quedó como atributo o como entidad? Si quedó como entidad, ¿por qué debería ser atributo de MODELO?

algoritmo quedó como atributo de MODELO porque describe una característica del modelo. No es necesario crear una entidad independiente para almacenar esta información.

b) ¿DATASET es una entidad fuerte o débil en su modelo? Justifiquen.

DATASET es una entidad fuerte porque puede identificarse por sí misma mediante una llave propia, id_dataset, y no depende de otra entidad para existir.

c) ¿EXPERIMENTO quedó modelado como entidad o como relación en su boceto original? Si quedó como relación, ¿qué atributos propios tiene que solo tienen sentido si EXPERIMENTO es entidad?

EXPERIMENTO se modeló como entidad porque tiene información propia, como id_experimento, nombre_experimento, fecha_ejecucion, configuracion, estado y resultado_resumen. Estos atributos describen directamente al experimento.

Cardinalidad y participación
Relación	Cardinalidad	Participación (¿por qué?)
CIENTIFICO_DATOS – participa en – PROYECTO	N:M	Un científico puede participar en varios proyectos y un proyecto puede tener varios científicos.
DATASET – se usa en – EXPERIMENTO	N:M	Un dataset puede utilizarse en varios experimentos y un experimento puede utilizar varios datasets.
EXPERIMENTO – produce – MODELO	1:1	Un experimento exitoso produce como máximo un modelo y cada modelo proviene de un experimento.
MODELO – se evalúa con – METRICA	1:N	Un modelo puede evaluarse mediante varias métricas y cada métrica pertenece a un modelo.
Ejercicios rápidos — otros contextos de datos e IA

a) Pipeline de anotación de datos

La relación entre ANOTADOR e IMAGEN es N:M, porque un anotador puede etiquetar varias imágenes y una imagen puede ser revisada por más de un anotador. La participación del anotador es total si todos deben etiquetar imágenes, mientras que la de la imagen puede ser parcial porque no necesariamente todas las imágenes tienen que ser revisadas por un segundo anotador.

b) Plataforma de MLOps

La relación MODELO–DESPLIEGUE es 1:N, porque un modelo puede desplegarse en varios ambientes, mientras que cada despliegue corresponde a un solo modelo.

Llaves primarias y candidatas

La entidad EXPERIMENTO tiene los atributos:

id_experimento_interno, nombre_experimento, fecha_ejecucion, configuracion.

a) ¿Cuál es la llave candidata más evidente?

La llave candidata más evidente es id_experimento_interno, porque permite identificar de manera única cada experimento.

b) ¿Por qué nombre_experimento no sirve como llave por sí sola?

Porque pueden existir varios experimentos con el mismo nombre. Por lo tanto, el nombre no garantiza que cada experimento pueda identificarse de forma única.

c) Llaves candidatas y primarias de las otras entidades de DataLab

Entidad	Llave(s) candidata(s)	Llave primaria elegida	Justificación
CIENTIFICO_DATOS	id_cientifico	id_cientifico	Identifica de manera única a cada científico de datos.
PROYECTO	id_proyecto	id_proyecto	Identifica de manera única cada proyecto.
DATASET	id_dataset	id_dataset	Permite identificar de forma única cada dataset.
MODELO	id_modelo	id_modelo	Identifica de manera única cada modelo.
METRICA	id_metrica	id_metrica	Identifica de manera única cada métrica.
Entregable — Hito 1
 Diagrama E-R final y corregido en diagramas/e-r/s01-modelo-final.png.
 Diccionario de datos completo en documentacion/diccionario_datos.md.
 Decisiones de diseño registradas en documentacion/decisiones.md.
 Commit final realizado.
 Tag h1-modelo-er creado.