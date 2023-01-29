# usr/bin/env python

import logging

import click
import click_odoo

logger = logging.getLogger(__name__)


modules2uninstall = [
    "account_move_cancel",
    "web_export_view",
    "mass_operation_abstract",
    "l10n_ec_followup",
    "account_payment_import_invoice",
    "web_widget_many2many_tags_multi_selection",
    "account_move_chatter",
    "l10n_ec_liq_purchase",
    "hr_payroll_cancel",
    "resource_hook",
    "mass_editing",
]


def uninstall(env, module_names):
    modules = env["ir.module.module"].search(
        [("name", "in", module_names), ("state", "=", "installed")]
    )
    logger.info("uninstalling %s", modules.mapped("name"))
    modules.module_uninstall()
    env.cr.commit()


def install(env, names):
    modules = env["ir.module.module"].search(
        [("name", "in", names), ("state", "=", "uninstalled")]
    )
    logger.info("installing %s", modules.mapped("name"))
    modules.button_immediate_install()
    env.cr.commit()


def update_list(env):
    env["ir.module.module"].update_list()
    env.cr.commit()


def update_modules(env, module_names):
    mod = env["ir.module.module"].search([("name", "in", module_names)])
    mod.button_immediate_upgrade()
    env.cr.commit()


@click.command()
@click_odoo.env_options()
def main(env):
    update_list(env)
    uninstall(env, modules2uninstall)


if __name__ == "__main__":
    main()
