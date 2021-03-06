#Espacio de trabajo: setwd("C:/Users/maria/OneDrive/Escritorio/ICI Cuarto a�o/Segundo semestre/Big data/Tarea2_FOR_LOOP")

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

#Creando variables de tama�o

micro <- "Micro"
mediana <- "Mediana"
pequena <- "Pequena"
grande <- "Grande"

#Agregando las variables de tama�o en nueva columna

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

##Se crea una funcion que contiene un loop que recorre las columnas de la base de datos definiendo su tipolog�a
##Tipologia_base_de_datos: Entrada: List -> Salida: String
##Ejemplo: Entrada: Base_datos_empresas -> Salida: La variable 1 es de tipo list... (N = 13)

##Creando la funci�n

Tipologia_base_de_datos <- function(Base_datos_empresas){
    for (i in 1:length(Base_datos_empresas)) {
    tipo <- typeof(Base_datos_empresas[i])
    print(paste("La variable",i,"es de tipo",tipo))
  }
}

##Probando la funci�n

Tipologia_base_de_datos(Base_datos_empresas)

# # # # # # 3. DETERMINACION OBSERVACIONES PERU V/S CHILE # # # # # # # # # # # #

#Se crea una funcion que contiene un loop que recorre la columna paises dentro de la base de datos para determinar la
#cantidad de observaciones que poseen Per� v/s Chile
#Observaciones: Entrada: list -> Salida: String
#Ejemplo: Entrada: Base_datos_empresas -> Salida: Chile posee 260 observaciones, mientras que Per� posee 260 observaciones

#Creando la funci�n

Observaciones <- function(Base_datos_empresas){
  #Se establecen las variables vacias que contendran la cantidad de observaciones de cada pa�s
  observacioneschile <- 0
  observacionesperu <- 0
    #[INICIA LOOP]
    for (ob in 1:length(Base_datos_empresas$pais)) {
      #Se establece la condicional para chile
    if(Base_datos_empresas$pais[ob] == "chile"){
      #Se aumenta la variable correspondiente 
      observacioneschile <- observacioneschile + 1
      #Se establece la condicional para peru
    }else if(Base_datos_empresas$pais[ob] == "peru"){
      #Se aumenta la variable correspondiente
      observacionesperu <- observacionesperu + 1
    }
    #[FINALIZA LOOP]
  }
  #Se imprime string con los resultados obtenidos
  print(paste("Chile posee",observacioneschile,"observaciones, mientras que Per� posee",observacionesperu,"observaciones"))
}

#Probando la funci�n

Observaciones(Base_datos_empresas)

# # # # 4. DETERMINACION DEL PAIS CON MAYORES INGRESOS DE EXPLOTACION # # # # # # 

#Cambiando las compas por puntos en la variable tasas de interes para que R las tome como valor numerico

Base_datos_empresas$ingresos <- gsub("[,]",".",Base_datos_empresas$ingresos)

#Transformando la variable ingresos en valores numericos

Base_datos_empresas$ingresos <- as.numeric(Base_datos_empresas$ingresos)

#Creando funcion que contiene loop que recorera la base de datos en busqueda del pa�s con mayores ingresos

MayorIng <- function(Base_datos_empresas){
  #Estableciendo las variables que almacenaran los montos de cada pais
  IngChile <- 0
  IngColombia <- 0
  IngPeru <- 0
  #Creando loop que sumara los montos de cada pais en su variable correspondiente
  for (m in 1:nrow(Base_datos_empresas)) {
    #[INICIA LOOP]
    #Estableciendo condicion para almacenar en ingresos de chile
    if(Base_datos_empresas[m,2] == "chile"){
      IngChile <- IngChile + Base_datos_empresas[m,3]
    #Estableciendo condicion para almacenar en ingresos colombia
    }else if(Base_datos_empresas[m,2] == "colombia"){
      IngColombia <- IngColombia + Base_datos_empresas[m,3]
    #Estableciendo condicion para almacenar en ingresos peru
    }else if(Base_datos_empresas[m,2] == "peru"){
      IngPeru <- IngPeru + Base_datos_empresas[m,3]
    }
    #[FINALIZA LOOP]
  }
  #Definiendo por medio de funcion max el mayor monto de ingresos y almacenandolo en una variable
  MontoMax <- max(IngPeru,IngColombia,IngChile)
  #Estableciendo una serie de condicionales para el establecimiento del pais correspondiente al monto maximo encontrado
  if(IngPeru == MontoMax){
    PaisMax <- "Peru"
  }else if(IngColombia == MontoMax){
    PaisMax <- "Colombia"
  }else if(IngChile == MontoMax){
    PaisMax <- "Chile"
  }
  #Imprimiendo resultados con el nombre del pais con mayores ingresos y el monto correspondiente
  print(paste("El pais con mayores ingreso es", PaisMax, "con montos totales de", MontoMax))
}

#Probando la funcion

MayorIng(Base_datos_empresas)

# # # # # 5. CREACI�N DE NUEVA COLUMNA CON NUEVOS REQUERIMIENTOS # # # # # # # #

#Cambiando las comas por puntos en la variable tasas de interes para poder realizar las operaciones

Base_datos_empresas$tasa_interes <- gsub("[,]",".",Base_datos_empresas$tasa_interes)

#Transformando la variable de tasas de interes de caracteres a valores numericos

Base_datos_empresas$tasa_interes <- as.numeric(Base_datos_empresas$tasa_interes)

#Creando vector que almacenara los datos de la nueva columna

nueva_tasa <- c()

#Creando loop que recorrera la base de datos

for (i in 1:nrow(Base_datos_empresas)) {
  #[INICIA LOOP]
  #Estableciendo la condicional para chile
  if(Base_datos_empresas[i,2] == "chile"){
    #Agregando al vector el resultado del calculo
    nueva_tasa <- c(nueva_tasa,(Base_datos_empresas[i,12] * 0.1))
    #Estableciendo la condicional para peru
  }else if(Base_datos_empresas[i,2] == "peru"){
    #Agregando al vector el resultado del calculo
    nueva_tasa <- c(nueva_tasa,(Base_datos_empresas[i,12] + 0.3))
    #Estableciendo la condicional para colombia
  }else if(Base_datos_empresas[i,2] == "colombia"){
    #Agregando al vector el resultado del calculo
    nueva_tasa <- c(nueva_tasa,(Base_datos_empresas[i,12] / 10))
  }
  #[FINALIZA LOOP]
}

#Generando y agregando la nueva columna con los datos obtenidos en el loop almacenados en el vector

Base_datos_empresas <- cbind(Base_datos_empresas, nueva_tasa = nueva_tasa)

# # # # # # # # # # 6. REEMPLAZO DE LA COLUMNA EXPORTACIONES # # # # # # # # #

#Se pide reemplazar  la columna exportaciones con 1 cuando es mayor a 2,1, con un 2
#cuando es menor 2,1 y un 3 cuando es igual a 2,1

#Cambiando las comas por puntos en las variables de la columna exportaciones

Base_datos_empresas$exportaciones <- gsub("[,]",".",Base_datos_empresas$exportaciones)

#Transformando la variable exportaciones de caracteres a valores numericos

Base_datos_empresas$exportaciones <- as.numeric(Base_datos_empresas$exportaciones)

#Redondeando las variables al primer decimal con funcion encontrada online

Base_datos_empresas$exportaciones <- round(Base_datos_empresas$exportaciones,1)

#Creando loop que recorrera la columna exportaciones para el reemplazo de las variables

for (r in 1:(length(Base_datos_empresas$exportaciones))) {
  #[INICA LOOP]
  #Se establece la primera condicion
  if(Base_datos_empresas$exportaciones[r] > 2.1){
    Base_datos_empresas$exportaciones[r] <- 1
  #Se establece la segunda condicion
  }else if(Base_datos_empresas$exportaciones[r] < 2.1){
    Base_datos_empresas$exportaciones[r] <- 2
  #Se establece la tercera condicion
  }else if(Base_datos_empresas$exportaciones[r] == 2.1){
    Base_datos_empresas$exportaciones[r] <- 3
  }
  #[FINALIZA LOOP]
}

# # # # # # # # 7. GRAFICANDO VARIABLES SELECCIONADAS # # # # # # # # # # # # # 

#Se deseea hacer un grafico que compare los montos de importaciones de cada pa�s para conocer visualmente las diferencias

#Transformando la variable importaciones

##Cambiando las compas por puntos
Base_datos_empresas$importaciones <- gsub("[,]",".",Base_datos_empresas$importaciones)
##Transformando la variable a valores numericos
Base_datos_empresas$importaciones <- as.numeric(Base_datos_empresas$importaciones)

#Se suman las totalidades de importaciones correspondientes a cada pais

##Estableciendo variables que almacenaran las exportaciones totales de cada pais

ImpChile <- 0
ImpColombia <- 0
ImpPeru <- 0

##Creando loop que sumara las importaciones correspondientes a la variable de cada pais

for (i in 1:nrow(Base_datos_empresas)) {
  if(Base_datos_empresas[i,2] == "chile"){
    ImpChile <- ImpChile + Base_datos_empresas[i,7]
  }else if(Base_datos_empresas[i,2] == "colombia"){
    ImpColombia <- ImpColombia + Base_datos_empresas[i,7]
  }else if(Base_datos_empresas[i,2] == "peru"){
    ImpPeru <- ImpPeru + Base_datos_empresas[i,7]
  }
}

#Creando vector que almacena las importaciones

Import <- c(ImpChile,ImpColombia,ImpPeru)

#Creando vector que almacena los paises

Country <- c("Chile","Colombia","Peru")

#Creando grafico que mostrara la informacion almacenada en ambos vectores

barplot(height = Import, names.arg = Country, main = "Importaciones por pais", ylab = "Montos $MUSD", xlab = "Pais", col = c("blue","yellow","red"))



