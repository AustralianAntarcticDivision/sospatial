ice_cache <- tibble::tibble(lon = rep_len(seq(-180, 179), length.out = length(packed_lats)), 
                            lat = packed_lats/10,
                            day = rep(ice_dates, each = 360))
usethis::use_data(ice_cache, compress = "xz")
pryr::object_size(ice_cache)

iceproj <- "+proj=stere +lat_0=-90 +lat_ts=-70 +lon_0=0 +k=1 +x_0=0 +y_0=0 +a=6378273 +b=6356889.449 +units=m +no_defs"
iceproj_ll <- "+proj=longlat +a=6378273 +b=6356889.449 +no_defs"
usethis::use_data(iceproj, internal = TRUE)
usethis::use_data(iceproj_ll, internal = TRUE)
