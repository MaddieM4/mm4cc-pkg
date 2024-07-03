FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt install -y gpg
RUN deluser ubuntu

ARG UID=1000
ARG GID=${UID}
RUN groupadd -g $GID indexer
RUN useradd -u $UID -g $GID indexer

USER indexer
ENV PATH="$PATH:/home/indexer/bin"
WORKDIR /home/indexer
