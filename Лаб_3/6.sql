SELECT g.students_group_number, COUNT(s.student_id) as student_count
FROM public.students_group g
LEFT JOIN public.student s ON g.students_group_number = s.students_group_number
GROUP BY g.students_group_number
UNION ALL
SELECT 'Итого студентов', COUNT(*)
FROM public.student;
