package tiendavirtual;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ReportesServlet
 */
@WebServlet("/ReportesServlet")
public class ReportesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportesServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void ListarUsuarios(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	try {
    		ArrayList<Usuarios> lista = UsuariosJSON.getJSON();
    		request.setAttribute("lista", lista);
    		request.getRequestDispatcher("/JSP/listado_usuarios.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    }
    
    public void ListarClientes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	try {
    		ArrayList<Clientes> lista = ClientesJSON.getJSON();
    		request.setAttribute("lista", lista);
    		request.getRequestDispatcher("/JSP/listado_clientes.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    }

	 void ListarVentasCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	    	try {
	    		ArrayList<Clientes> lista = ClientesJSON.getJSON();
	    		request.setAttribute("lista", lista);
	    		ArrayList<Ventas> listaventas = VentasJSON.getJSON();
	    		request.setAttribute("listaventas", listaventas);
	    		request.getRequestDispatcher("/JSP/listado_ventas_clientes.jsp").forward(request, response);
	    	} catch (Exception e){
	    		e.printStackTrace();
	    	}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String accion = request.getParameter("accion");
		if (accion.equals("listado de Usuarios")) {
			this.ListarUsuarios(request, response);
		}else if(accion.equals("listado de Clientes")) {
			this.ListarClientes(request, response);
		}else if(accion.equals("Ventas por Cliente")) {
			this.ListarVentasCliente(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
