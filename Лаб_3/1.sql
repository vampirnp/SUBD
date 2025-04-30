SELECT e.contract_number, u.full_title
FROM public.employment e
JOIN public.structural_unit u ON e.structural_unit_number = u.structural_unit_id
ORDER BY e.contract_number;
