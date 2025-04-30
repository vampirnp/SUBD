-- Создание таблицы medical_center
CREATE TABLE medical_center (
    center_id SERIAL PRIMARY KEY,
    center_name VARCHAR(100) NOT NULL,
    address VARCHAR(255)
);

-- Создание таблицы medical_records
CREATE TABLE medical_records (
    record_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    center_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    diagnosis TEXT,
    FOREIGN KEY (student_id) REFERENCES student (student_id),
    FOREIGN KEY (center_id) REFERENCES medical_center (center_id)
);

-- Создание таблицы medical_staff
CREATE TABLE medical_staff (
    staff_id SERIAL PRIMARY KEY,
    center_id INTEGER NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    FOREIGN KEY (center_id) REFERENCES medical_center (center_id)
);
