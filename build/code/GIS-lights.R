rm(list = ls())

library(sp)
library(raster)
library(rgdal)
library(rgeos)
library(maptools)
library(dplyr)
library(reshape)
library(tmap)

setwd("~/Documents/Programs/R-general/GIS-lights-data")

#Read in Data
#Lights raster data
lights <- raster("./build/input/lights-data-2013/F182013.v4c_web.stable_lights.avg_vis.tif") #cleaned up version of avg_vis files

#US Borders data
borders <- readOGR(dsn = path.expand("~/Documents/Programs/R-general/GIS-lights-data/build/input/us-national-borders"), layer = "USA_adm0")

#Testing-plot lights data, US borders
plot(lights)
plot(borders, add = T) #they don't align, but resolutions seem to map ok.

#NPS shapefiles
