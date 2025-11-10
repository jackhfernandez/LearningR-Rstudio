# =============================================================================
# EJERCICIO 1: Desarrollo de Módulo vs. Compra de Licencia (VME)
# =============================================================================

# PASO 1: Ingresar los datos del ejercicio
resultados <- matrix(c(
  180, 50,   # A1: Desarrollar Internamente
  140, 80    # A2: Comprar Licencia
), nrow = 2, byrow = TRUE)

probabilidades <- c(
  "Aceptación Alta" = 0.7, 
  "Aceptación Baja" = 0.3
)

# Nombrar filas y columnas
rownames(resultados) <- c("Desarrollar Internamente", "Comprar Licencia")
colnames(resultados) <- names(probabilidades)

# --- PASO 2: Calcular el Valor Monetario Esperado (VME) ---
VME_A1 <- sum(resultados["Desarrollar Internamente", ] * probabilidades)
VME_A2 <- sum(resultados["Comprar Licencia", ] * probabilidades)

# Crear dataframe de resultados
VMEs <- data.frame(
  Alternativa = rownames(resultados),
  Valor_Esperado = c(VME_A1, VME_A2),
  stringsAsFactors = FALSE
)

# --- MOSTRAR RESULTADOS ---
cat("EJERCICIO 1: DESARROLLAR INTERNAMENTE vs. COMPRA DE LICENCIA (VME)\n")

cat("--- MATRIZ DE RESULTADOS (miles de USD) ---\n")
print(resultados)

cat("\n--- CÁLCULO DE VALORES ESPERADOS ---\n")
cat(sprintf("VME (A1: Desarrollar) = (180×0.7) + (50×0.3) = %.2f\n", VME_A1))
cat(sprintf("VME (A2: Licencia)    = (140×0.7) + (80×0.3) = %.2f\n", VME_A2))

cat("\n--- TABLA DE VALORES ESPERADOS ---\n")
print(VMEs, row.names = FALSE)

# --- PASO 3: Decisión Óptima ---
decisión_final <- VMEs[which.max(VMEs$Valor_Esperado), ]

cat("\nDECISIÓN ÓPTIMA: \n")
cat(decisión_final$Alternativa, "\n\n")
cat(sprintf("VME: $%.2f mil USD\n", decisión_final$Valor_Esperado))

cat("\nCONCLUSIÓN: Se debe elegir DESARROLLAR INTERNAMENTE\n",
    "porque maximiza el valor esperado.\n")

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
  edge [fontname = 'Arial', fontsize = 12]
  
  # Nodo de decisión (cuadrado)
  D [label = 'DECISIÓN\nDesarrollo vs.\nLicencia', 
     fillcolor = '#4CAF50', fontcolor = white, 
     shape = box, width = 1.8]
  
  # Nodos de alternativas (cuadrados)
  A1 [label = 'A1: Desarrollar\nVME = 141', 
      fillcolor = '#2196F3', fontcolor = white]
  A2 [label = 'A2: Licencia\nVME = 122', 
      fillcolor = '#FF9800', fontcolor = white]
  
  # Nodos de estados de naturaleza (círculos)
  E1_A1 [label = 'Aceptación\nAlta', 
         shape = circle, fillcolor = '#E3F2FD']
  E2_A1 [label = 'Aceptación\nBaja', 
         shape = circle, fillcolor = '#E3F2FD']
  
  E1_A2 [label = 'Aceptación\nAlta', 
         shape = circle, fillcolor = '#FFF3E0']
  E2_A2 [label = 'Aceptación\nBaja', 
         shape = circle, fillcolor = '#FFF3E0']
  
  # Nodos de resultados (triángulos)
  R1_A1 [label = '$180k', shape = triangle, 
         fillcolor = '#C8E6C9', style = filled]
  R2_A1 [label = '$50k', shape = triangle, 
         fillcolor = '#FFCCBC', style = filled]
  
  R1_A2 [label = '$140k', shape = triangle, 
         fillcolor = '#C8E6C9', style = filled]
  R2_A2 [label = '$80k', shape = triangle, 
         fillcolor = '#FFE0B2', style = filled]
  
  # Conexiones principales
  D -> A1 [label = '  Opción 1', fontcolor = '#2196F3', penwidth = 2]
  D -> A2 [label = '  Opción 2', fontcolor = '#FF9800', penwidth = 2]
  
  # Ramas de A1: Desarrollar
  A1 -> E1_A1 [label = ' P=0.7', fontcolor = '#1976D2']
  A1 -> E2_A1 [label = ' P=0.3', fontcolor = '#1976D2']
  E1_A1 -> R1_A1
  E2_A1 -> R2_A1
  
  # Ramas de A2: Licencia
  A2 -> E1_A2 [label = ' P=0.7', fontcolor = '#F57C00']
  A2 -> E2_A2 [label = ' P=0.3', fontcolor = '#F57C00']
  E1_A2 -> R1_A2
  E2_A2 -> R2_A2
  
}
")

# Mostrar el árbol
print(arbol)

cat("\nÁrbol de decisión generado exitosamente.\n")
cat("   El árbol muestra todas las alternativas, probabilidades y resultados.\n\n")
