## code to prepare datasets from gadm.org

library(sf)
library(stars)
library(terra)
library(geodata)
library(rnaturalearth)
library(rmapshaper)

# outline of Costa Rica from gadm.org using the package geodata

na <- ne_countries(continent = "north america", scale = 10, returnclass = "sf")

ca <- na |> dplyr::filter(iso_a3 %in% c("CRI", "PAN", "NIC", "GTM", "BLZ", "SLV", "HND"))

ca <- dplyr::select(COUNTRY)

st_write(ca, "data-raw/rnaturalearth/ca.gpkg", delete_layer = TRUE)

ca_outline <- st_read("data-raw/rnaturalearth/ca.gpkg")

usethis::use_data(ca_outline, overwrite = TRUE)

# outline of Central America only continent

ca_outline_c <- ms_filter_islands(ca_outline, min_area = 1000000000)

usethis::use_data(ca_outline_c, overwrite = TRUE)

# Central America dissolved

ca_outline_d <- ca_outline_c |>
  st_union()

usethis::use_data(ca_outline_d, overwrite = TRUE)
