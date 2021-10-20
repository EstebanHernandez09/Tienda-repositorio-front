package tiendavirtual;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.csvreader.CsvReader;

/**
 * Servlet implementation class CargarArchivo
 */
@WebServlet("/CargarArchivo")
public class CargarArchivo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		String accion = request.getParameter("Procesar");
		if (accion.equals("Procesar")) {
			System.out.println("Procesar");
		}
		System.out.println("Entro Sevlet");
		String nomb = request.getParameter("nombre");
		System.out.println(nomb);
		Part arch = request.getPart("archivo");
		String process = request.getParameter("Procesar");
		InputStream is = arch.getInputStream();
		Charset charset = Charset.forName("UTF-8");
		
		if (process != null) {
			if(is.available() ==0) {
				is.close();
				System.out.println("Entro error sin archivo");
				request.setAttribute("error", 1);//error no se ha seleccionado el archivo
				request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
			}else {
				if(ProductosJSON.validarCSV(nomb)) {
					try {
						String registros = "";
						boolean reg_no_cargados = false;
						System.out.println("entro a csvreader");
						CsvReader leerproducto = new CsvReader(is, charset);
						leerproducto.readHeaders();
						List<Productos> productos = new ArrayList<Productos>(); // Lista donde se guardara los datos
						while(leerproducto.readRecord()) {
							String codigo = leerproducto.get(0);
							String iva = leerproducto.get(1);
							String nit = leerproducto.get(2);
							String nombre = leerproducto.get(3);
							String compra = leerproducto.get(4);
							String venta = leerproducto.get(5);
							
							//a�ade lo leido a una lista tipo productos
						productos.add(new Productos(Long.parseLong(codigo), Double.parseDouble(iva), Long.parseLong(nit), nombre, Double.parseDouble(compra), Double.parseDouble(venta)));
						}
						is.close();
						System.out.println("Entro en boton");
						ArrayList<Productos> listafinal = new ArrayList<Productos>();
						try {
							
							ArrayList<Proveedores> lista = ProveedoresJSON.getJSON();
							for (Proveedores suplier:lista) {
								for(Productos item:productos) {
									if(suplier.getNitproveedor() == item.getNitproveedor()) {
										System.out.println("Entro for if");
										listafinal.add(item);
									}else {
										registros = String.valueOf(item.getNitproveedor())+",";
										reg_no_cargados =  true;
									}
								}
							}
						} catch (Exception e) {
							System.out.println("Entro catch");
							System.out.println("Catch :(");
							// TODO: handle exception
						}
						String registros2 = "";
						int ban= 3;
						int validacion = 0;
						for(Productos item:listafinal) {
							ArrayList<Productos> listaproductos = ProductosJSON.getJSON();
							for(Productos item2:listaproductos) {
								if(item.getCodigo_producto()!=item2.getCodigo_producto()) {
									validacion = ProductosJSON.postJSON(item);
									if(validacion==200) {
										ban = (ban * 0) + 2;
									}
								}else {
									registros2 = String.valueOf(item.getCodigo_producto())+",";
								}
							}		
						}
						if(validacion == 200) {
							System.out.println("carga existosa");
							request.setAttribute("error", 2); //carga exitosa de csv
							request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
						}else {
							System.out.println("los registros no se cargaron");
							request.setAttribute("error", 4); //Registros no se cargaron
							request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
						}
					}catch(Exception e){
						System.out.println("Entro datos invalidos");
						request.setAttribute("error", 0);//error datos leidos invalidos
						request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
					}finally {
						is.close();
					}
				}else {
					is.close();
					System.out.println("Entro error formato");
					request.setAttribute("error", 3);//error datos leidos invalidos
					request.getRequestDispatcher("/ProductosServlet?accion=Listar").forward(request, response);
					//request.getRequestDispatcher("/ValidacionProductos?validar=3&error=3").forward(request, response);
				}
			}		
		}
		

	}

}
