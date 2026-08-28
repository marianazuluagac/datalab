# Diccionario de datos

## CIENTIFICO_DATOS
- id_cientifico — PK

## PROYECTO
- id_proyecto — PK

## PARTICIPACION
- id_cientifico — PK, FK
- id_proyecto — PK, FK

## DATASET
- id_dataset — PK
- nombre
- fuente
- fecha_carga
- tamano_filas

## EXPERIMENTO
- id_experimento — PK
- id_proyecto — FK
- id_cientifico — FK
- id_dataset — FK
- nombre_experimento
- fecha_ejecucion
- configuracion

## MODELO
- id_modelo — PK
- id_experimento — FK
- nombre
- version
- algoritmo'

## METRICA
- id_metrica — PK
- id_modelo — FK
- nombre
- valor
- fecha_calculo