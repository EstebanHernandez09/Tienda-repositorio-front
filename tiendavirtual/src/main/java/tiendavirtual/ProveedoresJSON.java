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

public class ProveedoresJSON {
	private static URL url;
	private static String sitio = "http://localhost:8585/";

	//agregar informacion a la tabla proveedores
	
	public static ArrayList<Proveedores> parsingProveedores(String json) throws ParseException {//devuelve un arraylist
		JSONParser jsonParser = new JSONParser();
		ArrayList<Proveedores> lista = new ArrayList<Proveedores>();
		JSONArray proveedores = (JSONArray) jsonParser.parse(json);
		Iterator i = proveedores.iterator(); //recorrer la tabla clientes
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Proveedores proveedor = new Proveedores();
			proveedor.setNitproveedor(Long.parseLong(innerObj.get("nitproveedor").toString())); //convertir de String a Long
			proveedor.setCiudad_proveedor(innerObj.get("ciudad_proveedor").toString());
			proveedor.setDireccion_proveedor(innerObj.get("direccion_proveedor").toString());
			proveedor.setNombre_proveedor(innerObj.get("nombre_proveedor").toString());
			proveedor.setTelefono_proveedor(innerObj.get("telefono_proveedor").toString());
			lista.add(proveedor);
		}
		return lista;
	}
	
	
	//listar la informacion
	public static ArrayList<Proveedores> getJSON() throws IOException, ParseException { //devolver un listado JSON

		url = new URL(sitio + "proveedores/listar"); //trae el metodo de Clientes.API 
		HttpURLConnection http = (HttpURLConnection) url.openConnection();

		http.setRequestMethod("GET");
		http.setRequestProperty("Accept", "application/json");

		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";

		for (int i = 0; i < inp.length; i++) {
			json += (char) inp[i];
		}

		ArrayList<Proveedores> lista = new ArrayList<Proveedores>();
		lista = parsingProveedores(json);
		http.disconnect();
		return lista;
	}

	public static int postJSON(Proveedores proveedor) throws IOException {

		url = new URL(sitio + "proveedores/guardar");
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

		String data = "{" + "\"nitproveedor\":\"" + String.valueOf(proveedor.getNitproveedor())
				+ "\",\"ciudad_proveedor\": \"" + proveedor.getCiudad_proveedor() + "\",\"direccion_proveedor\": \""
				+ proveedor.getDireccion_proveedor() + "\",\"nombre_proveedor\":\"" + proveedor.getNombre_proveedor() + "\",\"telefono_proveedor\":\""
				+ proveedor.getTelefono_proveedor() + "\"}";
		
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);

		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
	
public static int putJSON(Proveedores proveedor, Long id) throws IOException {
		
		
		url = new URL(sitio+"proveedores/actualizar");
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
		
		String data = "{"
				+ "\"nitproveedor\":\""+ id
				+"\",\"ciudad_proveedor\": \""+proveedor.getCiudad_proveedor()
				+"\",\"direccion_proveedor\": \""+proveedor.getDireccion_proveedor()
				+"\",\"nombre_proveedor\":\""+proveedor.getNombre_proveedor()
				+"\",\"telefono_proveedor\":\""+proveedor.getTelefono_proveedor()
				+ "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);
		
		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}


	public static int deleteJSON(Long id) throws IOException {
		
		
		url = new URL(sitio+"proveedores/eliminar/" + id);
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
