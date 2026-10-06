
USE Ventas_Tech_DB;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 1: Resumen ejecutivo mensual
-- -----------------------------------------------------------------------------
SELECT
    MONTH (fecha_venta) AS mes,
    SUM(CANTIDAD * PRECIO_UNITARIO) AS TOTAL_FACTURADO,
    COUNT(DISTINCT id_venta) AS CANTIDAD_PEDIDOS,
    SUM(cantidad * precio_unitario) / COUNT(DISTINCT id_venta) AS TICKET_PROMEDIO
FROM 
    VENTAS
GROUP BY 
    MONTH (fecha_venta)
ORDER BY 
    mes ASC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 2: Ranking de productos
-- -----------------------------------------------------------------------------
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM 
    ventas
GROUP BY 
    id_producto
ORDER BY 
    total_generado DESC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 3: Clientes recurrentes
-- -----------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM 
    ventas
GROUP BY 
    id_cliente
HAVING 
    COUNT(*) > 1
ORDER BY 
    cantidad_pedidos DESC,
    total_gastado DESC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 4: Meses por encima/por debajo del promedio
-- -----------------------------------------------------------------------------
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) >= (
            SELECT AVG(total_mes)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mes
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) sub
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparativa_promedio
FROM 
    ventas
GROUP BY 
    MONTH(fecha_venta)
ORDER BY 
    mes ASC;
GO

-- =============================================================================
-- BLOQUE DE CIERRE: 3 Hallazgos concretos
-- =============================================================================
/*
1. La totalidad de las ventas registradas corresponden al mes 3 (marzo), sumando 
   un total facturado de 6,444.00 a través de 10 pedidos, con un ticket promedio de 644.40.

2. El ranking de facturación por producto muestra una concentración de ingresos 
   en los primeros artículos del Top 5, donde los productos de mayor rotación física 
   no necesariamente corresponden a los de mayor impacto en ingresos brutos.

3. El filtro de recurrencia mediante HAVING COUNT(*) > 1 evidencia qué porción de la 
   cartera realiza compras repetidas, identificando los IDs clave para fidelizar clientes.
