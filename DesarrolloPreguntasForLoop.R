# # # # # # # # # # 1. CARGANDO BASE DE DATOS # # # # # # # # # # # # # # # # # #

#Instalando paquete para la lectura de archivos csv

install.packages("csv")
library("csv")

#Cargando base de datos

pequena_peru <- read.csv(file = "pequena_peru.csv", sep = ";")
micro_peru <- read.csv(file = "micro_peru.csv", sep = ";")
medianas_peru <- read.csv(file = "medianas_peru.csv", sep = ";")
grandes_peru <- read.csv(file = "grandes_peru.csv", sep = ";")
pequena_colombia <- read.csv(file = "pequena_colombia.csv", sep = ";")
micro_colombia <- read.csv(file = "micro_colombia.csv", sep = ";")
medianas_colombia <- read.csv(file = "medianas_colombia.csv", sep = ";")
grandes_colombia <- read.csv(file = "grandes_colombia.csv", sep = ";")
pequena_chile <- read.csv(file = "pequena_chile.csv", sep = ";")
micro_chile <- read.csv(file = "micro_chile.csv", sep = ";")
medianas_chile <- read.csv(file = "medianas_chile.csv", sep = ";")
grandes_chile <- read.csv(file = "grandes_chile.csv", sep = ";")
