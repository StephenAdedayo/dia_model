# Install packages
source("install.R")

# Load plumber API and run
library(plumber)
pr <- plumber::plumb("plumber_api.R")
pr$run(host = "0.0.0.0", port = 8000)
