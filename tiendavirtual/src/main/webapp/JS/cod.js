/**
 * 
 */

function ver_contra(checkbox){
	
 var password = document.getElementById("contrasena");

  if (checkbox.checked){
    password.type = "text";
  } else {
    password.type = "password";
    
  }
}

function elim_usuario(btn){
	var id = btn.id;
	id = parseInt(id);
    	Swal.fire({
              html: '¿Estas seguro de eliminar este usuario?',
              text: "Tenga en cuenta que esta accion es irreversible!",
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Si, Eliminar!',
              cancelButtonText: 'Cancelar'
            }).then((result) => {
              if (result.isConfirmed) {
      			location.href = "http://localhost:6450/login/UsuariosServlet?accion=Eliminar&id="+id;
              }
            })
    
  }
function mostrar_usuario(btn){
	var id = btn.id;
	id = parseInt(id);
	//alert(id);
	location.href = "http://localhost:6450/login/UsuariosServlet?accion=Traer&id="+id;
}
function modal(){
	$('#modal_editar_usuarios').modal('show');
}
function buscarUsuario(){
	var id = document.getElementById("num_buscar_usu").value;
	id = parseInt(id);
	if($("#num_buscar_usu").val().length < 1){
		Swal.fire({
				  title: 'Espera!',
				  text: "Debe digitar almenos un numero para empezar la busqueda del usuario",
				  icon: 'warning',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
	}else{
	//alert(id);
		location.href = "http://localhost:6450/login/UsuariosServlet?accion=buscar&id="+id;
	}
}

//-------clientes---------------

function elim_cliente(btn){
	var id = btn.id;
	id = parseInt(id);
    	Swal.fire({
              html: '¿Estas seguro de eliminar este cliente?',
              text: "Tenga en cuenta que esta accion es irreversible!",
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Si, Eliminar!',
              cancelButtonText: 'Cancelar'
            }).then((result) => {
              if (result.isConfirmed) {
      			location.href = "http://localhost:6450/login/ClientesServlet?accion=Eliminar&id="+id;
              }
            })
    
  }

function mostrar_cliente(btn){
	var id = btn.id;
	id = parseInt(id);
	//alert(id);
	location.href = "http://localhost:6450/login/ClientesServlet?accion=Traer&id="+id;
}

function modal_clientes(){
	$('#modal_editar_clientes').modal('show');
}
function buscarCliente(){
	var id = document.getElementById("num_buscar_cli").value;
	id = parseInt(id);
	if($("#num_buscar_cli").val().length < 1){
		Swal.fire({
				  title: 'Espera!',
				  text: "Debe digitar almenos un numero para empezar la busqueda del cliente",
				  icon: 'warning',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
	}else{
	//alert(id);
		location.href = "http://localhost:6450/login/ClientesServlet?accion=buscar&id="+id;
	}
}

//-------proveedores---------------

function elim_proveedor(btn){
	var id = btn.id;
	id = parseInt(id);
    	Swal.fire({
              html: '¿Estas seguro de eliminar este proveedor?',
              text: "Tenga en cuenta que esta accion es irreversible!",
              icon: 'warning',
              showCancelButton: true,
              confirmButtonColor: '#3085d6',
              cancelButtonColor: '#d33',
              confirmButtonText: 'Si, Eliminar!',
              cancelButtonText: 'Cancelar'
            }).then((result) => {
              if (result.isConfirmed) {
      			location.href = "http://localhost:6450/login/ProveedoresServlet?accion=Eliminar&id="+id;
              }
            })
    
  }

function mostrar_proveedor(btn){
	var id = btn.id;
	id = parseInt(id);
	//alert(id);
	location.href = "http://localhost:6450/login/ProveedoresServlet?accion=Traer&id="+id;
}

function modal_proveedores(){
	$('#modal_editar_proveedores').modal('show');
}
function buscarProveedor(){
	var id = document.getElementById("nit_bus_pro").value;
	id = parseInt(id);
	if($("#nit_bus_pro").val().length < 1){
		Swal.fire({
				  title: 'Espera!',
				  text: "Debe digitar almenos un numero para empezar la busqueda del proveedor",
				  icon: 'warning',
				  showCancelButton: false,
				  confirmButtonColor: '#3085d6',
				  confirmButtonText: 'Entiendo'
				})
	}else{
	//alert(id);
		location.href = "http://localhost:6450/login/ProveedoresServlet?accion=buscar&id="+id;
	}
}



//---------- ventas---------
function buscar_nom_cli(){
	var id = document.getElementById("cedula_cliente").value;
	id = parseInt(id);
	if($("#cedula_cliente").val().length < 1){
		Swal.fire({
		  title: 'Espera!',
		  text: "Debe digitar almenos un numero para empezar la busqueda del cliente",
		  icon: 'warning',
		  showCancelButton: false,
		  confirmButtonColor: '#3085d6',
		  confirmButtonText: 'Entiendo'
		})
	}else{
		//alert(id);
		location.href = "http://localhost:6450/login/VentasServlet?accion=Traer&cedula_cliente="+id;
	}
}

function buscar_nom_pro(){
	var id = document.getElementById("cod_producto").value;
	id = parseInt(id);
	var nombre = document.getElementById("nombre_cliente").value;
	var cedula = document.getElementById("cedula_cliente").value;
	cedula = parseInt(cedula);
	if($("#cod_producto").val().length < 1){
		Swal.fire({
		  title: 'Espera!',
		  text: "Debe digitar almenos un numero para empezar la busqueda del producto",
		  icon: 'warning',
		  showCancelButton: false,
		  confirmButtonColor: '#3085d6',
		  confirmButtonText: 'Entiendo'
		})
	}else{
		//alert(id);
		location.href = "http://localhost:6450/login/VentasServlet?accion=Traerp&cod_producto="+id+"&nombre_cliente="+nombre+"&cedula_cliente="+cedula;
	}
}
