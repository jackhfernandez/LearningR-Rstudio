#Caso 1: Decisión sobre la Tecnología de Base de Datos

#Paso 1: Definir la Matriz y Probabilidades

# Definir los resultados (matriz de ganancias)
resultados <- matrix(c(
  150, 70,  # PostgreSQL: Alta, Baja
  200, 40   # MongoDB: Alta, Baja
), nrow = 2, byrow = TRUE)

# Definir las probabilidades de los estados de la naturaleza
probabilidades <- c(Demanda_Alta = 0.6, Demanda_Baja = 0.4)

# Nombrar filas y columnas para claridad
rownames(resultados) <- c("PostgreSQL", "MongoDB")
colnames(resultados) <- names(probabilidades)

print(resultados)
#Paso 2: Calcular el Valor Monetario Esperado (VME)
#El VME se calcula como: VME=∑(Resultadoi×Probabilidadi)

# Multiplicar la matriz de resultados por el vector de probabilidades
VME_PostgreSQL <- sum(resultados["PostgreSQL", ] * probabilidades)
VME_MongoDB <- sum(resultados["MongoDB", ] * probabilidades)

# Crear un dataframe para comparar
VMEs <- data.frame(
  Alternativa = c("PostgreSQL", "MongoDB"),
  VME = c(VME_PostgreSQL, VME_MongoDB)
)

print(VMEs)

# Decisión
decisión_1 <- VMEs[which.max(VMEs$VME), ]
cat("\nLa decisión óptima es:", decisión_1$Alternativa, 
    "con un VME de", round(decisión_1$VME, 2), "mil USD.")


#Caso 2: Decisión sobre Inversión en Ciberseguridad
#Paso 1: Definir la Matriz y Probabilidades

# Definir los costos (matriz de pérdidas)
costos <- matrix(c(
  500, 50,  # Moderada: AM, Am
  150, 80   # Alta: AM, Am
), nrow = 2, byrow = TRUE)

probabilidades_ataque <- c(Ataque_Masivo = 0.1, Ataque_Menor = 0.9)

rownames(costos) <- c("Inversion_Moderada", "Inversion_Alta")
colnames(costos) <- names(probabilidades_ataque)

print(costos)

#Paso 2: Calcular el Costo Esperado (CE)

# Calcular el Costo Esperado (CE) para cada alternativa
CE_Moderada <- sum(costos["Inversion_Moderada", ] * probabilidades_ataque)
CE_Alta <- sum(costos["Inversion_Alta", ] * probabilidades_ataque)

CEs <- data.frame(
  Alternativa = c("Inversion_Moderada", "Inversion_Alta"),
  CE = c(CE_Moderada, CE_Alta)
)

print(CEs)

# Decisión: Minimizar el CE
decisión_2 <- CEs[which.min(CEs$CE), ]
cat("\nLa decisión óptima es:", decisión_2$Alternativa, 
    "con un Costo Esperado de", round(decisión_2$CE, 2), "mil USD.")


#caso 3: Decisión sobre Contratación en Proyecto
#Paso 1: Definir la Matriz y Probabilidades

costos_retraso <- matrix(c(
  10, 120, # Equipo Actual: Fácil, Difícil
  40, 50   # Experto: Fácil, Difícil
), nrow = 2, byrow = TRUE)

probabilidades_integracion <- c(Facil = 0.7, Dificil = 0.3)

rownames(costos_retraso) <- c("Equipo_Actual", "Contratar_Experto")
colnames(costos_retraso) <- names(probabilidades_integracion)

print(costos_retraso)
#Paso 2: Calcular el Costo Esperado (CE)

CE_Actual <- sum(costos_retraso["Equipo_Actual", ] * probabilidades_integracion)
CE_Experto <- sum(costos_retraso["Contratar_Experto", ] * probabilidades_integracion)

CEs_3 <- data.frame(
  Alternativa = c("Equipo_Actual", "Contratar_Experto"),
  CE = c(CE_Actual, CE_Experto)
)

print(CEs_3)

# Decisión: Minimizar el CE
decisión_3 <- CEs_3[which.min(CEs_3$CE), ]
cat("\nLa decisión óptima es:", decisión_3$Alternativa, 
    "con un Costo Esperado (días-hombre) de", round(decisión_3$CE, 2), ".")


#caso 4: Decisión sobre Actualización de Servidor
#Paso 1: Definir la Matriz y Probabilidades

perdidas <- matrix(c(
  60, 5,   # Mantener Actual: Alto, Bajo
  10, 15   # Actualizar: Alto, Bajo
), nrow = 2, byrow = TRUE)

probabilidades_trafico <- c(Alto = 0.25, Bajo = 0.75)

rownames(perdidas) <- c("Mantener_Actual", "Actualizar_Servidor")
colnames(perdidas) <- names(probabilidades_trafico)

print(perdidas)
#Paso 2: Calcular el Costo Esperado (CE)

CE_Mantener <- sum(perdidas["Mantener_Actual", ] * probabilidades_trafico)
CE_Actualizar <- sum(perdidas["Actualizar_Servidor", ] * probabilidades_trafico)

CEs_4 <- data.frame(
  Alternativa = c("Mantener_Actual", "Actualizar_Servidor"),
  CE = c(CE_Mantener, CE_Actualizar)
)

print(CEs_4)

# Decisión: Minimizar el CE
decisión_4 <- CEs_4[which.min(CEs_4$CE), ]
cat("\nLa decisión óptima es:", decisión_4$Alternativa, 
    "con un Costo Esperado de", round(decisión_4$CE, 2), "mil USD.")

