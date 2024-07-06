FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install curl file -y

ENV PATH="$PATH:/opt/trial/bin/"
COPY . /opt/trial/bin
CMD ["try-install"]
