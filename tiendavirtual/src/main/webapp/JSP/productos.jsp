<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Productos || Tienda Generica</title>
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
                  <form action="">
                    <div class="row">
                      <div class="col-md-5">
	                      <input type="file" class="form-control">
                      </div>
                      <div class="col-md-4">
                      	<button class="btn btn-success">Cargar</button>
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
