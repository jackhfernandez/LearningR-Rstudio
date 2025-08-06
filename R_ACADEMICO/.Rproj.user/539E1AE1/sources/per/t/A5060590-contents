# Análisis de Datos sobre calidad de sueño y rendimiento académico
# FACFYM - EPICI primer ciclo

# Carga de librerías necesarias
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr)

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

# GRÁFICO 1: CALIDAD DE SUEÑO VS RENDIMIENTO ACADÉMICO
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

# GRÁFICO 2: CALIDAD DE SUEÑO VS USO DE DISPOSITIVOS
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

# GRÁFICO 4: DISPERSIÓN HORAS DE SUEÑO VS RENDIMIENTO
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

# Mostrar los gráficos
print(grafico1)
print(grafico2) 
print(grafico4)

# Guardar gráficos
ggsave("calidad_vs_rendimiento.png", grafico1, width = 10, height = 6, dpi = 300)
ggsave("calidad_vs_dispositivos.png", grafico2, width = 10, height = 6, dpi = 300)
ggsave("dispersion_horas_rendimiento.png", grafico4, width = 10, height = 6, dpi = 300)