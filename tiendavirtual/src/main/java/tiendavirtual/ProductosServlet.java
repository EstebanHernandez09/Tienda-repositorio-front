package tiendavirtual;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.csvreader.CsvReader;

/**
 * Servlet implementation class ProductosServlet
 */
@WebServlet("/ProductosServlet")
@MultipartConfig
public class ProductosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductosServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void agregarProducto(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	if(request.getParameter("cod_producto") == "" || request.getParameter("nom_agre_pro") == "" || request.getParameter("nit_agre_pro") == "" || request.getParameter("iva_agre_pro") == "" || request.getParameter("compra_agre_usu") == "" || request.getParameter("venta_agre_usu") == "") {
    		val = "vacioproductos";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
    	}else {
    		Productos producto = new Productos();
        	long cod = Long.parseLong(request.getParameter("cod_producto"));
        	double iva = Double.parseDouble(request.getParameter("iva_agre_pro"));
        	long nit = Long.parseLong(request.getParameter("nit_agre_pro"));
        	double compra = Double.parseDouble(request.getParameter("compra_agre_usu"));
        	double venta = Double.parseDouble(request.getParameter("venta_agre_usu"));
        	
        	producto.setCodigo_producto(cod);
        	producto.setIvacompra(iva);
        	producto.setNitproveedor(nit);
        	producto.setNombre_producto(request.getParameter("nom_agre_pro"));
        	producto.setPrecio_compra(compra);
        	producto.setPrecio_venta(venta);
        	
    	try {
    		respuesta = ProductosJSON.postJSON(producto);
    		if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
    			System.out.println("Producto Agregado");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
    			System.out.println("Producto no Agregado");
    		}
    		
    	}catch (IOException e){
    		// TODO: handle exception
    		e.printStackTrace();
    	}
    	}
    	
    }
    
    public void listarProductos(HttpServletRequest request, HttpServletResponse response){
    	try {
    		ArrayList<Productos> lista = ProductosJSON.getJSON();
    		request.setAttribute("lista", lista);
    		request.getRequestDispatcher("/JSP/productos.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    	
    }
    
    public void EliminarProducto(HttpServletRequest request, HttpServletResponse response){
    	Long id= Long.parseLong(request.getParameter("id"));			
		int respuesta = 0;
		String preloader = "preloader";
		try {
			   respuesta = ProductosJSON.deleteJSON(id);
			   String val = "";
			   if (respuesta==200) {
				   val = "eliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
			   } else {
				   val = "errorEliminado";
				   request.setAttribute("respuesta", val);
				   request.setAttribute("preloader", preloader);
				   request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
				   System.out.println("error"+respuesta);
			   }

			   } catch (Exception e) {
				e.printStackTrace();
			   }	
    	
    }
    
    public void TraerProducto(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("id"));
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
			   request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);	
			}
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
    
    public void BuscarProducto(HttpServletRequest request, HttpServletResponse response) {
    	String val = "busca";
    	String preloader = "preloader";
		try {
			   ArrayList<Productos> lista = ProductosJSON.getJSON();	
			   request.setAttribute("lista", lista);
			   request.setAttribute("buscar", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);	
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }

    public void actualizarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	
    	if(request.getParameter("cod_producto") == "" || request.getParameter("nom_edit_pro") == "" || request.getParameter("nit_edit_pro") == "" || request.getParameter("iva_edit_pro") == "" || request.getParameter("compra_edit_usu") == "" || request.getParameter("venta_edit_usu") == "") {
    		val = "vacioeditar";
    		request.setAttribute("preloader", preloader);
    		request.setAttribute("respuesta", val);
			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
    	}else {
    	
    		Productos producto = new Productos();
        	long cod = Long.parseLong(request.getParameter("cod_producto"));
        	double iva = Double.parseDouble(request.getParameter("iva_edit_pro"));
        	long nit = Long.parseLong(request.getParameter("nit_edit_pro"));
        	double compra = Double.parseDouble(request.getParameter("compra_edit_usu"));
        	double venta = Double.parseDouble(request.getParameter("venta_edit_usu"));
        	
        	producto.setCodigo_producto(cod);
        	producto.setIvacompra(iva);
        	producto.setNitproveedor(nit);
        	producto.setNombre_producto(request.getParameter("nom_edit_pro"));
        	producto.setPrecio_compra(compra);
        	producto.setPrecio_venta(venta);
    	try {
    		respuesta = ProductosJSON.putJSON(producto,producto.getCodigo_producto());
    		if (respuesta == 200) {
    			val = "editado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
    			System.out.println("producto editado");
    		} else {
    			val = "errorEditado";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
    			System.out.println("producto no editado");
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
			this.listarProductos(request, response);
		}else if(accion.equals("Eliminar")) {
			this.EliminarProducto(request, response);
		}else if(accion.equals("Traer")) {
			this.TraerProducto(request, response);
		}else if(accion.equals("buscar")) {
			this.BuscarProducto(request, response);
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
			this.agregarProducto(request, response);
		}else if(accion.equals("Actualizar")) {
			this.actualizarProductos(request, response);
		}
	}

}
