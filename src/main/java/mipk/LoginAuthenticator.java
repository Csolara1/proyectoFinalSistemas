package mipk;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 * Servlet implementation class LoginAuthenticator
 */
@WebServlet("/LoginAuthenticator")
public class LoginAuthenticator extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String usuvalido = "admin";
	private String pwdvalida = "1234";
	private String usuvalido1 = "pepe";
	private String pwdvalida1 = "1234";
	private String usuvalido2 = "toor";
	private String pwdvalida2 = "1234";	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginAuthenticator() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("./index.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		beanDB db = new beanDB();
		HttpSession session = request.getSession();
		String usuario=request.getParameter("usuario");
		String pass=request.getParameter("pass");
		if (usuario == null) usuario="";
		if (pass == null) pass="";
		boolean ok=false;
		
		if(usuario.equals(usuvalido) && pass.equals(pwdvalida)) {
			session.setAttribute("attributo2",usuario);
			session.setAttribute("attributo1","2");
			ok=true;
		} else if(usuario.equals(usuvalido1) && pass.equals(pwdvalida1)) {
			session.setAttribute("attributo2",usuario);
			session.setAttribute("attributo1","0");
			ok=true;
		} else if(usuario.equals(usuvalido2) && pass.equals(pwdvalida2)) {
			session.setAttribute("attributo2",usuario);
			session.setAttribute("attributo1","3");
			ok=true;
		}
				
		if (ok) response.sendRedirect("bienvenido.jsp");
		else response.sendRedirect("index.jsp");

	}


}
