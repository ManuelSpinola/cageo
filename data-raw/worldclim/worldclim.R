## Code to get worldclim data for Central America

library(sf)
library(stars)
library(terra)
library(geodata)
library(rnaturalearth)
library(rmapshaper)
library(here)

# Minimum temperature for Central America

ca_outline_d_t <- vect(ca_outline_d)

worldclim_tile(var = "tmin", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "tmin", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "tmax", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "tmax", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "tavg", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "tavg", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "prec", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "prec", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "srad", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "srad", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "vapr", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "vapr", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "wind", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "wind", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "bio", lon = -84.2541844, lat = 9.6301892, res = 0.5, path = "data-raw/worldclim")

worldclim_tile(var = "bio", lon = -90.522713, lat = 14.628434, res = 0.5, path = "data-raw/worldclim")

tmin_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_tmin.tif"))

tmin_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_tmin.tif"))

tmax_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_tmax.tif"))

tmax_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_tmax.tif"))

tavg_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_tavg.tif"))

tavg_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_tavg.tif"))

prec_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_prec.tif"))

prec_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_prec.tif"))

srad_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_srad.tif"))

srad_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_srad.tif"))

wind_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_wind.tif"))

wind_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_wind.tif"))

bio_a <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_28_wc2.1_30s_bio.tif"))

bio_b <- rast(here("data-raw/worldclim/wc2.1_tiles/tile_27_wc2.1_30s_bio.tif"))


tmin <- mosaic(tmin_a, tmin_b)
tmax <- mosaic(tmax_a, tmax_b)
tavg <- mosaic(tavg_a, tavg_b)
prec <- mosaic(prec_a, prec_b)
srad <- mosaic(srad_a, srad_b)
wind <- mosaic(wind_a, wind_b)
bio <- mosaic(bio_a, bio_b)


tmin_c <- crop(tmin, ca_outline_d_t)
tmax_c <- crop(tmax, ca_outline_d_t)
tavg_c <- crop(tavg, ca_outline_d_t)
prec_c <- crop(prec, ca_outline_d_t)
srad_c <- crop(srad, ca_outline_d_t)
wind_c <- crop(wind, ca_outline_d_t)
bio_c <- crop(bio, ca_outline_d_t)

tmin_m <- mask(tmin_c, ca_outline_d_t)
tmax_m <- mask(tmax_c, ca_outline_d_t)
tavg_m <- mask(tavg_c, ca_outline_d_t)
prec_m <- mask(prec_c, ca_outline_d_t)
srad_m <- mask(srad_c, ca_outline_d_t)
wind_m <- mask(wind_c, ca_outline_d_t)
bio_m <- mask(bio_c, ca_outline_d_t)


ca_tmin <- st_as_stars(tmin_m)
ca_tmax <- st_as_stars(tmax_m)
ca_tavg <- st_as_stars(tavg_m)
ca_prec <- st_as_stars(prec_m)
ca_srad <- st_as_stars(srad_m)
ca_wind <- st_as_stars(wind_m)
ca_bio <- st_as_stars(bio_m)


usethis::use_data(ca_tmin, overwrite = TRUE)
usethis::use_data(ca_tmax, overwrite = TRUE)
usethis::use_data(ca_tavg, overwrite = TRUE)
usethis::use_data(ca_prec, overwrite = TRUE)
usethis::use_data(ca_srad, overwrite = TRUE)
usethis::use_data(ca_wind, overwrite = TRUE)
usethis::use_data(ca_bio, overwrite = TRUE)


