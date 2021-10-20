<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='tiendavirtual.Usuarios' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Productos || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
</head>
<body
	class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
	<%
	if (session.getAttribute("nombre") == null && session.getAttribute("usuario") == null) {
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
	} else {
	%>
	<div class="wrapper">
		<!-- Preloader -->
		<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__wobble"
				src="${pageContext.request.contextPath}/img/logo-carro.png"
				alt="Logo_tienda" height="60" width="60">
		</div>
		<%@ include file="../template/menu-horizontal.jsp"%>
		<%@ include file="../template/menu-vertical.jsp"%>
		<div class="content-wrapper">
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6 col-lg-12">
							<h1 class="m-0 text-center">Administrador de productos</h1>
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
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group" id="mostrar_loading" style="display: none;"></div>
                        <div class="form-group" id="mostrar_usuarios">
                        	<div class="table-responsive">
							<div class="row">
								<div class="col-2">
									<button class="btn btn-outline-success" data-toggle="modal" data-target="#modal_agregar_usuarios">Agregar Producto</button>
								</div>
								<div class="col-6"></div>
								<div class="col-4">
									<div class="input-group mb-3">
                                    <input type="text" class="form-control" id="num_buscar_usu" name="num_buscar_usu" placeholder="Buscar por codigo de producto">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-search" onclick="buscarUsuario()"></span>
                                      </div>
                                    </div>
                                  </div>
								</div>
							</div>
							
							<table id="tabla_usuarios" class="table display table-striped table-bordered compact" style="width:100%">
							        <thead class="text-capitalize ">
							            <tr style="background: #3F6791; color: #fff;">
							                <th class="text-center">CODIGO</th>
							                <th class="text-center">NOMBRE</th>
							                <th class="text-center">NIT PROVEEDOR</th>
							                <th class="text-center">PRECIO COMPRA</th>
							                <th class="text-center">IVA</th>
							                <th class="text-center">PRECIO VENTA</th>
							            </tr>
							        </thead>
							        <tbody>
							        
							            <tfoot>
							                <tr style="background: #3F6791; color:#fff;">
							                    <th class="text-center">CODIGO</th>
							                <th class="text-center">NOMBRE</th>
							                <th class="text-center">NIT PROVEEDOR</th>
							                <th class="text-center">PRECIO COMPRA</th>
							                <th class="text-center">IVA</th>
							                <th class="text-center">PRECIO VENTA</th>
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
                                    <p class="h2"><span style="opacity:0;">ee</span>Agregar producto</p>
                                </div>
                                <div class="col-1">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                  </button>
                                </div>
                                </div>
                                <p class="login-box-msg">Registre un nuevo producto</p>
                                <form method="POST" action="${pageContext.request.contextPath}/ProductosServlet">
                                  <div class="input-group mb-3">
                                    <input type="number" class="form-control" id="cod_producto" name="cod_producto" placeholder="Codigo de producto">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_agre_pro" name="nom_agre_pro" placeholder="Nombre">
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
                                <p class="login-box-msg">Formulario de edicion de productos</p>
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

			<section class="content">

				<div class="accordion" id="accordionExample">
					<div class="card">
						<div class="card-header" >
							<h2 class="mb-0">
								<button
									class="btn btn-link btn-block text-left collapsed card-title text-center"
									type="button" data-toggle="collapse" data-target="#collapseTwo"
									aria-expanded="false" aria-controls="collapseTwo">
									<strong> Panel de carga archivo .csv</strong>
									<div class="divider"></div>
								</button>
							</h2>
						</div>
						<div id="collapseTwo" class="collapse"
							aria-labelledby="headingTwo" data-parent="#accordionExample">
							<div class="card-body">
								<div class="row">
									<div class="col-12 text-center">
										<h5 for="archivo" class="form-label"
											font-size: 18px;">Seleccione el
											archivo en formato .csv</h5>
										<div class="divider">
											<br>
										</div>
										<img width="300px" height="200px" src="${pageContext.request.contextPath}/img/Excel.png" alt="" class="img-size-10 mr-3">
										<div class="divider">
											<br>
										</div>
										<div class="row form-group">
											<input type="file" id="file" name="jetperu[archivo]"
												style="margin: auto;" accept=".txt" class="filestyle"
												data-buttonText="Seleccione archivo"
												data-buttonText="Seleccione archivo .txt"
												onchange="return validarExt()">
										</div>
									</div>
								</div>
								<br>
								<div class="row">
									<div class="text-center" style="margin: auto;">
										<br>
										<div id="boton">
											<a href="#!" id="enviar" class="btn btn-primary"
												data-toggle="modal" data-target="#modalEnvio">Enviar</a>
										</div>
									</div>
								</div>
								<br>
								<div class="modal fade" id="modalEnvio" data-backdrop="static"
									data-keyboard="false" tabindex="-1" role="dialog"
									aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div
										class="modal-dialog modal-dialog-scrollable modal-dialog-centered "
										role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">Confirmacion
													de Envio Archivo Plano a venegiros</h5>
											</div>
											<div class="modal-body">
												<form method="post" id="resultado" class="form-group">
													<div class="form-group">
														<label for="recipient-name" class="col-form-label"></label>
													</div>
												</form>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-primary"
													data-dismiss="modal" id="btn_revisado">Revisado</button>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</div>
	<%@ include file="../template/footer.jsp"%>
	<%
	}
	%>
	<%@ include file="../template/script.jsp"%>
</body>
</html>
