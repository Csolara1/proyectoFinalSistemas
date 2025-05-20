<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%
int alumnoID = Integer.parseInt(request.getParameter("alumnoID"));
int examenID = Integer.parseInt(request.getParameter("examenID"));
double calificacion = Double.parseDouble(request.getParameter("calificacion"));
String mensaje = "";

if (calificacion < 1.00 || calificacion > 10.00) {
	mensaje = "La calificación debe estar entre 1.00 y 10.00.";
} else {
	Connection conn = null;
	PreparedStatement pstmt = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://172.190.114.187/TRABAJOFINAL", "adan", "Altair123$%");

		String checkQuery = "SELECT * FROM notas WHERE alumnoID = ? AND examenID = ?";
		pstmt = conn.prepareStatement(checkQuery);
		pstmt.setInt(1, alumnoID);
		pstmt.setInt(2, examenID);
		ResultSet rs = pstmt.executeQuery();

		if (rs.next()) {
	String updateQuery = "UPDATE notas SET notaAlumno = ? WHERE alumnoID = ? AND examenID = ?";
	pstmt = conn.prepareStatement(updateQuery);
	pstmt.setDouble(1, calificacion);
	pstmt.setInt(2, alumnoID);
	pstmt.setInt(3, examenID);
	pstmt.executeUpdate();
	mensaje = "Calificación actualizada exitosamente.";
		} else {
	String insertQuery = "INSERT INTO notas (alumnoID, examenID, notaAlumno) VALUES (?, ?, ?)";
	pstmt = conn.prepareStatement(insertQuery);
	pstmt.setInt(1, alumnoID);
	pstmt.setInt(2, examenID);
	pstmt.setDouble(3, calificacion);
	pstmt.executeUpdate();
	mensaje = "Calificación registrada exitosamente.";
		}
	} catch (Exception e) {
		e.printStackTrace();
		mensaje = "Ocurrió un error al registrar la calificación.";
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
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Resultado Calificación</title>
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
	color: #333;
}

p {
	font-size: 1.2em;
	color: #555;
}

button {
	padding: 10px 20px;
	color: white;
	border-radius: 15px;
	background-color: #9A48FA;
	font-size: 1em;
	cursor: pointer;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #6801FA;
	color: white;
}
</style>
</head>
<body>
	<div class="container">
		<h1><%=mensaje%></h1>
		<button onclick="window.location.href='prueba.jsp'">Volver al menú</button>
	</div>
</body>
</html>
