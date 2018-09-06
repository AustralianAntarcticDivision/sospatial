
#' @importFrom spbabel sp
#' @importFrom sf st_as_sf
read_ice_ex <- function(date, latest = TRUE, ...) {
  if (is.null(date) || missing(date)) {
    date <- if (latest) max(ice_dates) else min(ice_dates)
  }
  #prjstere <- "+proj=stere +lat_0=-90 +datum=WGS84"
  #ice[c("x", "y")] <- rgdal::project(as.matrix(ice[c("lon", "lat")]), prjstere)
  ind <- which( as.Date(ice_cache$day) %in% as.Date(date))
  dplyr::slice(ice_cache, ind) %>% 
    dplyr::filter(!is.na(lat))
}

read_ice_ex_sp <- function(date = NULL, latest = TRUE, ...) {
  
  ice <- read_ice_ex(date, latest = latest, ...)
  ice %>% dplyr::mutate(object_ =as.integer(factor(day)), 
                        branch_ = object_, 
                        order_ = dplyr::row_number()) %>% 
    dplyr::rename(x_ = lon, y_ = lat) %>% spbabel::sp(crs = iceproj_ll)
}

read_ice_ex_sf <- function(date = NULL, latest = TRUE, ...) {
 read_ice_ex_sp(date = date, latest = latest, ...) %>% sf::st_as_sf() 
}