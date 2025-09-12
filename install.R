packages <- c("plumber", "randomForest", "fastDummies")

installed <- packages %in% rownames(installed.packages())
if(any(!installed)){
  install.packages(packages[!installed], repos = "https://cloud.r-project.org")
}
