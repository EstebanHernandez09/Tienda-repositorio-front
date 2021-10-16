<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='java.text.SimpleDateFormat' %>
<%@ page import='java.text.DateFormat' %>
<%@ page import='java.util.Date' %>
<%@ page import='tiendavirtual.DetalleVentas' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ventas || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	if(session.getAttribute("nombre") == null && session.getAttribute("usuario") == null){
		%>
</head>
<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed" onload="factura()">
<script>
		Swal.fire({
			  title: 'Espera!',
			  text: "Intentas ingresar al sitio sin haber iniciado sesion",
			  icon: 'warning',
			  showCancelButton: false,
			  confirmButtonColor: '#3085d6',
			  confirmButtonText: 'Entiendo'
			}).then((result) => {
				location.href = "http://localhost:6450/login/JSP/login.jsp";
			})
			</script>
		<%
		//response.sendRedirect("http://localhost:6450/login/JSP/login.jsp");
	}else{
		if(request.getAttribute("traer") == "noExiste"){%>
			<script>
			Swal.fire({
				  title: 'Espera!',
				  text: "No existe cliente con ese numero de documento",
				  icon: 'warning',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
		<%}
	%>
<div class="wrapper">
      <!-- Preloader -->
      <%if(request.getAttribute("preloader") == null) {%>
	      <div class="preloader flex-column justify-content-center align-items-center">
	        <img class="animation__wobble" src="${pageContext.request.contextPath}/img/logo-carro.png" alt="Logo_tienda" height="60" width="60">
	      </div>
      <%} %>
	<%@ include file="../template/menu-horizontal.jsp"%>
	<%@ include file="../template/menu-vertical.jsp"%>
	<div class="content-wrapper">
		<div class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6 col-lg-12">
                <h1 class="m-0 text-center">Ventas</h1>
              </div>
              <!-- /.col -->
            </div>
            <!-- /.row -->
          </div>
          <!-- /.container-fluid -->
        </div>
        <section class="content">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-body">
                  		<!-- <form method="get" action="${pageContext.request.contextPath}/VentasServlet"> -->
                  	<div class="row">
                     <div class="col-md-12">
	                      <br><h4 class="m-0 text-center">Informacion Cliente</h4><br>
                      </div>
                      <%if(request.getAttribute("cliente") == null) {%>
	                      <div class="col-md-4">
		                      <label>Cedula cliente</label>
		                      <div class="btn-group col-md-12">
		                      	<input type="text" class="form-control" id="cedula_cliente" name="cedula_cliente" value="${clienteTraer.getCedula_cliente()}">
		                      	<button type="button" class="btn btn-success" onclick="buscar_nom_cli()"><i class="far fa-check-circle"></i></button>
		                      </div>
	                      </div>
	                      <div class="col-md-4">
		                      <label for="nombre_cliente">Nombre cliente</label>
		                      <input type="text" class="form-control" id="nombre_cliente" name="nombre_cliente" value="${clienteTraer.getNombre_cliente()}" disabled>
	                      </div>
	                      <%} else{%>
	                      	<div class="col-md-4">
		                      <label>Cedula cliente</label>
		                      <div class="btn-group col-md-12">
		                      	<input type="text" class="form-control" id="cedula_cliente" name="cedula_cliente" value="<%=request.getAttribute("cedula")%>">
		                      	<button type="button" class="btn btn-success" onclick="buscar_nom_cli()"><i class="far fa-check-circle"></i></button>
		                      </div>
	                      </div>
	                      <div class="col-md-4">
		                      <label for="nombre_cliente">Nombre cliente</label>
		                      <input type="text" class="form-control" id="nombre_cliente" name="nombre_cliente" value="<%=request.getAttribute("cliente")%>" disabled>
	                      </div>
	                      <%} %>
	                      <div class="col-md-4">
		                      <label for="consecutivo">Consecutivo</label>
		                      <input type="text" class="form-control" id="consecutivo" name="consecutivo" value="" disabled>
	                      </div>
	                      <div class="col-md-12">
		                      <br><h4 class="m-0 text-center">Informacion Producto</h4><br>
	                      </div>
	                      <div class="col-md-3">
		                      <label for="consecutivo">Codigo producto</label>
		                      <div class="btn-group col-md-12">
		                      	<input type="text" class="form-control" id="cod_producto" name="cod_producto" value="${productoTraer.getCodigo_producto()}">
		                      	<button type="button" onclick="buscar_nom_pro('totaliva')" class="btn btn-success"><i class="far fa-check-circle"></i></button>
		                      </div>
	                      </div>
	                      
	                      <div class="col-md-3">
		                      <label for="consecutivo">Nombre</label>
		                      <input type="text" class="form-control" id="nom_producto" name="nom_producto" value="${productoTraer.getNombre_producto()}" disabled>
	                      </div>
	                      <div class="col-md-1">
		                      <label for="consecutivo">Cantidad</label>
		                      <input type="text" class="form-control" id="cantidad" name="cantidad" onkeyup="valorTotalProducto()">
	                      </div>
	                      <div class="col-md-2">
		                      <label for="consecutivo">Valor Unitario</label>
		                      <input type="text" class="form-control" id="valor_unitario" name="valor_unitario" value="$ ${productoTraer.getPrecio_venta()}" disabled>
	                      </div>
	                       <div class="col-md-1">
		                      <label for="consecutivo">IVA</label>
		                      <input type="text" class="form-control" id="iva" name="iva" value="${productoTraer.getIvacompra()}%" disabled>
	                      </div>
	                      <div class="col-md-2">
		                      <label for="consecutivo">Valor Total</label>
		                      <div class="btn-group col-md-12">
		                       <input type="text" class="form-control" id="valor_total" name="valor_total" value="" disabled>
		                      <button class="btn btn-success" onclick="agregar_producto()"><i class="far fa-plus-square"></i></button>
	                      </div>
	                      </div>
	                      
                       <!--</form>-->
                      
                      <div class="col-md-12">
	                      <br><h4 class="m-0 text-center">Lista de productos</h4><br>
                      </div>
                      <div class="col-12 my-2">
                      	<table id="example" class="table display table-striped table-bordered compact" style="width:100%">
					        <thead class="text-capitalize ">
					            <tr style="background: #3F6791; color: #fff;">
					                <th class="text-center">#</th>
					                <th class="text-center">CODIGO PRODUCTO</th>
					                <th class="text-center">NOMBRE PRODUCTO</th>
					                <th class="text-center">CANTIDAD</th>
					                <th class="text-center">IVA</th>
					                <th class="text-center">VALOR UNIDAD</th>
					                <th class="text-center">TOTAL</th>
					            </tr>
					        </thead>
					        <tbody><%
					        if(request.getAttribute("listaventas") == null){%>
					        	<tr><td style="text-align: center;" colspan="7">No se han añadido productos a la venta</td></tr>
					        <%}else{
					        	ArrayList<DetalleVentas> lista = (ArrayList<DetalleVentas>) request.getAttribute("listaventas");
							        	int contador = 0;
								        for (DetalleVentas venta : lista) {
								        	contador++;
								        	double total = venta.getValor_venta();
								        %>
								            <tr>
								                <td style="text-align: center;"><%=contador%></td>
								                <td style="text-align: center;"><%=venta.getCodigo_producto()%></td>
								                <td style="text-align: center;"><%=venta.getNombre_producto()%></td>
								                <td style="text-align: center;"><%=venta.getCantidad_producto()%></td>
								                <td style="text-align: center;"><%=venta.getValoriva()%></td>
								                <td style="text-align: center;"><%=venta.getValor_unitario()%></td>
								                <td style="text-align: center;"><%=venta.getValor_venta()%></td>
								            </tr>
								            <%} if(contador < 1){%>
							            	<tr><td style="text-align: center;" colspan="6">No se han añadido productos a la venta</td></tr>
								            <%}
								            }%>
					        </tbody>
						</table>
                      </div>
                      <div class="col-6">
                      	<img src="${pageContext.request.contextPath}/img/logo.png" alt="Logo_tienda" height="250" width="500">
                      </div>
                          <div class="col-6">
			                  <p class="m-0">Monto de venta - <%= new SimpleDateFormat("yyyy/MM/dd").format(new Date())%></p>

			                  <div class="table-responsive">
			                    <table class="table">
			                     <%if(request.getAttribute("totalsubtotal") != null) {%>
			                      <tr>
			                        <th style="width:50%">Total venta:</th>
			                        <td id="totalsubtotal">$ <%=request.getAttribute("totalsubtotal") %></td>
			                      </tr>
			                      <%}else{%>
			                    	  <tr>
			                        <th style="width:50%">Total venta:</th>
			                        <td id="totalsubtotal">$ 0</td>
			                      </tr>
			                      <%}
			                     if(request.getAttribute("totaliva") != null) { %>
			                      <tr>
			                        <th>Total IVA:</th>
			                        <td id="totaliva">$ <%=request.getAttribute("totaliva") %></td>
			                      </tr>
			                      <tr>
			                      <%}else{%>
		                    	  <tr>
			                        <th>Total IVA:</th>
			                        <td id="totaliva">$ 0</td>
			                      </tr>
			                      <%}
			                     if(request.getAttribute("totalpagar") != null) { %>
			                     <tr>
			                        <th>Total a Pagar:</th>
			                        <td id="totalpagar">$ <%=request.getAttribute("totalpagar") %></td>
			                      </tr>
			                      <%} else{%>
			                      <tr>
			                        <th>Total a Pagar:</th>
			                        <td id="totalpagar">$ 0</td>
			                      </tr>
			                      <%}%>
			                    </table>
			                  </div>
                			</div>
                			<div class="col-12">
			                   <button class="btn btn-success float-right">Confirmar</button>
			                   <button class="btn btn-danger float-right">Cancelar Venta</button>
                			</div>
                      <!-- /.col -->
                    </div>
                    
                    <!-- /.row -->
                  </div>
                  <!-- ./card-body-->
                </div>
                <!-- /.card -->
              </div>
              <!-- /.col -->
            </div>
          </div>
          <!--/. container-fluid -->
        </section>
	</div>
	<%@ include file="../template/footer.jsp"%>
</div>
<% } %>
	<%@ include file="../template/script.jsp"%>
</body>
</html>
