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


if(session.getAttribute("attributo1").toString().equals("3")){
	%> Bienvenido a la pagina exclusiva para super admins. <%
}else{
	%> No puedes entrar. <%
}

%>
</body>
</html>