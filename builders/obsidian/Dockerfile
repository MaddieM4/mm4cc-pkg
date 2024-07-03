# =============================================================================
# PACKAGE-AGNOSTIC PREAMBLE
# =============================================================================
ARG ARCH=amd64
ARG UBUNTU_RELEASE=latest
ARG BASE_IMAGE=${ARCH}/ubuntu:${UBUNTU_RELEASE}

FROM ${BASE_IMAGE}
ARG ARCH
RUN apt update && apt install -y wget
RUN mkdir /out/
WORKDIR /out/

# =============================================================================
# PACKAGE-SPECIFIC PREAMBLE
# =============================================================================
COPY dependencies.txt /deps.txt
RUN apt install -y $(cat /deps.txt)
ARG OBSIDIAN_VERSION=1.6.5

# =============================================================================
# DOWNLOAD THIRD-PARTY PACKAGE
# =============================================================================
ENV URL="https://github.com/obsidianmd/obsidian-releases/releases/download/v${OBSIDIAN_VERSION}/obsidian-${OBSIDIAN_VERSION}-${ARCH}.deb"
ENV DEB="obsidian-${OBSIDIAN_VERSION}-${ARCH}.deb"
RUN wget "${URL}" -O "${DEB}"

# =============================================================================
# VERIFY
# =============================================================================
RUN dpkg --install "$DEB"
RUN which obsidian
