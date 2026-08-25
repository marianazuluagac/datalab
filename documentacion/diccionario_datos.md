# Diccionario de datos

## CIENTIFICO_DATOS
- id_cientifico — PK

## PROYECTO
- id_proyecto — PK

## DATASET
- id_dataset — PK
- nombre
- fuente
- fecha_carga
- tamaño_filas

## EXPERIMENTO
- id_experimento — PK
- nombre_experimento
- fecha_ejecucion
- configuracion

## MODELO
- id_modelo — PK
- nombre
- version
- algoritmo

## METRICA
- id_metrica — PK
- nombre
- valor
- fecha_calculo