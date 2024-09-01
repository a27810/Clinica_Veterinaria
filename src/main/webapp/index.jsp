<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Clientes" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.ClientesDAO" %>

<%@include file="includes/header.jsp"%>

<main>
  <%
    // Comprobamos si el usuario ha iniciado sesion. Si no es asi, la variable 'Read_Only' es True.
    boolean read_only = true;
    if (IDUsuario != 0) {
    read_only = false;
    }
    String mensaje = "";
  %>

  <div class="container features">
    <div class="row">
      <div class="col-lg-4 col-md-4 col-sm-6">
        <section class="py-5 text-center container">
    <h1>Buscar cliente</h1>
    <form id="busqueda" modelAttribute="busqueda" method="POST"
          action="index.jsp?busqueda=true">
      <input type="text" name="Nombre" class="form-control" placeholder="Nombre cliente" required>
      <input type="text" name="Apellido1" class="form-control" placeholder="Primer apellido" required>
      <input type="text" name="Apellido2" class="form-control" placeholder="Segundo apellido">

      <input type="submit" class="btn btn-secondary btn-block" value="Buscar cliente" name="BuscarCliente">
    </form>
    <div><%= mensaje %></div>
  </section>
      </div>
    </div>
  </div>

  <section class="py-5 text-center container">
    <h1>Lista clientes</h1>
  </section>
  <div class="background">
    <a class="btn btn-outline-secondary btn-lg" value="Nuevo cliente" href="nuevo-cliente.jsp"
            <% if (read_only == true) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %> >
      Crear nuevo cliente</a>

    <div class="container team">
      <div class="row">
        <%
          Database.connect();
          List<Clientes> clientes = null;

          if (request.getParameter("busqueda") != null){
            String nombreCliente;
            String apellido1Cliente;
            String apellido2Cliente;

            if (request.getParameter("Nombre") != null) { nombreCliente = request.getParameter("Nombre"); } else {
              nombreCliente = "";
            }
            if (request.getParameter("Apellido1") != null) { apellido1Cliente = request.getParameter("Apellido1"); } else {
              apellido1Cliente = "";
            }
            if (request.getParameter("Apellido2") != null) { apellido2Cliente = request.getParameter("Apellido2"); } else {
              apellido2Cliente = "";
            }

            if (nombreCliente != null && !nombreCliente.isEmpty() &&
                    apellido1Cliente != null && !apellido1Cliente.isEmpty()) {
              clientes = Database.jdbi.withExtension(ClientesDAO.class, dao ->
                      dao.getClientePorNombreApellidos(nombreCliente, apellido1Cliente, apellido2Cliente));
            } else {
              mensaje = "Nombre y primer apellido son obligatorios para realizar la busqueda";
            }
          } else {
            clientes = Database.jdbi.withExtension(ClientesDAO.class, ClientesDAO::getListaClientes);
          }
          for (Clientes cliente : clientes) {
        %>
        <div class="card col-lg-3 col-md-3 col-sm-4 text-center">
          <a href="Detalles-cliente.jsp?ClienteID=<%= cliente.getId() %>">
            <img class="card-img-top rounded-circle" src="<%= request.getContextPath() + cliente.getRutafoto() %>" alt="Foto usuario">
          </a>
          <div class="card-body">
            <h4 class="card-title"><%= cliente.getNombre() + ' ' + cliente.getApellido1() + ' ' + cliente.getApellido2() %></h4>
            <p class="card-text"><%= cliente.getTelefono() %></p>
          </div>
        </div>
        <% } %>
      </div>
    </div>
  </div>
</main>

<%@include file="includes/footer.jsp"%>