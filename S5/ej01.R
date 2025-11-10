# --- PLANTILLA DE ANÁLISIS DE DECISIONES CON VME/CE ---

# PASO 1: Ingresar los datos del ejercicio
# EJEMPLO: Usando los datos del Ejercicio 1

resultados <- matrix(c(
  180, 50, # A1: Desarrollar
  140, 80 # A2: Licencia
), nrow = 2, byrow = TRUE)
probabilidades <- c(P1 = 0.7, P2 = 0.3)

# Nombrar para claridad (Asegúrate de cambiar los nombres de fila y
# columna según el ejercicio)
rownames(resultados) <- c("Desarrollar internamente", "Comprar licencia")
colnames(resultados) <- names(probabilidades)

# PASO 2: Calcular el Valor Esperado (VME o CE)
# Multiplicar la matriz por el vector de probabilidades
VME_A1 <- sum(resultados["Desarrollar internamente", ] * probabilidades)
VME_A2 <- sum(resultados["Comprar licencia", ] * probabilidades)

# Crear un dataframe de resultados
VMEs <- data.frame(
  Alternativa = rownames(resultados),
  Valor_Esperado = c(VME_A1, VME_A2)
)

print("--- Matriz de Resultados ---")
print(resultados)

print("--- Valores Esperados ---")
print(VMEs)

# PASO 3: Tomar la Decisión Óptima
# Si el resultado es GANANCIA (VME), se busca el máximo (which.max)
# Si el resultado es COSTO (CE), se busca el mínimo (which.min)
# En este caso (Ej. 1), buscamos MAXIMIZAR la ganancia

decisión_final <- VMEs[which.max(VMEs$Valor_Esperado), ]
cat("\nDecisión Óptima:", decisión_final$Alternativa,
    "con un VME de", round(decisión_final$Valor_Esperado, 2))

# Si el ejercicio fuera de COSTO (CE), la línea de decisión cambiaría a:
  # decisión_final <- VMEs[which.min(VMEs$Valor_Esperado), ]