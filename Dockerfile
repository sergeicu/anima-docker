FROM ubuntu:18.04

MAINTAINER Serge V "serge.vasylechko@tch.harvard.edu"

# basic tools   
RUN apt-get update && apt-get install -y \
    unzip \ 
    wget  

# Anima binaries   
RUN wget https://github.com/Inria-Visages/Anima-Public/releases/download/v4.0/Anima-Ubuntu-4.0.zip && unzip Anima-Ubuntu-4.0.zip && rm -rf Anima-Ubuntu-4.0.zip && mv Anima-Binaries-4.0/ anima/ && mv anima/animaGMMT2RelaxometryEstimation . && rm -rf anima/

# python3 
RUN apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

# anima helper script 
COPY src/run_anima.py /
RUN chmod 666 /run_anima.py

CMD ["python", "/run_anima.py"]



