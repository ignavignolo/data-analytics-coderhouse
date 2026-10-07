USE Ventas_Tech_DB;
GO

-- =============================================================================
-- PRE-ENTREGA 5: CONSULTAS CON JOINS PARA EL PROYECTO
-- =============================================================================
-- =============================================================================
-- Cargo datos para la consulta 2 y 3
-- =============================================================================
INSERT INTO clientes (id_cliente, nombre, email, ciudad, fecha_registro) 
VALUES (6, 'Martín Silva', 'martin@mail.com', 'Salta', '2024-03-16');

INSERT INTO productos (id_producto, nombre_producto, id_categoria, precio, stock, activo) 
VALUES (7, 'Webcam HD 1080p', 2, 65.00, 25, 1);
-- -----------------------------------------------------------------------------
-- CONSULTA 1: Vista base del proyecto (INNER JOIN)
-- -----------------------------------------------------------------------------

SELECT 
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM 
    ventas v
INNER JOIN 
    clientes c ON v.id_cliente = c.id_cliente
INNER JOIN 
    productos p ON v.id_producto = p.id_producto
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY 
    v.fecha_venta ASC, 
    v.id_venta ASC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 2: Clientes sin ventas (LEFT JOIN)
-- -----------------------------------------------------------------------------

SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM 
    clientes c
LEFT JOIN 
    ventas v ON c.id_cliente = v.id_cliente
WHERE 
    v.id_venta IS NULL;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 3: Productos sin ventas (LEFT JOIN)
-- -----------------------------------------------------------------------------

SELECT 
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM 
    productos p
INNER JOIN 
    categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN 
    ventas v ON p.id_producto = v.id_producto
WHERE 
    v.id_venta IS NULL;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 4: Consolidado por canal (UNION ALL)
-- -----------------------------------------------------------------------------

SELECT 
    canal, 
    SUM(total) AS total_canal
FROM (
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Online' AS canal
    FROM 
        ventas 
    WHERE 
        fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total, 
        'Presencial' AS canal
    FROM 
        ventas 
    WHERE 
        fecha_venta > '2024-03-10'
) AS consolidado
GROUP BY 
    canal;
GO

-- =============================================================================
-- BLOQUE DE CIERRE: HALLAZGOS CLAVE DE NEGOCIO
-- =============================================================================
/*
1. Vista (Consulta 1):
   El dataset consolidado permite cruzar directamente el ticket de venta con 
   dimensiones geográficas (ciudad) y categorías de producto (Computación, Accesorios, etc.), 
   eliminando la necesidad de relaciones complejas.

2. Eficiencia (Consultas 2 y 3):
   El aislamiento mediante LEFT JOIN + IS NULL establece los indicadores clave de 
   inactividad: tasa de conversión a clientes compradores, y 
   porcentaje de stock muerto dentro del catálogo activo.

3. Distribución por Canales (Consulta 4):
   El agrupamiento mediante UNION ALL refleja la distribución del volumen transaccional 
   entre los dos segmentos de tiempo/canal definidos, manteniendo la integridad total 
   de los ingresos sin pérdida de registros por duplicados.
   */
