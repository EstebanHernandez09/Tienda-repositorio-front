package tiendavirtual;

import java.io.IOException;


import java.util.ArrayList;
import java.util.List;

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
	
	List<DetalleVentas> listaVentas= new ArrayList<>();
	DetalleVentas lista_venta = new DetalleVentas();
       
	long contador = 0, acusubtotal = 0, totalpagar = 0, codProducto = 0, factura = 2;
	String nombre_producto = "";
	int cantidad = 0, valunitario = 0, subtotal = 0, iva = 0,valorIva = 0, acuIva=0;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VentasServlet() {
        super();
        // TODO Auto-generated constructor stub
    }	
    
    public void TraerCliente(HttpServletRequest request, HttpServletResponse response) {
    	Long id= Long.parseLong(request.getParameter("cedula_cliente"));
    	Long num= Long.parseLong(request.getParameter("num"));
    	String val = "";
    	String preloader = "preloader";
		try {
           ArrayList<Clientes> listacliente = ClientesJSON.getJSON();	
		   for (Clientes clientes:listacliente){
			if (clientes.getCedula_cliente()==id) {
				val = "clientetraido";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.setAttribute("numFac", num);
			   request.setAttribute("clienteTraer", clientes);
			  request.getRequestDispatcher("/VentasServlet?accion=factura").forward(request, response);	
			}
		   }
		   if(val == "") {
			   val = "noexiste";
			   request.setAttribute("traer", val);
			   //System.out.println(val);
			   request.setAttribute("numFac", num);
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
    	subtotal=Integer.parseInt(request.getParameter("subtotal"));
    	iva=Integer.parseInt(request.getParameter("iva"));
    	int total=Integer.parseInt(request.getParameter("total"));
    	Long num= Long.parseLong(request.getParameter("num"));
    	String val = "";
    	String preloader = "preloader";
		try {
           ArrayList<Productos> listaproducto = ProductosJSON.getJSON();	
		   for (Productos productos:listaproducto){
			if (productos.getCodigo_producto()==id) {
			   lista_venta = new DetalleVentas();
			   if(lista_venta != null) {
				   request.setAttribute("listaventas", listaVentas);
			   }
			   val = "productotraido";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.setAttribute("productoTraer", productos);
			   request.setAttribute("cedula", cedula);
			   request.setAttribute("cliente", cliente);
			   request.setAttribute("totalpagar", total);
		    	request.setAttribute("totalsubtotal", subtotal);
		    	request.setAttribute("numFac", num);
		    	request.setAttribute("totaliva", iva);
			   request.getRequestDispatcher("/VentasServlet?accion=factura").forward(request, response);	
			}
		   }
		   if(val == "") {
			   val = "noExiste";
			   request.setAttribute("traer", val);
			   request.setAttribute("preloader", preloader);
			   request.getRequestDispatcher("/VentasServlet?accion=factura").forward(request, response);
		   }
		 } catch (Exception e) {
	       	e.printStackTrace();
		 }
    }
    
    public void factura(HttpServletRequest request, HttpServletResponse response) {
    	try {
    		ArrayList<Ventas> lista = VentasJSON.getJSON();
    		int numFac= lista.size();
    		numFac=numFac+1;
    		request.setAttribute("numFac", numFac);
    		//System.out.println(numFac);
    		request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);
    	} catch (Exception e){
    		e.printStackTrace();
    	}
    }
    
    public void agregarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	double preunitario = 0.0, pretotalpagar = 0.0, preiva = 0.0, presubtotal = 0.0;
		long precodprod = 0, precant = 0;
		String prenomprod = "";
    	acusubtotal = 0;
    	acuIva = 0;
    	String preloader = "preloader";
    	lista_venta = new DetalleVentas(); 
    	Long cedula = Long.parseLong(request.getParameter("cedula_cliente"));
    	String cliente = request.getParameter("nombre_cliente");
    	codProducto=Long.parseLong(request.getParameter("cod_producto"));
    	nombre_producto=request.getParameter("nom_producto");
    	valunitario=Integer.parseInt(request.getParameter("valor_unitario"));
    	cantidad=Integer.parseInt(request.getParameter("cantidad"));
    	iva=Integer.parseInt(request.getParameter("iva"));
    	Long num= Long.parseLong(request.getParameter("num"));
    	
    	int valex = -1;
    	long subindice = 0,cont = 0;
    	for(int i=0; i<listaVentas.size();i++) {
    		if(listaVentas.get(i).getCodigo_producto() == codProducto) {
    			subindice = cont;
    			preunitario = listaVentas.get(i).getValor_unitario();
    			pretotalpagar = listaVentas.get(i).getValor_total();
    			precodprod = listaVentas.get(i).getCodigo_producto();
    			prenomprod = listaVentas.get(i).getNombre_producto();
    			precant = listaVentas.get(i).getCantidad_producto();
    			preiva = listaVentas.get(i).getValoriva();
    			presubtotal = listaVentas.get(i).getValor_venta();
    			valex = 1;
    			//System.out.println("existe");
    		}
    		cont++;
    	}
    	if(valex >=  0) {
    		int indice = (int) subindice; 
    		subtotal=(valunitario*cantidad)+ (int) presubtotal;
        	valorIva=(subtotal*iva/100);
        	cantidad=cantidad+(int) precant;
        	totalpagar=subtotal+valorIva;
    		lista_venta.setCodigo_producto(codProducto);
        	lista_venta.setNombre_producto(nombre_producto);
        	lista_venta.setValor_unitario(valunitario);
        	lista_venta.setCantidad_producto(cantidad);
        	lista_venta.setCodigo_venta(factura);
        	lista_venta.setValoriva(valorIva);
        	lista_venta.setValor_venta(subtotal);
        	lista_venta.setValor_total(totalpagar);
    		listaVentas.set(indice, lista_venta);
    		//System.out.println("actualizado");
    	}else {
    		contador++;
    		subtotal=(valunitario*cantidad);
        	valorIva=(subtotal*iva/100);
    		//almacena temporalmente cada producto
        	lista_venta.setCodigo_detalle_venta(Long.valueOf(contador));
        	lista_venta.setCodigo_producto(codProducto);
        	lista_venta.setNombre_producto(nombre_producto);
        	lista_venta.setValor_unitario(valunitario);
        	lista_venta.setCantidad_producto(cantidad);
        	lista_venta.setCodigo_venta(factura);
        	lista_venta.setValoriva(valorIva);
        	lista_venta.setValor_venta(subtotal);
        	lista_venta.setValor_total(totalpagar);
        	listaVentas.add(lista_venta);
    	}
    	for(int b=0; b<listaVentas.size();b++) {
    		acusubtotal += listaVentas.get(b).getValor_venta();
    		acuIva += listaVentas.get(b).getValoriva();
    	}
    	totalpagar = acusubtotal + acuIva;
    	lista_venta.setValor_total(totalpagar);
    	//una vez hecho todos los calculos ahora hacemos el envio de la info al formulario ventas seccion2
    	request.setAttribute("listaventas", listaVentas);
    	request.setAttribute("totalsubtotal", acusubtotal);
    	request.setAttribute("totaliva", acuIva);
    	request.setAttribute("totalpagar", totalpagar);
    	request.setAttribute("cedula", cedula);
		request.setAttribute("cliente", cliente);
		request.setAttribute("numFac", num);
		request.setAttribute("preloader", preloader);
    	request.getRequestDispatcher("/JSP/ventas.jsp").forward(request, response);	
    }
    
    public void ingresoVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int respuesta = 0;
    	String val = "";
    	String preloader = "preloader";
    	Ventas venta = new Ventas();
    	long cedula_cliente=Long.parseLong(request.getParameter("cedula_cliente"));
    	long cedula_usuario=Long.parseLong(request.getParameter("numdoc"));
    	long codigo_venta=Long.parseLong(request.getParameter("num"));
    	double ivaventa=Double.parseDouble(request.getParameter("iva"));
    	double totalventa=Double.parseDouble(request.getParameter("subtotal"));
    	double valorventa=Double.parseDouble(request.getParameter("total"));
    	
    	venta.setCodigo_venta(codigo_venta);
    	venta.setCedula_cliente(cedula_cliente);
    	venta.setCedula_usuario(cedula_usuario);
    	venta.setIvaventa(ivaventa);
    	venta.setTotal_venta(totalventa);
    	venta.setValor_venta(valorventa);
    	try {
    		respuesta = VentasJSON.postJSON(venta);
    		if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
				response.sendRedirect("http://localhost:6450/login/VentasServlet?accion=detalle&cod="+codigo_venta);
    			//request.getRequestDispatcher("/VentasServlet?accion=detalle&cod="+codigo_venta).forward(request, response);
    			System.out.println("venta Agregada");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/VentasServlet?accion=factura").forward(request, response);
    			System.out.println("Venta no Agregada");
    			System.out.println(respuesta);
    		}
    		
    	}catch (IOException e){
    		// TODO: handle exception
    		e.printStackTrace();
    	}
    }
    
    public void detalleVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int respuesta = 0, cantidad = 0;;
    	String val = "";
    	String preloader = "preloader";
    	double unitario = 0.0, totalpagar = 0.0, iva = 0.0, subtotal = 0.0;
		long codproducto = 0;
		long subindice = 0,cont = 0;
		long cod_venta =Long.parseLong(request.getParameter("cod"));
    	lista_venta = new DetalleVentas(); 
    	DetalleVentas detalleventa = new DetalleVentas();
   
    	try {
    		ArrayList<DetalleVentas> lista = DetalleVentasJSON.getJSON();
    		subindice = lista.size();
        	for(int i=0; i<listaVentas.size();i++) {
    			
    			unitario = listaVentas.get(i).getValor_unitario();
    			codproducto = listaVentas.get(i).getCodigo_producto();
    			cantidad = listaVentas.get(i).getCantidad_producto();
    			iva = listaVentas.get(i).getValoriva();
    			subtotal = listaVentas.get(i).getValor_venta();
    			//System.out.println("existe");
    			subtotal = subtotal + iva;
    			subindice++;
    			detalleventa.setCodigo_detalle_venta(subindice);
    			detalleventa.setCantidad_producto(cantidad);
    			detalleventa.setCodigo_producto(codproducto);
    			detalleventa.setCodigo_venta(cod_venta);
    			detalleventa.setValor_total(subtotal);
    			detalleventa.setValor_venta(unitario);
    			detalleventa.setValoriva(iva);
    			
    			try {
    	    		respuesta = DetalleVentasJSON.postJSON(detalleventa);
    	    		System.out.println(" detalle venta Agregada");
    	    		
    	    	}catch (IOException e){
    	    		// TODO: handle exception
    	    		e.printStackTrace();
    	    	}
        	}
        	
        	if (respuesta == 200) {
    			val = "excelente";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
    			request.getRequestDispatcher("/VentasServlet?accion=factura").forward(request, response);
    			System.out.println("detalle venta Agregada");
    		} else {
    			val = "error";
				request.setAttribute("respuesta", val);
				request.setAttribute("preloader", preloader);
				//request.getRequestDispatcher("/VentasServlet?accion=factura").forward(request, response);
    			System.out.println("detalle Venta no Agregada");
    			System.out.println(respuesta);
    		}
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
		if (accion.equals("Traer")) {
			this.TraerCliente(request, response);
		}else if (accion.equals("Traerp")) {
			this.TraerProducto(request, response);
		}else if (accion.equals("add")) {
			this.agregarProducto(request, response);
		}else if (accion.equals("factura")) {
			this.factura(request, response);
		}else if (accion.equals("ingreso")) {
			this.ingresoVenta(request, response);
		}else if (accion.equals("detalle")) {
			this.detalleVenta(request, response);
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
