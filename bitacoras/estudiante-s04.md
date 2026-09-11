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

**Equipo:** ______________________

---

## BLOQUE 1 — Formalización (2 horas, sin PC)

### Retomar la Semana 3

Recuerden su respuesta escrita de la semana pasada: ¿qué debería pasar si se intenta insertar un experimento con un `id_proyecto` que no existe?

_______________________________________________________________________________

### Integridad referencial

**a)** ¿Qué garantiza la integridad referencial? Expliquenlo en sus propias palabras.

_______________________________________________________________________________

Completen la tabla de políticas mientras el docente explica:

| Política | Qué hace | Cuándo tiene sentido |
|---|---|---|
| `RESTRICT` | | |
| `CASCADE` | | |
| `SET NULL` | | |

**b)** Si borramos un `MODELO`, ¿qué debería pasar con sus filas en `METRICA`? Argumenten antes de que el docente dé la respuesta.

_______________________________________________________________________________

### Ejercicio: política para cada FK de DataLab

Para cada llave foránea de su esquema, elijan una política `ON DELETE` y justifíquenla:

| Llave foránea | Política elegida | Justificación |
|---|---|---|
| experimento.id_proyecto → proyecto | | |
| experimento.id_cientifico → cientifico_datos | | |
| modelo.id_experimento → experimento | | |
| metrica.id_modelo → modelo | | |
| participacion.id_cientifico → cientifico_datos | | |
| participacion.id_proyecto → proyecto | | |
| uso_dataset.id_dataset → dataset | | |
| uso_dataset.id_experimento → experimento | | |

### Primera forma normal (1FN)

Analicen este diseño:

```
metrica_mala(id_metrica, id_modelo, metricas_registradas)
```
donde `metricas_registradas` guarda `"accuracy:0.95, f1:0.89, precision:0.91"` en una sola columna de texto.

**c)** ¿Qué problema tiene este diseño si quisieran buscar todos los modelos con accuracy mayor a 0.90?

_______________________________________________________________________________

**d)** ¿Cómo lo corregirían? (Pista: ya tienen la respuesta en su propio esquema de la Semana 2)

_______________________________________________________________________________

### Segunda forma normal (2FN)

Analicen este diseño, con llave primaria compuesta `(id_dataset, id_experimento)`:

```
uso_dataset_malo(id_dataset, id_experimento, nombre_dataset, fecha_ejecucion)
```

**e)** `nombre_dataset`, ¿depende de las dos columnas de la llave o de solo una? ¿Y `fecha_ejecucion`?

_______________________________________________________________________________

**f)** ¿Cómo se corrige esta dependencia parcial?

_______________________________________________________________________________

### Tercera forma normal (3FN)

Analicen este diseño:

```
experimento_malo(id_experimento, id_proyecto, nombre_proyecto, fecha_ejecucion)
```

**g)** `nombre_proyecto`, ¿depende directamente de `id_experimento`, o depende de `id_proyecto`? ¿Cómo se llama esa cadena de dependencia?

_______________________________________________________________________________

**h)** ¿Cómo se corrige?

_______________________________________________________________________________

**i)** Si construyeron correctamente su esquema desde la Semana 2 (siguiendo las reglas de conversión E-R→relacional), ¿por qué sería esperable que ya esté en 3FN?

_______________________________________________________________________________

---

## BLOQUE 2 — Laboratorio (3 horas, con PC)

### Retomar (20 min)

¿Alguno de los tres ejemplos "malos" de la formalización les recordó algo de un borrador anterior de su propio esquema?

_______________________________________________________________________________

### Auditoría de normalización del propio esquema (50 min)

Revisen, tabla por tabla, su esquema real de DataLab (Semana 3) y respondan para cada una:

| Tabla | ¿Valores atómicos? (1FN) | ¿Sin dependencia parcial? (2FN, solo si aplica) | ¿Sin dependencia transitiva? (3FN) |
|---|---|---|---|
| cientifico_datos | | | |
| proyecto | | | |
| dataset | | | |
| experimento | | | |
| modelo | | | |
| metrica | | | |
| participacion | | | |
| uso_dataset | | | |

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

## Verificación de comprensión — antes de salir

**1.** ¿Cuál es la diferencia entre `RESTRICT` y `CASCADE`?

_______________________________________________________________________________

**2.** ¿Por qué 2FN solo importa cuando la llave primaria es compuesta?

_______________________________________________________________________________

**3.** Si su esquema fue construido correctamente a partir del modelo E-R, ¿por qué es esperable que ya esté en 3FN?

_______________________________________________________________________________

---

## Avance hacia el Hito 2

- [ ] Políticas `ON DELETE` definidas y aplicadas en el diagrama para las 8 FK.
- [ ] Auditoría de normalización completa (1FN, 2FN, 3FN) registrada.
- [ ] Decisiones documentadas en `documentacion/decisiones.md`.
- [ ] Commit realizado con el mensaje sugerido.

*(El Hito 2 completo — diseño físico + creación en motor real — se cierra en la Semana 5.)*
