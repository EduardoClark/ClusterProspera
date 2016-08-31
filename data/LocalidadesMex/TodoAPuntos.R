setwd("~")

require(rgdal)
require(rgeos)

urbanas <- readOGR("/Users/eduardofierro/Dropbox/UI/DatosLecturasDos/Shapefiles/INEGI/LocalidadesMex/LOCALIDADES_URBANAS/POLIGONOS_URBANOS.shp", "POLIGONOS_URBANOS")
rurales <- readOGR("/Users/eduardofierro/Dropbox/UI/DatosLecturasDos/Shapefiles/INEGI/LocalidadesMex/LOCALIDADES_RURALES/LOCALIDADES_RURALES.shp", "LOCALIDADES_RURALES")

urbanas.centroide <- SpatialPointsDataFrame(gCentroid(urbanas, byid=T), urbanas@data,  proj4string=CRS(proj4string(urbanas)))

rurales@data$CVE_AGEB <- NULL

rurales@data$tipo <- "Rural"
urbanas.centroide@data$tipo <- "Urbana"

todas <- rbind(urbanas.centroide, rurales)

writeOGR(todas, "/Users/eduardofierro/Dropbox/UI/DatosLecturasDos/Shapefiles/INEGI/LocalidadesMex/LocalidadesPuntos.shp", "LocalidadesPuntos", driver="ESRI Shapefile")
