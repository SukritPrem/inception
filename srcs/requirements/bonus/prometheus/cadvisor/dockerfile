# Base image
FROM debian:bullseye

# Update package lists
RUN apt-get update && apt-get upgrade -y \
    && apt install -y net-tools \
    vim \
    ufw \
    htop \
    iputils-ping \
    telnet \
    wget \
    curl \
    cadvisor 

COPY entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh
# Expose port
EXPOSE 19999
# Set working directory and command to run Netdata
WORKDIR /

CMD ["/usr/bin/cadvisor","-port","19999"]

#Here's an analogy:
# cAdvisor: Like a detailed performance monitor for
#   each car in a race.
# Node Exporter: Like monitoring the entire 
#   racetrack, including fuel levels, pit stop times, 
#   and overall race progress.