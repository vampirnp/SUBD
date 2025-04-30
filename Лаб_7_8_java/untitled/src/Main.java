import java.sql.*;

public class Main {
    public static void main(String[] args) {
        String url = "jdbc:postgresql://localhost:5432/автовокзал";
        String user = "postgres";
        String password = "password";

        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            // CRUD операции
            // Пример: Добавление автобуса
            String sql = "INSERT INTO Автобусы (номер, модель, вместимость, статус) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, "А1238В");
            stmt.setString(2, "Mercedes");
            stmt.setInt(3, 50);
            stmt.setString(4, "активен");
            stmt.executeUpdate();

            // Вызов хранимой процедуры
            CallableStatement cstmt = conn.prepareCall("{? = call calculate_revenue(?, ?, ?)}");
            cstmt.registerOutParameter(1, Types.DECIMAL);
            cstmt.setInt(2, 1);
            cstmt.setDate(3, Date.valueOf("2023-10-01"));
            cstmt.setDate(4, Date.valueOf("2023-10-31"));
            cstmt.execute();
            System.out.println("Выручка: " + cstmt.getBigDecimal(1));

            // проверка что маршрут_id = 1 существует
            cstmt.setInt(2, 1);
            cstmt.setDate(3, Date.valueOf("2023-10-01"));
            cstmt.setDate(4, Date.valueOf("2023-10-31"));

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}