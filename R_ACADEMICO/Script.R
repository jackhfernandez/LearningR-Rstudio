# Análisis de Datos de Sueño - RENACAD
# Carga de librerías necesarias
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)
library(gridExtra)

# Lectura de datos
datos <- read_csv("RENACAD.csv")

# Limpieza de nombres de columnas para facilitar el trabajo
colnames(datos) <- c("Nro", "Timestamp", "Email", "Acepto", 
                     "Hora_acostarse", "Tiempo_dormirse", "Hora_levantarse", 
                     "Horas_dormido", "Prob_conciliar", "Prob_despertar", 
                     "Prob_sanitario", "Prob_respirar", "Prob_roncar", 
                     "Prob_frio", "Prob_calor", "Prob_pesadillas", 
                     "Prob_dolores", "Prob_otras", "Otras_razones",
                     "Calidad_sueño", "Medicamentos", "Somnolencia", 
                     "Animos", "Dispositivos", "Rendimiento")

# Conversión de variables categóricas a factores ordenados
datos$Calidad_sueño <- factor(datos$Calidad_sueño, 
                              levels = c("Muy mala", "Bastante mala", "Bastante buena", "Muy buena"),
                              ordered = TRUE)

datos$Rendimiento <- factor(datos$Rendimiento,
                            levels = c("Deficiente", "Regular", "En proceso", "Satisfactorio"),
                            ordered = TRUE)

datos$Dispositivos <- factor(datos$Dispositivos,
                             levels = c("Nunca", "A veces", "Frecuentemente", "Siempre"),
                             ordered = TRUE)

# 1. GRÁFICO DE BARRAS AGRUPADO: CALIDAD DE SUEÑO VS RENDIMIENTO ACADÉMICO
grafico1 <- datos %>%
  count(Calidad_sueño, Rendimiento) %>%
  ggplot(aes(x = Calidad_sueño, y = n, fill = Rendimiento)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  labs(title = "Relación entre Calidad de Sueño y Rendimiento Académico",
       subtitle = "Distribución de estudiantes por categorías",
       x = "Calidad de Sueño",
       y = "Número de Estudiantes",
       fill = "Rendimiento\nAcadémico") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_viridis_d(option = "plasma")

# 2. GRÁFICO DE BARRAS AGRUPADO: CALIDAD DE SUEÑO VS USO DE DISPOSITIVOS
grafico2 <- datos %>%
  count(Calidad_sueño, Dispositivos) %>%
  ggplot(aes(x = Calidad_sueño, y = n, fill = Dispositivos)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  labs(title = "Relación entre Calidad de Sueño y Uso de Dispositivos Electrónicos",
       subtitle = "Frecuencia de uso antes de dormir",
       x = "Calidad de Sueño",
       y = "Número de Estudiantes",
       fill = "Frecuencia de Uso\nde Dispositivos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_viridis_d(option = "viridis")

# 3. BOX PLOT: CALIDAD DE SUEÑO VS RENDIMIENTO ACADÉMICO
grafico3 <- datos %>%
  mutate(Calidad_num = case_when(
    Calidad_sueño == "Muy mala" ~ 1,
    Calidad_sueño == "Bastante mala" ~ 2,
    Calidad_sueño == "Bastante buena" ~ 3,
    Calidad_sueño == "Muy buena" ~ 4
  )) %>%
  ggplot(aes(x = Rendimiento, y = Calidad_num, fill = Rendimiento)) +
  geom_boxplot(alpha = 0.7, outlier.alpha = 0.6) +
  geom_jitter(width = 0.2, alpha = 0.5) +
  labs(title = "Distribución de Calidad de Sueño según Rendimiento Académico",
       subtitle = "Box plot con puntos individuales",
       x = "Rendimiento Académico",
       y = "Calidad de Sueño (1=Muy mala, 4=Muy buena)",
       fill = "Rendimiento") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = "none") +
  scale_y_continuous(breaks = 1:4, 
                     labels = c("Muy mala", "Bastante mala", "Bastante buena", "Muy buena")) +
  scale_fill_viridis_d(option = "cividis")

# 4. GRÁFICO DE DISPERSIÓN: HORAS DE SUEÑO VS RENDIMIENTO
datos_dispersion <- datos %>%
  mutate(Rendimiento_num = case_when(
    Rendimiento == "Deficiente" ~ 1,
    Rendimiento == "Regular" ~ 2,
    Rendimiento == "En proceso" ~ 3,
    Rendimiento == "Satisfactorio" ~ 4
  ))

grafico4 <- ggplot(datos_dispersion, aes(x = Horas_dormido, y = Rendimiento_num)) +
  geom_point(aes(color = Calidad_sueño), size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, color = "red", linetype = "dashed") +
  labs(title = "Relación entre Horas de Sueño y Rendimiento Académico",
       subtitle = "Coloreado por calidad de sueño",
       x = "Horas de Sueño por Noche",
       y = "Rendimiento Académico",
       color = "Calidad\nde Sueño") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_y_continuous(breaks = 1:4, 
                     labels = c("Deficiente", "Regular", "En proceso", "Satisfactorio")) +
  scale_color_viridis_d(option = "plasma")

# OPCIÓN 1: Visualizar en el panel Plots de RStudio
# Los gráficos aparecerán uno por uno en la pestaña "Plots" (abajo derecha)
print(grafico1)
print(grafico2) 
print(grafico3)
print(grafico4)

# OPCIÓN 2: Mostrar múltiples gráficos juntos
grid.arrange(grafico1, grafico2, ncol = 2)
grid.arrange(grafico3, grafico4, ncol = 2)

# ESTADÍSTICAS DESCRIPTIVAS ADICIONALES
cat("=== ESTADÍSTICAS DESCRIPTIVAS ===\n")
cat("Distribución de Calidad de Sueño:\n")
print(table(datos$Calidad_sueño))

cat("\nDistribución de Rendimiento Académico:\n")
print(table(datos$Rendimiento))

cat("\nEstadísticas de Horas de Sueño:\n")
summary(datos$Horas_dormido)

cat("\nCorrelación entre variables numéricas:\n")
correlacion <- cor(datos_dispersion$Horas_dormido, datos_dispersion$Rendimiento_num, 
                   use = "complete.obs")
cat("Correlación Horas de Sueño - Rendimiento:", round(correlacion, 3), "\n")

# TABLAS DE CONTINGENCIA
cat("\n=== TABLAS DE CONTINGENCIA ===\n")
cat("Calidad de Sueño vs Rendimiento Académico:\n")
tabla1 <- table(datos$Calidad_sueño, datos$Rendimiento)
print(tabla1)

cat("\nPorcentajes por fila:\n")
print(round(prop.table(tabla1, 1) * 100, 1))

# GRÁFICOS ADICIONALES SUGERIDOS

# 5. HISTOGRAMA DE HORAS DE SUEÑO
grafico5 <- ggplot(datos, aes(x = Horas_dormido, fill = Calidad_sueño)) +
  geom_histogram(binwidth = 0.5, alpha = 0.7, position = "identity") +
  facet_wrap(~Calidad_sueño, ncol = 2) +
  labs(title = "Distribución de Horas de Sueño por Calidad de Sueño",
       x = "Horas de Sueño",
       y = "Frecuencia",
       fill = "Calidad de Sueño") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold")) +
  scale_fill_viridis_d(option = "plasma")

# 6. GRÁFICO DE BARRAS: USO DE DISPOSITIVOS VS RENDIMIENTO
grafico6 <- datos %>%
  count(Dispositivos, Rendimiento) %>%
  ggplot(aes(x = Dispositivos, y = n, fill = Rendimiento)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(title = "Proporción de Rendimiento Académico según Uso de Dispositivos",
       subtitle = "Gráfico de barras apiladas (proporciones)",
       x = "Frecuencia de Uso de Dispositivos",
       y = "Proporción",
       fill = "Rendimiento\nAcadémico") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_viridis_d(option = "cividis") +
  scale_y_continuous(labels = scales::percent_format())

# GRÁFICO ADICIONAL: ANÁLISIS DE LA PREGUNTA 8 (SOMNOLENCIA DIURNA)

# Conversión de la variable Somnolencia a factor ordenado
datos$Somnolencia <- factor(datos$Somnolencia,
                            levels = c("Ninguna vez en el último mes", 
                                       "Menos de una vez a la semana",
                                       "Una o dos veces a la semana", 
                                       "Tres o más veces a la semana"),
                            ordered = TRUE)

# GRÁFICO 7: Distribución de Somnolencia Diurna
grafico7 <- datos %>%
  count(Somnolencia) %>%
  mutate(porcentaje = n/sum(n)*100) %>%
  ggplot(aes(x = Somnolencia, y = n, fill = Somnolencia)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  geom_text(aes(label = paste0(n, "\n(", round(porcentaje, 1), "%)")), 
            vjust = -0.3, size = 3.5, fontface = "bold") +
  labs(title = "Frecuencia de Somnolencia Diurna en Estudiantes",
       subtitle = "Pregunta 8: Somnolencia durante actividades diarias",
       x = "Frecuencia de Somnolencia",
       y = "Número de Estudiantes",
       caption = "Actividades: conducir, comer, u otras actividades") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5, face = "italic"),
        legend.position = "none") +
  scale_fill_viridis_d(option = "magma") +
  ylim(0, max(table(datos$Somnolencia)) * 1.15)

# GRÁFICO 8: Somnolencia vs Calidad de Sueño
grafico8 <- datos %>%
  count(Somnolencia, Calidad_sueño) %>%
  ggplot(aes(x = Somnolencia, y = n, fill = Calidad_sueño)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  labs(title = "Relación entre Somnolencia Diurna y Calidad de Sueño",
       subtitle = "¿Los estudiantes con peor sueño tienen más somnolencia?",
       x = "Frecuencia de Somnolencia Diurna",
       y = "Número de Estudiantes",
       fill = "Calidad\nde Sueño") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_viridis_d(option = "plasma")

# GRÁFICO 9: Somnolencia vs Rendimiento Académico
grafico9 <- datos %>%
  count(Somnolencia, Rendimiento) %>%
  ggplot(aes(x = Somnolencia, y = n, fill = Rendimiento)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(title = "Proporción de Rendimiento Académico según Somnolencia Diurna",
       subtitle = "¿La somnolencia afecta el rendimiento académico?",
       x = "Frecuencia de Somnolencia Diurna",
       y = "Proporción",
       fill = "Rendimiento\nAcadémico") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_viridis_d(option = "cividis") +
  scale_y_continuous(labels = scales::percent_format())

# GRÁFICO 10: Heatmap de Somnolencia
grafico10 <- datos %>%
  count(Somnolencia, Calidad_sueño) %>%
  ggplot(aes(x = Calidad_sueño, y = Somnolencia, fill = n)) +
  geom_tile(color = "white", size = 0.5) +
  geom_text(aes(label = n), color = "white", fontface = "bold", size = 4) +
  labs(title = "Mapa de Calor: Somnolencia vs Calidad de Sueño",
       subtitle = "Intensidad representa el número de estudiantes",
       x = "Calidad de Sueño",
       y = "Frecuencia de Somnolencia",
       fill = "Número de\nEstudiantes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5)) +
  scale_fill_viridis_c(option = "inferno")

# Mostrar los gráficos de somnolencia
print(grafico7)
print(grafico8)
print(grafico9)
print(grafico10)

# Panel combinado para somnolencia
panel_somnolencia <- grid.arrange(grafico7, grafico8, grafico9, grafico10, 
                                  ncol = 2, nrow = 2,
                                  top = "Análisis Completo de Somnolencia Diurna - Pregunta 8")

# Guardar gráficos de somnolencia
ggsave("graficos/somnolencia_distribucion.png", grafico7, width = 10, height = 6, dpi = 300)
ggsave("graficos/somnolencia_vs_calidad.png", grafico8, width = 12, height = 6, dpi = 300)
ggsave("graficos/somnolencia_vs_rendimiento.png", grafico9, width = 12, height = 6, dpi = 300)
ggsave("graficos/heatmap_somnolencia.png", grafico10, width = 8, height = 6, dpi = 300)
ggsave("graficos/panel_somnolencia_completo.png", panel_somnolencia, width = 16, height = 12, dpi = 300)

# ESTADÍSTICAS DESCRIPTIVAS PARA SOMNOLENCIA
cat("\n=== ANÁLISIS DE SOMNOLENCIA DIURNA (PREGUNTA 8) ===\n")
cat("Distribución de frecuencia de somnolencia:\n")
tabla_somnolencia <- table(datos$Somnolencia)
print(tabla_somnolencia)

cat("\nPorcentajes:\n")
print(round(prop.table(tabla_somnolencia) * 100, 1))

cat("\nSomnolencia vs Calidad de Sueño:\n")
tabla_somno_calidad <- table(datos$Somnolencia, datos$Calidad_sueño)
print(tabla_somno_calidad)

cat("\nSomnolencia vs Rendimiento Académico:\n")
tabla_somno_rend <- table(datos$Somnolencia, datos$Rendimiento)
print(tabla_somno_rend)
# Crear carpeta para guardar gráficos (opcional)
if (!dir.exists("graficos")) {
  dir.create("graficos")
}

# Guardar cada gráfico individualmente
ggsave("graficos/calidad_vs_rendimiento.png", grafico1, width = 10, height = 6, dpi = 300)
ggsave("graficos/calidad_vs_dispositivos.png", grafico2, width = 10, height = 6, dpi = 300)
ggsave("graficos/boxplot_calidad_rendimiento.png", grafico3, width = 10, height = 6, dpi = 300)
ggsave("graficos/dispersion_horas_rendimiento.png", grafico4, width = 10, height = 6, dpi = 300)
ggsave("graficos/histograma_horas_sueño.png", grafico5, width = 12, height = 8, dpi = 300)
ggsave("graficos/dispositivos_rendimiento_proporciones.png", grafico6, width = 10, height = 6, dpi = 300)

# OPCIÓN 4: Crear un panel con todos los gráficos principales
panel_principal <- grid.arrange(grafico1, grafico2, grafico3, grafico4, ncol = 2, nrow = 2,
                                top = "Análisis de Patrones de Sueño y Rendimiento Académico - RENACAD")

# Guardar el panel completo
ggsave("graficos/panel_completo.png", panel_principal, width = 16, height = 12, dpi = 300)

# OPCIÓN 5: Para visualizar en R Markdown/Quarto (si usas un documento .Rmd o .qmd)
# Solo necesitas incluir los gráficos sin print()
# grafico1
# grafico2
# etc.

print(grafico5)
print(grafico6)