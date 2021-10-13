package tiendavirtual;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProveedoresServlet
 */
@WebServlet("/ProveedoresServlet")
public class ProveedoresServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProveedoresServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void agregarProveedor(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	if(request.getParameter("nit_agre_pro") == "" || request.getParameter("dir_agre_cli") == "" || request.getParameter("email_agre_cli") == "" || request.getParameter("nom_agre_cli") == "" || request.getParameter("tel_agre_cli") == "") {
    		val = "vacioagregar";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
    	}else {
    		Proveedores proveedor = new Proveedores();
        	long nit = Long.parseLong(request.getParameter("nit_agre_pro"));
        	proveedor.setNitproveedor(nit);
        	proveedor.setCiudad_proveedor(request.getParameter("ciu_agre_pro"));
        	proveedor.setDireccion_proveedor(request.getParameter("dir_agre_pro"));
        	proveedor.setNombre_proveedor(request.getParameter("nom_agre_pro"));
        	proveedor.setTelefono_proveedor(request.getParameter("Tel_agre_pro"));
    	try {
    		respuesta = ProveedoresJSON.postJSON(proveedor);
    		if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
    			System.out.println("Proveedor Agregado");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
    			System.out.println("Proveedor no Agregado");
    		}
    		
    	}catch (IOException e){
    		// TODO: handle exception
    		e.printStackTrace();
    	}
    	}
    	
    }
    
    public void listarProveedores(HttpServletRequest request, HttpServletResponse response){
    	try {
    		ArrayList<Proveedores> lista = ProveedoresJSON.getJSON();
    		request.setAttribute("lista", lista);
    		request.getRequestDispatcher("/JSP/proveedores.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    	
    }
    
    public void EliminarProveedor(HttpServletRequest request, HttpServletResponse response){
    	Long id= Long.parseLong(request.getParameter("id"));			
		int respuesta = 0;
		String preloader = "preloader";
		try {
			   respuesta = ProveedoresJSON.deleteJSON(id);
			   String val = "";
			   if (respuesta==200) {
				   val = "eliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
			   } else {
				   val = "errorEliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
				   System.out.println("error"+respuesta);
			   }

			   } catch (Exception e) {
				e.printStackTrace();
			   }	
    	
    }
    
    public void TraerProveedor(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("id"));
    	String val = "";
    	String preloader = "preloader";
		try {
           ArrayList<Proveedores> listaproveedor = ProveedoresJSON.getJSON();	
		   for (Proveedores proveedores:listaproveedor){
			if (proveedores.getNitproveedor()==id) {
				val = "proveedortraido";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.setAttribute("proveedorTraer", proveedores);
			   request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);	
			}
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
    
    public void BuscarProveedor(HttpServletRequest request, HttpServletResponse response) {
    	String val = "busca";
    	String preloader = "preloader";
		try {
			   ArrayList<Proveedores> lista = ProveedoresJSON.getJSON();	
			   request.setAttribute("lista", lista);
			   request.setAttribute("buscar", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);	
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }

    public void actualizarProveedor(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	
    	if(request.getParameter("nit_edit_pro") == "" || request.getParameter("ciu_edit_pro") == "" || request.getParameter("dir_edit_pro") == "" || request.getParameter("nom_edit_pro") == "" || request.getParameter("Tel_edit_pro") == "") {
    		val = "vacioeditar";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
    	}else {
    		Proveedores proveedor = new Proveedores();
        	long nit = Long.parseLong(request.getParameter("nit_edit_pro"));
        	proveedor.setNitproveedor(nit);
        	proveedor.setCiudad_proveedor(request.getParameter("ciu_edit_pro"));
        	proveedor.setDireccion_proveedor(request.getParameter("dir_edit_pro"));
        	proveedor.setNombre_proveedor(request.getParameter("nom_edit_pro"));
        	proveedor.setTelefono_proveedor(request.getParameter("Tel_edit_pro"));
    	try {
    		respuesta = ProveedoresJSON.putJSON(proveedor,proveedor.getNitproveedor());
    		if (respuesta == 200) {
    			val = "editado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
    			System.out.println("proveedor editado");
    		} else {
    			val = "errorEditado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProveedoresServlet?accion=Listar").forward(request, response);
    			System.out.println("proveedor no editado");
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
			this.listarProveedores(request, response);
		}else if(accion.equals("Eliminar")) {
			this.EliminarProveedor(request, response);
		}else if(accion.equals("Traer")) {
			this.TraerProveedor(request, response);
		}else if(accion.equals("buscar")) {
			this.BuscarProveedor(request, response);
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
			this.agregarProveedor(request, response);
		}else if(accion.equals("Actualizar")) {
			this.actualizarProveedor(request, response);
		}
	}

}
