SELECT s.surname, s.name, s.patronymic, s.student_id
FROM public.student s
JOIN public.students_group g ON s.students_group_number = g.students_group_number;
