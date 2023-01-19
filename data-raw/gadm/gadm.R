## code to prepare datasets from gadm.org

library(sf)
library(stars)
library(terra)
library(geodata)
library(rnaturalearth)
library(rmapshaper)

# outline of Costa Rica from gadm.org using the package geodata

ca_geodata <- gadm(c("CRI", "PAN", "GTM", "SLV", "HND", "NIC", "BLZ"), level = 0, path = "data-raw/gadm")

ca_geodata_to_sf <- st_as_sf(ca_geodata) |>
  dplyr::select(COUNTRY)

st_write(ca_geodata_to_sf, "data-raw/gadm/ca_gadm41.gpkg")

ca_outline <- st_read("data-raw/gadm/ca_gadm41.gpkg")

usethis::use_data(ca_outline, overwrite = TRUE)

# outline of Central America only continent

ca_outline_c <- ms_filter_islands(ca_outline, min_area = 1000000000)

usethis::use_data(ca_outline_c, overwrite = TRUE)

# Central America dissolved

ca_outline_d <- ca_outline_c |>
  st_union()

usethis::use_data(ca_outline_d, overwrite = TRUE)






