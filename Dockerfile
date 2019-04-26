# Dockerfile for jiant repo. Currently intended to run in our GCP environment.
#
# To set up Docker for local use, follow the first part of the Kubernetes
# install instructions (gcp/kubernetes/README.md) to install Docker and
# nvidia-docker.
#
# For local usage, see demo.with_docker.sh
#
# To run on Kubernetes, see gcp/kubernetes/run_batch.sh
#
# Note that --remote_log currently doesn't work with containers,
# since the host name seen by main.py is the name of the container, not the
# name of the host GCE instance.

# Use CUDA base image.
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Fix unicode issues in Python3 by setting default text file encoding.
ENV LANG C.UTF-8

# Update Ubuntu packages
RUN apt-get update && yes | apt-get upgrade && \
    apt-get install -y --no-install-recommends \
            build-essential \
            locales \
            ca-certificates \
            git \
            vim \
            curl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \     
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build \
    python=3.6.3 && \
    /opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/bin:$PATH

# Fix some package issues
RUN pip install --upgrade --no-cache-dir pip && \
    pip install --no-cache-dir \
    pyyaml \
    mkl \
    torch==1.0.0 \
    torchvision==0.2.1 \
    pandas \
    nltk==3.2.5 \
    msgpack \
    nose2 \
    ipdb \
    tensorflow-gpu==1.12.2 \
    tensorboardX==1.2 \
    python-Levenshtein \
    ftfy==5.4.1 \
    spacy==2.0.11 \
    greenlet==0.4.15 \
    pyhocon==0.3.35 \
    sacremoses && \
    pip install --no-cache-dir allennlp==0.8.1 --ignore-installed PyYAML && \
    pip install --upgrade --no-cache-dir \
    tensorflow-hub \
    google-cloud-logging \
    sendgrid \
    pytorch-pretrained-bert==0.5.1 && \
    python -m spacy download en && \
    python -m nltk.downloader -d /usr/share/nltk_data \
    perluniprops \
    nonbreaking_prefixes \
    punkt && \
    rm -rf ~/.cache/pip

ADD ./ /app/

