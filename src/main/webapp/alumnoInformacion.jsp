<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Información del Alumno</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: teal;
	text-align: center;
}

.container {
	width: 80%;
	margin: 0 auto;
	padding: 20px;
	background-color: white;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

h1, h2 {
	color: #333;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

button {
	color: white; 
	border-radius : 15px;	
	background-color: #9A48FA;
	padding: 10px 20px;
	font-size: 16px;
	margin-top: 20px;
	margin-bottom: 10px;
	cursor: pointer;
	padding: 10px 20px;
	align-items: center;
}

button:hover {
	background-color: #6801FA;
}
</style>
</head>
<body>

	<div class="container">
		<%
		Connection conn = null;
		PreparedStatement pstmtAlumno = null;
		PreparedStatement pstmtNotas = null;
		ResultSet rsAlumno = null;
		ResultSet rsNotas = null;
		String nombreAlumno = "";
		String descripcionAlumno = "";
		String fechaNacimiento = "";
		int edad = 0;
		int alumnoID = Integer.parseInt(request.getParameter("id"));

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://host/TRABAJOFINAL", "user", "password%");

			String queryAlumno = "SELECT alumnoNombre, descripcion, fechaNacimiento FROM alumnos WHERE alumnoID = ?";
			pstmtAlumno = conn.prepareStatement(queryAlumno);
			pstmtAlumno.setInt(1, alumnoID);
			rsAlumno = pstmtAlumno.executeQuery();

			if (rsAlumno.next()) {
				nombreAlumno = rsAlumno.getString("alumnoNombre");
				descripcionAlumno = rsAlumno.getString("descripcion");
				fechaNacimiento = rsAlumno.getString("fechaNacimiento");

				java.sql.Date fechaNacimientoSQL = rsAlumno.getDate("fechaNacimiento");
				java.util.Calendar cal = java.util.Calendar.getInstance();
				cal.setTime(fechaNacimientoSQL);
				int yearOfBirth = cal.get(java.util.Calendar.YEAR);
				int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
				edad = currentYear - yearOfBirth;
			}

			String queryNotas = "SELECT ex.descripcion, n.notaAlumno FROM examenes ex "
			+ "LEFT JOIN notas n ON ex.examenID = n.examenID " + "WHERE n.alumnoID = ?";
			pstmtNotas = conn.prepareStatement(queryNotas);
			pstmtNotas.setInt(1, alumnoID);
			rsNotas = pstmtNotas.executeQuery();

		} catch (Exception e) {
			e.printStackTrace();
		}
		%>

		<h1><%=nombreAlumno%></h1>
		<p>
			<strong>Descripción:</strong>
			<%=descripcionAlumno%></p>
		<p>
			<strong>Edad:</strong>
			<%=edad%>
			años
		</p>
		<p>
			<strong>ID:</strong>
			<%=alumnoID%></p>
		<p>
			<strong>Fecha de Nacimiento:</strong>
			<%=fechaNacimiento%></p>

		<h2>Notas en Exámenes:</h2>
		<table>
			<thead>
				<tr>
					<th>Examen</th>
					<th>Nota</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (rsNotas != null) {
					while (rsNotas.next()) {
				%>
				<tr>
					<td><%=rsNotas.getString("descripcion")%></td>
					<td><%=rsNotas.getString("notaAlumno") != null ? rsNotas.getString("notaAlumno") : "NP"%></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="2">No hay notas disponibles para este alumno.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

		<button onclick="window.location.href='alumnos.jsp'">Volver
			al Listado de Alumnos</button>
	</div>

	<%
	try {
		if (rsAlumno != null)
			rsAlumno.close();
		if (rsNotas != null)
			rsNotas.close();
		if (pstmtAlumno != null)
			pstmtAlumno.close();
		if (pstmtNotas != null)
			pstmtNotas.close();
		if (conn != null)
			conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	%>

</body>
</html>
