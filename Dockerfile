FROM gcr.io/kaggle-images/python

# update
RUN apt-get -y update --allow-releaseinfo-change && apt-get -y upgrade
RUN apt-get -y update --fix-missing && apt-get -y upgrade



# _/_/_/_/_/_/_/_/_/_/ jupyter _/_/_/_/_/_/_/_/
#参考URL	https://qiita.com/canonrock16/items/d166c93087a4aafd2db4
#		http://tonop.cocolog-nifty.com/blog/2020/07/post-a216ae.html
# Install nodejs
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

# gitをインストールするとtzdataのtimezone設定を要求されてビルドが止まるので対応
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
  && apt-get install -y tzdata
RUN sudo apt-get install -y git-all



WORKDIR /
RUN mkdir /work

ENTRYPOINT ["jupyter", "lab","--ip=0.0.0.0","--allow-root", "--LabApp.token=''"]