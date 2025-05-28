#!/bin/bash

# Render odoo.conf with actual environment variables
envsubst < /etc/odoo/odoo.conf.template > /etc/odoo/odoo.conf

# Start Odoo
exec odoo --config=/etc/odoo/odoo.conf
