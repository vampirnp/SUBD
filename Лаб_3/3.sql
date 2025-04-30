SELECT p.surname, p.name, p.patronymic, f.field_name, fc.mark, COUNT(fc.mark) as mark_count
FROM public.field_comprehension fc
JOIN public.field f ON fc.field = f.field_id
JOIN public.employment e ON fc.field = f.field_id
JOIN public.professor p ON e.professor_id = p.professor_id
WHERE fc.mark IS NOT NULL
GROUP BY p.surname, p.name, p.patronymic, f.field_name, fc.mark
ORDER BY p.surname, p.name, f.field_name;
