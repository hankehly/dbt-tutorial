# syntax=docker/dockerfile:1
FROM python:3.11
WORKDIR /app
COPY requirements.txt .
RUN <<EOT
  pip install -U pip
  pip install -r requirements.txt
EOT
