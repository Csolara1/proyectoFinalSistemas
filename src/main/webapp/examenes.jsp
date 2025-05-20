<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String examenIDStr = request.getParameter("examenID");
String examenDescripcion = "";
String mensaje = "";

if (examenIDStr == null || examenIDStr.isEmpty()) {
	mensaje = "El parámetro examenID es obligatorio.";
} else {
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://172.190.114.187/TRABAJOFINAL", "adan", "Altair123$%");

		System.out.println("examenID recibido: " + examenIDStr);

		String examenQuery = "SELECT descripcion FROM examenes WHERE examenID = ?";
		pstmt = conn.prepareStatement(examenQuery);
		pstmt.setInt(1, Integer.parseInt(examenIDStr));
		rs = pstmt.executeQuery();

		if (rs.next()) {
	examenDescripcion = rs.getString("descripcion");
		}
		rs.close();

		String notasQuery = "SELECT a.alumnoNombre, a.alumnoApellido, n.notaAlumno " + "FROM alumnos a "
		+ "JOIN notas n ON a.alumnoID = n.alumnoID " + "WHERE n.examenID = ? AND n.notaAlumno IS NOT NULL";
		pstmt = conn.prepareStatement(notasQuery);
		pstmt.setInt(1, Integer.parseInt(examenIDStr));
		rs = pstmt.executeQuery();

		int resultados = 0;
		while (rs != null && rs.next()) {
	resultados++;
		}
		System.out.println("Resultados obtenidos: " + resultados);

		rs.beforeFirst();

	} catch (Exception e) {
		e.printStackTrace();
	}
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notas del Examen: <%=examenDescripcion%></title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: teal;
	margin: 0;
	padding: 0;
	text-align: center;
}

.container {
	width: 80%;
	margin: 50px auto;
	padding: 30px;
	background-color: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

h1 {
	color: #333;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

table, th, td {
	border: 1px solid #ddd;
}

th, td {
	padding: 10px;
	text-align: left;
}

th {
	background-color: #007BFF;
	color: white;
}

td {
	background-color: #f9f9f9;
}

button {
	padding: 10px 20px;
	color: white; 
	border-radius : 15px;	
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
		<h1>
			Notas del Examen:
			<%=examenDescripcion%></h1>

		<%
		if (mensaje != null && !mensaje.isEmpty()) {
		%>
		<p style="color: red;"><%=mensaje%></p>
		<%
		} else {
		%>
		<%-- Mostrar las notas de los alumnos --%>
		<table>
			<thead>
				<tr>
					<th>Alumno</th>
					<th>Nota</th>
				</tr>
			</thead>
			<tbody>
				<%
				boolean hayNotas = false;
				while (rs != null && rs.next()) {
					hayNotas = true;
					String nombreAlumno = rs.getString("alumnoNombre");
					String apellidoAlumno = rs.getString("alumnoApellido");
					Double notaAlumno = rs.getDouble("notaAlumno");
				%>
				<tr>
					<td><%=nombreAlumno + " " + apellidoAlumno%></td>
					<td><%=notaAlumno != null ? String.format("%.2f", notaAlumno) : "NP"%></td>
				</tr>
				<%
				}
				if (!hayNotas) {
				%>
				<tr>
					<td colspan="2">No hay calificaciones disponibles para este
						examen.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>

		<button onclick="window.location.href='calificar.jsp'">Volver
			a Calificar</button>
		<button onclick="window.location.href='prueba.jsp'">Volver
			atras</button>
	</div>
</body>
</html>
