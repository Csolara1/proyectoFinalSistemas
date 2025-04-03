<%@ page import="java.sql.*"%>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String orderBy = request.getParameter("order");
String query = "SELECT alumnoID, alumnoNombre FROM alumnos";

if ("asc".equals(orderBy)) {
	query += " ORDER BY alumnoNombre ASC";
} else if ("desc".equals(orderBy)) {
	query += " ORDER BY alumnoNombre DESC";
}

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://host/TRABAJOFINAL", "user", "password%");

	stmt = conn.createStatement();
	rs = stmt.executeQuery(query);
} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Lista de Alumnos</title>
<style>
body {
	background-color: teal;
	color: white;
	font-family: Arial, sans-serif;
	text-align: center;
	margin-top: 50px;
}

h1 {
	color: white;
}

ul {
	list-style-type: none;
	padding: 0;
}

li {
	margin: 10px 0;
}

a {
	color: yellow;
	text-decoration: none;
}

button {
	color: white; 
	border-radius : 15px;	
	background-color: #9A48FA;
	padding: 10px 20px;
	font-size: 16px;
	margin-bottom: 20px;
	cursor: pointer;
}

button:hover {
	background-color: #6801FA;
	color: white;
}
</style>
</head>
<body>

	<h1>Lista de Alumnos</h1>

	<button onclick="window.location.href='alumnos.jsp?order=asc'">Ordenar
		A-Z</button>
	<button onclick="window.location.href='alumnos.jsp?order=desc'">Ordenar
		Z-A</button>

	<ul>
		<%
		if (rs != null) {
			while (rs.next()) {
		%>
		<li><a href="alumnoInformacion.jsp?id=<%=rs.getInt("alumnoID")%>"><%=rs.getString("alumnoNombre")%></a></li>
		<%
		}
		}
		%>
	</ul>

	<button onclick="window.location.href='prueba.jsp'">Volver
		atrás</button>

</body>
</html>
