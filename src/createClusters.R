#######################################
##### Project: Create locality clusters 
##### Date: August 2016
#######################################

#Load Libraries
source("src/loadlibraries.R")

#Read locality point dataset
PuntosLocalidades <- readOGR("data","puntoslocalidadeslatlon")
PuntosLocalidades <- cbind(PuntosLocalidades@data,PuntosLocalidades@coords)
PuntosLocalidades$CVE <- paste(PuntosLocalidades$CVE_ENT,PuntosLocalidades$CVE_MUN,PuntosLocalidades$CVE_LOC,sep="")
ListaLocalidades <- paste(PuntosLocalidades$CVE_ENT,PuntosLocalidades$CVE_MUN,PuntosLocalidades$CVE_LOC,sep="")

#Function to compute clusters for any given kilometer cut
Grupos <- function(X,Y){
TMP <- PuntosLocalidades[PuntosLocalidades$CVE==ListaLocalidades[X],]
Prueba <- PuntosLocalidades[abs(PuntosLocalidades$coords.x1 - TMP[1,6])<.1 & abs(PuntosLocalidades$coords.x2 - TMP[1,7])<.1 ,]
if(nrow(Prueba)==1){
  Prueba <- rbind(Prueba,Prueba)
}
Prueba1 <- earth.dist(Prueba[,c(6,7)])
Dend <- hclust(Prueba1,method = "complete")
Prueba$Grupo <- as.character(cutree(Dend, h=Y))
Prueba <- Prueba[Prueba$Grupo==Prueba[Prueba$CVE==ListaLocalidades[X],9],]
Prueba$Grupo <- ListaLocalidades[X]
Prueba <- Prueba[,c(8,9)]
print( (X  / length(ListaLocalidades) * 100))
return(Prueba)
}


#Run for 1-10 Kilometers
Grupos1K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=1))
write.csv(Grupos1K,"G1K.csv",row.names=FALSE);remove(Grupos1K)
Grupos2K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=2))
write.csv(Grupos2K,"G2K.csv",row.names=FALSE);remove(Grupos2K)
Grupos3K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=3))
write.csv(Grupos3K,"G3K.csv",row.names=FALSE);remove(Grupos3K)
Grupos4K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=4))
write.csv(Grupos4K,"G4K.csv",row.names=FALSE);remove(Grupos4K)
Grupos5K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=5))
write.csv(Grupos5K,"G5K.csv",row.names=FALSE);remove(Grupos5K)
Grupos6K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=6))
write.csv(Grupos6K,"G6K.csv",row.names=FALSE);remove(Grupos6K)
Grupos7K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=7))
write.csv(Grupos7K,"G7K.csv",row.names=FALSE);remove(Grupos7K)
Grupos8K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=8))
write.csv(Grupos8K,"G8K.csv",row.names=FALSE);remove(Grupos8K)
Grupos9K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=9))
write.csv(Grupos9K,"G9K.csv",row.names=FALSE);remove(Grupos9K)
Grupos10K <- bind_rows(lapply(1:length(ListaLocalidades), Grupos,Y=10))
write.csv(Grupos10K,"G10K.csv",row.names=FALSE);remove(Grupos10K)
remove(list=ls())

