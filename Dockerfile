# Use R base image
FROM rocker/r-ver:4.3.1

# Install system dependencies for plumber, httpuv, sodium, etc.
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libffi-dev \
    libsodium-dev \
    libssl-dev \
    make \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install R packages
RUN Rscript install.R

# Expose Plumber port
EXPOSE 8000

# Run the Plumber API
CMD ["Rscript", "-e", "library(plumber); pr <- plumber::plumb('plumber_api.R'); pr$run(host='0.0.0.0', port=8000)"]
