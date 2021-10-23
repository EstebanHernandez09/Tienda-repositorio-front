package tiendavirtual;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
/**
 * Servlet implementation class CargarArchivo
 */
@WebServlet("/CargarArchivo")
@MultipartConfig
public class CargarArchivo extends HttpServlet {
	private static final long serialVersionUID = 1L;
	List<Productos> listaProductos= new ArrayList<>();
	Productos lista_producto = new Productos();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CargarArchivo() {
        super();
        // TODO Auto-generated constructor stub
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
		long nit = 0, cod = 0;
		double compra = 0, venta = 0, iva = 0;
		String preloader = "preloader", vali = "", nom = "";
		int respuesta = 0;
		System.out.println("Entro Sevlet");
		String nomb = request.getParameter("nombre");
		Part arch = request.getPart("archivo");
		String process = request.getParameter("procesar");
		InputStream is = arch.getInputStream();
		String cadena;
		BufferedReader b = new BufferedReader(new InputStreamReader(is));
		lista_producto = new Productos(); 
		ArrayList lista = new ArrayList();
		ArrayList listas = new ArrayList();
		while((cadena = b.readLine())!=null) {
			  String result = cadena.replaceAll("\"", "");
	         // System.out.println(result);
	          lista.add(result);
	      }
		//System.out.println(lista);
		lista.remove(0);
		for(int i=0; i<lista.size();i++) {
			String result = lista.get(i).toString();
			//System.out.println(lista.get(i).toString());
			//System.out.println(listas);
			String[] arr = result.split(",");
	        for (String corr: arr) {
	        	listas.add(corr);
	        	//System.out.println(corr);
	        }
		}
		long cont=0;
		for(int i=0; i<listas.size();i++) {
			//System.out.println(listas.get(i));
			if(cont<=5) {
				String val = String.valueOf(listas.get(i));
				if(cont == 0) {
					cod = Long.parseLong(val);
					System.out.println(cod);
				}else if(cont == 1) {
					iva = Double.parseDouble(val);
					System.out.println(iva);
				}else if(cont == 2) {
					nit = Long.parseLong(val);
					System.out.println(nit);
				}else if(cont == 3) {
					nom = val;
					System.out.println(nom);
				}else if(cont == 4) {
					compra = Double.parseDouble(val);
					System.out.println(compra);
				}else if(cont == 5) {
					venta = Double.parseDouble(val);
					System.out.println(venta);
					cont=-1;
					lista_producto.setCodigo_producto(Long.valueOf(cod));
					lista_producto.setIvacompra(iva);
					lista_producto.setNitproveedor(nit);
					lista_producto.setNombre_producto(nom);
					lista_producto.setPrecio_compra(compra);
					lista_producto.setPrecio_venta(venta);
					try {
						System.out.println("llego a json");
			    		 respuesta = ProductosJSON.postJSON(lista_producto);
			    	}catch (IOException e){
			    		// TODO: handle exception
			    		e.printStackTrace();
			    	}
				}
				cont++;
			}else {
				cont=0;
			}
		}
		
		if (respuesta == 200) {
			vali = "importado";
			request.setAttribute("respuesta", vali);
			request.setAttribute("preloader", preloader);
			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
			System.out.println("productos Agregados");
		} else {
			vali = "errorimportado";
			request.setAttribute("respuesta", vali);
			request.setAttribute("preloader", preloader);
			request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
			System.out.println("productos no Agregados");
			System.out.println(respuesta);
		}
		//System.out.println(listas);
		b.close();
	}
}
