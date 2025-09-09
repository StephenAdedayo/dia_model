# Use official R base image
FROM rocker/r-ver:4.3.1

# Install system dependencies
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all project files
COPY . /app

# Install R dependencies
RUN Rscript install.R

# Expose port for Render
EXPOSE 8000

# Run Plumber API
CMD ["Rscript", "-e", "library(plumber); pr <- plumber::plumb('plumber_api.R'); pr$run(host='0.0.0.0', port=8000"]
