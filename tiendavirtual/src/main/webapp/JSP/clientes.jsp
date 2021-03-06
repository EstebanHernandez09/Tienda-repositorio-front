<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='tiendavirtual.Clientes' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Clientes || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
</head>
<%if(request.getAttribute("traer") == "clientetraido"){ %>
	<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed" onload="modal_clientes();">
<%} else{%>
<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
<%}
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
		if(request.getAttribute("respuesta") == "excelente"){
			%>
			<script>
			Swal.fire({
				  title: 'Excelente',
				  text: "El cliente ha sido creado correctamente",
				  icon: 'success',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6'
				})
				</script>
	<%} else if(request.getAttribute("respuesta") == "error") {
	%>
	<script>
			Swal.fire({
				  title: 'Error!',
				  text: "No se ha podido ingresar el cliente",
				  icon: 'error',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
				
		<%} else if(request.getAttribute("respuesta") == "vaciousuarios") {%>
			<script>
			Swal.fire({
				  title: 'Espera!',
				  text: "No se puede dejar vacio ningun campo del formulario",
				  icon: 'warning',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
		
		<%}	else if(request.getAttribute("respuesta") == "editado") {
	%>
	<script>
			Swal.fire({
				  title: 'Excelente!',
				  text: "El cliente ha sido editado correctamente",
				  icon: 'success',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
				
		<%} else if(request.getAttribute("respuesta") == "errorEditado") {
	%>
			<script>
				Swal.fire({
					  title: 'Error!',
					  text: "No se ha podido editar el cliente",
					  icon: 'error',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  confirmButtonText: 'Entiendo'
				})
			</script>
				
		<%} else if(request.getAttribute("respuesta") == "vacioeditar") {%>
			<script>
			Swal.fire({
				  title: 'Espera!',
				  text: "No se puede dejar vacio ningun campo del formulario",
				  icon: 'warning',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
		  <%} else if(request.getAttribute("respuesta") == "eliminado") {%>
		}
			<script>
				Swal.fire({
					  title: 'Excelente!',
					  text: "El cliente se ha eliminado correctamente",
					  icon: 'success',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  confirmButtonText: 'Entiendo'
				})
			</script>
		<%} else if(request.getAttribute("respuesta") == "errorEliminado") {%>
			<script>
				Swal.fire({
					  title: 'Error!',
					  text: "No se ha podido eliminado el cliente",
					  icon: 'error',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  confirmButtonText: 'Entiendo'
				})
			</script>
		<%}%>
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
        <!-- Content Header (Page header) -->
        <div class="content-header">
          <div class="container-fluid">
            <div class="row mb-2">
              <div class="col-sm-6 col-lg-12">
                <h1 class="m-0 text-center">Administrador de clientes</h1>
              </div>
              <!-- /.col -->
            </div>
            <!-- /.row -->
          </div>
          <!-- /.container-fluid -->
        </div>
        <!-- /.content-header -->
        <!-- Main content -->
        <section class="content">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-12">
                <div class="card">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group" id="mostrar_loading" style="display: none;"></div>
                        <div class="form-group" id="mostrar_usuarios">
                        	<div class="table-responsive">
							<div class="row">
								<div class="col-2">
									<button class="btn btn-outline-success" data-toggle="modal" data-target="#modal_agregar_usuarios">Agregar cliente</button>
								</div>
								<div class="col-6"></div>
								<div class="col-4 mb-3">
									<div class="btn-group col-md-12">
                                    <input type="text" class="form-control" id="num_buscar_cli" placeholder="Buscar por numero de documento">
                                    <button type="button" class="btn btn-secondary" onclick="buscarCliente()"><i class="fas fa-search"></i></button>
                                  </div>
								</div>
							</div>
							
							<table id="tabla_clientes" class="table display table-striped table-bordered compact" style="width:100%">
							        <thead class="text-capitalize ">
							            <tr style="background: #3F6791; color: #fff;">
							                <th class="text-center">NUMERO DOCUMENTO</th>
							                <th class="text-center">DIRECCION</th>
							                <th class="text-center">CORREO ELECTRONICO</th>
							                <th class="text-center">NOMBRE</th>
							                <th class="text-center">TELEFONO</th>
							                <th class="text-center">ACCIONES</th>
							            </tr>
							        </thead>
							        <tbody>
							        <%
							        if(request.getAttribute("buscar") == "busca"){
							        	Long id= Long.parseLong(request.getParameter("id"));
							        	int contador = 0;
							        	ArrayList<Clientes> lista = (ArrayList<Clientes>) request.getAttribute("lista");
							        	for (Clientes cliente:lista){
								        	if (cliente.getCedula_cliente()==id) {
								        		contador = contador + 1;
								        		%>
							            <tr>
							                <td style="text-align: center;"><%=cliente.getCedula_cliente() %></td>
							                <td style="text-align: center;"><%=cliente.getDireccion_cliente() %></td>
							                <td style="text-align: center;"><%=cliente.getEmail_cliente() %></td>
							                <td style="text-align: center;"><%=cliente.getNombre_cliente() %></td>
							                <td style="text-align: center;"><%=cliente.getTelefono_cliente() %></td>
							                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=cliente.getCedula_cliente()%>" onclick="mostrar_cliente(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=cliente.getCedula_cliente()%>" onclick="elim_cliente(this);"> <i class="far fa-trash-alt"></i></button>
							                </div></td>
							            </tr>
							            <%
								        	}
							        	}
							        	if(contador == 0){%>
							        	<tr><td style="text-align: center;" colspan="6">No se ha encontrado clientes con ese numero de documento</td></tr>
						        		<% }
							        }else{
							        	ArrayList<Clientes> lista = (ArrayList<Clientes>) request.getAttribute("lista");
							        	int contador = 0;
							        	for (Clientes cliente:lista){
							        		contador++;
								        %>
								            <tr>
								                <td style="text-align: center;"><%=cliente.getCedula_cliente() %></td>
								                <td style="text-align: center;"><%=cliente.getDireccion_cliente() %></td>
								                <td style="text-align: center;"><%=cliente.getEmail_cliente() %></td>
								                <td style="text-align: center;"><%=cliente.getNombre_cliente() %></td>
								                <td style="text-align: center;"><%=cliente.getTelefono_cliente() %></td>
								                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=cliente.getCedula_cliente()%>" onclick="mostrar_cliente(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=cliente.getCedula_cliente()%>" onclick="elim_cliente(this);"> <i class="far fa-trash-alt"></i></button>
								                </div></td>
								            </tr>
								            <%} 
							        	if(contador < 1){%>
						            	<tr><td style="text-align: center;" colspan="6">No se han encontrado clientes</td></tr>
						            <%}
							        }
							        %>
							         <tfoot>
							                <tr style="background: #3F6791; color: #fff;">
							                    <th class="text-center">NUMERO DOCUMENTO</th>
								                <th class="text-center">DIRECCION</th>
								                <th class="text-center">CORREO ELECTRONICO</th>
								                <th class="text-center">NOMBRE</th>
								                <th class="text-center">TELEFONO</th>
								                <th class="text-center">ACCIONES</th>
							                </tr>
							            </tfoot>
							        </tbody>
							    </table>
							</div>
                        </div>
                        <!-- Modal agregar usuario-->
                        <div class="modal fade" id="modal_agregar_usuarios" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content card card-outline card-primary">
                              <div class="modal-body card-body">
                                <div class="row card-header text-center">
                                <div class="col-11">
                                    <p class="h2"><span style="opacity:0;">ee</span>Agregar Cliente</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Registre un nuevo cliente</p>
                                <form method="POST" action="${pageContext.request.contextPath}/ClientesServlet">
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="num_agre_cli" name="num_agre_cli" placeholder="Numero de documento">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_agre_cli" name="nom_agre_cli" placeholder="Nombre completo">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="dir_agre_cli" name="dir_agre_cli" placeholder="Direccion">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-map-marked-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="tel_agre_cli" name="tel_agre_cli" placeholder="Telefono">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-phone-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="email_agre_cli" name="email_agre_cli" placeholder="Correo Electronico">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-envelope"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="row">
                                    <!-- /.col -->
                                    <div class="col-4 mb-0">
                                      <button type="button" class="btn btn-danger btn-block" data-dismiss="modal" >Cerrar</button>
                                    </div>
                                    <!-- /.col -->
                                    <div class="col-4 mb-0">
                                      <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">                                    </div>
                                    <!-- /.col -->
                                  </div>
                                </form>
                              </div>
                              <!-- /.form-box -->
                            </div>
                            <!-- /.register-box -->
                          </div>
                        </div>
                        <!-- Modal editar cliente-->
                        <div class="modal fade" id="modal_editar_clientes" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content card card-outline card-primary">
                              <div class="modal-body card-body">
                                <div class="row card-header text-center">
                                <div class="col-11">
                                    <p class="h2"><span style="opacity:0;">ee</span>Editar cliente</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Formulario de edicion de clientes</p>
                                <form method="POST" action="${pageContext.request.contextPath}/ClientesServlet">
	                                <div class="input-group mb-3">
	                                    <input type="text" class="form-control" id="num_edit_cli" name="num_edit_cli" placeholder="Numero de documento" value="${clienteTraer.getCedula_cliente()}">
	                                    <div class="input-group-append">
	                                      <div class="input-group-text">
	                                        <span class="fas fa-address-card"></span>
	                                      </div>
	                                    </div>
	                                  </div>
                                      <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_edit_cli" name="nom_edit_cli" placeholder="Nombre completo" value="${clienteTraer.getNombre_cliente()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="dir_edit_cli" name="dir_edit_cli" placeholder="Direccion" value="${clienteTraer.getDireccion_cliente()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-map-marked-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="tel_edit_cli" name="tel_edit_cli" placeholder="Telefono" value="${clienteTraer.getTelefono_cliente()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-phone-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="email_edit_cli" name="email_edit_cli" placeholder="Correo Electronico" value="${clienteTraer.getEmail_cliente()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-envelope"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="row">
                                    <!-- /.col -->
                                    <div class="col-4 mb-0">
                                      <button type="button" class="btn btn-danger btn-block" data-dismiss="modal" >Cerrar</button>
                                    </div>
                                    <!-- /.col -->
                                    <div class="col-4 mb-0">
                                      <input type="submit" class="btn btn-primary btn-block" name="accion" value="Actualizar">
                                    </div>
                                    <!-- /.col -->
                                  </div>
                                </form>
                              </div>
                              <!-- /.form-box -->
                            </div>
                            <!-- /.register-box -->
                          </div>
                        </div>
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
        <!-- /.content -->
      </div>


<%@ include file="../template/footer.jsp"%>
</div>
<%} %>
<%@ include file="../template/script.jsp"%>
</body>
</html>
