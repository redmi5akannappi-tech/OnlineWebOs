FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install only minimal required packages
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
    supervisor \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create startup script
RUN mkdir -p /opt/startup

RUN echo '#!/bin/bash\n\
export DISPLAY=:0\n\
Xvfb :0 -screen 0 1024x768x16 &\n\
sleep 2\n\
openbox &\n\
xfce4-panel &\n\
x11vnc -display :0 -nopw -forever -shared &\n\
websockify --web=/usr/share/novnc/ 6080 localhost:5900\n\
' > /opt/startup/start.sh

RUN chmod +x /opt/startup/start.sh

EXPOSE 6080

CMD ["/opt/startup/start.sh"]
