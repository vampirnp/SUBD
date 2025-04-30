SELECT s.name, COUNT(s.name) as name_count,
       CASE
           WHEN g.students_group_number LIKE 'ИБ-1%' THEN 'первая'
           WHEN g.students_group_number LIKE 'ИБ-2%' THEN 'вторая'
       END as group_type
FROM public.student s
JOIN public.students_group g ON s.students_group_number = g.students_group_number
WHERE g.students_group_number LIKE 'ИБ-1%' OR g.students_group_number LIKE 'ИБ-2%'
GROUP BY s.name, group_type;
