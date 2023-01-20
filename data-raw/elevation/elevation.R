## Code to get elevation data for Central America

library(sf)
library(stars)
library(terra)
library(geodata)
library(rnaturalearth)
library(rmapshaper)
library(here)

# Elevation data of Central America from the geodata package

elevation_30s(country = c("CRI"), path = "data-raw/elevation")

elevation_30s(country = c("PAN"), path = "data-raw/elevation")

elevation_30s(country = c("GTM"), path = "data-raw/elevation")

elevation_30s(country = c("SLV"), path = "data-raw/elevation")

elevation_30s(country = c("HND"), path = "data-raw/elevation")

elevation_30s(country = c("NIC"), path = "data-raw/elevation")

elevation_30s(country = c("BLZ"), path = "data-raw/elevation")

r1 <- rast("data-raw/elevation/CRI_elv_msk.tif")
r2 <- rast("data-raw/elevation/PAN_elv_msk.tif")
r3 <- rast("data-raw/elevation/GTM_elv_msk.tif")
r4 <- rast("data-raw/elevation/SLV_elv_msk.tif")
r5 <- rast("data-raw/elevation/HND_elv_msk.tif")
r6 <- rast("data-raw/elevation/NIC_elv_msk.tif")
r7 <- rast("data-raw/elevation/BLZ_elv_msk.tif")

ras <- mosaic(r1, r2, r3, r4, r5, r6, r7)

writeRaster(ras, "data-raw/elevation/ca_elevation.tif", overwrite = TRUE)

# I deleted all the country rasters and left the mosaic

ca_elevation <- read_stars(here("data-raw/elevation/ca_elevation.tif")) |>
  st_crop(ca_outline_d)

usethis::use_data(ca_elevation, overwrite = TRUE)
