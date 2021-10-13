package tiendavirtual;

import java.io.IOException;


import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ClientesServlet
 */
@WebServlet("/ClientesServlet")
public class ClientesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void agregarCliente(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	if(request.getParameter("num_agre_cli") == "" || request.getParameter("dir_agre_cli") == "" || request.getParameter("email_agre_cli") == "" || request.getParameter("nom_agre_cli") == "" || request.getParameter("tel_agre_cli") == "") {
    		val = "vaciousuarios";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
    	}else {
    		Clientes cliente = new Clientes();
        	long cedula = Long.parseLong(request.getParameter("num_agre_cli"));
        	cliente.setCedula_cliente(cedula);
        	cliente.setDireccion_cliente(request.getParameter("dir_agre_cli"));
        	cliente.setEmail_cliente(request.getParameter("email_agre_cli"));
        	cliente.setNombre_cliente(request.getParameter("nom_agre_cli"));
        	cliente.setTelefono_cliente(request.getParameter("tel_agre_cli"));
    	try {
    		respuesta = ClientesJSON.postJSON(cliente);
    		if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
    			System.out.println("Cliente Agregado");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
    			System.out.println("Cliente no Agregado");
    		}
    		
    	}catch (IOException e){
    		// TODO: handle exception
    		e.printStackTrace();
    	}
    	}
    	
    }
    
    public void listarClientes(HttpServletRequest request, HttpServletResponse response){
    	try {
    		ArrayList<Clientes> lista = ClientesJSON.getJSON();
    		request.setAttribute("lista", lista);
    		request.getRequestDispatcher("/JSP/clientes.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    	
    }
    
    public void EliminarCliente(HttpServletRequest request, HttpServletResponse response){
    	Long id= Long.parseLong(request.getParameter("id"));			
		int respuesta = 0;
		String preloader = "preloader";
		try {
			   respuesta = ClientesJSON.deleteJSON(id);
			   String val = "";
			   if (respuesta==200) {
				   val = "eliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
			   } else {
				   val = "errorEliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
				   System.out.println("error"+respuesta);
			   }

			   } catch (Exception e) {
				e.printStackTrace();
			   }	
    	
    }
    
    public void TraerCliente(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("id"));
    	String val = "";
    	String preloader = "preloader";
		try {
           ArrayList<Clientes> listacliente = ClientesJSON.getJSON();	
		   for (Clientes clientes:listacliente){
			if (clientes.getCedula_cliente()==id) {
				val = "clientetraido";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.setAttribute("clienteTraer", clientes);
			   request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);	
			}
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
    
    public void BuscarCliente(HttpServletRequest request, HttpServletResponse response) {
    	String val = "busca";
    	String preloader = "preloader";
		try {
			   ArrayList<Clientes> lista = ClientesJSON.getJSON();	
			   request.setAttribute("lista", lista);
			   request.setAttribute("buscar", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);	
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }

    public void actualizarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	
    	if(request.getParameter("num_edit_cli") == "" || request.getParameter("dir_edit_cli") == "" || request.getParameter("email_edit_cli") == "" || request.getParameter("nom_edit_cli") == "" || request.getParameter("tel_edit_cli") == "") {
    		val = "vacioeditar";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
    	}else {
    		Clientes cliente = new Clientes();
        	long cedula = Long.parseLong(request.getParameter("num_edit_cli"));
        	cliente.setCedula_cliente(cedula);
        	cliente.setDireccion_cliente(request.getParameter("dir_edit_cli"));
        	cliente.setEmail_cliente(request.getParameter("email_edit_cli"));
        	cliente.setNombre_cliente(request.getParameter("nom_edit_cli"));
        	cliente.setTelefono_cliente(request.getParameter("tel_edit_cli"));
    	try {
    		respuesta = ClientesJSON.putJSON(cliente,cliente.getCedula_cliente());
    		if (respuesta == 200) {
    			val = "editado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
    			System.out.println("cliente editado");
    		} else {
    			val = "errorEditado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ClientesServlet?accion=Listar").forward(request, response);
    			System.out.println("cliente no editado");
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
			this.listarClientes(request, response);
		}else if(accion.equals("Eliminar")) {
			this.EliminarCliente(request, response);
		}else if(accion.equals("Traer")) {
			this.TraerCliente(request, response);
		}else if(accion.equals("buscar")) {
			this.BuscarCliente(request, response);
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
			this.agregarCliente(request, response);
		}else if(accion.equals("Actualizar")) {
			this.actualizarCliente(request, response);
		}
	}

}
