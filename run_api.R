library(plumber)

pr <- plumb("plumber_api.R")
pr$run(host = "0.0.0.0", port = as.numeric(Sys.getenv("PORT", 8000)))
