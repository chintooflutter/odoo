FROM python:3.10

# System dependencies
RUN apt-get update && apt-get install -y \
    git wget node-less libjpeg-dev libpq-dev \
    libsasl2-dev libldap2-dev build-essential \
    libxml2-dev libxslt1-dev zlib1g-dev \
    libevent-dev libssl-dev locales \
    wkhtmltopdf

# Create user
RUN useradd -ms /bin/bash odoo

# Set working directory
WORKDIR /opt/odoo

# Clone Odoo (you can change the version here)
RUN git clone --depth 1 --branch 17.0 https://www.github.com/odoo/odoo /opt/odoo

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy custom config (if any)
COPY odoo.conf /etc/odoo.conf

# Expose port
EXPOSE 8069

# Set default command
CMD ["python3", "odoo-bin", "-c", "/etc/odoo.conf"]
