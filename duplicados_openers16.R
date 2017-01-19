
# Definir ruta del archivo

carpeta <- "C:/Users/rauace/Documents/"
archivo_origen <- "openers16.txt"
archivo_completo <- "completo.csv"
archivo_sindup <- "sinduplicados.csv"
archivo_dup <- "duplicados.csv"

# Lectura de datos y visualización
 
data <- read.csv(paste0(carpeta, archivo_origen), header = TRUE)

View(data)
str(data)
colnames(data)
data$email <- as.character(data$email)


#Separar el dataset en dos

sindup <- data[!duplicated(data$email), ]
str(sindup)
dup <- data[duplicated(data$email), ]
str(dup)

# Exportar los csv

write.csv(data, file = paste0(carpeta, archivo_completo))
write.csv(sindup, file = paste0(carpeta, archivo_sindup))
write.csv(dup, file = paste0(carpeta, archivo_dup))


