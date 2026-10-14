
-- =============================================
-- DataLab - Semana 9
-- Creacion de vistas
-- =============================================

-- Vista de modelos asociados a experimentos
CREATE VIEW dbo.vista_modelos_por_experimento AS
SELECT
    e.id_experimento,
    e.fecha_ejecucion,
    m.nombre AS nombre_modelo,
    m.algoritmo,
    m.version
FROM dbo.experimento AS e
INNER JOIN dbo.modelo AS m
    ON m.id_experimento = e.id_experimento;
