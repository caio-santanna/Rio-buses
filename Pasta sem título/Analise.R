library('rgeos')
library('maptools')
library('rgdal')
library("sp")
library('geosphere')
library('RPostgreSQL')
library('graphics')
library('e1071')
library('kernlab')

#source('/home/santanna/Documents/Projeto/read.data.bus.R',encoding='UTF-8')
#source('/home/santanna/Documents/Projeto/def.trajectories.R',encoding='UTF-8')
source('/home/santanna/Documents/Projeto/functions.project.R',encoding='UTF-8')

###Salvando data_bus na base PostgreSQL
pg = dbDriver("PostgreSQL")
conn <- dbConnect(pg, user="postgres", password='postgres',dbname='postgres',
                  host="localhost",port=5432)
for(i in 1:length(data_bus)){
  aux<-as.data.frame(data_bus[[i]])
  colnames(aux)<-colnames(df_linha)
  dbWriteTable(conn, total_linhas[i], aux)
}

#Lendo uma tabela
df_321 <- dbReadTable(conn,'321')







len<-matrix(NA, ncol=length(trajetorias),nrow=1)
for(i in 1:length(trajetorias)){
  len[i]<-nrow(trajetorias[[i]])
}
indice<-order(len,decreasing = TRUE)

# Determinação de trajetórias de ida e volta ##############
#Espacialização de dados##############
#Pontos
data_321$Date<-as.character(data_321$Date)
data_321$Time<-as.character(data_321$Time)
obj<-SpatialPointsDataFrame(coords=cbind(data_321$longitude,data_321$latitude), data=data_321, coords.nrs = numeric(0), 
                            proj4string = CRS(as.character(NA)), match.ID = TRUE)
writePointsShape(x=obj, fn=paste("/home/santanna/Documents/Projeto/Dados espacializados/","321",sep=""), factor2char = TRUE, max_nchar=254)

a<-"obrigado"
a<-as.data.frame(a)
teste<-Line(coords)
linha<-Lines(list(teste),ID='a')
S1<-SpatialLines(list(linha))

plot(S1)
a.df<-data.frame(len='1')
rownames(a.df)<-"a"

teste.dataframe<-SpatialLinesDataFrame(S1,data=a.df)

writeLinesShape(teste.dataframe, "/home/santanna/Documents/Projeto/Dados espacializados/teste321-2", factor2char = TRUE, max_nchar=254)
spplot(teste,type='l')


obj<-SpatialPoints(coords=coords, proj4string = CRS(as.character(NA)))
obj<-SpatialPointsDataFrame(coords=coords, data=as.data.frame(coords), coords.nrs = numeric(0), 
                            proj4string = CRS(as.character(NA)), match.ID = TRUE)
writePointsShape(x=obj, fn=paste("/home/santanna/Documents/Projeto/Dados espacializados/","teste 321 2",sep=""), factor2char = TRUE, max_nchar=254)




