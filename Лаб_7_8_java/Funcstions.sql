-- Выручка по маршруту за период
CREATE OR REPLACE FUNCTION calculate_revenue(маршрут_id INT, start_date DATE, end_date DATE)
RETURNS DECIMAL(10, 2) AS $$
BEGIN
    RETURN (
        SELECT SUM(цена)
        FROM Билеты б
        JOIN Расписание р ON б.расписание_id = р.id
        WHERE р.маршрут_id = calculate_revenue.маршрут_id
        AND DATE(р.время_отправления) BETWEEN start_date AND end_date
        AND б.статус = 'куплен'
    );
END;
$$ LANGUAGE plpgsql;

-- Свободные автобусы на дату
CREATE OR REPLACE FUNCTION find_free_buses(query_date DATE)
RETURNS TABLE (автобус_id INT, номер VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT а.id, а.номер
    FROM Автобусы а
    WHERE а.id NOT IN (
        SELECT автобус_id
        FROM Расписание
        WHERE DATE(время_отправления) = query_date
    );
END;
$$ LANGUAGE plpgsql;

-- Функция подсчета занятых мест в автобусе
CREATE OR REPLACE FUNCTION count_booked_seats(schedule_id INT)
RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM Билеты WHERE расписание_id = schedule_id AND статус = 'куплен');
END;
$$ LANGUAGE plpgsql;

-- Процедура генерации расписания на неделю (пример для маршрута 1)
CREATE OR REPLACE PROCEDURE generate_weekly_schedule(маршрут_id INT, автобус_id INT, start_date DATE)
LANGUAGE plpgsql AS $$
BEGIN
    FOR i IN 0..6 LOOP
        INSERT INTO Расписание (маршрут_id, автобус_id, время_отправления, время_прибытия)
        VALUES (
            маршрут_id,
            автобус_id,
            start_date + i * INTERVAL '1 day' + TIME '08:00',
            start_date + i * INTERVAL '1 day' + TIME '20:00'
        );
    END LOOP;
END;
$$;

-- Функция проверки доступности водителя
CREATE OR REPLACE FUNCTION is_driver_available(водитель_id INT, check_date DATE)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN NOT EXISTS (
        SELECT 1 FROM Назначения 
        WHERE водитель_id = is_driver_available.водитель_id 
        AND дата_назначения = check_date
    );
END;
$$ LANGUAGE plpgsql;