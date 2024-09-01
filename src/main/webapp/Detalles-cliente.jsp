<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Clientes" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.ClientesDAO" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Clientes_Animales" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Clientes_AnimalesDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%@include file="includes/header.jsp"%>

<main>
  <section class="py-5 text-center container">
    <h1>Detalles cliente</h1>
  </section>

  <%
    String mensaje = "";
    int clienteID = Integer.parseInt(request.getParameter("ClienteID"));
    int resultado = 0;
    int animalID = 0;

    try{
      animalID = Integer.parseInt(request.getParameter("AnimalID"));
    } catch (Exception e) {
     // Ponemos este request dentro de un try-catch para evitar errores cuando solo estamos visualizando
      // o actualizando los datos del cliente.
    }

    // Comprobamos si el usuario ha iniciado sesion. Si no es asi, la variable 'Read_Only' es True.
    boolean read_only = true;
    if (IDUsuario != 0) {
      read_only = false;
    }

    Clientes cliente = new Clientes();

    // Si no hay un ID de cliente volvemos a la pagina principal
    if (request.getParameter("ClienteID") == null) {
      response.sendRedirect("index.jsp");
    } else {
      Database.connect();

      // Si solo tenemos el ID de cliente pero no el del animal, solo actualizamos el cliente.
      if (clienteID != 0 && animalID == 0) {
        String nombreCliente = request.getParameter("Nombre");
        String apellido1Cliente = request.getParameter("Apellido1");
        String apellido2Cliente = request.getParameter("Apellido2");
        String telefonoCliente = request.getParameter("Telefono");

        if (nombreCliente != null && !nombreCliente.isEmpty() &&
                apellido1Cliente != null && !apellido1Cliente.isEmpty() &&
                apellido2Cliente != null && !apellido2Cliente.isEmpty() &&
                telefonoCliente != null && !telefonoCliente.isEmpty()) {
          resultado = Database.jdbi.withExtension(ClientesDAO.class, dao -> dao.updateCliente(nombreCliente, apellido1Cliente, apellido2Cliente, telefonoCliente, clienteID));

          if (resultado != 1) {
            mensaje = "Error al actualizar los datos ";
          } else {
            mensaje = "Cliente actualizado correctamente";
          }
        }
      } else if (animalID != 0) {
        String nombreAnimal = request.getParameter("NombreAnimal");
        Date fechaNacimiento = null;

          try {
              fechaNacimiento = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("FechaNacimiento"));
          } catch (ParseException e) {
              //throw new RuntimeException(e);
            mensaje = "Formato de fecha invalido. " + e.getMessage();
          }

          if (nombreAnimal != null && !nombreAnimal.isEmpty()) {
            Date finalFechaNacimiento = fechaNacimiento;
            int finalAnimalID = animalID;
            resultado = Database.jdbi.withExtension(Clientes_AnimalesDAO.class, dao -> dao.updateCliente_Animal(nombreAnimal, finalFechaNacimiento, finalAnimalID));

          if (resultado != 1) {
            mensaje = "Error al actualizar los datos del animal";
          } else {
            mensaje = "Animal actualizado correctamente";
          }
        }
      }

      cliente = Database.jdbi.withExtension(ClientesDAO.class, dao -> dao.getClientePorID(clienteID));
    }
  %>

  <div class="container features">
    <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-6">
          <form id="defaults_clientes_formulario" modelAttribute="detalles_cliente" method="POST"
                action="Detalles-cliente.jsp?ClienteID=<%= String.valueOf(clienteID) %>">
            <div class="form-group">
              <input type="text" name="Nombre" value="<%= cliente.getNombre() %>" class="form-control"
                  <% if (read_only == true) { %> disabled <% } %> required >
            </div>
            <div class="form-group">
              <input type="text" name="Apellido1" value="<%= cliente.getApellido1() %>" class="form-control"
                  <% if (read_only == true) { %> disabled <% } %> required >
            </div>
            <div class="form-group">
              <input type="text" name="Apellido2" value="<%= cliente.getApellido2() %>" class="form-control"
                  <% if (read_only == true) { %> disabled <% } %> required >
            </div>
            <div class="form-group">
              <input type="text" name="Telefono" value="<%= cliente.getTelefono() %>" class="form-control"
                  <% if (read_only == true) { %> disabled <% } %> required >
            </div>

            <input type="submit" class="btn btn-secondary btn-block" value="Actualizar cliente" name="ActualizarCliente"
                    <% if (read_only == true) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %> >
          </form>
        </div>
      <div><%= mensaje %></div>
    </div>
  </div>

  <div class="container features">
    <h3 class="feature-title">Animales del cliente</h3>
    <a class="btn btn-outline-secondary btn-lg" value="Nuevo animal" href="nuevo-animal-cliente.jsp?ClienteID=<%= String.valueOf(clienteID) %>"
            <% if (read_only == true) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %> >
      Crear nuevo animal</a>

    <div class="row">
      <%
        List<Clientes_Animales> listaAnimales = null;

        if (request.getParameter("busqueda") != null){
          String nombreAnimal;
          String fechaNacimiento;

          if (request.getParameter("NombreAnimal") != null) { nombreAnimal = request.getParameter("NombreAnimal"); } else {
            nombreAnimal = "";
          }
          if (request.getParameter("FechaNacimiento") != null) { fechaNacimiento = request.getParameter("FechaNacimiento"); } else {
            fechaNacimiento = "";
          }

          if (nombreAnimal != null && !nombreAnimal.isEmpty() &&
                  fechaNacimiento != null && !fechaNacimiento.isEmpty()) {
            listaAnimales = Database.jdbi.withExtension(Clientes_AnimalesDAO.class, dao ->
                    dao.getBusquedaAnimales(nombreAnimal, new SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimiento), clienteID));
          } else {
            mensaje = "Nombre de animal y fecha de nacimiento son obligatorios para realizar la busqueda";
          }
        } else {
          listaAnimales = Database.jdbi.withExtension(Clientes_AnimalesDAO.class, dao -> dao.getListaAnimalesCliente(Integer.parseInt(request.getParameter("ClienteID"))));
        }

        for (Clientes_Animales animalCliente : listaAnimales) {
      %>

      <div class="card col-lg-3 col-md-3 col-sm-4 text-center">
        <form id="detalles_animal_formulario" modelAttribute="detalles_animal" method="POST"
              action="Detalles-cliente.jsp?ClienteID=<%= String.valueOf(clienteID) %>&AnimalID=<%= animalCliente.getId() %>">
          <div class="card-body">
            <div class="form-group">
              <h4 class="card-title">
                <input type="text" name="NombreAnimal" value="<%= animalCliente.getNombreanimal() %>" class="form-control"
                  <% if (read_only == true) { %> disabled <% } %> required >
              </h4>
            </div>
            <div class="form-group">
              <input type="text" name="FechaNacimiento" value="<%= animalCliente.getFechanacimiento() %>" class="form-control"
                <% if (read_only == true) { %> disabled <% } %> required >
            </div>
            <div class="form-group">
              <p class="card-text"><%= animalCliente.getTipo() %></p>
            </div>
            <input type="submit" class="btn btn-secondary btn-block" value="Actualizar animal" name="ActualizarAnimal"
              <% if (read_only == true) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %> >
          </div>
        </form>

        <!-- Botón para eliminar el animal -->
        <form method="POST" action="EliminarAnimal.jsp">
          <input type="hidden" name="ClienteID" value="<%= clienteID %>">
          <input type="hidden" name="AnimalID" value="<%= animalCliente.getId() %>">
          <input type="submit" class="btn btn-danger btn-block" value="Eliminar animal" name="EliminarAnimal"
            <% if (read_only == true) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %>
                 onclick="return confirm('¿Estás seguro de que deseas eliminar este animal?');">
        </form>
      </div>
      <% } %>

    </div>
  </div>

  <div class="container features">
    <div class="row">
      <div class="col-lg-4 col-md-4 col-sm-6">
        <section class="py-5 text-center container">
          <h1>Buscar animal</h1>
          <form id="busqueda" modelAttribute="busqueda" method="POST"
                action="Detalles-cliente.jsp?ClienteID=<%= clienteID %>&busqueda=true">
            <input type="text" name="NombreAnimal" class="form-control" placeholder="Nombre animal" required>
            <label for="FechaNacimientoCalendario">Fecha Nacimiento</label>
            <input id="FechaNacimientoCalendario" name="FechaNacimiento" class="form-control" type="date"
                   placeholder="Fecha nacimiento" required />

            <input type="submit" class="btn btn-secondary btn-block" value="Buscar animal" name="BuscarAnimal">
          </form>
          <div><%= mensaje %></div>
        </section>
      </div>
    </div>
  </div>

  <!-- Botón de Eliminar Cliente -->
  <div class="container features">
    <div class="row">
      <div class="col-lg-4 col-md-4 col-sm-6">
        <form id="detalles_clientes_formulario" modelAttribute="detalles_cliente" method="POST"
              action="Detalles-cliente.jsp?ClienteID=<%= String.valueOf(clienteID) %>">
        </form>
      </div>


      <div class="col-lg-4 col-md-4 col-sm-6">
        <form id="eliminar_cliente_formulario" method="POST" action="EliminarCliente.jsp">
          <input type="hidden" name="ClienteID" value="<%= clienteID %>">
          <input type="submit" class="btn btn-danger btn-block" value="Eliminar Cliente" name="EliminarCliente"
            <% if (read_only) { %> style="visibility: hidden" <% } %> >
        </form>

      </div>
    </div>
    <div><%= mensaje %></div>
  </div>

</main>

<%@include file="includes/footer.jsp"%>

