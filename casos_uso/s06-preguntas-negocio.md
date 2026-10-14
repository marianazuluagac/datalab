
# Preguntas de negocio - DataLab

## Hito 3: JOIN, subconsultas y vistas

### 1. ¿Qué proyectos tienen más experimentos?
**Estado:** Parcialmente resuelta.  
Se puede consultar la cantidad de experimentos asociados a cada proyecto mediante JOIN, COUNT y GROUP BY.

### 2. ¿Qué científicos han ejecutado experimentos recientemente?
**Estado:** Parcialmente resuelta.  
Se pueden consultar los científicos y las fechas de ejecución de sus experimentos, aplicando filtros por fecha cuando sea necesario.

### 3. ¿Qué datasets nunca se han usado?
**Estado:** Consulta preparada.  
Se puede identificar mediante LEFT JOIN e IS NULL o mediante NOT IN, relacionando dataset con experimento_dataset.

### 4. ¿Cuáles son los modelos con mejor desempeño?
**Estado:** Parcialmente resuelta.  
Se pueden consultar los modelos y sus métricas, ordenando los valores de accuracy de mayor a menor.

### 5. ¿Qué proyectos no tienen experimentos?
**Estado:** Consulta preparada.  
Se pueden identificar con LEFT JOIN entre proyecto y experimento, filtrando los proyectos sin coincidencias.

### 6. ¿Qué datasets son más grandes que el promedio?
**Estado:** Consulta preparada.  
Se utiliza una subconsulta con AVG para comparar el tamaño de cada dataset con el promedio global.

### 7. ¿Qué científicos tienen más métricas registradas?
**Estado:** Pendiente.  
Se requiere definir una consulta que relacione los científicos con sus experimentos y las métricas de sus modelos, respetando la regla de máximo dos tablas por consulta.
    