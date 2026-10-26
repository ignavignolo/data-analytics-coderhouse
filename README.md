# RetailPro — Análisis de Ventas, Pipeline ETL y Modelo Dimensional

Este repositorio contiene el desarrollo integral del proyecto relacional y analítico para **RetailPro**, abarcando desde el diseño de la base de datos relacional en **SQL Server (T-SQL)** hasta la transformación de datos en **Power Query** y el modelado analítico con **DAX** en **Power BI**.

## 🛠️ Tecnologías y Herramientas
* **Motor de Base de Datos:** Microsoft SQL Server (T-SQL)
* **Transformación y ETL:** Power Query (Power BI)
* **Modelado y Visualización:** Power BI Desktop (Modelo Estrella & DAX)
* **Documentación y Co-piloto:** ChatGPT / Gemini / Claude

## 📂 Estructura del Repositorio

* `m4_consultas_negocio.sql`: Consultas analíticas de resumen ejecutivo mensual, ranking de productos más vendidos e identificación de clientes recurrentes mediante `HAVING`.
* `m5_consultas_joins.sql`: Consultas avanzadas utilizando `INNER JOIN`, aislamiento de clientes y productos sin ventas (`LEFT JOIN` + `IS NULL`) y consolidado por canal (`UNION ALL`).
* `Pipeline_Vignolo_Ignacio.pbix`: Archivo de Power Query con el pipeline ETL documentado (limpieza de nulos, desduplicación por PK, tipado de datos y combinación de consultas).
* `Vignolo_Ignacio_Checkpoint2.pbix`: Proyecto final en Power BI con el modelo dimensional en estrella (`Fact_Ventas`, `Dim_Clientes`, `Dim_Productos`, `Dim_Categorias`, `Dim_Fechas`) y la tabla de `_Medidas` DAX (`Total Ventas`, `Ventas LY`, `Ventas YTD`, `% Crecimiento Anual`, `Ventas Online`).
* `Ventas_Tech_DB.sql`: Script DDL y DML para la creación de tablas con restricciones de claves (`PK`/`FK`), tipos `DECIMAL(10,2)` y carga de datos iniciales.

## 🚀 Instrucciones de Ejecución

### 1. Base de Datos SQL (T-SQL)
1. Abrir **SQL Server Management Studio (SSMS)** o Azure Data Studio.
2. Ejecutar el script DDL/DML para instanciar la base de datos `Ventas_Tech_DB`.
3. Ejecutar `m4_consultas_negocio.sql` y `m5_consultas_joins.sql` para consultar las vistas y reportes base.

### 2. Pipeline ETL y Reporte Power BI
1. Abrir el archivo `Vignolo_Ignacio_Checkpoint2.pbix` en **Power BI Desktop**.
2. Verificar el modelo relacional en la vista de modelo (esquema en estrella).
3. Consultar las métricas de negocio en la tabla centralizada `_Medidas` (cálculos de tiempo YTD, comparativa YoY y segmentación por canal).
