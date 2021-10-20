package tiendavirtual;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

public class ProductosJSON {
	private static URL url;
	private static String sitio = "http://localhost:8585/";
	
	//agregar informacion a la tabla productos
	
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
		
		
		public static int postJSON(Productos producto) throws IOException {

			url = new URL(sitio + "productos/guardar");
			HttpURLConnection http;
			http = (HttpURLConnection) url.openConnection();

			try {
				http.setRequestMethod("POST");
			} catch (ProtocolException e) {
				e.printStackTrace();
			}

			http.setDoOutput(true);
			http.setRequestProperty("Accept", "application/json");
			http.setRequestProperty("Content-Type", "application/json");

			String data = "{" + "\"codigo_producto\":\"" + String.valueOf(producto.getCodigo_producto())
					+ "\",\"ivacompra\": \"" + producto.getIvacompra() 
					+ "\",\"nitproveedor\": \"" + producto.getNitproveedor()
					+ "\",\"nombre_producto\":\"" + producto.getNombre_producto()
					+ "\",\"precio_compra\":\"" + producto.getPrecio_compra()
					+ "\",\"precio_venta\":\"" + producto.getPrecio_venta() + "\"}";
			
			byte[] out = data.getBytes(StandardCharsets.UTF_8);
			OutputStream stream = http.getOutputStream();
			stream.write(out);

			int respuesta = http.getResponseCode();
			http.disconnect();
			return respuesta;
		}
		
	public static int putJSON(Productos producto, Long id) throws IOException {
			
			
			url = new URL(sitio+"productos/actualizar");
			HttpURLConnection http;
			http = (HttpURLConnection)url.openConnection();
			
			try {
			  http.setRequestMethod("PUT");
			} catch (ProtocolException e) {
			  e.printStackTrace();
			}
			
			http.setDoOutput(true);
			http.setRequestProperty("Accept", "application/json");
			http.setRequestProperty("Content-Type", "application/json");
			
			String data = "{" + "\"codigo_producto\":\"" + id
							+ "\",\"ivacompra\": \"" + producto.getIvacompra() 
							+ "\",\"nitproveedor\": \"" + producto.getNitproveedor()
							+ "\",\"nombre_producto\":\"" + producto.getNombre_producto()
							+ "\",\"precio_compra\":\"" + producto.getPrecio_compra()
							+ "\",\"precio_venta\":\"" + producto.getPrecio_venta() + "\"}";
			byte[] out = data.getBytes(StandardCharsets.UTF_8);
			OutputStream stream = http.getOutputStream();
			stream.write(out);
			
			int respuesta = http.getResponseCode();
			http.disconnect();
			return respuesta;
		}


		public static int deleteJSON(Long id) throws IOException {
			
			
			url = new URL(sitio+"productos/eliminar/" + id);
			HttpURLConnection http;
			http = (HttpURLConnection)url.openConnection();
			
			try {
			  http.setRequestMethod("DELETE");
			} catch (ProtocolException e) {
			  e.printStackTrace();
			}
			
			http.setDoOutput(true);
			http.setRequestProperty("Accept", "application/json");
			http.setRequestProperty("Content-Type", "application/json");
			
			
			int respuesta = http.getResponseCode();
			http.disconnect();
			return respuesta;
		}


}
