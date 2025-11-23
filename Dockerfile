FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies (ffmpeg + libs for opencv/mediapipe)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       ffmpeg \
       build-essential \
       libgl1 \
       libglib2.0-0 \
       libsm6 \
       libxrender1 \
       libxext6 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt /app/requirements.txt

# Upgrade pip and install PyTorch CPU wheel first (reduces chance of building from source).
# Using PyTorch's CPU wheel index; change if you need CUDA-enabled build.
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -f https://download.pytorch.org/whl/cpu/torch_stable.html torch \
    && pip install --no-cache-dir -r /app/requirements.txt

# Copy dataset into image (this will make the image large). If you prefer mounting dataset from host,
# remove the next COPY and use the run examples in DOCKER_RUN.md that mount `/data`.
# The dataset in the repo will be available at `/data` inside the container.
COPY dataset/ /data/

# Set OUTPUT_DIR to the dataset path inside the container by default
ENV OUTPUT_DIR=/data/stgcn_dataset

# Copy code folder
COPY code/ /app/code/

# Default workdir
WORKDIR /app

# By default, do nothing useful; user runs the script they need.
CMD ["bash","-c","echo 'Image built (contains dataset). Use run commands in DOCKER_RUN.md to execute scripts.'"]
