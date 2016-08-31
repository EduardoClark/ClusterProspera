#######################################
##### Project: Create locality clusters 
##### Date: August 2016
#######################################

##Join Clusters
Cluster <- read.csv("data-out/G5K.csv",stringsAsFactors = FALSE)
Cluster1 <- Cluster %>% group_by(Grupo) %>% summarise(Unico=paste(arrange(CVE),collapse = ","))
Cluster <- left_join(Cluster,Cluster1)
Cluster$Grupo <- NULL
Cluster <- unique(Cluster)




TMP <- Cluster[Cluster$Grupo=="60091226",]s
TMP1 <- Cluster[Cluster$Grupo=="60090968",]

Clusters <- 






Test <- Cluster[Cluster$Grupo=="110080001",]
TestHull <- chull(Test[,c(5,6)])
TestHull <- Test[c(TestHull,TestHull[1]),]
TestHull$Order <- 1:nrow(TestHull)
GG <- get_map("Manuel Doblado, Guanajuato",zoom = 12)
G1 <- ggmap(GG) + geom_point(aes(x=coords.x1,y=coords.x2),data=Test) +
  geom_polygon(aes(x=coords.x1,y=coords.x2,order=Order),data=TestHull,fill="black",alpha=.3) 
  ge


plot(G1)
G1 <- ggmap(Celaya) + geom_point(aes(x=coords.x1,y=coords.x2),data=Test) +
  geom_polygon(aes(x=coords.x1,y=coords.x2,order=Order),data=TestHull,alpha=.3,fill="black")
