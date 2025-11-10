# =============================================================================
# EJERCICIO 2: Estrategia de Prueba de Software (CE - Costo Esperado)
# =============================================================================

# --- PASO 1: Ingresar los datos del ejercicio ---
resultados <- matrix(c(
  12000, 4000,   # A1: Pruebas Exhaustivas
  25000, 2000    # A2: Pruebas Rápidas
), nrow = 2, byrow = TRUE)

probabilidades <- c(
  "Fallo Mayor" = 0.1, 
  "No Hay Fallo Mayor" = 0.9
)

# Nombrar filas y columnas
rownames(resultados) <- c("Pruebas Exhaustivas", "Pruebas Rápidas")
colnames(resultados) <- names(probabilidades)

# --- PASO 2: Calcular el Costo Esperado (CE) ---
CE_A1 <- sum(resultados["Pruebas Exhaustivas", ] * probabilidades)
CE_A2 <- sum(resultados["Pruebas Rápidas", ] * probabilidades)

# Crear dataframe de resultados
CEs <- data.frame(
  Alternativa = rownames(resultados),
  Costo_Esperado = c(CE_A1, CE_A2),
  stringsAsFactors = FALSE
)

# --- MOSTRAR RESULTADOS ---
cat("   EJERCICIO 2: ESTRATEGIA DE PRUEBA DE SOFTWARE (CE)\n")

cat("--- MATRIZ DE COSTOS (USD) ---\n")
print(resultados)

cat("\n--- CÁLCULO DE COSTOS ESPERADOS ---\n")
cat(sprintf("CE (A1: Exhaustivas) = (12,000×0.1) + (4,000×0.9) = $%.2f\n", CE_A1))
cat(sprintf("CE (A2: Rápidas)     = (25,000×0.1) + (2,000×0.9) = $%.2f\n", CE_A2))

cat("\n--- TABLA DE COSTOS ESPERADOS ---\n")
print(CEs, row.names = FALSE)

# --- PASO 3: Decisión Óptima (MINIMIZAR costo) ---
decisión_final <- CEs[which.min(CEs$Costo_Esperado), ]

cat("DECISIÓN ÓPTIMA\n")
cat(sprintf("%s\n", decisión_final$Alternativa))
cat(sprintf("Costo Esperado: $%.2f USD\n", decisión_final$Costo_Esperado))


#cat("\nCONCLUSIÓN: Se deben realizar PRUEBAS RÁPIDAS\n")
#cat("porque minimiza el costo esperado total.\n")
#cat("═══════════════════════════════════════════════════════════════\n\n")

# =============================================================================
# VISUALIZACIÓN: ÁRBOL DE DECISIÓN
# =============================================================================

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
  D [label = 'DECISIÓN\nTipo de\nPruebas', 
     fillcolor = '#E91E63', fontcolor = white, 
     shape = box, width = 1.8]
  
  # Nodos de alternativas (cuadrados)
  A1 [label = 'A1: Exhaustivas\\nCE = $4,800', 
      fillcolor = '#FF9800', fontcolor = white]
  A2 [label = 'A2: Rápidas\\nCE = $4,300', 
      fillcolor = '#4CAF50', fontcolor = white, penwidth = 3]
  
  # Nodos de estados de naturaleza (círculos)
  E1_A1 [label = 'Fallo\\nMayor', 
         shape = circle, fillcolor = '#FFEBEE']
  E2_A1 [label = 'No Hay\\nFallo Mayor', 
         shape = circle, fillcolor = '#E8F5E9']
  
  E1_A2 [label = 'Fallo\\nMayor', 
         shape = circle, fillcolor = '#FFEBEE']
  E2_A2 [label = 'No Hay\\nFallo Mayor', 
         shape = circle, fillcolor = '#E8F5E9']
  
  # Nodos de resultados (triángulos)
  R1_A1 [label = '$12,000', shape = triangle, 
         fillcolor = '#FFCCBC', style = filled]
  R2_A1 [label = '$4,000', shape = triangle, 
         fillcolor = '#C8E6C9', style = filled]
  
  R1_A2 [label = '$25,000', shape = triangle, 
         fillcolor = '#FF8A80', style = filled]
  R2_A2 [label = '$2,000', shape = triangle, 
         fillcolor = '#A5D6A7', style = filled]
  
  # Conexiones principales
  D -> A1 [label = '  Opción 1', fontcolor = '#FF9800', penwidth = 2]
  D -> A2 [label = '  Opción 2  ', fontcolor = '#4CAF50', penwidth = 3]
  
  # Ramas de A1: Pruebas Exhaustivas
  A1 -> E1_A1 [label = ' P=0.1', fontcolor = '#F57C00']
  A1 -> E2_A1 [label = ' P=0.9', fontcolor = '#F57C00']
  E1_A1 -> R1_A1
  E2_A1 -> R2_A1
  
  # Ramas de A2: Pruebas Rápidas
  A2 -> E1_A2 [label = ' P=0.1', fontcolor = '#388E3C']
  A2 -> E2_A2 [label = ' P=0.9', fontcolor = '#388E3C']
  E1_A2 -> R1_A2
  E2_A2 -> R2_A2
  
}
")

# Mostrar el árbol
print(arbol)

cat("\nÁrbol de decisión generado exitosamente.\n")
cat("El árbol muestra todas las alternativas, probabilidades y costos.\n")