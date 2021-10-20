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

public class DetalleVentasJSON {
	private static URL url;
	private static String sitio = "http://localhost:8585/";

	//agregar informacion a la tabla clientes
	
	public static ArrayList<DetalleVentas> parsingDetalleVentas(String json) throws ParseException {//devuelve un arraylist
		JSONParser jsonParser = new JSONParser();
		ArrayList<DetalleVentas> lista = new ArrayList<DetalleVentas>();
		JSONArray detalleventas = (JSONArray) jsonParser.parse(json);
		Iterator i = detalleventas.iterator(); //recorrer la tabla detalle ventas
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			DetalleVentas detalle = new DetalleVentas();
			detalle.setCodigo_detalle_venta(Long.parseLong(innerObj.get("codigo_detalle_venta").toString()));
			detalle.setCantidad_producto(Integer.parseInt(innerObj.get("cantidad_producto").toString()));
			detalle.setCodigo_producto(Long.parseLong(innerObj.get("codigo_producto").toString()));
			detalle.setCodigo_venta(Long.parseLong(innerObj.get("codigo_venta").toString())); 
			detalle.setValor_total(Double.parseDouble(innerObj.get("valor_total").toString())); 
			detalle.setValor_venta(Double.parseDouble(innerObj.get("valor_venta").toString())); 
			detalle.setValoriva(Double.parseDouble(innerObj.get("valoriva").toString()));
			lista.add(detalle);
		}
		return lista;
	}
	
	//listar la informacion
	public static ArrayList<DetalleVentas> getJSON() throws IOException, ParseException { //devolver un listado JSON

		url = new URL(sitio + "detalleventas/listar"); //trae el metodo de DetalleVentas.API 
		HttpURLConnection http = (HttpURLConnection) url.openConnection();

		http.setRequestMethod("GET");
		http.setRequestProperty("Accept", "application/json");

		InputStream respuesta = http.getInputStream();
		byte[] inp = respuesta.readAllBytes();
		String json = "";

		for (int i = 0; i < inp.length; i++) {
			json += (char) inp[i];
		}

		ArrayList<DetalleVentas> lista = new ArrayList<DetalleVentas>();
		lista = parsingDetalleVentas(json);
		http.disconnect();
		return lista;
	}
	
	public static int postJSON(DetalleVentas detalleventa) throws IOException {

		url = new URL(sitio + "detalleventas/guardar");
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

		String data = "{"  + "\"codigo_detalle_venta\": \""+ String.valueOf(detalleventa.getCodigo_detalle_venta()) 
						   + "\",\"cantidad_producto\": \""+ detalleventa.getCantidad_producto()
						   + "\",\"nombre_producto\": \""+ detalleventa.getNombre_producto()
						   + "\",\"codigo_producto\": \""+ detalleventa.getCodigo_producto() 
						   + "\",\"codigo_venta\":\""  + detalleventa.getCodigo_venta() 
						   + "\",\"valor_total\":\""  + detalleventa.getValor_total()
						   + "\",\"valor_venta\":\""  + detalleventa.getValor_venta()
						   + "\",\"valoriva\":\""  + detalleventa.getValoriva()
						   + "\",\"valor_unitario\":\"" + detalleventa.getValor_unitario() + "\"}";
		byte[] out = data.getBytes(StandardCharsets.UTF_8);
		OutputStream stream = http.getOutputStream();
		stream.write(out);

		int respuesta = http.getResponseCode();
		http.disconnect();
		return respuesta;
	}
}
