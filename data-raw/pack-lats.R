cl <- readRDS("data-raw/cl_.rds")

## pack and compress the raw latitudes
packed_lats <- as.integer(round(unlist(cl) * 10))
devtools::use_data(packed_lats, compress = "xz")
