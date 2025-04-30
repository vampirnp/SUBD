-- Удаление таблицы field_professor, если она уже существует
DROP TABLE IF EXISTS field_professor;

-- Создание таблицы field_professor с правильным типом данных
CREATE TABLE field_professor (
    field_id UUID NOT NULL,
    professor_id INTEGER NOT NULL,
    PRIMARY KEY (field_id, professor_id),
    FOREIGN KEY (field_id) REFERENCES field (field_id),
    FOREIGN KEY (professor_id) REFERENCES professor (professor_id)
);
