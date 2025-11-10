# =============================================================================
# EJERCICIO 4: Inversión en Seguridad de Datos (CE - Costo Esperado)
# =============================================================================

# --- PASO 1: Ingresar los datos del ejercicio ---
resultados <- matrix(c(
  20, 10,    # A1: Aplicar Parche Inmediato
  150, 5     # A2: Esperar Actualización Trimestral
), nrow = 2, byrow = TRUE)

probabilidades <- c(
  "Explotación de Vulnerabilidad" = 0.15, 
  "No Hay Explotación" = 0.85
)

# Nombrar filas y columnas
rownames(resultados) <- c("A1: Aplicar Parche Inmediato", "A2: Esperar Actualización")
colnames(resultados) <- names(probabilidades)

# --- PASO 2: Calcular el Costo Esperado (CE) ---
CE_A1 <- sum(resultados["A1: Aplicar Parche Inmediato", ] * probabilidades)
CE_A2 <- sum(resultados["A2: Esperar Actualización", ] * probabilidades)

# Crear dataframe de resultados
CEs <- data.frame(
  Alternativa = rownames(resultados),
  Costo_Esperado = c(CE_A1, CE_A2),
  stringsAsFactors = FALSE
)

# --- MOSTRAR RESULTADOS ---
cat("   EJERCICIO 4: INVERSIÓN EN SEGURIDAD DE DATOS (CE)\n")

cat("--- MATRIZ DE COSTOS (horas-hombre) ---\n")
print(resultados)

cat("\n--- CÁLCULO DE COSTOS ESPERADOS ---\n")
cat(sprintf("CE (A1: Parche Inmediato) = (20×0.15) + (10×0.85) = %.2f\n", CE_A1))
cat(sprintf("CE (A2: Esperar Actualiz.) = (150×0.15) + (5×0.85) = %.2f\n", CE_A2))

cat("\n--- TABLA DE COSTOS ESPERADOS ---\n")
print(CEs, row.names = FALSE)

# --- PASO 3: Decisión Óptima (MINIMIZAR costo) ---
decisión_final <- CEs[which.min(CEs$Costo_Esperado), ]

cat("DECISIÓN ÓPTIMA\n")
cat(sprintf("%s\n", decisión_final$Alternativa))
cat(sprintf("Costo Esperado: %.2f horas-hombre\n", decisión_final$Costo_Esperado))

#cat("\nCONCLUSIÓN: Se debe APLICAR EL PARCHE INMEDIATO\n")
#cat("porque minimiza el costo esperado en horas-hombre perdidas.\n")

# VISUALIZACIÓN: ÁRBOL DE DECISIÓN

# Instalar/cargar librerías necesarias
if (!require("DiagrammeR")) install.packages("DiagrammeR")
library(DiagrammeR)

# Crear el árbol de decisión usando DOT
arbol <- grViz("
digraph arbol_decision {
  
  # Configuración general
  graph [rankdir = LR, bgcolor = '#f8f9fa']
  node [shape = box, style = filled, fontname = 'Arial']
  edge [fontname = 'Arial', fontsize = 10]
  
  # Nodo de decisión (cuadrado)
  D [label = 'DECISIÓN\nSeguridad de\nDatos', 
     fillcolor = '#D32F2F', fontcolor = white, 
     shape = box, width = 1.8]
  
  # Nodos de alternativas (cuadrados)
  A1 [label = 'A1: Parche Inmediato\\nCE = 11.5 hrs', 
      fillcolor = '#4CAF50', fontcolor = white, penwidth = 3]
  A2 [label = 'A2: Esperar Actualiz.\\nCE = 26.75 hrs', 
      fillcolor = '#FF9800', fontcolor = white]
  
  # Nodos de estados de naturaleza (círculos)
  E1_A1 [label = 'Explotación\\nVulnerabilidad', 
         shape = circle, fillcolor = '#FFEBEE']
  E2_A1 [label = 'No Hay\\nExplotación', 
         shape = circle, fillcolor = '#E8F5E9']
  
  E1_A2 [label = 'Explotación\\nVulnerabilidad', 
         shape = circle, fillcolor = '#FFEBEE']
  E2_A2 [label = 'No Hay\\nExplotación', 
         shape = circle, fillcolor = '#E8F5E9']
  
  # Nodos de resultados (triángulos)
  R1_A1 [label = '20 hrs', shape = triangle, 
         fillcolor = '#FFE082', style = filled]
  R2_A1 [label = '10 hrs', shape = triangle, 
         fillcolor = '#C8E6C9', style = filled]
  
  R1_A2 [label = '150 hrs', shape = triangle, 
         fillcolor = '#FF8A80', style = filled]
  R2_A2 [label = '5 hrs', shape = triangle, 
         fillcolor = '#A5D6A7', style = filled]
  
  # Conexiones principales
  D -> A1 [label = '  Opción 1  ', fontcolor = '#4CAF50', penwidth = 3]
  D -> A2 [label = '  Opción 2', fontcolor = '#FF9800', penwidth = 2]
  
  # Ramas de A1: Parche Inmediato
  A1 -> E1_A1 [label = ' P=0.15', fontcolor = '#388E3C']
  A1 -> E2_A1 [label = ' P=0.85', fontcolor = '#388E3C']
  E1_A1 -> R1_A1
  E2_A1 -> R2_A1
  
  # Ramas de A2: Esperar Actualización
  A2 -> E1_A2 [label = ' P=0.15', fontcolor = '#F57C00']
  A2 -> E2_A2 [label = ' P=0.85', fontcolor = '#F57C00']
  E1_A2 -> R1_A2
  E2_A2 -> R2_A2
}
")

# Mostrar el árbol
print(arbol)

cat("\nÁrbol de decisión generado exitosamente.\n")