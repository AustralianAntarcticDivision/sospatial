#' sospatial.
#'
#' @name sospatial
#' @docType package
NULL

#' packed_lats
#'
#' A vector of reduced precision latitudes, stored as 10* decimal latitude from
#' contouring NSIDC 25km sea ice extent. The vector is in groups of 360 from
#' longitude in whole numbers from -180 to 179 inclusive. There were  12538 days
#' of these data on 2017-11-10 (since 1978-10-26). The cached data will be
#' updated now and then, we are exploring ways to make this more convenient and
#' it would be good to include the northern hemisphere as well.
#'
#' This is not enough information to reconstruct the entire sequence, because
#' the earliest years are two-daily, and there's a several week gap in 1987 or
#' so so the dates will also need to be encoded explicitly in the package (or we
#' will provide interpolated latitudes for the gaps).
#' @name packed_lats
#' @docType data
NULL



