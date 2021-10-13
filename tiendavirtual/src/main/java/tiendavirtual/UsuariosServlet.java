package tiendavirtual;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class UsuariosServlet
 */
@WebServlet("/UsuariosServlet")
public class UsuariosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UsuariosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void agregarUsuarios(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	if(request.getParameter("numdoc_agre_usu") == "" || request.getParameter("email_agre_usu") == "" || request.getParameter("nom_agre_usu") == "" || request.getParameter("pass_agre_usu") == "" || request.getParameter("us_agre_usu") == "") {
    		val = "vaciousuarios";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
    	}else {
    		Usuarios usuario = new Usuarios();
        	int cedula = Integer.parseInt(request.getParameter("numdoc_agre_usu"));
        	usuario.setCedula_usuario(cedula);
        	usuario.setEmail_usuario(request.getParameter("email_agre_usu"));
        	usuario.setNombre_usuario(request.getParameter("nom_agre_usu"));
        	usuario.setPassword(request.getParameter("pass_agre_usu"));
        	usuario.setUsuario(request.getParameter("us_agre_usu"));
    	try {
    		respuesta = UsuariosJSON.postJSON(usuario);
    		if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
    			System.out.println("Usuario Agregado");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
    			System.out.println("Usuario no Agregado");
    		}
    		
    	}catch (IOException e){
    		// TODO: handle exception
    		e.printStackTrace();
    	}
    	}
    	
    }
    
    public void listarUsuarios(HttpServletRequest request, HttpServletResponse response){
    	try {
    		ArrayList<Usuarios> lista = UsuariosJSON.getJSON();
    		request.setAttribute("lista", lista);
    		request.getRequestDispatcher("/JSP/usuarios.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    	
    }
    
    public void EliminarUsuario(HttpServletRequest request, HttpServletResponse response){
    	Long id= Long.parseLong(request.getParameter("id"));			
		int respuesta = 0;
		String preloader = "preloader";
		try {
			   respuesta = UsuariosJSON.deleteJSON(id);
			   String val = "";
			   if (respuesta==200) {
				   val = "eliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
			   } else {
				   val = "errorEliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
				   System.out.println("error"+respuesta);
			   }

			   } catch (Exception e) {
				e.printStackTrace();
			   }	
    	
    }
    
    public void TraerUsuario(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("id"));
    	String val = "";
    	String preloader = "preloader";
		try {
           ArrayList<Usuarios> listausuario = UsuariosJSON.getJSON();	
		   for (Usuarios usuarios:listausuario){
			if (usuarios.getCedula_usuario()==id) {
				val = "usuariotraido";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.setAttribute("usuarioTraer", usuarios);
			   request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);	
			}
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
    
    public void BuscarUsuario(HttpServletRequest request, HttpServletResponse response) {
    	String val = "busca";
    	String preloader = "preloader";
		try {
			   ArrayList<Usuarios> lista = UsuariosJSON.getJSON();	
			   request.setAttribute("lista", lista);
			   request.setAttribute("buscar", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);	
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }

    public void actualizarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	
    	if(request.getParameter("numdoc_edit_usu") == "" || request.getParameter("email_edit_usu") == "" || request.getParameter("nom_edit_usu") == "" || request.getParameter("pass_edit_usu") == "" || request.getParameter("us_edit_usu") == "") {
    		val = "vacioeditar";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
    	}else {
    	
    	Usuarios usuario = new Usuarios();
    	int cedula = Integer.parseInt(request.getParameter("numdoc_edit_usu"));
    	usuario.setCedula_usuario(cedula);
    	usuario.setEmail_usuario(request.getParameter("email_edit_usu"));
    	usuario.setNombre_usuario(request.getParameter("nom_edit_usu"));
    	usuario.setPassword(request.getParameter("pass_edit_usu"));
    	usuario.setUsuario(request.getParameter("us_edit_usu"));
    	try {
    		respuesta = UsuariosJSON.putJSON(usuario,usuario.getCedula_usuario());
    		if (respuesta == 200) {
    			val = "editado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
    			System.out.println("Usuario editado");
    		} else {
    			val = "errorEditado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/UsuariosServlet?accion=Listar").forward(request, response);
    			System.out.println("Usuario no editado");
    		}
		   } catch (Exception e) {
			e.printStackTrace();
		   }
    	}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String accion = request.getParameter("accion");
		if (accion.equals("Listar")) {
			this.listarUsuarios(request, response);
		}else if(accion.equals("Eliminar")) {
			this.EliminarUsuario(request, response);
		}else if(accion.equals("Traer")) {
			this.TraerUsuario(request, response);
		}else if(accion.equals("buscar")) {
			this.BuscarUsuario(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		response.setContentType("text/html");		
		String accion = request.getParameter("accion");

		if(accion.equals("Agregar")){
			this.agregarUsuarios(request, response);
		}else if(accion.equals("Actualizar")) {
			this.actualizarUsuarios(request, response);
		}
	}

}
