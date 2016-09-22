library(sp)
library(raster)
library(rgdal)
library(rgeos)
library(maptools)
library(dplyr)
library(reshape)
library(tmap)

rm(list = ls())

#Read in Data
#Lights raster data
lights <- raster("./build/input/lights-data-2013/F182013.v4c_web.stable_lights.avg_vis.tif") #cleaned up version of avg_vis files
crs_lights = crs(lights)

#US Borders data
borders <- readOGR(dsn = path.expand("~/Documents/Programs/R-general/GIS-lights-data/build/input/us-national-borders"), layer = "cb_2015_us_nation_5m")
borders_wgs84 <- spTransform(borders, crs_lights) #convert borders to wgs84 (from NAD83)

#Testing-plot lights data, US borders
plot(lights)
plot(borders_wgs84, add = T) #they don't align, but resolutions seem to map ok.

#NPS shapefiles
