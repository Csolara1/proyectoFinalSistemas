package api;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/grupos")
public class grupos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        List<Map<String, String>> grupos = new ArrayList<>();

        try {
            // 1. Cargar el driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 2. Conexión a la base de datos
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://172.190.114.187/TRABAJOFINAL", "adan", "Altair123$%");

            // 3. Ejecutar la consulta (solo los campos solicitados)
            String sql = "SELECT a.alumnoNombre, m.materiaNombre, e.descripcion AS examenDescripcion, n.notaAlumno " +
                         "FROM notas n " +
                         "JOIN alumnos a ON n.alumnoID = a.alumnoID " +
                         "JOIN examenes e ON n.examenID = e.examenID " +
                         "JOIN materias m ON e.materiaID = m.materiaID";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Map<String, String> fila = new HashMap<>();
                fila.put("alumnoNombre", rs.getString("alumnoNombre"));
                fila.put("materiaNombre", rs.getString("materiaNombre"));
                fila.put("examenDescripcion", rs.getString("examenDescripcion"));
                fila.put("notaAlumno", rs.getString("notaAlumno"));
                grupos.add(fila);
            }

            // 4. Convertir a JSON y enviar
            String json = new Gson().toJson(grupos);
            out.print(json);

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
