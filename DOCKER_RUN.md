Docker build & run instructions (PowerShell)

Prerequisites
- Docker Desktop installed and running on Windows.

There are two modes now:

- **Mount dataset from host (recommended)** — image stays small and dataset remains on the host.
- **Include dataset inside the image (packaged)** — image will be large but self-contained. The repository here now supports packaging the `dataset/` folder into the image.

1) Build image that INCLUDES dataset (self-contained)

Run from repository root `d:\MultiVSL\MultiVSL`:

```powershell
docker build -t multivsl:with-data .
```

Notes: this will copy the repository `dataset/` into the image at `/data` and set `OUTPUT_DIR=/data/stgcn_dataset` by default. The build context will be larger and the build may take significantly longer.

Run training using the packaged dataset (no host dataset mount required):

```powershell
docker run --rm -it \
  -v "${PWD}:/app" `
  -w /app \
  multivsl:with-data \
  bash -c "python code/train_stgcn.py"
```

Run extract frames (ffmpeg is installed inside image):

```powershell
docker run --rm -it -v "${PWD}:/app" -w /app multivsl:with-data bash -c "python code/extract_image.py"
```

2) Build image WITHOUT dataset (mount dataset at runtime) — original recommended flow

```powershell
docker build -t multivsl:latest .
```

Run training (mount host dataset at `/data` and override `OUTPUT_DIR`):

```powershell
docker run --rm -it \
  -v "${PWD}:/app" \
  -v "D:\MultiVSL\MultiVSL\dataset:/data" \
  -e OUTPUT_DIR=/data/stgcn_dataset \
  -w /app \
  multivsl:latest \
  bash -c "python code/train_stgcn.py"
```

Notes & troubleshooting
- Image size: packaging the dataset produces a large image. If your dataset is big, prefer mounting or using Docker volumes (see below).
- GPU: packaged image is CPU-only. For GPU support you must install the CUDA-compatible `torch` wheel and run with the `--gpus` flag (requires nvidia container toolkit).
- MediaPipe: `pip install mediapipe` may fail on some platforms; if so, prefer running the pipeline on the host or follow MediaPipe Linux install docs.
- Webcam/GUI: running `test_webcam.py` inside Docker on Windows is not guaranteed — prefer running on the host for webcam/GUI.

Optional: copy dataset into a Docker volume (keeps image smaller and dataset in Docker-managed storage)

```powershell
docker volume create multivsl_data
docker run --rm -v multivsl_data:/data -v "D:\MultiVSL\MultiVSL\dataset:/import" busybox sh -c "cp -a /import/. /data/"

docker run --rm -it -v "${PWD}:/app" -v multivsl_data:/data -e OUTPUT_DIR=/data/stgcn_dataset -w /app multivsl:latest bash -c "python code/train_stgcn.py"
```

If you want I can also:
- Add a small `run.ps1` wrapper to simplify the long run commands.
- Pin package versions in `requirements.txt` and add a separate `Dockerfile.cpu` / `Dockerfile.gpu` for CUDA wheels.

