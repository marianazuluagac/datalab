
-- =====================================================
-- DataLab - Semana 9
-- JOIN, subconsultas y preguntas de negocio
-- Hito 3
-- =====================================================

-- =====================================================
-- NIVEL 1: INNER JOIN
-- =====================================================

-- Ejercicio 1. Proyecto y experimento
SELECT
    p.nombre_proyecto,
    e.id_experimento,
    e.fecha_ejecucion
FROM dbo.proyecto AS p
INNER JOIN dbo.experimento AS e
    ON e.id_proyecto = p.id_proyecto;


-- Ejercicio 2. Cientifico y experimento
SELECT
    c.nombre_completo,
    e.fecha_ejecucion
FROM dbo.cientifico_datos AS c
INNER JOIN dbo.experimento AS e
    ON e.id_cientifico = c.id_cientifico;


-- Ejercicio 3. Modelo y experimento
SELECT
    m.nombre AS nombre_modelo,
    m.algoritmo,
    e.id_experimento
FROM dbo.modelo AS m
INNER JOIN dbo.experimento AS e
    ON m.id_experimento = e.id_experimento;


-- Ejercicio 4. Metricas de modelos
SELECT
    m.nombre AS nombre_modelo,
    met.nombre AS nombre_metrica,
    met.valor
FROM dbo.modelo AS m
INNER JOIN dbo.metrica AS met
    ON met.id_modelo = m.id_modelo;


-- =====================================================
-- NIVEL 2: LEFT JOIN Y RIGHT JOIN
-- =====================================================

-- Ejercicio 5. Todos los experimentos
SELECT
    e.id_experimento,
    e.fecha_ejecucion,
    m.nombre AS nombre_modelo
FROM dbo.experimento AS e
LEFT JOIN dbo.modelo AS m
    ON m.id_experimento = e.id_experimento;


-- Ejercicio 6. Proyectos y sus experimentos
SELECT
    p.nombre_proyecto,
    e.id_experimento
FROM dbo.proyecto AS p
LEFT JOIN dbo.experimento AS e
    ON e.id_proyecto = p.id_proyecto;


-- Ejercicio 7. Experimentos sin modelo
SELECT
    e.id_experimento,
    e.fecha_ejecucion
FROM dbo.experimento AS e
LEFT JOIN dbo.modelo AS m
    ON m.id_experimento = e.id_experimento
WHERE m.id_modelo IS NULL;


-- Ejercicio 8. Conservar todos los experimentos
SELECT
    c.nombre_completo,
    e.fecha_ejecucion
FROM dbo.cientifico_datos AS c
RIGHT JOIN dbo.experimento AS e
    ON e.id_cientifico = c.id_cientifico;


-- =====================================================
-- NIVEL 3: FILTROS Y ORDENAMIENTO
-- =====================================================

-- Ejercicio 9. Modelos Random Forest
SELECT
    m.nombre,
    m.version,
    m.algoritmo
FROM dbo.modelo AS m
WHERE m.algoritmo = 'Random Forest';


-- Ejercicio 10. Experimentos desde enero de 2026
SELECT
    p.nombre_proyecto,
    e.fecha_ejecucion
FROM dbo.proyecto AS p
INNER JOIN dbo.experimento AS e
    ON e.id_proyecto = p.id_proyecto
WHERE e.fecha_ejecucion >= '20260101';


-- Ejercicio 11. Ranking de accuracy
SELECT
    m.nombre AS nombre_modelo,
    met.nombre AS tipo_metrica,
    met.valor
FROM dbo.modelo AS m
INNER JOIN dbo.metrica AS met
    ON met.id_modelo = m.id_modelo
WHERE met.nombre = 'accuracy'
ORDER BY met.valor DESC;


-- Ejercicio 12. Modelos por version
SELECT
    m.nombre,
    m.algoritmo,
    m.version
FROM dbo.modelo AS m
WHERE m.version LIKE '1.2%'
ORDER BY m.version ASC;


-- =====================================================
-- NIVEL 4: SUBCONSULTAS
-- =====================================================

-- Ejercicio 13. Datasets nunca utilizados
SELECT
    d.nombre,
    d.fuente
FROM dbo.dataset AS d
WHERE d.id_dataset NOT IN (
    SELECT ed.id_dataset
    FROM dbo.experimento_dataset AS ed
);


-- Ejercicio 14. Datasets mayores al promedio
SELECT
    d.nombre,
    d.tamano_filas
FROM dbo.dataset AS d
WHERE d.tamano_filas > (
    SELECT AVG(d2.tamano_filas)
    FROM dbo.dataset AS d2
);


-- Ejercicio 15. Modelos del proyecto con ID 10
SELECT
    m.nombre,
    m.algoritmo,
    m.version
FROM dbo.modelo AS m
WHERE m.id_experimento IN (
    SELECT e.id_experimento
    FROM dbo.experimento AS e
    WHERE e.id_proyecto = 10
);


-- Ejercicio 16. Metricas superiores al promedio
SELECT
    met.id_modelo,
    met.nombre,
    met.valor
FROM dbo.metrica AS met
WHERE met.valor > (
    SELECT AVG(met2.valor)
    FROM dbo.metrica AS met2
);


-- =====================================================
-- NIVEL 5: JOIN CON AGREGACIONES
-- =====================================================

-- Ejercicio 17. Experimentos por proyecto
SELECT
    p.id_proyecto,
    p.nombre_proyecto,
    COUNT(e.id_experimento) AS total_experimentos
FROM dbo.proyecto AS p
INNER JOIN dbo.experimento AS e
    ON e.id_proyecto = p.id_proyecto
GROUP BY
    p.id_proyecto,
    p.nombre_proyecto;


-- Ejercicio 18. Todos los proyectos, incluso sin experimentos
SELECT
    p.id_proyecto,
    p.nombre_proyecto,
    COUNT(e.id_experimento) AS total_experimentos
FROM dbo.proyecto AS p
LEFT JOIN dbo.experimento AS e
    ON e.id_proyecto = p.id_proyecto
GROUP BY
    p.id_proyecto,
    p.nombre_proyecto;


-- Ejercicio 19. Modelos con varias metricas
SELECT
    m.id_modelo,
    COUNT(*) AS total_metricas
FROM dbo.modelo AS m
INNER JOIN dbo.metrica AS met
    ON met.id_modelo = m.id_modelo
GROUP BY
    m.id_modelo
HAVING COUNT(*) > 1;


-- =====================================================
-- NIVEL 6: COMPARACION DE ESTRATEGIAS
-- =====================================================

-- Ejercicio 20A. Datasets no utilizados con LEFT JOIN
SELECT
    d.nombre,
    d.fuente
FROM dbo.dataset AS d
LEFT JOIN dbo.experimento_dataset AS ed
    ON ed.id_dataset = d.id_dataset
WHERE ed.id_dataset IS NULL;


-- Ejercicio 20B. Datasets no utilizados con NOT IN
SELECT
    d.nombre,
    d.fuente
FROM dbo.dataset AS d
WHERE d.id_dataset NOT IN (
    SELECT ed.id_dataset
    FROM dbo.experimento_dataset AS ed
);

-- =====================================================
-- Fin de los ejercicios de la Semana 9
-- =====================================================
