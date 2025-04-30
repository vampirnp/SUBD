-- Проверка свободных мест при покупке билета
CREATE OR REPLACE FUNCTION check_seat_availability()
RETURNS TRIGGER AS $$
DECLARE
    max_seats INT;
    booked_seats INT;
BEGIN
    SELECT вместимость INTO max_seats
    FROM Автобусы а
    JOIN Расписание р ON а.id = р.автобус_id
    WHERE р.id = NEW.расписание_id;

    SELECT COUNT(*) INTO booked_seats
    FROM Билеты
    WHERE расписание_id = NEW.расписание_id AND статус = 'куплен';

    IF booked_seats >= max_seats THEN
        RAISE EXCEPTION 'Нет свободных мест!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_ticket
BEFORE INSERT ON Билеты
FOR EACH ROW EXECUTE FUNCTION check_seat_availability();

-- Обновление статуса автобуса при отмене рейса
CREATE OR REPLACE FUNCTION update_bus_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.статус = 'отменен' THEN
        UPDATE Автобусы
        SET статус = 'недоступен'
        FROM Расписание
        WHERE Расписание.id = NEW.расписание_id
        AND Автобусы.id = Расписание.автобус_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_update_reis
AFTER UPDATE ON Рейсы
FOR EACH ROW EXECUTE FUNCTION update_bus_status();