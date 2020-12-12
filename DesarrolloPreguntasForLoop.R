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

# # # # # # # # # AGREGANDO VARIABLE TAMANIO # # # # # # # # # # # # # # # # # #

#Creando variables de tamaño

micro <- "Micro"
mediana <- "Mediana"
pequena <- "Pequena"
grande <- "Grande"

#Agregando las variables de tamaño en nueva columna

pequena_peru <- cbind(pequena_peru, Tamanio = pequena)
pequena_chile <- cbind(pequena_chile, Tamanio = pequena)
pequena_colombia <- cbind(pequena_colombia, Tamanio = pequena)
micro_chile <- cbind(micro_chile, Tamanio = micro)
micro_colombia <- cbind(micro_colombia,Tamanio = micro)
micro_peru <- cbind(micro_peru, Tamanio = micro)
medianas_chile <- cbind(medianas_chile, Tamanio = mediana)
medianas_colombia <- cbind(medianas_colombia, Tamanio = mediana)
medianas_peru <- cbind(medianas_peru, Tamanio = mediana)
grandes_chile <- cbind(grandes_chile, Tamanio = grande)
grandes_colombia <- cbind(grandes_colombia, Tamanio = grande)
grandes_peru <- cbind(grandes_peru, Tamanio = grande)

# # # # # # # # 2. REUNIENDO BASES DE DATOS Y DEFINIENDO TIPOLOGIA # # # # # # #

#Cambiando el nombre de las variables con error de sintaxis ya que al no coincidir entre
#bases de datos no permitian la union de las tablas

##Instalando paquete encontrado online para el cambio de nombre de las variables

install.packages("dplyr")
library("dplyr")

##Cambiando el nombre de las variables con error de sintaxis

pequena_peru <- rename(pequena_peru, porcentaje_mujeres = procentaje_mujeres)
micro_chile <- rename(micro_chile, porcentaje_mujeres = procentaje_muejeres)
medianas_chile <- rename(medianas_chile, porcentaje_mujeres = procentaje_mujeres)
medianas_peru <- rename(medianas_peru, porcentaje_mujeres = procentaje_muejeres)
grandes_chile <- rename(grandes_chile, porcentaje_mujeres = procentaje_mujeres)
grandes_colombia <- rename(grandes_colombia, porcentaje_mujeres = procentaje_mujeres)
grandes_peru <- rename(grandes_peru, porcentaje_mujeres = procentaje_muejeres)

#Reuniendo las bases de datos

Base_datos_empresas <- rbind(pequena_chile,pequena_colombia,pequena_peru,
                             micro_chile,micro_colombia,micro_peru,
                             medianas_chile,medianas_colombia,medianas_peru,
                             grandes_chile,grandes_colombia,grandes_peru)

#Definiendo la tipologia de cada una de las variables

