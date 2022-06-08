# syntax=docker/dockerfile:1
FROM ubuntu:18.04 AS base

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

FROM base AS codespaces

# use same setup as codespaces for testing purposes

ARG YARN_URL="https://dl.yarnpkg.com/debian"

RUN curl --location --show-error --silent "$YARN_URL/pubkey.gpg" | apt-key add - \
  && echo "deb $YARN_URL/ stable main" > /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y yarn \
  && rm -rf /var/lib/apt/lists*

RUN echo 'vscode ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/10-vscode

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
