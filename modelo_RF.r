# Modelo RF simples para a classificação de um raster a partir de informações extraidas de pontos amostrais coletados.

# instalando as bibliotecas:
install.packages("randomForest")
install.packages("sf")
install.packages("tidyverse")
install.packages("raster")
install.packages("tiff")
install.packages("magrittr")
library(magrittr)
library(randomForest)
library(sf)
library(tidyverse)
library(raster)
library(tiff)

# Carregando os dados: ----
# raster
setwd("C:/meu_diretorio/tif_wgs")
img <- stack(list.files(".", pattern = ".tif$", full.names = T))

plotRGB(img, 4, 2, 1, stretch = 'hist') #para uma imagem pleiades, blue=1, green=2, nir=3, red=4
names(img) <- paste0(rep('band', nlayers(img)), 1:nlayers(img))


# amostras
setwd("C:/meu_diretorio/shapes_wgs")
c1 <- read_sf("classe1.shp")
c2 <-read_sf("classe2.shp")
c3 <-read_sf("classe3.shp")
c4 <-read_sf("classe4.shp")
amostras<-rbind(c1, c2, c3, c4)
plot(amostras, add=T)
x <- c(1:20000)  
amostras<-cbind(amostras,x)

# Amostras de treino de teste ----
teste <- amostras %>% group_by(classe) %>% sample_n(size = 1500 ) #note que "classe" é um atributo de cada entrada do conjunto de dados
#1500 amostras de teste por classe
treino <- amostras %>% filter(! x %in% (teste$x))
nrow(treino)
nrow(teste)

# Extração de dados: ----
valsTrain <- raster::extract(img,treino)
valsTest <- raster::extract(img, teste)

head(valsTrain)
head(valsTest)

valsTrain <- data.frame(valsTrain, treino$classe)
valsTest <- data.frame(valsTest, teste$classe)
head(valsTrain)
head(valsTest)
names(valsTrain)[ncol(valsTrain)] <- "class"
names(valsTest)[ncol(valsTest)] <- "class"

valsTrain$class <- as.factor(valsTrain$class)
valsTest$class <- as.factor(valsTest$class)

class(valsTrain$class)

# Criando modelo randomForest ----
rf.mdl <- randomForest(valsTrain$class ~., data = valsTrain, xtest = subset(valsTest, select = -class), ytest = valsTest$class, keep.forest = TRUE)

#confusionMatrix da fase de treinamento
setwd("C:/meu_diretorio")
rf.mdl$confusion 

options(max.print = 6000)

#cálculo do kappa nos dados de teste
rf.mdl$test$predicted
write.table(rf.mdl$test$predicted, file = "testPredicted.txt", sep = "\t")

install.packages("irr",dependencies = T)
library(irr)

dadoskappa<-read.table("testPredicted.txt", header = T)
kappa2(dadoskappa)

# plot da importância das bandas
getTree(rf.mdl, k=1)
varImpPlot(rf.mdl)

# Classificação ----
rf.class <- raster::predict(img, rf.mdl, progress = "text", type = "response")

# Salvando classificação: ----
writeRaster(rf.class, "rf_ClassificationCrossValidation.tif", overwrite = TRUE) 
