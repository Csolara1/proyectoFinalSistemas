<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Página de Exámenes</title>
<style>
body {
    background: teal;
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 50px;
}

.container {
    max-width: 600px;
    margin: auto;
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

ul {
    list-style: none;
    padding: 0;
}

li {
    font-size: 18px;
    margin: 10px 0;
}

a {
    text-decoration: none;
    color: yellow;
    font-size: 18px;
}

a:hover {
    text-decoration: underline;
}

button:hover {
	background-color: #6801FA;
	color: white;
}

</style>
</head>
<body>
    <div class="container">
        <h1>Bienvenido</h1>
        <button onclick="window.location.href='alumnos.jsp'">Ver Alumnos</button>
        <h2>Exámenes Disponibles</h2>
        <ul>
            <li><a href="examenes.jsp?examenID=1">Query</a></li>
            <li><a href="examenes.jsp?examenID=2">DDL/DML</a></li>
            <li><a href="examenes.jsp?examenID=3">Diseño</a></li>
        </ul>
        <br>
        <button onclick="window.location.href='calificar.jsp'">Calificar</button>
        <br>
        <button onclick="window.location.href='agregarAlumno.jsp'">Añadir alumno</button>
        <br>
        <button onclick="window.location.href='borrarAlumno.jsp'">Eliminar alumno</button>
        <br>
        <button onclick="window.location.href='bienvenido.jsp'">Volver al Inicio</button>
    </div>
</body>
</html>
