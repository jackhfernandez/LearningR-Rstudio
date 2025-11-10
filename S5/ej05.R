# =============================================================================
# EJERCICIO 5: Estrategia de Implementación Ágil (VME)
# =============================================================================

# PASO 1: Ingresar los datos del ejercicio ---
resultados <- matrix(c(
  95, 70,    # A1: Lanzamiento Múltiple (LM)
  100, 55    # A2: Lanzamiento Único Grande (LUG)
), nrow = 2, byrow = TRUE)

probabilidades <- c(
  "Estabilidad Alta" = 0.4, 
  "Estabilidad Baja" = 0.6
)

# Nombrar filas y columnas
rownames(resultados) <- c("Lanzamiento Múltiple (LM)", "Lanzamiento Único Grande (LUG)")
colnames(resultados) <- names(probabilidades)

# --- PASO 2: Calcular el Valor Monetario Esperado (VME) ---
VME_A1 <- sum(resultados["Lanzamiento Múltiple (LM)", ] * probabilidades)
VME_A2 <- sum(resultados["Lanzamiento Único Grande (LUG)", ] * probabilidades)

# Crear dataframe de resultados
VMEs <- data.frame(
  Alternativa = rownames(resultados),
  Valor_Esperado = c(VME_A1, VME_A2),
  stringsAsFactors = FALSE
)

# --- MOSTRAR RESULTADOS ---
cat("   EJERCICIO 5: ESTRATEGIA DE IMPLEMENTACIÓN ÁGIL (VME)\n")

cat("--- MATRIZ DE SATISFACCIÓN DEL CLIENTE (puntos) ---\n")
print(resultados)

cat("\n--- CÁLCULO DE VALORES ESPERADOS ---\n")
cat(sprintf("VME (A1: Lanzamiento Múltiple) = (95×0.4) + (70×0.6) = %.2f\n", VME_A1))
cat(sprintf("VME (A2: Lanzamiento Grande)   = (100×0.4) + (55×0.6) = %.2f\n", VME_A2))

cat("\n--- TABLA DE VALORES ESPERADOS ---\n")
print(VMEs, row.names = FALSE)

# --- PASO 3: Decisión Óptima (MAXIMIZAR satisfacción) ---
decisión_final <- VMEs[which.max(VMEs$Valor_Esperado), ]

cat("DECISIÓN ÓPTIMA\n")
cat(sprintf("Alternativa: %s\n", decisión_final$Alternativa))
cat(sprintf("VME: %.2f puntos de satisfacción\n", decisión_final$Valor_Esperado))

#cat("\nCONCLUSIÓN: Se debe elegir LANZAMIENTO MÚLTIPLE (LM)\n")
#cat("porque maximiza la satisfacción esperada del cliente.\n")

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
  D [label = 'DECISIÓN\nEstrategia de\nImplementación', 
     fillcolor = '#1976D2', fontcolor = white, 
     shape = box, width = 1.8]
  
  # Nodos de alternativas (cuadrados)
  A1 [label = 'A1: Lanzamiento\\nMúltiple (LM)\\nVME = 80', 
      fillcolor = '#4CAF50', fontcolor = white, penwidth = 3]
  A2 [label = 'A2: Lanzamiento\\nÚnico Grande (LUG)\\nVME = 73', 
      fillcolor = '#FF9800', fontcolor = white]
  
  # Nodos de estados de naturaleza (círculos)
  E1_A1 [label = 'Estabilidad\\nAlta', 
         shape = circle, fillcolor = '#E8F5E9']
  E2_A1 [label = 'Estabilidad\\nBaja', 
         shape = circle, fillcolor = '#FFEBEE']
  
  E1_A2 [label = 'Estabilidad\\nAlta', 
         shape = circle, fillcolor = '#E8F5E9']
  E2_A2 [label = 'Estabilidad\\nBaja', 
         shape = circle, fillcolor = '#FFEBEE']
  
  # Nodos de resultados (triángulos)
  R1_A1 [label = '95 pts', shape = triangle, 
         fillcolor = '#A5D6A7', style = filled]
  R2_A1 [label = '70 pts', shape = triangle, 
         fillcolor = '#FFE082', style = filled]
  
  R1_A2 [label = '100 pts', shape = triangle, 
         fillcolor = '#81C784', style = filled]
  R2_A2 [label = '55 pts', shape = triangle, 
         fillcolor = '#FFCCBC', style = filled]
  
  # Conexiones principales
  D -> A1 [label = '  Opción 1  ', fontcolor = '#4CAF50', penwidth = 3]
  D -> A2 [label = '  Opción 2', fontcolor = '#FF9800', penwidth = 2]
  
  # Ramas de A1: Lanzamiento Múltiple
  A1 -> E1_A1 [label = ' P=0.4', fontcolor = '#388E3C']
  A1 -> E2_A1 [label = ' P=0.6', fontcolor = '#388E3C']
  E1_A1 -> R1_A1
  E2_A1 -> R2_A1
  
  # Ramas de A2: Lanzamiento Único Grande
  A2 -> E1_A2 [label = ' P=0.4', fontcolor = '#F57C00']
  A2 -> E2_A2 [label = ' P=0.6', fontcolor = '#F57C00']
  E1_A2 -> R1_A2
  E2_A2 -> R2_A2
}
")

# Mostrar el árbol
print(arbol)

cat("\nÁrbol de decisión generado exitosamente.\n")