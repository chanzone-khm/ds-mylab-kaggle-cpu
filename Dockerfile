FROM gcr.io/kaggle-images/python:latest

# Add Zscaler certificate
COPY ${CERT_FILE} /usr/local/share/ca-certificates/zscaler.crt
RUN update-ca-certificates

# update and install basic packages
RUN apt-get update --allow-releaseinfo-change && apt-get upgrade -y && apt-get install -y \
  sudo \
  wget \
  bzip2 \
  vim \
  zip \
  unzip \
  ca-certificates \
  curl \
  tzdata \
  git-all \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs

# Install Python packages
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

WORKDIR /work

# Start JupyterLab
ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root", "--LabApp.token=''"]
