<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

String usuario="";
try {  //AQUI VA EL CONTROL DE SESION
	usuario=session.getAttribute("attributo2").toString();
	String acceso = session.getAttribute("attributo1").toString();
 	if (acceso.equals("1")){
 		%>
 		<p>Se ha validado el usuario</p>
 		<%
 	}
} catch (Exception e) {
	%>
	<p>No se ha validado el usuario</p>
	<%
}

%>

</body>
</html>