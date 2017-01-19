
archivo_csv <- "C:/Users/rauace/Documents/data.csv"

library(dplyr)
library(XLConnect)
library(xlsx)

data <- read.csv2(archivo_csv, sep = ";", dec = ",", stringsAsFactors=F, header=TRUE, row.names=NULL)

View(data)
str(data)

informe <- data %>% 
  group_by(código) %>%
  summarise(total = sum(Cantidad))  

write.csv(informe, file = "C:/Users/rauace/Documents/informe.csv")

