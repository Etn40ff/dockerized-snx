FROM i386/debian:stable-slim

RUN apt-get update && apt-get install -y \
    kmod \
    libstdc++5 \
    libx11-6 \
    expect \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/bin/ /etc/snx
ADD snx-800008209 /opt/bin
ADD snx-800007075 /opt/bin
ADD snx-800010003 /opt/bin
ADD dig-tunnel.exp /opt/bin
RUN chmod a+x /opt/bin/snx-800008209
RUN chmod a+x /opt/bin/snx-800007075
RUN chmod a+x /opt/bin/snx-800010003
RUN chmod a+x /opt/bin/dig-tunnel.exp

ENTRYPOINT ["/opt/bin/dig-tunnel.exp"]
