FROM ubuntu:22.04

# Install required packages: wget, unzip, mono-runtime, expect (for scripting setup)
RUN apt-get update && \
    apt-get install -y wget unzip mono-runtime expect && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /terraria

# Download and extract a pinned TShock release (faster & more reliable than 'latest')
RUN wget -O tshock.zip "https://github.com/Pryaxis/TShock/releases/download/v4.5.4/tshock_release.zip" && \
    unzip tshock.zip && \
    rm tshock.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7777

ENTRYPOINT ["/entrypoint.sh"]
