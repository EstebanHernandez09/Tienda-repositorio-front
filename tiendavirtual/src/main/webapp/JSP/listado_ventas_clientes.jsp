<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='tiendavirtual.Ventas' %>
<%@ page import='tiendavirtual.Clientes' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reportes || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
</head>
<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
<%
	if(session.getAttribute("nombre") == null && session.getAttribute("usuario") == null){
%>
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
	}else{
	%>
<div class="wrapper">
      <!-- Preloader -->
      <div class="preloader flex-column justify-content-center align-items-center">
        <img class="animation__wobble" src="${pageContext.request.contextPath}/img/logo-carro.png" alt="Logo_tienda" height="60" width="60">
      </div>
	<%@ include file="../template/menu-horizontal.jsp"%>
	<%@ include file="../template/menu-vertical.jsp"%>
	<div class="content-wrapper">
				 <div class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6 col-lg-12">
                <h1 class="m-0 text-center">Total de Ventas por Cliente</h1>
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
                  <form action="">
                    <div class="row">
                      <div class="table-responsive">
                      	<table id="example" class="table display table-striped table-bordered compact" style="width:100%">
							        <thead class="text-capitalize ">
							            <tr style="background: #3F6791; color: #fff;">
							                <th class="text-center">NUMERO DOCUMENTO</th>
							                <th class="text-center">NOMBRE</th>
							                <th class="text-center">VALOR TOTAL VENTAS</th>
							            </tr>
							        </thead>
							        <tbody>
							            <%
							            ArrayList<Clientes> lista = (ArrayList<Clientes>) request.getAttribute("lista");
							            ArrayList<Ventas> listaventas = (ArrayList<Ventas>) request.getAttribute("listaventas");
							            int cont = 0;
							       		int contador = 0;
							       		long  almacedula = 0;
							       	 	double almacenador=0, valor = 0, valortotal = 0, subalmacenador = 0;
								        for (Clientes cliente: lista) {
								        	contador++;
								        	cont=0;
								        	
								        %>
								            <tr>
								                 <td style="text-align: center;"><%=cliente.getCedula_cliente() %></td>
								                 <td style="text-align: center;"><%=cliente.getNombre_cliente() %></td>
								                 <%for (Ventas venta:listaventas){
								                	 
								                	 
								                	 if(cliente.getCedula_cliente() == venta.getCedula_cliente()){    
								                		 cont++;
								                		
								                		 
								                	 if(almacedula == cliente.getCedula_cliente()){%>
								                		
								                		 <%
								                		 valor = venta.getValor_venta()+almacenador;%>
								                		 <%
								                	 }else{%>
								                	 	<%
								                	 	
								                		 valor = venta.getValor_venta();%>
								                		<%
								                	 }
								                	 almacenador = valor;
								                	 almacedula = cliente.getCedula_cliente();
								                	 subalmacenador = venta.getValor_venta();
								                	 if(valortotal == 0){
							                			 valortotal = venta.getValor_venta();
							                		 }else{
							                			 valortotal = valortotal+subalmacenador;
							                		 }
								                	 }
								                	 } if(cont >= 1){%>
								                 
										                 <td style="text-align: center;"> 
										                 	$ <%=valor %>
										                 </td>
								                 	<%}else{ %>
								                 		<td style="text-align: center;"> 
										                 	$ 0
										                 </td>
								                 	<%} %>
								               							           
								            </tr>
								            <%}if(contador < 1){%>
								            	<tr><td style="text-align: center;" colspan="3">No se han encontrado clientes</td></tr>
								            <%} %>
							            <tfoot>
							                <tr style="background: #3F6791; color: #fff;">
							                    <th class="text-center">NUMERO DOCUMENTO</th>
								                <th class="text-center">NOMBRE</th>
								                <th class="text-center">VALOR TOTAL VENTAS</th>
							                </tr>
							            </tfoot>
							        </tbody>
							    </table>
							    <div class="row col-12 text-right">
							    	<b>Total Ventas $ <%= valortotal %></b>
                  				</div>
                      </div>
                      <!-- /.col -->
                    </div>
                    </form>
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
</div>
<%@ include file="../template/footer.jsp"%>
<%} %>
<%@ include file="../template/script.jsp"%>
</body>
</html>
