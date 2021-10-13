package tiendavirtual;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class ProductosJSON {
	private static URL url;
	private static String sitio = "http://localhost:8585/";
	
	//agregar informacion a la tabla clientes
	
		public static ArrayList<Productos> parsingProductos(String json) throws ParseException {//devuelve un arraylist
			JSONParser jsonParser = new JSONParser();
			ArrayList<Productos> lista = new ArrayList<Productos>();
			JSONArray productos = (JSONArray) jsonParser.parse(json);
			Iterator i = productos.iterator(); //recorrer la tabla productos
			while (i.hasNext()) {
				JSONObject innerObj = (JSONObject) i.next();
				Productos producto = new Productos();
				producto.setCodigo_producto(Long.parseLong(innerObj.get("codigo_producto").toString())); //convertir de String a Long
				producto.setIvacompra(Double.parseDouble(innerObj.get("ivacompra").toString())); 
				producto.setNitproveedor(Long.parseLong(innerObj.get("nitproveedor").toString())); 
				producto.setNombre_producto(innerObj.get("nombre_producto").toString());
				producto.setPrecio_compra(Double.parseDouble(innerObj.get("precio_compra").toString())); 
				producto.setPrecio_venta(Double.parseDouble(innerObj.get("precio_venta").toString())); 
				lista.add(producto);
			}
			return lista;
		}
	//listar la informacion
		public static ArrayList<Productos> getJSON() throws IOException, ParseException { //devolver un listado JSON

			url = new URL(sitio + "productos/listar"); //trae el metodo de Clientes.API 
			HttpURLConnection http = (HttpURLConnection) url.openConnection();

			http.setRequestMethod("GET");
			http.setRequestProperty("Accept", "application/json");

			InputStream respuesta = http.getInputStream();
			byte[] inp = respuesta.readAllBytes();
			String json = "";

			for (int i = 0; i < inp.length; i++) {
				json += (char) inp[i];
			}

			ArrayList<Productos> lista = new ArrayList<Productos>();
			lista = parsingProductos(json);
			http.disconnect();
			return lista;
		}

}
