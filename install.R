# install.R
packages <- c("plumber", "caret", "randomForest", "e1071", "class", 
              "rpart", "tidyverse", "MLmetrics", "pROC")

installed <- packages %in% rownames(installed.packages())
if(any(!installed)){
  install.packages(packages[!installed], repos="https://cloud.r-project.org")
}
