<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%
    Connection conn = null;
    PreparedStatement pstmtAlumnos = null;
    PreparedStatement pstmtExamenes = null;
    ResultSet rsAlumnos = null;
    ResultSet rsExamenes = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://host/TRABAJOFINAL", "user", "password%");
        
        String queryAlumnos = "SELECT * FROM alumnos";
        pstmtAlumnos = conn.prepareStatement(queryAlumnos);
        rsAlumnos = pstmtAlumnos.executeQuery();
        
        String queryExamenes = "SELECT * FROM examenes";
        pstmtExamenes = conn.prepareStatement(queryExamenes);
        rsExamenes = pstmtExamenes.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Calificar Alumno</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: teal;
	margin: 0;
	padding: 0;
}

.container {
	width: 60%;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

h1 {
	color: #333;
	text-align: center;
}

form {
	display: flex;
	flex-direction: column;
}

label {
	font-size: 1.1em;
	margin-bottom: 8px;
	color: #333;
}

select, input[type="number"] {
	padding: 10px;
	margin-bottom: 15px;
	border-radius: 5px;
	border: 1px solid #ccc;
	font-size: 1em;
	width: 100%;
	box-sizing: border-box;
}

button {
	padding: 10px 20px;
	background-color: #A321E1;color: white;	
	border: none;
	border-radius: 5px;
	font-size: 1em;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #6801FA;
	color: white;
}

.back-buttons {
	margin-top: 20px;
	text-align: center;
}

.back-buttons button {
	margin: 10px 15px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Calificar Alumno</h1>

		<form action="guardarCalificacion.jsp" method="POST">
			<label for="alumnoID">Seleccionar Alumno:</label> <select
				name="alumnoID" id="alumnoID" required>
				<option value="">Selecciona un alumno</option>
				<%
                    while (rsAlumnos.next()) {
                        int alumnoID = rsAlumnos.getInt("alumnoID");
                        String nombreAlumno = rsAlumnos.getString("alumnoNombre");
                        String apellidoAlumno = rsAlumnos.getString("alumnoApellido");
                %>
				<option value="<%= alumnoID %>"><%= nombreAlumno + " " + apellidoAlumno %></option>
				<%
                    }
                %>
			</select><br>
			<br> <label for="examenID">Seleccionar Examen:</label> <select
				name="examenID" id="examenID" required>
				<option value="">Selecciona un examen</option>
				<%
                    while (rsExamenes.next()) {
                        int examenID = rsExamenes.getInt("examenID");
                        String descripcionExamen = rsExamenes.getString("descripcion");  // Asumimos que la columna es 'descripcion'
                %>
				<option value="<%= examenID %>"><%= descripcionExamen %></option>
				<%
                    }
                %>
			</select><br>
			<br> <label for="calificacion">Calificación:</label> <input
				type="number" name="calificacion" id="calificacion" step="0.01"
				min="1.00" max="10.00" required><br>
			<br>

			<button type="submit">Guardar Calificación</button>
		</form>

		<div class="back-buttons">
			<button onclick="window.location.href='prueba.jsp'">Volver
				atras</button>
		</div>
	</div>
</body>
</html>

<%
    try {
        if (rsAlumnos != null) rsAlumnos.close();
        if (rsExamenes != null) rsExamenes.close();
        if (pstmtAlumnos != null) pstmtAlumnos.close();
        if (pstmtExamenes != null) pstmtExamenes.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
