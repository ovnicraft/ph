#!/bin/bash

# check the paths for Odoo and enterprise
# Enterprise last is not included in this repo to be compatible
# with Odoo.sh


ODOO_VERSION=15.0
ODOO_ROOT=~/development/odoo/$ODOO_VERSION/odoo
ENTERPRISE=~/development/odoo/$ODOO_VERSION/enterprise
ODOO_BIN=odoo-bin

ADDONS_PATH=$ODOO_ROOT/addons,$ENTERPRISE

for d in $(ls -1d OCA/* prisehub/*); do
    echo "directory" $d
    ADDONS_PATH=$ADDONS_PATH,$(pwd)/$d
done



python $ODOO_ROOT/$ODOO_BIN --addons-path=$ADDONS_PATH --db_port=5434 --limit-memory-hard 0 $@
