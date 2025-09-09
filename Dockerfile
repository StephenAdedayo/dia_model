# Use official R base image
FROM rocker/r-ver:4.3.1

# Install system dependencies
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install plumber
RUN R -e "install.packages('plumber', repos='https://cloud.r-project.org')"

# Copy your project files into the container
WORKDIR /app
COPY . /app

# Install other R dependencies from install.R
RUN Rscript install.R

# Expose port
EXPOSE 8000

# Run the API
CMD ["Rscript", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]
