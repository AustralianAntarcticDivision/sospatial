cl <- readRDS("data-raw/cl_.rds")

## pack and compress the raw latitudes
packed_lats <- as.integer(round(unlist(cl) * 10))
usethis::use_data(packed_lats, compress = "xz", overwrite = TRUE)
