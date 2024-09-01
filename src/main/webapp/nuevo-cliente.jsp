<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.ClientesDAO" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Clientes" %>
<%@ page import="java.util.List" %>

<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container">
        <h1>Nuevo cliente</h1>
    </section>

    <%
        String mensaje = "";
        int resultado = 0;

        // Comprobamos si el usuario ha iniciado sesion. Si no es asi, la variable 'Read_Only' es True.
        boolean read_only = (IDUsuario == 0);

        String nombreCliente = request.getParameter("Nombre");
        String apellido1Cliente = request.getParameter("Apellido1");
        String apellido2Cliente = request.getParameter("Apellido2");
        String telefonoCliente = request.getParameter("Telefono");

        if (nombreCliente != null && !nombreCliente.isEmpty() &&
                apellido1Cliente != null && !apellido1Cliente.isEmpty() &&
                apellido2Cliente != null && !apellido2Cliente.isEmpty() &&
                telefonoCliente != null && !telefonoCliente.isEmpty()) {
            resultado = Database.jdbi.withExtension(ClientesDAO.class, dao -> dao.addCliente(nombreCliente, apellido1Cliente, apellido2Cliente, telefonoCliente));

            if (resultado != 1) {
                mensaje = "Error al insertar los datos ";
            } else {
                mensaje = "Nuevo cliente creado correctamente";

                // Buscamos el cliente que acabamos de crear para obtener el ID.
                List<Clientes> clientes = Database.jdbi.withExtension(ClientesDAO.class, dao -> dao.getClientePorNombreApellidos(nombreCliente, apellido1Cliente, apellido2Cliente));

                if (clientes != null && !clientes.isEmpty()) {
                    Clientes nuevoCliente = clientes.get(0);  // Tomamos el primer cliente en la lista
                    String redirigirURL = "Detalles-cliente.jsp?ClienteID=" + nuevoCliente.getId();
                    response.sendRedirect(redirigirURL);
                } else {
                    mensaje = "No se encontró el cliente recién creado.";
                }
            }
        }

    %>

    <div class="container features">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-6">
                <form id="nuevo_cliente_formulario" modelAttribute="nuevo_cliente" method="POST"
                      action="nuevo-cliente.jsp">
                    <div class="form-group">
                        <input type="text" name="Nombre" class="form-control" placeholder="Nombre"
                            <% if (read_only) { %> disabled <% } %> required >
                    </div>
                    <div class="form-group">
                        <input type="text" name="Apellido1" class="form-control" placeholder="Primer apellido"
                            <% if (read_only) { %> disabled <% } %> required >
                    </div>
                    <div class="form-group">
                        <input type="text" name="Apellido2" class="form-control" placeholder="Segundo apellido"
                            <% if (read_only) { %> disabled <% } %> required >
                    </div>
                    <div class="form-group">
                        <input type="text" name="Telefono" class="form-control" placeholder="Telefono"
                            <% if (read_only) { %> disabled <% } %> required >
                    </div>

                    <input type="submit" class="btn btn-secondary btn-block" value="Crear cliente" name="NuevoCliente"
                        <% if (read_only) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %> >
                </form>
            </div>
            <div><%= mensaje %></div>
        </div>
    </div>

</main>

<%@include file="includes/footer.jsp"%>
