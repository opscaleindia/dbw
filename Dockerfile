# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y mosquitto-clients && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for configuration files and scripts
RUN mkdir -p /mqtt/config

# Copy the default MQTT configuration file
COPY mqtt.conf /mqtt/config/mqtt.conf

# Copy the script to listen for MQTT messages and execute commands
COPY mqtt_listener.sh /mqtt/mqtt_listener.sh
RUN chmod +x /mqtt/mqtt_listener.sh

# Set the default command to start the MQTT listener script
CMD ["/mqtt/mqtt_listener.sh"]
