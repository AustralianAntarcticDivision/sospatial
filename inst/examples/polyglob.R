library(raadtools)
#http://onlinelibrary.wiley.com/doi/10.1029/2006JC004061/full
#https://www.businessinsider.com.au/polynya-hole-antarctica-sea-ice-2017-10?r=US&IR=T
#http://onlinelibrary.wiley.com/doi/10.1029/2002JC001739/full
icf <- icefiles()
dts <- icf$date[findInterval(seq(min(icf$date), max(icf$date), by = "14 days"), icf$date)]
ras <- raster(readice(inputfiles = icf))
library(dplyr)
add_date <- function(p, layer) {
  if (is.null(p)) return(NULL)
  p <- SpatialPolygonsDataFrame(p, data.frame(date = rep(getZ(layer), length(p))))
#  p$date <-  getZ(layer)
  p
}
pp <- function(x) {
  ice <- readice(x, inputfiles = icf, setNA = FALSE)
  spbabel::sptable(rasterToContour(ice, level = 15)) %>% 
    group_by(branch_) %>% mutate(n = n()) %>% ungroup() %>% filter(n < max(n)) %>% 
    spbabel::sp() %>% rgeos::gPolygonize() %>% add_date(layer = ice)
}

x <- purrr::map(dts[1:10], pp)
