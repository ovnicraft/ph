UPDATE ir_module_module SET name = 'l10n_ec_payment_order' WHERE name = 'l10n_ec_payments';
UPDATE ir_model_data SET module = 'l10n_ec_payment_order' WHERE module = 'l10n_ec_payments';
UPDATE ir_model_data SET name = 'module_l10n_ec_payment_order'
       WHERE name = 'module_l10n_ec_payments'
       AND module = 'base'
       AND model = 'ir.module.module';
UPDATE ir_module_module_dependency SET name = 'l10n_ec_payment_order'
       WHERE name = 'l10n_ec_payments';
UPDATE ir_translation SET module = 'l10n_ec_payment_order'
       WHERE module = 'l10n_ec_payments';


UPDATE ir_module_module SET name = 'account_move_cancel' WHERE name = 'l10n_ec_account_move';
UPDATE ir_model_data SET module = 'account_move_cancel' WHERE module = 'l10n_ec_account_move';
UPDATE ir_model_data SET name = 'module_account_move_cancel'
       WHERE name = 'module_account_move_cancel'
       AND module = 'base'
       AND model = 'ir.module.module';
UPDATE ir_module_module_dependency SET name = 'account_move_cancel'
       WHERE name = 'l10n_ec_account_move';
UPDATE ir_translation SET module = 'account_move_cancel'
       WHERE module = 'l10n_ec_account_move';


UPDATE ir_module_module SET name = 'l10n_ec_payroll_data' WHERE name = 'payroll_data';
UPDATE ir_model_data SET module = 'l10n_ec_payroll_data' WHERE module = 'payroll_data';
UPDATE ir_model_data SET name = 'module_l10n_ec_payroll_data'
       WHERE name = 'module_l10n_ec_payroll_data'
       AND module = 'base'
       AND model = 'ir.module.module';
UPDATE ir_module_module_dependency SET name = 'l10n_ec_payroll_data'
       WHERE name = 'l10n_ec_account_move';
UPDATE ir_translation SET module = 'l10n_ec_payroll_data'
       WHERE module = 'payroll_data';


UPDATE ir_module_module SET name = 'l10n_ec_followup' WHERE name = 'account_followup_ec';
UPDATE ir_model_data SET module = 'l10n_ec_followup' WHERE module = 'account_followup_ec';
UPDATE ir_model_data SET name = 'module_l10n_ec_followup'
       WHERE name = 'module_account_followup_ec'
       AND module = 'base'
       AND model = 'ir.module.module';
UPDATE ir_module_module_dependency SET name = 'l10n_ec_followup'
       WHERE name = 'account_followup_ec';
UPDATE ir_translation SET module = 'l10n_ec_followup'
       WHERE module = 'account_followup_ec';


UPDATE ir_module_module SET name = 'l10n_ec_liq_purchase' WHERE name = 'l10n_ec_epurchase';
UPDATE ir_model_data SET module = 'l10n_ec_liq_purchase' WHERE module = 'l10n_ec_epurchase';
UPDATE ir_model_data SET name = 'module_l10n_ec_liq_purchase'
       WHERE name = 'module_l10n_ec_epurchase'
       AND module = 'base'
       AND model = 'ir.module.module';
UPDATE ir_module_module_dependency SET name = 'l10n_ec_liq_purchase'
       WHERE name = 'l10n_ec_epurchase';
UPDATE ir_translation SET module = 'l10n_ec_liq_purchase'
       WHERE module = 'l10n_ec_epurchase';

DELETE FROM ir_ui_view where name = 'view.account.payment.line.conciled.form';
DELETE FROM ir_ui_view where name = 'view.users.restrictions.stocks';
UPDATE ir_ui_view set active = 'f' where arch_db ilike '%auth_number%';
DELETE FROM ir_ui_view WHERE name = 'account.refund.invoice.wizard.form';
DELETE FROM ir_ui_view WHERE name ilike '%ir.actions.report.xml%';
DELETE FROM ir_ui_view where name = 'view.account.invoice.epurchase.form';
DELETE FROM ir_module_module_dependency WHERE name = 'base_xlsx';
UPDATE account_invoice
SET invoice_number = substring(invoice_number,1,3)||'-'||substring(invoice_number, 4,3)||'-'||substring(invoice_number, 7,9)
WHERE STATE NOT IN ('draft','cancel') ;
