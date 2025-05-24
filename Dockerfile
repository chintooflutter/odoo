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
    node-less wkhtmltopdf \
 && rm -rf /var/lib/apt/lists/*

# Create odoo user
RUN useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# Set working directory
WORKDIR /opt/odoo

# Copy only requirements.txt first to leverage Docker cache
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

# Now copy the rest of the Odoo source code
COPY . .

# Copy config file if you have one
COPY odoo.conf /etc/odoo.conf

# Change ownership of project files
RUN chown -R odoo:odoo /opt/odoo

# Expose Odoo port
EXPOSE 8069

# Switch to odoo user
USER odoo

# Default command
CMD ["python3", "odoo-bin", "-c", "/etc/odoo.conf"]
