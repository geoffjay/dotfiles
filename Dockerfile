# syntax=docker/dockerfile:1
FROM ubuntu:18.04

LABEL project=dotfiles
MAINTAINER Geoff Johnson <geoff.jay@gmail.com>

RUN apt-get update \
  && apt-get install -y \
    bash \
    curl \
    git \
    python3 \
    python3-pip \
    python3-venv \
    software-properties-common \
    sudo \
  && apt-add-repository -y ppa:ansible/ansible \
  && apt-get update \
  && apt-get install -y ansible \
  && rm -rf /var/lib/apt/lists*

# use same things as codespaces for testing purposes

RUN echo 'vscode ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/10-vscode

ENV CODESPACES="true"

RUN groupadd -r vscode \
  && useradd -g vscode vscode \
  && usermod -a -G sudo vscode \
  && mkdir /home/vscode \
  && chown vscode.vscode -R /home/vscode

USER vscode

WORKDIR /home/vscode/projects/dotfiles
COPY . .

# run the dotfiles setup
RUN ./install.sh
