# syntax=docker/dockerfile:1
FROM ubuntu:18.04

LABEL project=dotfiles
MAINTAINER Geoff Johnson <geoff.jay@gmail.com>

RUN apt-get update \
  && apt-get install -y \
    bash \
    build-essential \
    curl \
    git \
    sudo \
  && rm -rf /var/lib/apt/lists*

# FIXME: use an image for this
RUN curl -L https://go.dev/dl/go1.17.7.linux-amd64.tar.gz -o /tmp/go1.17.7.tar.gz \
  && sudo tar -C /usr/local -xvf /tmp/go1.17.7.tar.gz

RUN echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/10-vscode

# use same things as codespaces for testing purposes

ENV CODESPACES="true"

RUN groupadd -r vscode \
  && useradd -g vscode vscode \
  && usermod -a -G sudo vscode

USER vscode

WORKDIR /home/vscode/projects/dotfiles
COPY . .

# build the dotfiles binary
RUN PATH=$PATH:/usr/local/go/bin make

# run the dotfiles setup
RUN ./install.sh
