FROM python:3.10-slim

# Set environment variables
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git build-essential wget \
    libxslt-dev libzip-dev libldap2-dev libsasl2-dev \
    libjpeg-dev libpq-dev libxml2-dev libssl-dev \
    python3-dev libffi-dev zlib1g-dev \
    node-less wkhtmltopdf

# Create user
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Set workdir
WORKDIR /opt/odoo

# Clone Odoo from your GitHub fork
RUN git clone -b 18.0 https://github.com/chintooflutter/odoo.git .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

# Copy config
COPY odoo.conf /etc/odoo.conf

# Set permissions
RUN chown -R odoo:odoo /opt/odoo

# Expose port
EXPOSE 8069

# Run as odoo user
USER odoo

# Command to run Odoo
CMD ["python3", "odoo-bin", "-c", "/etc/odoo.conf"]
