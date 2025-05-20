<%@ page import="mipk.beanDB" %>
<%@ page import="java.sql.SQLException" %>

<%
    beanDB bd = new beanDB();
    try {
        bd.conectarBD();
        out.println("<h2>Conexión establecida correctamente</h2>");
        bd.desconectarBD();
    } catch (Exception e) {
        out.println("<h2>Error al conectar con la base de datos</h2>");
        out.println("<p>" + e.getMessage() + "</p>");
    }
%>
