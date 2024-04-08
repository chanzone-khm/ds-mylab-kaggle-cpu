FROM gcr.io/kaggle-images/python:latest

# update
RUN apt-get -y update --allow-releaseinfo-change && apt-get -y upgrade
RUN apt-get -y update --fix-missing && apt-get -y upgrade

# install basic packages
RUN apt-get install -y \
  sudo \
  wget \
  bzip2 \
  vim \
  zip \
  unzip \
  ca-certificates \
  curl

# Install nodejs and Python packages
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
RUN pip install --no-cache-dir \
  black \
  jupyterlab \
  jupyterlab_code_formatter \
  jupyterlab-git \
  lckr-jupyterlab-variableinspector \
  jupyterlab_widgets \
  ipywidgets \
  import-ipynb \
  jupyterlab-unfold

# Avoid timezone prompt
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y tzdata git-all



WORKDIR /work

# Start JupyterLab
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root", "--LabApp.token=''"]
