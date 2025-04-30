WITH student_marks AS (
    SELECT s.student_id, s.surname, s.name, s.students_group_number,
           SUM(CASE WHEN fc.mark = 3 THEN 1 ELSE 0 END) as count_threes,
           SUM(CASE WHEN fc.mark = 4 THEN 1 ELSE 0 END) as count_fours
    FROM public.student s
    JOIN public.field_comprehension fc ON s.student_id = fc.student_id
    GROUP BY s.student_id, s.surname, s.name, s.students_group_number
)
SELECT sm.surname, sm.name, sm.students_group_number
FROM student_marks sm
WHERE sm.count_threes > sm.count_fours;
