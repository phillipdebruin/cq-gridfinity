# Use the latest Python LTS image as the base
FROM --platform=linux/amd64 python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Update the system and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libgl1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Install Python dependencies
RUN pip install --no-cache-dir \
    cqkit \
    https://github.com/CadQuery/cadquery/archive/master.zip

COPY . .
RUN pip install .
RUN rm -rf /app/*

# Default command allows flexibility for all cq-gridfinity CLI commands
CMD ["gridfinitybox"]
