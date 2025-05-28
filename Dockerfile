# Use the official Odoo image (adjust the version as needed: 18.0, 17.0, 16.0, etc.)
FROM odoo:18.0

# Set environment variables (optional)
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install required packages (if any extra python packages are needed)
USER root
RUN apt-get update && apt-get install -y \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Copy config template and entrypoint
COPY ./odoo.conf.template /etc/odoo/odoo.conf.template
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the default user for Odoo
USER odoo

# Expose port (used by Odoo internally)
EXPOSE 8069

# Start Odoo using the configuration file
CMD ["odoo", "--config=/etc/odoo/odoo.conf"]
