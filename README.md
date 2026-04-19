# Dockerfile for building a DeepLoc 2.1 Docker image

This repository provides a Dockerfile for building a local Docker image to run DeepLoc 2.1 on eukaryotic protein FASTA files.
It is intended as a reproducible wrapper around the officially distributed DeepLoc 2.1 package for integration into workflows.
This project does **not** redistribute the DeepLoc 2.1 software. Users are responsible for obtaining the official package directly from DTU Health Tech and for complying with the original license and download terms, available at:
https://services.healthtech.dtu.dk/services/DeepLoc-2.1/

## Features

* Accepts protein FASTA input
* Runs DeepLoc 2.1 using the "Fast" or "Accurate" model (-m)
* Provides a reproducible containerized execution environment

## Required file

Before building the image, download the official DeepLoc 2.1 package from the DTU Health Tech website and place the archive file in the same directory as the Dockerfile.

Expected file:

`deeploc-2.1.All.tar.gz`

After placing the archive in the build directory, run:

`docker build -t deeploc2.1 .`

## Input

Protein FASTA file.

## Output

DeepLoc 2.1 CSV containing: Protein_ID, localizations, signals, membrane types, localization scores, membrane association scores and solubility scores

## Recommended usage

For large-scale datasets, the Fast model is recommended:

deeploc2 -f input.fasta -o output_dir -m Fast

## Example (Docker)

docker run --rm -v $(pwd):/data -v $(pwd)/torch_cache:/root/.cache/torch deeploc2.1 -f /data/input.fasta -o /data/output -m Fast

## Model download note

On first execution, the container may download the ESM1b model required for the Fast mode.

To avoid repeated downloads, it is recommended to mount a persistent cache directory:

-v /local/cache:/root/.cache/torch

This ensures the model is downloaded only once and reused in future runs.

## Performance notes

For large FASTA files, splitting the input into chunks is recommended to reduce memory usage and improve execution stability.
Dockerfile prepared for integration into the FastTarget-fungi workflow by Danielly Bittencourt Castro
