SELECT s.surname, s.name, s.student_id, AVG(fc.mark) as average_mark
FROM public.student s
JOIN public.field_comprehension fc ON s.student_id = fc.student_id
JOIN public.field f ON fc.field = f.field_id
WHERE f.field_name <> 'Философия'
GROUP BY s.surname, s.name, s.student_id
ORDER BY average_mark DESC;
