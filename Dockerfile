FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install minimal GUI + VNC + noVNC
RUN apt-get update && apt-get install -y \
    xfce4-session \
    xfce4-panel \
    xfce4-terminal \
    xfce4-settings \
    openbox \
    x11vnc \
    xvfb \
    novnc \
    websockify \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Render requires a port (value doesn't matter here)
EXPOSE 10000

CMD ["/start.sh"]
