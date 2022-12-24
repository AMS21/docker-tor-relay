FROM alpine:edge

# Install packages
RUN apk add --no-cache \
    tor \
    python3 \
    python3-dev \
    py3-pip \
    build-base \
    sudo

# Clear cache
RUN rm -rf "/var/cache/apk/*"

# Install nyx using python
RUN pip install --no-cache-dir wheel
RUN pip install --no-cache-dir nyx

# Ensure we have access to the required files
RUN chown tor: /etc/tor
RUN chown tor: /var/lib/tor
RUN chown tor: /var/log/tor

# Copy entry point
COPY entrypoint.sh /usr/local/bin

RUN chmod 0755 /usr/local/bin/entrypoint.sh

USER tor

# Run our entrypoint
CMD [ "/usr/local/bin/entrypoint.sh" ]
