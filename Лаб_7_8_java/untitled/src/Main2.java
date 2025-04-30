import java.sql.*;
import java.util.Scanner;

public class Main2 {
    private static final String URL = "jdbc:postgresql://localhost:5432/автовокзал";
    private static final String USER = "postgres";
    private static final String PASSWORD = "password";
    private static Connection connection;

    public static void main(String[] args) {
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            Scanner scanner = new Scanner(System.in);

            while (true) {
                System.out.println("\n1. Добавить автобус");
                System.out.println("2. Добавить водителя");
                System.out.println("3. Купить билет");
                System.out.println("4. Отменить рейс");
                System.out.println("5. Проверить выручку");
                System.out.println("6. Проверить свободные автобусы");
                System.out.println("7. Выход");
                System.out.print("Выберите действие: ");
                int choice = scanner.nextInt();

                switch (choice) {
                    case 1 -> addBus();
                    case 2 -> addDriver();
                    case 3 -> buyTicket();
                    case 4 -> cancelFlight();
                    case 5 -> checkRevenue();
                    case 6 -> checkFreeBuses();
                    case 7 -> {
                        connection.close();
                        System.exit(0);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void addBus() throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(
                "INSERT INTO Автобусы (номер, модель, вместимость, статус) VALUES (?, ?, ?, ?)"
        );
        stmt.setString(1, "АtdgdfgС");
        stmt.setString(2, "Volvo");
        stmt.setInt(3, 60);
        stmt.setString(4, "активен");
        stmt.executeUpdate();
        System.out.println("Автобус добавлен!");
    }

    private static void addDriver() throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(
                "INSERT INTO Водители (фио, категория_прав, стаж) VALUES (?, ?, ?)"
        );
        stmt.setString(1, "Ивsfsfsd1");
        stmt.setString(2, "D");
        stmt.setInt(3, 5);
        stmt.executeUpdate();
        System.out.println("Водитель добавлен!");
    }

    private static void buyTicket() throws SQLException {
        try {
            // Получить список доступных расписаний
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id FROM Расписание");
            System.out.println("Доступные расписания:");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id"));
            }

            // Выбрать расписание
            Scanner scanner = new Scanner(System.in);
            System.out.print("Введите ID расписания: ");
            int scheduleId = scanner.nextInt();

            // Добавить билет
            PreparedStatement pstmt = connection.prepareStatement(
                    "INSERT INTO Билеты (расписание_id, место, цена, статус) VALUES (?, ?, ?, ?)"
            );
            pstmt.setInt(1, scheduleId);
            pstmt.setInt(2, 15);
            pstmt.setDouble(3, 3000.00);
            pstmt.setString(4, "куплен");
            pstmt.executeUpdate();
            System.out.println("Билет куплен!");
        } catch (SQLException e) {
            System.out.println("Ошибка: " + e.getMessage());
        }
    }

    private static void cancelFlight() throws SQLException {
        PreparedStatement stmt = connection.prepareStatement(
                "UPDATE Рейсы SET статус = 'отменен' WHERE id = ?"
        );
        stmt.setInt(1, 1);
        stmt.executeUpdate();
        System.out.println("Рейс отменен. Статус автобуса изменен!");
    }

    private static void checkRevenue() throws SQLException {
        CallableStatement cstmt = connection.prepareCall("{? = call calculate_revenue(?, ?, ?)}");
        cstmt.registerOutParameter(1, Types.DECIMAL);
        cstmt.setInt(2, 1);
        cstmt.setDate(3, Date.valueOf("2023-10-01"));
        cstmt.setDate(4, Date.valueOf("2023-10-31"));
        cstmt.execute();
        System.out.println("Выручка: " + cstmt.getBigDecimal(1));
    }

    private static void checkFreeBuses() throws SQLException {
        CallableStatement cstmt = connection.prepareCall("{call find_free_buses(?)}");
        cstmt.setDate(1, Date.valueOf("2023-10-15"));
        ResultSet rs = cstmt.executeQuery();
        System.out.println("Свободные автобусы:");
        while (rs.next()) {
            System.out.println(rs.getInt("автобус_id") + " - " + rs.getString("номер"));
        }
    }
}
