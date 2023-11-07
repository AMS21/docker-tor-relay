FROM alpine:edge

# Install packages
RUN apk add --no-cache \
    tor \
    libcap-utils

# Clear cache
RUN rm -rf "/var/cache/apk/*"

# Allow tor to bind to ports < 1024.
RUN setcap cap_net_bind_service=+ep /usr/bin/tor

# Ensure we have access to the required files
RUN chown tor: /etc/tor
RUN chown tor: /var/lib/tor
RUN chown tor: /var/log/tor

# Copy entry point
COPY entrypoint.sh /usr/local/bin

RUN chmod 0755 /usr/local/bin/entrypoint.sh

# Run our entrypoint
CMD [ "/usr/local/bin/entrypoint.sh" ]
