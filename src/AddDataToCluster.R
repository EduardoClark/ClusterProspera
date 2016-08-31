#######################################
##### Project: Create locality clusters 
##### Date: August 2016
#######################################

##Add population and coordinates to each cluster db
#List cluster db
Clusters <- list.files("data-out/",pattern = "K.csv",full.names = TRUE)

#Load population and point data
PuntosLocalidades <- readOGR("data","puntoslocalidadeslatlon")
PuntosLocalidades <- cbind(PuntosLocalidades@data,PuntosLocalidades@coords)
PuntosLocalidades$CVE <- paste(PuntosLocalidades$CVE_ENT,PuntosLocalidades$CVE_MUN,PuntosLocalidades$CVE_LOC,sep="")
PuntosLocalidades <- PuntosLocalidades[,c(6:8)]
Censo <- foreign::read.dbf("data/ITER_NALDBF10.dbf",as.is = TRUE)
Censo <- Censo %>% mutate(CVE=paste(ENTIDAD,MUN,LOC,sep="")) %>% select(CVE,POBTOT)

#Function to append data
AddDataToCluster <- function(X){
  TMP <- read.csv(Clusters[X],stringsAsFactors = FALSE)
  TMP$CVE <- formatC(TMP$CVE,width = 9,flag = 0)
  TMP <- left_join(TMP,Censo)
  TMP1 <- TMP %>% group_by(Grupo) %>% summarise(POBTOTGRUPO=sum(as.numeric(as.character(POBTOT)),na.rm = TRUE))
  TMP <- left_join(TMP,TMP1)
  remove(TMP1)
  TMP <- left_join(TMP,PuntosLocalidades)
  write.csv(TMP,Clusters[X],row.names = FALSE)
  print(paste(Clusters[X],"written"))
}

#Run function for the clusters
lapply(1:length(Clusters), AddDataToCluster)
remove(list=ls())
