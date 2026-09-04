# Semana 1 — Guía del Estudiante

## Modelado Conceptual y Diseño Entidad-Relación (2.1–2.8)
### Caso hilo conductor: DataLab

---

## Objetivos de la semana

Al final de esta semana estarán en capacidad de:

- Explicar qué es el diseño conceptual y por qué es independiente del motor de base de datos.
- Diferenciar los niveles de modelado: conceptual, lógico, físico.
- Aplicar la notación del modelo entidad-relación de Chen.
- Clasificar entidades, atributos y relaciones a partir de un enunciado en lenguaje natural.
- Determinar cardinalidad y participación, justificando con base en el enunciado.
- Diferenciar llave candidata de llave primaria y justificar la elección.
- Usar una herramienta de modelado para documentar un diagrama E-R.
- Entregar el modelo E-R completo de DataLab — **Hito 1** del semestre.

**Equipo:** ______________________ **Integrantes:** ______________________________________

---

## El caso: DataLab

> DataLab es la plataforma interna que usa un equipo de ciencia de datos para llevar el control de sus proyectos de inteligencia artificial. Cada científico de datos del equipo puede participar en uno o varios proyectos, y cada proyecto agrupa el trabajo alrededor de un problema de negocio concreto (por ejemplo, "Detección de fraude en transacciones" o "Clasificación de imágenes médicas"). Para resolver un proyecto, el equipo se apoya en datasets: conjuntos de datos con un nombre, una fuente (interna o externa), una fecha de carga y un tamaño en filas; un mismo dataset puede reutilizarse en varios experimentos, incluso de proyectos distintos. Dentro de cada proyecto se ejecutan experimentos: cada experimento usa un dataset, fue ejecutado por un científico de datos del equipo, tiene una fecha de ejecución y una configuración (los hiperparámetros usados en esa corrida). Cuando un experimento resulta exitoso, produce un modelo entrenado, identificado por un nombre, una versión y un algoritmo (por ejemplo, "Random Forest" o "Red neuronal convolucional"). Cada modelo se evalúa con una o varias métricas de desempeño (accuracy, precisión, F1-score, entre otras), cada una con su valor numérico y la fecha en que fue calculada.

Este será el caso que van a construir, capa sobre capa, durante todo el semestre. Todo lo que hagan hoy lo van a volver a tocar en las próximas 13 semanas.

---

## BLOQUE 1 — Laboratorio (3 horas, con PC)

### Hito 0 — Preparar el repositorio (15 min)

1. Formen su equipo (3-4 integrantes).
2. Creen el repositorio `datalab-<equipo>` con esta estructura:

```
datalab-<equipo>/
├── README.md
├── .gitignore
├── diagramas/e-r/
├── scripts/{ddl,dml,consultas}/
├── casos_uso/
├── documentacion/
├── mongodb/
└── bitacoras/
```

3. Primer commit: `git commit -m "modelo: estructura inicial del repositorio"`.
4. Den acceso de lectura al docente.

### Actividad 1 — Lectura y extracción cruda (30 min)

**Sin dibujar nada todavía**, respondan en su bitácora (`bitacoras/s01-<nombre>.md`):

**a)** ¿De qué "cosas" del negocio de DataLab se necesita guardar información? Listen todas las que encuentren, en sus propias palabras.

_______________________________________________________________________________

_______________________________________________________________________________

**b)** ¿Qué preguntas le harían al equipo de ciencia de datos antes de empezar a modelar?

_______________________________________________________________________________

_______________________________________________________________________________

**c)** Reto Feynman: expliquen en voz alta a su compañero de equipo qué es un "Experimento" en DataLab, **sin usar la palabra "entidad"**. Si se traban, ahí hay algo que todavía no tienen claro — vuelvan al enunciado antes de seguir.

### Actividad 2 — Primer boceto (45 min)

Abran una herramienta de modelado (ERDPlus o draw.io recomendadas). Construyan su primer intento de diagrama E-R con lo que identificaron en la Actividad 1: entidades, algunos atributos, relaciones. No se preocupen por que quede perfecto — este es un primer boceto exploratorio.

**Herramienta usada:** _______________________

### Descanso (15 min)

### Actividad 3 — Puesta en común (45 min)

Van a proyectar su boceto ante el resto del curso. Mientras ven los bocetos de los demás equipos, anoten:

**a)** ¿En qué se parece su boceto al de otros equipos?

_______________________________________________________________________________

**b)** ¿En qué se diferencia? ¿Alguna diferencia les genera dudas sobre cuál versión es la correcta?

_______________________________________________________________________________

**c)** Preguntas abiertas que les quedan después de ver otros bocetos:

_______________________________________________________________________________

_______________________________________________________________________________

### Actividad 4 — Commit del boceto (30 min)

1. Exporten su boceto como imagen a `diagramas/e-r/s01-boceto-inicial.png`.
2. Commit: `git commit -m "modelo: boceto inicial del diagrama E-R de DataLab"`.
3. Escriban en `documentacion/decisiones.md` las preguntas abiertas de la Actividad 3 — las van a resolver en la sesión de formalización.

---

## BLOQUE 2 — Formalización (2 horas, sin PC)

### Retomando las preguntas abiertas

Antes de seguir, revisen la lista de preguntas abiertas que dejaron en `documentacion/decisiones.md`. El docente va a resolverlas junto con ustedes en esta sesión — guárdenlas a la vista.

### Niveles de modelado — verificación rápida

Clasifiquen cada frase como **conceptual**, **lógico** o **físico**:

| Frase | Nivel |
|---|---|
| "Un experimento puede producir, como máximo, un modelo" | |
| "La tabla EXPERIMENTO tiene una llave foránea id_dataset" | |
| "La columna fecha_ejecucion es de tipo DATE" | |

### Corrección del boceto con notación de Chen

Con la explicación del docente, corrijan en papel su propio boceto de la Actividad 2. Marquen con un color los cambios respecto al boceto original — esa comparación es la evidencia de lo que aprendieron hoy.

**Preguntas guía para la corrección:**

**a)** ¿`algoritmo` en su boceto quedó como atributo o como entidad? Si quedó como entidad, ¿por qué debería ser atributo de MODELO?

_______________________________________________________________________________

**b)** ¿DATASET es una entidad fuerte o débil en su modelo? Justifiquen.

_______________________________________________________________________________

**c)** ¿EXPERIMENTO quedó modelado como entidad o como relación en su boceto original? Si quedó como relación, ¿qué atributos propios tiene que solo tienen sentido si EXPERIMENTO es entidad?

_______________________________________________________________________________

### Cardinalidad y participación

Para cada relación, determinen la cardinalidad (1:1, 1:N o N:M) y la participación (total o parcial) de cada lado, con una frase que lo justifique:

| Relación | Cardinalidad | Participación (¿por qué?) |
|---|---|---|
| CIENTIFICO_DATOS – participa en – PROYECTO | | |
| DATASET – se usa en – EXPERIMENTO | | |
| EXPERIMENTO – produce – MODELO | | |
| MODELO – se evalúa con – METRICA | | |

**Ejercicios rápidos — otros contextos de datos e IA:**

**a)** *Pipeline de anotación de datos:* "Un anotador etiqueta imágenes; cada imagen puede ser revisada por un segundo anotador antes de aprobarse." ¿Cardinalidad y participación entre ANOTADOR e IMAGEN?

_______________________________________________________________________________

**b)** *Plataforma de MLOps:* "Un modelo en producción puede desplegarse en varios ambientes (staging, producción); cada despliegue tiene su propia fecha y versión de infraestructura." ¿MODELO–DESPLIEGUE es 1:N o N:M? ¿Por qué?

_______________________________________________________________________________

### Llaves primarias y candidatas

La entidad EXPERIMENTO tiene los atributos: `id_experimento_interno`, `nombre_experimento`, `fecha_ejecucion`, `configuracion`.

**a)** ¿Cuál es la llave candidata más evidente?

_______________________________________________________________________________

**b)** ¿Por qué `nombre_experimento` no sirve como llave por sí sola?

_______________________________________________________________________________

**c)** Ahora identifiquen las llaves candidatas y primarias de las otras 5 entidades de DataLab:

| Entidad | Llave(s) candidata(s) | Llave primaria elegida | Justificación |
|---|---|---|---|
| CIENTIFICO_DATOS | | | |
| PROYECTO | | | |
| DATASET | | | |
| MODELO | | | |
| METRICA | | | |

---

## Entregable — Hito 1 (antes de la Semana 2)

- [ ] Diagrama E-R final y corregido en `diagramas/e-r/s01-modelo-final.png` (o enlace de la herramienta).
- [ ] Diccionario de datos completo en `documentacion/diccionario_datos.md` (entidad, atributo, tipo de atributo, llave candidata/primaria).
- [ ] Todas las decisiones de diseño discutidas hoy, registradas en `documentacion/decisiones.md`.
- [ ] Commit final: `git commit -m "modelo: diagrama E-R final de DataLab (Hito 1)"`.
- [ ] Tag: `git tag h1-modelo-er`.

**Recuerden:** el historial de commits de hoy (boceto → correcciones → versión final) es evidencia de su proceso, no solo del resultado. No lo aplasten en un único commit al final.
