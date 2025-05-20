<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%
String mensaje = "";
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

if (request.getMethod().equalsIgnoreCase("POST")) {
	String alumnoIDStr = request.getParameter("alumnoID");

	if (alumnoIDStr != null && !alumnoIDStr.isEmpty()) {
		try {
	int alumnoID = Integer.parseInt(alumnoIDStr);

	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://172.190.114.187/TRABAJOFINAL", "adan", "Altair123$%");

	String deleteNotasQuery = "DELETE FROM notas WHERE alumnoID = ?";
	pstmt = conn.prepareStatement(deleteNotasQuery);
	pstmt.setInt(1, alumnoID);
	pstmt.executeUpdate();

	String deleteAlumnoQuery = "DELETE FROM alumnos WHERE alumnoID = ?";
	pstmt = conn.prepareStatement(deleteAlumnoQuery);
	pstmt.setInt(1, alumnoID);
	pstmt.executeUpdate();

	mensaje = "Alumno y sus datos eliminados exitosamente.";
		} catch (Exception e) {
	e.printStackTrace();
	mensaje = "Ocurrió un error al eliminar el alumno.";
		} finally {
	try {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
		}
	} else {
		mensaje = "Debe seleccionar un alumno para eliminar.";
	}
}

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://172.190.114.187/TRABAJOFINAL", "adan", "Altair123$%");
	String alumnosQuery = "SELECT alumnoID, alumnoNombre, alumnoApellido FROM alumnos";
	pstmt = conn.prepareStatement(alumnosQuery);
	rs = pstmt.executeQuery();
} catch (Exception e) {
	e.printStackTrace();
	mensaje = "Ocurrió un error al obtener la lista de alumnos.";
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Eliminar Alumno</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: teal;
	margin: 0;
	padding: 0;
	text-align: center;
}

.container {
	width: 50%;
	margin: 100px auto;
	padding: 30px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

h1 {
	color: #6801FA;
}

select, button {
	padding: 10px;
	font-size: 1em;
	margin: 10px;
	width: 100%;
	max-width: 300px;
	cursor: pointer;
}

button {
	color: white; 
	border-radius : 15px;	
	background-color: #9A48FA;
	transition: background-color 0.3s;
	cursor: pointer;
	padding: 10px 20px;
	font-size: 16px;
}

button:hover {
	background-color: #6801FA;
	color: white;
}

.mensaje {
	font-size: 1.2em;
	color: #555;
}
</style>
</head>
<body>

	<div class="container">
		<h1>Eliminar Alumno</h1>

		<%
		if (mensaje != null && !mensaje.isEmpty()) {
		%>
		<p class="mensaje"><%=mensaje%></p>
		<%
		}
		%>

		<form action="borrarAlumno.jsp" method="POST">
			<label for="alumnoID">Selecciona el Alumno a Eliminar:</label> <select
				name="alumnoID" id="alumnoID" required>
				<option value="">Seleccione un alumno</option>
				<%
				while (rs != null && rs.next()) {
				%>
				<option value="<%=rs.getInt("alumnoID")%>">
					<%=rs.getString("alumnoNombre") + " " + rs.getString("alumnoApellido")%>
				</option>
				<%
				}
				%>
			</select> <br>
			<button type="submit">Eliminar Alumno</button>
			<button onclick="window.location.href='prueba.jsp'">Volver
				atras</button>
		</form>
	</div>

</body>
</html>
