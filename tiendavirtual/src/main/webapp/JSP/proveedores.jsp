<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='tiendavirtual.Proveedores' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Proveedores || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
</head>
<%if(request.getAttribute("traer") == "proveedortraido"){ %>
	<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed" onload="modal_proveedores();">
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
				  text: "El proveedor ha sido creado correctamente",
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
				  text: "No se ha podido ingresar el proveedor",
				  icon: 'error',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
				
		<%} else if(request.getAttribute("respuesta") == "vacioagregar") {%>
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
				  text: "El proveedor ha sido editado correctamente",
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
					  text: "No se ha podido editar el proveedor",
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
					  text: "El proveedor se ha eliminado correctamente",
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
					  text: "No se ha podido eliminado el proveedor",
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
                <h1 class="m-0 text-center">Administrador de proveedores</h1>
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
									<button class="btn btn-outline-success" data-toggle="modal" data-target="#modal_agregar_proveedores">Agregar proveedor</button>
								</div>
								<div class="col-6"></div>
								<div class="col-4">
									<div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nit_bus_pro" name="nit_bus_pro" placeholder="Buscar por NIT">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-search" onclick="buscarProveedor();"></span>
                                      </div>
                                    </div>
                                  </div>
								</div>
							</div>
							
							<table id="example" class="table display table-striped table-bordered compact" style="width:100%">
							        <thead class="text-capitalize ">
							            <tr style="background: #3F6791; color: #fff;">
							                <th class="text-center">NIT</th>
							                <th class="text-center">NOMBRE PROVEEDOR</th>
							                <th class="text-center">DIRECCION</th>
							                <th class="text-center">TELEFONO</th>
							                <th class="text-center">CIUDAD</th>
							                <th class="text-center">ACCIONES</th>
							            </tr>
							        </thead>
							        <tbody>
							            <%
							        if(request.getAttribute("buscar") == "busca"){
							        	Long id= Long.parseLong(request.getParameter("id"));
							        	int contador = 0;
							        	ArrayList<Proveedores> lista = (ArrayList<Proveedores>) request.getAttribute("lista");
							        	for (Proveedores proveedor:lista){
								        	if (proveedor.getNitproveedor()==id) {
								        		contador = contador + 1;
								        		%>
							            <tr>
							                <td style="text-align: center;"><%=proveedor.getNitproveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getNombre_proveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getDireccion_proveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getTelefono_proveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getCiudad_proveedor() %></td>
							                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=proveedor.getNitproveedor()%>" onclick="mostrar_proveedor(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=proveedor.getNitproveedor()%>" onclick="elim_proveedor(this);"> <i class="far fa-trash-alt"></i></button>
							                </div></td>
							            </tr>
							            <%
								        	}
							        	}
							        	if(contador == 0){%>
							        	<tr><td style="text-align: center;" colspan="6">No se han encontrado proveedores con ese NIT</td></tr>
						        		<% }
							        }else{
							        	ArrayList<Proveedores> lista = (ArrayList<Proveedores>) request.getAttribute("lista");
							        	int contador = 0;
							        	for (Proveedores proveedor:lista){
							        		contador++;
								        %>
								            <tr>
								               <td style="text-align: center;"><%=proveedor.getNitproveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getNombre_proveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getDireccion_proveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getTelefono_proveedor() %></td>
							                <td style="text-align: center;"><%=proveedor.getCiudad_proveedor() %></td>
								                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=proveedor.getNitproveedor()%>" onclick="mostrar_proveedor(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=proveedor.getNitproveedor()%>" onclick="elim_proveedor(this);"> <i class="far fa-trash-alt"></i></button>
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
							                    <th class="text-center">NIT</th>
								                <th class="text-center">NOMBRE PROVEEDOR</th>
								                <th class="text-center">DIRECCION</th>
								                <th class="text-center">TELEFONO</th>
								                <th class="text-center">CIUDAD</th>
								                <th class="text-center">ACCIONES</th>
							                </tr>
							            </tfoot>
							        </tbody>
							    </table>
							</div>
                        </div>
                        <!-- Modal agregar usuario-->
                        <div class="modal fade" id="modal_agregar_proveedores" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content card card-outline card-primary">
                              <div class="modal-body card-body">
                                <div class="row card-header text-center">
                                <div class="col-11">
                                    <p class="h2"><span style="opacity:0;">ee</span>Agregar proveedor</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Registre un nuevo proveedor</p>
                                <form method="POST" action="${pageContext.request.contextPath}/ProveedoresServlet">
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nit_agre_pro" name="nit_agre_pro" placeholder="NIT">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_agre_pro" name="nom_agre_pro" placeholder="Nombre proveedor">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-signature"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="dir_agre_pro" name="dir_agre_pro" placeholder="Direccion">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-map-marked-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="Tel_agre_pro" name="Tel_agre_pro" placeholder="Telefono">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-phone-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="ciu_agre_pro" name="ciu_agre_pro" placeholder="Ciudad">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-city"></span>
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
                                      <input type="submit" class="btn btn-primary btn-block" name="accion" value="Agregar">
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
                        <!-- Modal editar usuario-->
                        <div class="modal fade" id="modal_editar_proveedores" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content card card-outline card-primary">
                              <div class="modal-body card-body">
                                <div class="row card-header text-center">
                                <div class="col-11">
                                    <p class="h2"><span style="opacity:0;">ee</span>Editar proveedor</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Formulario de edicion de proveedores</p>
                                <form method="POST" action="${pageContext.request.contextPath}/ProveedoresServlet">
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nit_edit_pro" name="nit_edit_pro" placeholder="NIT" value="${proveedorTraer.getNitproveedor()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_edit_pro" name="nom_edit_pro" placeholder="Nombre proveedor" value="${proveedorTraer.getNombre_proveedor()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-signature"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="dir_edit_pro" name="dir_edit_pro" placeholder="Direccion" value="${proveedorTraer.getDireccion_proveedor()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-map-marked-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="Tel_edit_pro" name="Tel_edit_pro" placeholder="Telefono" value="${proveedorTraer.getTelefono_proveedor()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-phone-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="ciu_edit_pro" name="ciu_edit_pro" placeholder="Ciudad" value="${proveedorTraer.getCiudad_proveedor()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-city"></span>
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

</div>
	
<%@ include file="../template/footer.jsp"%>
<%} %>
<%@ include file="../template/script.jsp"%>
</body>
</html>
