FROM ubuntu:22.04

# Install required packages: wget, unzip, mono, expect (for scripting setup)
RUN apt-get update && \
    apt-get install -y wget unzip mono-complete expect && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /terraria

# Download TShock latest release
RUN wget -O tshock.zip "https://github.com/Pryaxis/TShock/releases/latest/download/tshock_release.zip" && \
    unzip tshock.zip && \
    rm tshock.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7777

ENTRYPOINT ["/entrypoint.sh"]