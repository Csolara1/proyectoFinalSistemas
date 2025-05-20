<%@ page import="java.sql.*"%>
<%
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String descripcion = request.getParameter("descripcion");
String fechaNacimiento = request.getParameter("fechaNacimiento");
String mensaje = "";

Connection conn = null;
PreparedStatement pstmt = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://172.190.114.187/TRABAJOFINAL", "adan", "Altair123$%");

	if (nombre != null && apellido != null && descripcion != null && fechaNacimiento != null) {
		String sql = "INSERT INTO alumnos (alumnoNombre, alumnoApellido, descripcion, fechaNacimiento) VALUES (?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nombre);
		pstmt.setString(2, apellido);
		pstmt.setString(3, descripcion);
		pstmt.setString(4, fechaNacimiento);

		int result = pstmt.executeUpdate();

		if (result > 0) {
	mensaje = "Alumno agregado exitosamente.";
		} else {
	mensaje = "Error al agregar el alumno.";
		}
	} else {
		mensaje = "Por favor, complete todos los campos.";
	}
} catch (Exception e) {
	e.printStackTrace();
	mensaje = "Ocurrió un error al agregar el alumno.";
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
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Agregar Alumno</title>
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

h2 {
	color: #6801FA;
}

label {
	display: block;
	margin: 10px 0;
	font-size: 1.1em;
}

input, button {
	padding: 10px;
	margin: 5px;
	width: 100%;
	max-width: 300px;
	font-size: 1em;
}

button {
	color: white;
	border-radius: 15px;
	background-color: #9A48FA;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
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
		<h2>Agregar Alumno</h2>

		<%
		if (mensaje != null && !mensaje.isEmpty()) {
		%>
		<p class="mensaje"><%=mensaje%></p>
		<%
		}
		%>

		<form action="agregarAlumno.jsp" method="POST">
			<label for="nombre">Nombre:</label> <input type="text" id="nombre"
				name="nombre" required> <label for="apellido">Apellido:</label>
			<input type="text" id="apellido" name="apellido" required> <label
				for="descripcion">Descripción:</label> <input type="text"
				id="descripcion" name="descripcion" required> <label
				for="fechaNacimiento">Fecha de Nacimiento:</label> <input
				type="date" id="fechaNacimiento" name="fechaNacimiento" required>

			<button type="submit">Agregar Alumno</button>
			<button onclick="window.location.href='prueba.jsp'">Volver
				atras</button>
		</form>
	</div>

</body>
</html>
