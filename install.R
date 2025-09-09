# install.R
# This script installs all required packages for the Diabetes Prediction API

packages <- c(
  "plumber",       # API framework
  "caret",         # preprocessing (dummyVars)
  "randomForest",  # model training/prediction
  "e1071",         # required by caret
  "jsonlite"       # JSON handling
)

# Install any missing packages
installed <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

cat("✅ All packages installed successfully\n")
