#' Stereographic south polar grid
#' 
#' Generate a grid at one of a set of common resolutions. The input `res` is the resolution
#' in kilometres. The grid is carefully aligned to `x = 0` so that cell edges intersect exactly 
#' with the prime meridan and the dateline. 
#' 
#' Currently `res` must be one of 24, 16, 8, 4, 1. 
#' @export
#' @export
#' @examples
#' stere_grid()
#' stere_grid(16)
stere_grid <- function(res = 24) {
  stopifnot(res %in% c(24, 16, 8, 4, 1))
  #resolutions <- c(24000, 16000, 8000, 4000, 1000)
  ## make sure this is TRUE so we don't sample from the dateline exactly
  offset <- 8688000
  #all(((offset / resolutions) - (offset %/% resolutions)) == 0)
  prj <- "+proj=stere +lat_0=-90 +lat_ts=-71 +datum=WGS84 +x_0=0 +y_0=0 +ellps=WGS84 +towgs84=0,0,0"
  raster::raster(extent(-offset, offset, -offset, offset), res = res * 1000, crs = prj)
}
