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

public class VentasJSON {
	private static URL url;
	private static String sitio = "http://localhost:8585/";

	//agregar informacion a la tabla clientes
	
	public static ArrayList<Ventas> parsingVentas(String json) throws ParseException {//devuelve un arraylist
		JSONParser jsonParser = new JSONParser();
		ArrayList<Ventas> lista = new ArrayList<Ventas>();
		JSONArray ventas = (JSONArray) jsonParser.parse(json);
		Iterator i = ventas.iterator(); //recorrer la tabla ventas
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			Ventas venta = new Ventas();
			venta.setCodigo_venta(Long.parseLong(innerObj.get("codigo_venta").toString()));
			venta.setCedula_cliente(Long.parseLong(innerObj.get("cedula_cliente").toString()));
			venta.setCedula_usuario(Long.parseLong(innerObj.get("cedula_usuario").toString()));
			venta.setIvaventa(Double.parseDouble(innerObj.get("ivaventa").toString())); //convertir de String a Double
			venta.setTotal_venta(Double.parseDouble(innerObj.get("total_venta").toString())); 
			venta.setValor_venta(Double.parseDouble(innerObj.get("valor_venta").toString())); 
			lista.add(venta);
		}
		return lista;
	}
	
	
	//listar la informacion
	public static ArrayList<Ventas> getJSON() throws IOException, ParseException { //devolver un listado JSON

		url = new URL(sitio + "ventas/listar"); //trae el metodo de Ventas.API 
		HttpURLConnection http = (HttpURLConnection) url.openConnection();

		http.setRequestMethod("GET");
		http.setRequestProperty("Accept", "application/json");

		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";

		for (int i = 0; i < inp.length; i++) {
			json += (char) inp[i];
		}

		ArrayList<Ventas> lista = new ArrayList<Ventas>();
		lista = parsingVentas(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(Ventas venta) throws IOException {

		url = new URL(sitio + "ventas/guardar");
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

		String data = "{"  + "\"codigo_venta\": \""+ String.valueOf(venta.getCodigo_venta()) 
						   + "\",\"cedula_cliente\": \""+ venta.getCedula_cliente()
						   + "\",\"cedula_usuario\": \""+ venta.getCedula_usuario()
						   + "\",\"ivaventa\": \""+ venta.getIvaventa() 
						   + "\",\"total_venta\":\""  + venta.getTotal_venta() 
						   + "\",\"valor_venta\":\"" + venta.getValor_venta() + "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);

		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
}
