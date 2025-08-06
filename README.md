# Proyectos de Análisis Estadístico en R

Este repositorio contiene proyectos de análisis estadístico desarrollados en R como parte del curso de Estadística en la Universidad Nacional Pedro Ruiz Gallo (UNPRG).

## Estructura del Proyecto

### 📁 [AprendiendoR](AprendiendoR/)
Proyecto introductorio para aprender conceptos básicos de R.

**Archivos principales:**
- [`Script.R`](AprendiendoR/Script.R) - Script de práctica con conceptos básicos de R
- [`ENLA.xlsx`](AprendiendoR/ENLA.xlsx) - Dataset de evaluación nacional de logros de aprendizaje
- [`TutoR.Rproj`](AprendiendoR/TutoR.Rproj) - Proyecto de RStudio

**Contenido:**
- Lectura de archivos Excel
- Estadísticas descriptivas básicas (media, desviación estándar)
- Análisis de frecuencias y proporciones
- Manipulación básica de datos

### 📁 [R_ACADEMICO](R_ACADEMICO/)
Análisis estadístico sobre patrones de sueño y rendimiento académico en estudiantes universitarios.

**Archivos principales:**
- [`Script.R`](R_ACADEMICO/Script.R) - Análisis completo de datos de sueño
- [`GraficosPoster.R`](R_ACADEMICO/GraficosPoster.R) - Gráficos específicos para presentación
- [`RENACAD.csv`](R_ACADEMICO/RENACAD.csv) - Dataset de la encuesta RENACAD
- [`R_ACADEMICO.Rproj`](R_ACADEMICO/R_ACADEMICO.Rproj) - Proyecto de RStudio

**Análisis incluidos:**
- Relación entre calidad de sueño y rendimiento académico
- Impacto del uso de dispositivos electrónicos en el sueño
- Análisis de somnolencia diurna
- Correlación entre horas de sueño y rendimiento
- Visualizaciones avanzadas con ggplot2

**Gráficos generados:**
- [`calidad_vs_rendimiento.png`](R_ACADEMICO/calidad_vs_rendimiento.png)
- [`calidad_vs_dispositivos.png`](R_ACADEMICO/calidad_vs_dispositivos.png)
- [`dispersion_horas_rendimiento.png`](R_ACADEMICO/dispersion_horas_rendimiento.png)
- Carpeta [`img/`](R_ACADEMICO/img/) con visualizaciones adicionales

## Tecnologías Utilizadas

- **R**: Lenguaje principal de análisis
- **RStudio**: IDE para desarrollo
- **Librerías principales:**
  - `ggplot2` - Visualización de datos
  - `dplyr` - Manipulación de datos
  - `readr` - Lectura de archivos
  - `tidyr` - Organización de datos
  - `gridExtra` - Combinación de gráficos
  - `readxl` - Lectura de archivos Excel

## Cómo usar estos proyectos

1. Abre RStudio
2. Navega a la carpeta del proyecto deseado
3. Abre el archivo `.Rproj` correspondiente
4. Ejecuta los scripts en el siguiente orden:
   - Para **AprendiendoR**: Ejecutar [`Script.R`](AprendiendoR/Script.R)
   - Para **R_ACADEMICO**: Ejecutar [`Script.R`](R_ACADEMICO/Script.R) para análisis completo o [`GraficosPoster.R`](R_ACADEMICO/GraficosPoster.R) para gráficos específicos

## Requisitos

- R (versión 4.0 o superior)
- RStudio
- Librerías mencionadas (se instalan automáticamente al ejecutar los scripts)

## Autor
- Fernandez Reyes Jack Hoover
Proyecto desarrollado como parte del **Ciclo II** de la **Facultad de Ciencias Físicas y Matemáticas** - **EPICI** de la Universidad Nacional Pedro Ruiz Gallo.