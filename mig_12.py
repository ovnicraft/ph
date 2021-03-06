# usr/bin/env python

import logging

import click
import click_odoo

logger = logging.getLogger(__name__)


modules2uninstall = [
    "account_financial_report_qweb",
    "account_group",
    "account_payment_batch_process",
    "hr_payslip_monthly_report",
    "invoice_reports",
    # "invoice_taxexcent",
    # "invoice_third_party",
    "l10n_ec_statement",
    "l10n_ec_statement_import_move_line",
    "payment_cancel",
    "report_stock_picking",
    "stock_cancel",
    "stock_picking_internal",
    "mass_editing_groups",
    "base_xlsx",
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


def remove_view(env):
    env.cr.execute("delete from ir_ui_view where id = 1169")
    # this db has manually fields inserted
    views = env["ir.ui.view"].search([("arch_db", "ilike", "%auth_number%")])
    from lxml import etree

    for view in views:
        doc = etree.fromstring(view.arch_db)
        for ele in doc.xpath("//field[@name='auth_number']"):
            ele.getparent().remove(ele)
            logger.info("Removing from view %s", view.name)
        view.arch_db = etree.tostring(doc)
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
    remove_view(env)
    update_list(env)
    uninstall(env, modules2uninstall)
    uninstall(env, ["l10n_ec_chart"])
    install(env, ["base_vat", "report_xml"])
    update_modules(env, ["base", "report_xlsx"])


if __name__ == "__main__":
    main()
