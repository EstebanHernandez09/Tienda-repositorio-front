package tiendavirtual;

import java.io.PrintWriter;


import java.net.URL;
import java.util.ArrayList;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void validarUsuarios(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			ArrayList<Usuarios> lista = UsuariosJSON.getJSON();
			request.setAttribute("lista", lista);
			String usua = request.getParameter("nombre_usuario");
			String pass = request.getParameter("contrasena");
			int respuesta = 0;
			String val = "";
			for (Usuarios usuario : lista) {
				if (usuario.getUsuario().equals(usua) && usuario.getPassword().equals(pass)) {
					String email = usuario.getEmail_usuario();
					HttpSession sesion = request.getSession();
					sesion.setAttribute("usuario", usua);
					sesion.setAttribute("email", email);
					request.setAttribute("usuario", usuario);
					val = "ingreso";
					request.setAttribute("respuesta", val);
					//response.sendRedirect ( "http://localhost:6450/login/JSP/usuarios.jsp" );  
					request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
					//response.sendRedirect ( "http://localhost:6450/login/JSP/usuarios.jsp" );
					respuesta = 1;
				}

			}

			if (respuesta == 0) {
				val = "error";
				request.setAttribute("respuesta", val);
				//response.sendRedirect ( "http://localhost:6450/login/JSP/login.jsp" );  
				request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
				//response.sendRedirect ( "http://localhost:6450/login/JSP/login.jsp" );  
				System.out.println("No se encontraron datos");
			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
    
    public void cerrarSesion(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	try {
    		HttpSession sesion = request.getSession();
    		sesion.removeAttribute("nombre");
    		sesion.removeAttribute("usuario");
    		response.sendRedirect("http://localhost:6450/login/JSP/login.jsp");
    	} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    }
    
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		response.setContentType("text/html");		
		String accion = request.getParameter("accion");

		if (accion.equals("Ingresar")) {
			this.validarUsuarios(request, response);
		}else if(accion.equals("Cerrar sesion")){
			this.cerrarSesion(request, response);
		}
	}

}
