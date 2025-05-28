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

# Use the default user for Odoo
USER odoo

# Expose port (used by Odoo internally)
EXPOSE 8069

# Run Odoo
CMD ["odoo", "-d", "odoo", "--db_host=$DB_HOST", "--db_port=$DB_PORT", "--db_user=$DB_USER", "--db_password=$DB_PASSWORD"]
