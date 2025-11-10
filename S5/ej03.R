# =============================================================================
# EJERCICIO 3: Elección de Servidor Cloud (VME - Valor Monetario Esperado)
# =============================================================================

# PASO 1: Ingresar los datos del ejercicio ---
resultados <- matrix(c(
  500, 1500,   # A1: Servidor Básico (B)
  1800, 1000   # A2: Servidor Premium (P)
), nrow = 2, byrow = TRUE)

probabilidades <- c(
  "Carga Crítica" = 0.3, 
  "Carga Normal" = 0.7
)

# Nombrar filas y columnas
rownames(resultados) <- c("Servidor Básico (B)", "Servidor Premium (P)")
colnames(resultados) <- names(probabilidades)

# --- PASO 2: Calcular el Valor Monetario Esperado (VME) ---
VME_A1 <- sum(resultados["Servidor Básico (B)", ] * probabilidades)
VME_A2 <- sum(resultados["Servidor Premium (P)", ] * probabilidades)

# Crear dataframe de resultados
VMEs <- data.frame(
  Alternativa = rownames(resultados),
  Valor_Esperado = c(VME_A1, VME_A2),
  stringsAsFactors = FALSE
)

# --- MOSTRAR RESULTADOS ---
cat("      EJERCICIO 3: ELECCIÓN DE SERVIDOR CLOUD (VME)\n")

cat("--- MATRIZ DE GANANCIAS (USD) ---\n")
print(resultados)

cat("\n--- CÁLCULO DE VALORES ESPERADOS ---\n")
cat(sprintf("VME (A1: Básico)   = (500×0.3) + (1,500×0.7) = $%.2f\n", VME_A1))
cat(sprintf("VME (A2: Premium)  = (1,800×0.3) + (1,000×0.7) = $%.2f\n", VME_A2))

cat("\n--- TABLA DE VALORES ESPERADOS ---\n")
print(VMEs, row.names = FALSE)

# --- PASO 3: Decisión Óptima (MAXIMIZAR ganancia) ---
decisión_final <- VMEs[which.max(VMEs$Valor_Esperado), ]

cat("DECISIÓN ÓPTIMA\n")
cat(sprintf("%s\n", decisión_final$Alternativa))
cat(sprintf("VME: $%.2f USD\n", decisión_final$Valor_Esperado))

#cat("\nCONCLUSIÓN: Se debe elegir SERVIDOR PREMIUM (P)\n")
#cat("porque maximiza el valor esperado de ganancia.\n")

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
  D [label = 'DECISIÓN\nTipo de\nServidor Cloud', 
     fillcolor = '#673AB7', fontcolor = white, 
     shape = box, width = 1.8]
  
  # Nodos de alternativas (cuadrados)
  A1 [label = 'A1: Básico (B)\\nVME = $1,200', 
      fillcolor = '#FF9800', fontcolor = white]
  A2 [label = 'A2: Premium (P)\\nVME = $1,240 ✓', 
      fillcolor = '#4CAF50', fontcolor = white, penwidth = 3]
  
  # Nodos de estados de naturaleza (círculos)
  E1_A1 [label = 'Carga\\nCrítica', 
         shape = circle, fillcolor = '#FFEBEE']
  E2_A1 [label = 'Carga\\nNormal', 
         shape = circle, fillcolor = '#E8F5E9']
  
  E1_A2 [label = 'Carga\\nCrítica', 
         shape = circle, fillcolor = '#FFEBEE']
  E2_A2 [label = 'Carga\\nNormal', 
         shape = circle, fillcolor = '#E8F5E9']
  
  # Nodos de resultados (triángulos)
  R1_A1 [label = '$500', shape = triangle, 
         fillcolor = '#FFE082', style = filled]
  R2_A1 [label = '$1,500', shape = triangle, 
         fillcolor = '#C8E6C9', style = filled]
  
  R1_A2 [label = '$1,800', shape = triangle, 
         fillcolor = '#A5D6A7', style = filled]
  R2_A2 [label = '$1,000', shape = triangle, 
         fillcolor = '#C8E6C9', style = filled]
  
  # Conexiones principales
  D -> A1 [label = '  Opción 1', fontcolor = '#FF9800', penwidth = 2]
  D -> A2 [label = '  Opción 2  ', fontcolor = '#4CAF50', penwidth = 3]
  
  # Ramas de A1: Servidor Básico
  A1 -> E1_A1 [label = ' P=0.3', fontcolor = '#F57C00']
  A1 -> E2_A1 [label = ' P=0.7', fontcolor = '#F57C00']
  E1_A1 -> R1_A1
  E2_A1 -> R2_A1
  
  # Ramas de A2: Servidor Premium
  A2 -> E1_A2 [label = ' P=0.3', fontcolor = '#388E3C']
  A2 -> E2_A2 [label = ' P=0.7', fontcolor = '#388E3C']
  E1_A2 -> R1_A2
  E2_A2 -> R2_A2
  
}
")

# Mostrar el árbol
print(arbol)

cat("\nÁrbol de decisión generado exitosamente.\n")