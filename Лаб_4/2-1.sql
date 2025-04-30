-- Добавление поля inn в таблицу students
ALTER TABLE student
ADD COLUMN inn CHAR(12);

-- Установка ограничения на формат значения
ALTER TABLE student
ADD CONSTRAINT inn_format CHECK (inn ~ '^[0-9]{2}[0-9]{2}[0-9]{6}[0-9]{2}$');
