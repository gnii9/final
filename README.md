# Project: Frontend + Backend + Model (MultiVSL)

This repository contains three main folders you mentioned:

- `frontend-react` — front-end React app (if present).
- `backend` — backend service (check for language/runtime inside this folder).
- `model` (this repo contains model code under `code/`, dataset, and Dockerfile).

This README explains how to prepare the repository for GitHub, recommended approach for the dataset, and how to run each component locally or with Docker.

---

## 1) Before pushing to GitHub — recommendations

- If your `dataset/` is large (>100 MB), do NOT commit it to GitHub directly. Options:
  - Use Git LFS: `git lfs install` then track files (see below).
  - Host dataset externally (Google Drive, S3, or a release asset) and keep only download script / manifest in the repo.
  - Package dataset inside Docker image (this repo already includes a `Dockerfile` that copies `dataset/` into the image). Note this makes the image large and increases build/upload time.

- By default this repo's `.gitignore` excludes `dataset/`. If you want to include dataset in Git, remove `dataset/` from `.gitignore` and consider Git LFS.

### Git LFS example (recommended for large files)

```powershell
# install and enable Git LFS (one-time)
git lfs install

# track dataset folder (run once)
git lfs track "dataset/**"
git add .gitattributes
git commit -m "Track dataset with LFS"
```

Note: Git LFS requires that the Git server supports LFS (GitHub does).

---

## 2) Files added to help push & run

- `.gitignore` — top-level, ignores venv, node_modules and `dataset/` by default.
- `.gitattributes` — suggests Git LFS for `dataset/` (you must run `git lfs track` yourself).
- `run_all.ps1` — PowerShell helper to build Docker images for frontend/backend/model.
- `DOCKER_RUN.md` — detailed Docker build/run instructions (model already has a `Dockerfile`).

---

## 3) How to initialize git and push to GitHub (PowerShell)

1. From repository root `d:\MultiVSL\MultiVSL`:

```powershell
# initialize repo (if not a git repo yet)
git init

# add files
git add .

# commit
git commit -m "Initial commit: frontend + backend + model"

# add remote (replace with your repo url)
git remote add origin https://github.com/<your-username>/<your-repo>.git

# push (first push for a new repo)
git branch -M main
git push -u origin main
```

If you used Git LFS, make sure to install Git LFS locally and that your remote supports LFS.

---

## 4) How to run each component

General notes:
- `model` folder already includes a `Dockerfile` and `DOCKER_RUN.md` with examples. The Docker image can be built either including `dataset/` (self-contained) or without it and mounting dataset at runtime.
- `frontend-react` is expected to be a typical React app. If a `Dockerfile` is absent you can run it locally with `npm install` and `npm start`.
- `backend` instructions depend on the backend language; check `backend/` for a `Dockerfile` or a `requirements.txt`.

### Model (Docker)

Build image that INCLUDES dataset (self-contained):

```powershell
docker build -t multivsl:with-data .
```

Run training (image contains dataset so no mount required):

```powershell
docker run --rm -it -v "${PWD}:/app" -w /app multivsl:with-data bash -c "python code/train_stgcn.py"
```

Or build image WITHOUT dataset and mount dataset at runtime (recommended for large datasets):

```powershell
docker build -t multivsl:latest .

docker run --rm -it -v "${PWD}:/app" -v "D:\\MultiVSL\\MultiVSL\\dataset:/data" -e OUTPUT_DIR=/data/stgcn_dataset -w /app multivsl:latest bash -c "python code/train_stgcn.py"
```

### Frontend (local / Docker)

Run locally (if Node.js is installed):

```powershell
cd frontend-react
npm install
npm start
```

Docker (if a `Dockerfile` exists inside `frontend-react`):

```powershell
docker build -t frontend:local ./frontend-react
docker run --rm -it -p 3000:3000 frontend:local
```

### Backend (local / Docker)

Check `backend/` for runtime details. Common commands:

Python example:

```powershell
cd backend
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python app.py
```

Docker example (if `backend/Dockerfile` present):

```powershell
docker build -t backend:local ./backend
docker run --rm -it -p 8000:8000 backend:local
```

---

## 5) Notes / Troubleshooting

- If `docker build` fails due to `torch`/`mediapipe` installation issues, see `DOCKER_RUN.md` for recommended pinned wheels and CPU vs GPU instructions. Provide the full build log when asking for help.
- For webcam display, prefer running `test_webcam.py` on the host (not inside Docker on Windows) unless you configure display forwarding.

---

If you want I can:
- create a sample `Dockerfile` for `frontend-react` (if you want to containerize it),
- add a small `backend/Dockerfile` template, or
- prepare a GitHub Actions workflow to build and push images automatically.

Tell me which of the above you'd like next.

---

# Dataset 
"https://drive.google.com/drive/folders/1YkSdYEcQt1KCVq6d1W5D2u9roeBbarxD?usp=drive_link"