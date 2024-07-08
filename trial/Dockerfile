FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install curl file -y

ENV MM4CC_PPA_URL=http://ppa-host
ENV MM4CC_PPA_SUITE=unstable
ENV PATH="$PATH:/opt/trial/bin/"
COPY . /opt/trial/bin
CMD ["try-install"]
