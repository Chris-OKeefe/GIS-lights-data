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
us_borders <- getData('GADM', country = "USA", level = 0)
#borders <- readOGR(dsn = path.expand("~/Documents/Programs/R-general/GIS-lights-data/build/input/us-national-borders"), layer = "USA_adm0")

#Plot lights data, US borders
#pdf("lights-test.pdf")#not sure if it's worth investing in making map look good.
#        plot(lights, xaxt = 'n', yaxt = 'n')
#        plot(us_borders, add = T, lwd = .25) 
#dev.off()

#Cropping
lights_crop <- crop(lights, extent(us_borders)) #may not work, gives an error & IDK how to check results
lights_crop <- mask(lights_crop, us_borders) #makes sure GIS features from raster properly associated with new object. Seems to take a long time

#then re-do plot like in above
#pdf("lights-test-us.pdf")
    plot(lights_crop, xaxt = 'n', yaxt = 'n')
    #plot(us_borders, add = T, lwd = .25) 
#dev.off()

#NPS shapefiles
nps <- readOGR(dsn = path.expand("~/Documents/Programs/R-general/GIS-lights-data/build/input/nps-boundaries"), layer = "nps_boundary")
nps_84 <- spTransform(nps, crs(us_borders))

#pdf("lights-test-nps.pdf")