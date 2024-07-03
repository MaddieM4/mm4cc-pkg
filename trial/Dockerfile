FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install curl -y
COPY ./try-install /bin/try-install
CMD ["try-install"]
