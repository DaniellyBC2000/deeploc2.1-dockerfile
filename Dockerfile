#syntax=docker/dockerfile:1

FROM python:3.10-slim

# Install dependencies necessary to execute it
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt

#copy the zip archieve and unzip and delete the zip.
COPY deeploc-2.1.All.tar.gz /opt/
RUN tar -xzf /opt/deeploc-2.1.All.tar.gz -C /opt/ &&\
rm -f /opt/deeploc-2.1.All.tar.gz

RUN python3 -m pip install --upgrade pip setuptools wheel --no-cache-dir

#Install dependencies to execute the program
RUN python3 -m pip install \
    numpy \
    matplotlib \
    pandas \
    scipy \
    biopython \
    onnxruntime>=1.7.0 \
    fair-esm \
    transformers \
    pytorch_lightning \
    sentencepiece --no-cache-dir

#Install torch sepaparately
RUN python3 -m pip install torch --no-cache-dir

#Install the deepLoc2.1 and delete the folder
RUN python3 -m pip install --no-build-isolation --no-deps --no-cache-dir /opt/deeploc2_package && \
    rm -rf /opt/deeploc2_package

# Automatic execution to execute the DeepLoc2.1 and test the docker image
ENTRYPOINT ["deeploc2"]

#to test the docker image
CMD ["--help"] 


