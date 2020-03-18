#!/bin/sh
IMAGE=cvdocker
docker build -t "$IMAGE" .
exec docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data "$IMAGE" pdflatex --shell-escape main.tex
