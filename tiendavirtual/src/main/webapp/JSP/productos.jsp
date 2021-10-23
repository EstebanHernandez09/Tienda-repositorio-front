<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import='tiendavirtual.Productos' %>
<%@ page import='java.util.ArrayList' %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Productos || Tienda Generica</title>
<%@ include file="../template/head.jsp"%>
</head>
<%if(request.getAttribute("traer") == "productotraido"){ %>
	<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed" onload="modal_producto();">
<%} else{%>
<body class="hold-transition sidebar-mini layout-fixed layout-navbar-fixed layout-footer-fixed">
<%}
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
		if(request.getAttribute("respuesta") == "excelente"){
			%>
			<script>
			Swal.fire({
				  title: 'Excelente',
				  text: "El producto ha sido creado correctamente",
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
				  text: "No se ha podido ingresar el producto",
				  icon: 'error',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
				</script>
				
		<%} else if(request.getAttribute("respuesta") == "vacioproductos") {%>
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
				  text: "El producto ha sido editado correctamente",
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
					  text: "No se ha podido editar el producto",
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
			<script>
				Swal.fire({
					  title: 'Excelente!',
					  text: "El producto se ha eliminado correctamente",
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
					  text: "No se ha podido eliminado el producto",
					  icon: 'error',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  confirmButtonText: 'Entiendo'
				})
			</script>
		<%} else if(request.getAttribute("respuesta") == "importado") {%>
			<script>
				Swal.fire({
					  title: 'Excelente!',
					  text: "Los productos se han importado correctamente",
					  icon: 'success',
					  showCancelButton: false,
					  confirmButtonColor: '#3085d6',
					  confirmButtonText: 'Entiendo'
				})
			</script>
		<%} else if(request.getAttribute("respuesta") == "errorimportado") {%>
			<script>
				Swal.fire({
					  title: 'Error!',
					  text: "No se han podido importar los productos",
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
									<button class="btn btn-outline-success" data-toggle="modal" data-target="#modal_agregar_producto">Agregar Producto</button>
								</div>
								<div class="col-6"></div>
								<div class="col-4 mb-3">
								  <div class="btn-group col-md-12">
                                    <input type="text" class="form-control" id="num_buscar_pro" name="num_buscar_pro" placeholder="Buscar por codigo de producto">
                                    <button type="button" class="btn btn-secondary" onclick="buscarProducto()"><i class="fas fa-search"></i></button>
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
							                <th class="text-center">ACCIONES</th>
							            </tr>
							        </thead>
							        <tbody>
							        <%
							        if(request.getAttribute("buscar") == "busca"){
							        	Long id= Long.parseLong(request.getParameter("id"));
							        	int contador = 0;
							        	ArrayList<Productos> lista = (ArrayList<Productos>) request.getAttribute("lista");
							        	for (Productos producto:lista){
								        	if (producto.getCodigo_producto()==id) {
								        		contador = contador + 1;
								        		%>
								        	<tr>
								                <td style="text-align: center;"><%=producto.getCodigo_producto()%></td>
								                <td style="text-align: center;"><%=producto.getNombre_producto()%></td>
								                <td style="text-align: center;"><%=producto.getNitproveedor()%></td>
								                <td style="text-align: center;"><%=producto.getPrecio_compra()%></td>
								                <td style="text-align: center;"><%=producto.getIvacompra()%></td>
								                <td style="text-align: center;"><%=producto.getPrecio_venta()%></td>
								                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=producto.getCodigo_producto()%>" onclick="mostrar_producto(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=producto.getCodigo_producto()%>" onclick="elim_producto(this);"> <i class="far fa-trash-alt"></i></button>
								                </div></td>
								            </tr>
								        		<%
								        	}
							        	}
							        	if(contador == 0){%>
						        		<tr><td style="text-align: center;" colspan="6">No se han encontrado productos con ese codigo</td></tr>
						        	<% }
							        }else{
							        	ArrayList<Productos> lista = (ArrayList<Productos>) request.getAttribute("lista");
							        	int contador = 0;
								        for (Productos producto : lista) {
								        	contador++;
								        %>
								            <tr>
								                <td style="text-align: center;"><%=producto.getCodigo_producto()%></td>
								                <td style="text-align: center;"><%=producto.getNombre_producto()%></td>
								                <td style="text-align: center;"><%=producto.getNitproveedor()%></td>
								                <td style="text-align: center;"><%=producto.getPrecio_compra()%></td>
								                <td style="text-align: center;"><%=producto.getIvacompra()%></td>
								                <td style="text-align: center;"><%=producto.getPrecio_venta()%></td>
								                <td style="text-align: center;"><div class="row" style="margin:auto;"><button class="btn btn-outline-success" id="<%=producto.getCodigo_producto()%>" onclick="mostrar_producto(this);"><i class="fas fa-edit"></i></button>
								                <button class="btn btn-outline-danger" id="<%=producto.getCodigo_producto()%>" onclick="elim_producto(this);"> <i class="far fa-trash-alt"></i></button>
								                </div></td>
								            </tr>
								            <%} if(contador < 1){%>
							            	<tr><td style="text-align: center;" colspan="6">No se han encontrado productos</td></tr>
								            <%}
							        }
							        %>
							            <tfoot>
							                <tr style="background: #3F6791; color:#fff;">
							                    <th class="text-center">CODIGO</th>
							                <th class="text-center">NOMBRE</th>
							                <th class="text-center">NIT PROVEEDOR</th>
							                <th class="text-center">PRECIO COMPRA</th>
							                <th class="text-center">IVA</th>
							                <th class="text-center">PRECIO VENTA</th>
							                <th class="text-center">ACCIONES</th>
							                </tr>
							            </tfoot>
							        </tbody>
							    </table>
							</div>
                        </div>
                        <!-- Modal agregar usuario-->
                        <div class="modal fade" id="modal_agregar_producto" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
                                        <span class="fas fa-barcode"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_agre_pro" name="nom_agre_pro" placeholder="Nombre">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-file-signature"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nit_agre_pro" name="nit_agre_pro" placeholder="Nit proveedor">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="iva_agre_pro" name="iva_agre_pro" placeholder="IVA de compra">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-percent"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="compra_agre_usu" name="compra_agre_usu" placeholder="Precio de compra">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="far fa-money-bill-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="venta_agre_usu" name="venta_agre_usu" placeholder="Precio de venta">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-hand-holding-usd"></span>
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
                        <div class="modal fade" id="modal_editar_producto" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
                                <form method="POST" action="${pageContext.request.contextPath}/ProductosServlet">
                                <div class="input-group mb-3">
                                    <input type="number" class="form-control" id="cod_producto" name="cod_producto" placeholder="Codigo de producto" value="${productoTraer.getCodigo_producto()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-barcode"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nom_edit_pro" name="nom_edit_pro" placeholder="Nombre" value="${productoTraer.getNombre_producto()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-file-signature"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="nit_edit_pro" name="nit_edit_pro" placeholder="Nit proveedor" value="${productoTraer.getNitproveedor()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-address-card"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="iva_edit_pro" name="iva_edit_pro" placeholder="IVA de compra" value="${productoTraer.getIvacompra()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-percent"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="compra_edit_usu" name="compra_edit_usu" placeholder="Precio de compra" value="${productoTraer.getPrecio_compra()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="far fa-money-bill-alt"></span>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="input-group mb-3">
                                    <input type="text" class="form-control" id="venta_edit_usu" name="venta_edit_usu" placeholder="Precio de venta" value="${productoTraer.getPrecio_venta()}">
                                    <div class="input-group-append">
                                      <div class="input-group-text">
                                        <span class="fas fa-hand-holding-usd"></span>
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
										<img width="200px" height="200px" src="${pageContext.request.contextPath}/img/csv.png" alt="" class="img-size-10 mr-3">
										<div class="divider">
											<br>
										</div>
										
										<form method="post" name="formulario" enctype="multipart/form-data">
											<div class="row form-group">
													<input type="file" name="archivo" id="archivo" style="margin: auto;" accept=".csv" class="filestyle" data-buttonText="Seleccione archivo" data-buttonText="Seleccione archivo .csv" onchange="return validarExt()">
											</div>
												<input type="hidden" name="nombre" value="">
												<br>
												<div class="row">
													<div class="text-center" style="margin: auto;">
														<br>
														<input type="submit" value="Procesar" name="procesar" onclick="cargarArchivo(archivo)" class="btn btn-success aling-center">
													</div>
												</div>
										 </form>
								<br>

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
