
# Definir ruta del archivo

carpeta <- "Z:/SAETA/EPO/Año 2016/Constitución Inmaculada/Sondeo Pre CI_16/"
archivo_origen <- "tokens_285296.csv"
archivo_completo <- "completo.csv"
archivo_sindup <- "sinduplicados.csv"
archivo_dup <- "duplicados.csv"

# Lectura de datos y visualización
 
data <- read.csv(paste0(carpeta, archivo_origen), header = TRUE)

View(data)
str(data)
colnames(data)

# Nos quedamos con las variables relevantes

library(dplyr)
data <- data %>%
select(firstname, lastname, email, token, attribute_1..rat.)
str(data)

#Separar el dataset en dos

sindup <- data[!duplicated(data$email), ]
str(sindup)
dup <- data[duplicated(data$email), ]
str(dup)

# Exportar los csv

write.csv(data, file = paste0(carpeta, archivo_completo))
write.csv(sindup, file = paste0(carpeta, archivo_sindup))
write.csv(dup, file = paste0(carpeta, archivo_dup))


