<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='tiendavirtual.Usuarios' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Gestion de Usuarios || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");%>
</head>
<%if(request.getAttribute("traer") == "usuariotraido"){ %>
	<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed" onload="modal();">
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
				  text: "El usuario ha sido creado correctamente",
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
				  text: "No se ha podido ingresar el usuario",
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
				  text: "El usuario ha sido editado correctamente",
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
					  text: "No se ha podido editar el usuario",
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
					  text: "El usuario se ha eliminado correctamente",
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
					  text: "No se ha podido eliminado el usuario",
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
                <h1 class="m-0 text-center">Administrador de usuarios</h1>
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
									<button class="btn btn-outline-success" data-toggle="modal" data-target="#modal_agregar_usuarios">Agregar Usuario</button>
								</div>
								<div class="col-6"></div>
								<div class="col-4 mb-3">
									<div class="btn-group col-md-12">
                                    <input type="text" class="form-control" id="num_buscar_usu" name="num_buscar_usu" placeholder="Buscar por numero de documento">
                                    <button type="button" class="btn btn-secondary" onclick="buscarUsuario()"><i class="fas fa-search"></i></button>
                                  </div>
								</div>
							</div>
							<table id="tabla_usuarios" class="table display table-striped table-bordered compact" style="width:100%">
							        <thead class="text-capitalize ">
							            <tr style="background: #3F6791; color: #fff;">
							                <th class="text-center">NUMERO DOCUMENTO</th>
							                <th class="text-center">NOMBRE</th>
							                <th class="text-center">CORREO ELECTRONICO</th>
							                <th class="text-center">USUARIO</th>
							                <th class="text-center">CONTRASEÑA</th>
							                <th class="text-center">ACCIONES</th>
							            </tr>
							        </thead>
							        <tbody>
							        <%
							        if(request.getAttribute("buscar") == "busca"){
							        	Long id= Long.parseLong(request.getParameter("id"));
							        	int contador = 0;
							        	ArrayList<Usuarios> lista = (ArrayList<Usuarios>) request.getAttribute("lista");
							        	for (Usuarios usuario:lista){
								        	if (usuario.getCedula_usuario()==id) {
								        		contador = contador + 1;
								        		%>
								        	<tr>
								                <td style="text-align: center;"><%=usuario.getCedula_usuario()%></td>
								                <td style="text-align: center;"><%=usuario.getNombre_usuario()%></td>
								                <td style="text-align: center;"><%=usuario.getEmail_usuario()%></td>
								                <td style="text-align: center;"><%=usuario.getUsuario()%></td>
								                <td style="text-align: center;"><%=usuario.getPassword()%></td>
								                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=usuario.getCedula_usuario()%>" onclick="mostrar_usuario(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=usuario.getCedula_usuario()%>" onclick="elim_usuario(this);"> <i class="far fa-trash-alt"></i></button>
								                </div></td>
								            </tr>
								        		<%
								        	}
							        	}
							        	if(contador == 0){%>
						        		<tr><td style="text-align: center;" colspan="6">No se ha encontrado usuarios con ese numero de documento</td></tr>
						        	<% }
							        }else{
							        	ArrayList<Usuarios> lista = (ArrayList<Usuarios>) request.getAttribute("lista");
							        	int contador = 0;
								        for (Usuarios usuario : lista) {
								        	contador++;
								        %>
								            <tr>
								                <td style="text-align: center;"><%=usuario.getCedula_usuario()%></td>
								                <td style="text-align: center;"><%=usuario.getNombre_usuario()%></td>
								                <td style="text-align: center;"><%=usuario.getEmail_usuario()%></td>
								                <td style="text-align: center;"><%=usuario.getUsuario()%></td>
								                <td style="text-align: center;"><%=usuario.getPassword()%></td>
								                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=usuario.getCedula_usuario()%>" onclick="mostrar_usuario(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=usuario.getCedula_usuario()%>" onclick="elim_usuario(this);"> <i class="far fa-trash-alt"></i></button>
								                </div></td>
								            </tr>
								            <%} if(contador < 1){%>
							            	<tr><td style="text-align: center;" colspan="6">No se han encontrado clientes</td></tr>
								            <%}
							        }
							        %>
							            <tfoot>
							                <tr style="background: #3F6791; color:#fff;">
							                    <th class="text-center">NUMERO DOCUMENTO</th>
								                <th class="text-center">NOMBRE</th>
								                <th class="text-center">CORREO ELECTRONICO</th>
								                <th class="text-center">USUARIO</th>
								                <th class="text-center">CONTRASEÑA</th>
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
                                    <p class="h2"><span style="opacity:0;">ee</span>Agregar usuario</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Registre un nuevo usuario</p>
                                <form method="POST" action="${pageContext.request.contextPath}/UsuariosServlet">
                                  <div class="input-group mb-3">
                                    <input type="number" class="form-control" id="numdoc_agre_usu" name="numdoc_agre_usu" placeholder="Numero de documento">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_agre_usu" name="nom_agre_usu" placeholder="Nombre completo">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="email_agre_usu" name="email_agre_usu" placeholder="Correo electronico">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-envelope"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="us_agre_usu" name="us_agre_usu" placeholder="Usuario">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="password" class="form-control" id="pass_agre_usu" name="pass_agre_usu" placeholder="Contraseña">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-lock"></span>
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
                        <div class="modal fade" id="modal_editar_usuarios" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content card card-outline card-primary">
                              <div class="modal-body card-body">
                                <div class="row card-header text-center">
                                <div class="col-11">
                                    <p class="h2"><span style="opacity:0;">ee</span>Editar usuario</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Formulario de edicion de usuarios</p>
                                <form method="POST" action="${pageContext.request.contextPath}/UsuariosServlet">
                                <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="numdoc_edit_usu" name="numdoc_edit_usu" placeholder="Numero de documento" value="${usuarioTraer.getCedula_usuario()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_edit_usu" name="nom_edit_usu" placeholder="Nombre completo" value="${usuarioTraer.getNombre_usuario()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="email_edit_usu" name="email_edit_usu" placeholder="Correo electronico" value="${usuarioTraer.getEmail_usuario()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-envelope"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="us_edit_usu" name="us_edit_usu" placeholder="Usuario" value="${usuarioTraer.getUsuario()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-user"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="pass_edit_usu" name="pass_edit_usu" placeholder="Contraseña" value="${usuarioTraer.getPassword()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-lock"></span>
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
<% } %>
<%@ include file="../template/script.jsp"%>

</body>
</html>
