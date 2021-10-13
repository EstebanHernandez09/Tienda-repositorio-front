package tiendavirtual;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class VentasServlet
 */
@WebServlet("/VentasServlet")
public class VentasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VentasServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void crearConsecutivo(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    		Ventas venta = new Ventas();
    		venta.setIvaventa(0);
    		venta.setTotal_venta(0);
    		venta.setValor_venta(0);
    	try {
    		respuesta = VentasJSON.postJSON(venta);
    		if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);
    			System.out.println("Cliente Agregado");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);
    			System.out.println("Cliente no Agregado");
    		}
    		
    	}catch (IOException e){
    		// TODO: handle exception
    		e.printStackTrace();
    	}
    }
    	
    
    public void TraerCliente(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("cedula_cliente"));
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
			   
			  request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);	
			}
		   }
		   if(val == "") {
			   val = "noExiste";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
    
    public void TraerProducto(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("cod_producto"));
    	Long cedula = Long.parseLong(request.getParameter("cedula_cliente"));
    	String cliente = request.getParameter("nombre_cliente");
    	String val = "";
    	String preloader = "preloader";
		try {
           ArrayList<Productos> listaproducto = ProductosJSON.getJSON();	
		   for (Productos productos:listaproducto){
			if (productos.getCodigo_producto()==id) {
				val = "productotraido";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.setAttribute("productoTraer", productos);
			   request.setAttribute("cedula", cedula);
			   request.setAttribute("cliente", cliente);
			   request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);	
			}
		   }
		   if(val == "") {
			   val = "noExiste";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String accion = request.getParameter("accion");
		if (accion.equals("Traer")) {
			this.TraerCliente(request, response);
		}else if (accion.equals("Traerp")) {
			this.TraerProducto(request, response);
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
