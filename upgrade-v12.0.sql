UPDATE ir_module_module SET name = 'hr_payslip_report' WHERE name = 'hr_payslip_monthly_report';
UPDATE ir_model_data SET module = 'hr_payslip_report' WHERE module = 'hr_payslip_monthly_report';
UPDATE ir_model_data SET name = 'module_hr_payslip_report'
       WHERE name = 'module_hr_payslip_monthly_report'
       AND module = 'base'
       AND model = 'ir.module.module';
UPDATE ir_module_module_dependency SET name = 'hr_payslip_report'
       WHERE name = 'hr_payslip_monthly_report';
UPDATE ir_translation SET module = 'hr_payslip_report'
       WHERE module = 'hr_payslip_monthly_report';
