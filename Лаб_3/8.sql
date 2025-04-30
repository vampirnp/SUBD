SELECT u.full_title, AVG(EXTRACT(YEAR FROM AGE(s.birthday))) as average_age
FROM public.student s
JOIN public.students_group g ON s.students_group_number = g.students_group_number
JOIN public.structural_unit u ON u.structural_unit_id = u.structural_unit_id
GROUP BY u.full_title;
