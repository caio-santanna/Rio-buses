library('rgeos')
library('maptools')
library('rgdal')
library("sp")
library('geosphere')

# Calcular ângulo entre vetores
angle <- function(x,y){
  x <- as.matrix(t(x))
  y <- as.matrix(y)
  dot.prod <- x%*%y 
  norm.x <- norm(x,type="2")
  norm.y <- norm(y,type="2")
  theta <- acos(dot.prod / (norm.x * norm.y))
  as.numeric(theta)
}

dist2d <- function(a,b,c) {
  v1 <- b - c
  d <- abs( (c[2]-b[2])*a[1] - (c[1]-b[1])*a[2] + c[1]*b[2] - c[2]*b[1]) /sqrt(sum(v1*v1))
  return(d)
} 

#Converter coordenadas para UTM
UTM.function<-function(data){
  sp<-SpatialPoints(coords=data, proj4string = CRS(as.character(NA)))
  proj4string(sp) <- CRS("+init=epsg:4326") 
  result<-spTransform(sp, CRS(paste("+proj=utm +south +zone=",23,"ellps=WGS84",sep='')))
  return(as.data.frame(result))
}

trajetorias.onibus<-function(linha='321'){
  indice<-which(total_linhas==linha)
  trajetorias=list()
  for(i in 1:length(alist[[indice]])){
    coords<- matrix(NA,ncol=2,nrow=nrow(alist[[indice]][[i]])+1)
    #Colunas 5 e 4 fornecem as coordenadas de cada ponto
    coords[1,]<-c(data_bus[[indice]][alist[[indice]][[i]][1,1],5],data_bus[[indice]][alist[[indice]][[i]][1,1],4])
    for(j in 1:nrow(alist[[indice]][[i]])){
      coords[j+1,]<-c(data_bus[[indice]][alist[[indice]][[i]][j,2],5],data_bus[[indice]][alist[[indice]][[i]][j,2],4])
    }
    trajetorias[[i]]<-coords[complete.cases(coords),]
  }
  return(trajetorias)
}