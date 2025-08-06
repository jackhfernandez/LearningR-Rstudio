### Practicando R

### Library
library(readxl)

### Leyendo Archivo
datos <- read_excel("ENLA.xlsx")

### Mostrar datos
str(datos)

### Mostrar los 10 primeros
head( datos, n=10)

### Resumen
summary(datos)

### Media de Mate que se guarda en mediaMate
mediaMate <- mean( datos$M500_EM_6P_2024_MA, na.rm = TRUE)

### Mostrar los resultados de mediaMate en Media en la consola
cat("Media: ", mediaMate, "\n")

### Desviacion standar
sd ( datos$M500_EM_6P_2024_MA, na.rm = TRUE)

### Media de Mate
mediaComu <- mean ( datos$M500_EM_6P_2024_CT, na.rm = TRUE)

### Tabla resumen de frecuencias de sexo
table (datos$sexo)

### Tabla de proporcion
prop.table(
  table (datos$sexo)
)

### 