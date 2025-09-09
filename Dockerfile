# Use official R base image
FROM rocker/r-ver:4.3.1

# Install system dependencies required by R packages
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcairo2-dev \
    libv8-dev \
    unixodbc-dev \
    gfortran \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install R packages
RUN Rscript install.R

# Expose port
EXPOSE 8000

# Run plumber API
CMD ["Rscript", "-e", "library(plumber); pr <- plumber::plumb('plumber_api.R'); pr$run(host='0.0.0.0', port=8000)"]
