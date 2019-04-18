library(raadtools)
library(dplyr)
files <- readice(returnfiles = TRUE) #%>% 
files <- dplyr::filter(files, as.Date(date) > as.Date(max(ice_dates)))
ice_dates_new <- files$date

#  filter(date >= as.POSIXct("2008-02-15")) %>% 
#  filter(between(as.integer(format(date, "%m")), 6, 11))
#library(sf)
get_lat <- function(date) {
  ice <- readice(date, setNA = FALSE, inputfiles = files)
  edge <- raadtools:::keepOnlyMostComplexLine( rasterToContour(ice, level = 15))
  edgell <- sp::spTransform(edge, "+init=epsg:4326")
  #edgell <- spbabel::sptable(st_transform(edge, 4326))
  ## decompose to coordinates (... but the coordinates are fine)
  coords <- ggplot2::fortify(edgell)
  reglons <- seq(-180, 179)
  # approxfun(coords$x_, coords$y_)(reglons)
   approxfun(coords$long, coords$lat)(reglons)

}
system.time(cl <- furrr::future_map(files$date, get_lat))

ice_dates <- c(ice_dates, ice_dates_new)
cl_old <- readRDS("data-raw/cl_.rds")
cl <- c(cl_old, cl)
usethis::use_data(ice_dates, overwrite = TRUE)

saveRDS(cl, "data-raw/cl_.rds")



