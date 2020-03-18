
FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

ENV HOME /data
WORKDIR /data

VOLUME ["/data"]

RUN apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:inkscape.dev/stable \
    && apt-get update \
    && apt-get install -y cm-super texlive-font-utils texlive-lang-german \
                          lmodern texlive-fonts-extra unzip \
                          texlive-science inkscape texlive-latex-base \
                          texlive-latex-extra texlive-latex-recommended

RUN mkdir -p /nobody/.config/inkscape
