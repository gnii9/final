# Use Python 3.12 (compatible with mediapipe)
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    default-libmysqlclient-dev \
    pkg-config \
    libgl1 \
    libglib2.0-0 \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements_docker.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements_docker.txt

# Copy application code
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create logs directory
RUN mkdir -p logs

# Expose ports
EXPOSE 8000 8001

# Use entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
