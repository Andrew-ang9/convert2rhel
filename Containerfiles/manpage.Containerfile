# Use runc as the OCI runtime
# (This line is optional, as runc is the default)
# Note: If you omit this line, Podman will use runc by default
# You can also specify other runtimes (e.g., runsc, krun) if available
# See the OCI runtime documentation for details
# https://github.com/opencontainers/runtime-spec/blob/master/config.md#linux

FROM quay.io/centos/centos:stream9 AS base
# Install Python, pip, and git
RUN yum install -y python3-pip git
COPY requirements/manpages_requirements.txt /tmp/
RUN pip3 install -r /tmp/manpages_requirements.txt

# Set the working directory
WORKDIR /app

COPY scripts/manpage_generation.py /app/

# Make the script executable
RUN chmod +x manpage_generation.py

# Run the Python script
CMD ["/usr/bin/python3", "manpage_generation.py"]
