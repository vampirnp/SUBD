CREATE TABLE Автобусы (
    id SERIAL PRIMARY KEY,
    номер VARCHAR(20) UNIQUE NOT NULL,
    модель VARCHAR(50),
    вместимость INT CHECK (вместимость > 0),
    статус VARCHAR(20) CHECK (статус IN ('активен', 'ремонт', 'недоступен'))
);

CREATE TABLE Маршруты (
    id SERIAL PRIMARY KEY,
    название VARCHAR(100) NOT NULL,
    начальная_точка VARCHAR(100),
    конечная_точка VARCHAR(100),
    расстояние_km INT
);

CREATE TABLE Расписание (
    id SERIAL PRIMARY KEY,
    маршрут_id INT REFERENCES Маршруты(id),
    автобус_id INT REFERENCES Автобусы(id),
    время_отправления TIMESTAMP,
    время_прибытия TIMESTAMP
);

CREATE TABLE Водители (
    id SERIAL PRIMARY KEY,
    фио VARCHAR(100) NOT NULL,
    категория_прав VARCHAR(10),
    стаж INT CHECK (стаж >= 0)
);

CREATE TABLE Назначения (
    id SERIAL PRIMARY KEY,
    водитель_id INT REFERENCES Водители(id),
    автобус_id INT REFERENCES Автобусы(id),
    дата_назначения DATE
);

CREATE TABLE Пассажиры (
    id SERIAL PRIMARY KEY,
    фио VARCHAR(100) NOT NULL,
    билет_id INT UNIQUE
);

CREATE TABLE Билеты (
    id SERIAL PRIMARY KEY,
    расписание_id INT REFERENCES Расписание(id),
    место INT CHECK (место > 0),
    цена DECIMAL(10, 2),
    статус VARCHAR(20) CHECK (статус IN ('куплен', 'возвращен'))
);

CREATE TABLE Рейсы (
    id SERIAL PRIMARY KEY,
    расписание_id INT REFERENCES Расписание(id),
    статус VARCHAR(20) CHECK (статус IN ('по расписанию', 'задержан', 'отменен'))
);