<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Clientes_AnimalesDAO" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Tipos_animales" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Tipos_animalesDAO" %>

<%@include file="includes/header.jsp"%>

<main>
    <section class="py-5 text-center container">
        <h1>Nuevo animal</h1>
    </section>

    <%
        String mensaje = "";
        int clienteID = Integer.parseInt(request.getParameter("ClienteID"));
        int resultado = 0;

        // Comprobamos si el usuario ha iniciado sesion. Si no es asi, la variable 'Read_Only' es True.
        boolean read_only = true;
        if (IDUsuario != 0) {
            read_only = false;
        }

        String nombreAnimal = request.getParameter("NombreAnimal");
        String fechaNacimiento = request.getParameter("FechaNacimiento");
        String tipoAnimal = request.getParameter("TipoAnimal");

        if (nombreAnimal != null && !nombreAnimal.isEmpty() &&
                fechaNacimiento != null && !fechaNacimiento.isEmpty() &&
                tipoAnimal != null && !tipoAnimal.isEmpty()) {
            resultado = Database.jdbi.withExtension(Clientes_AnimalesDAO.class, dao ->
                    dao.addCliente_Animal(nombreAnimal,
                            new SimpleDateFormat("yyyy-MM-dd").parse(fechaNacimiento), Integer.parseInt(tipoAnimal), clienteID));

            if (resultado != 1) {
                mensaje = "Error al insertar los datos ";
            } else {
                mensaje = "Nuevo animal creado correctamente";
                String redirigirURL = "Detalles-cliente.jsp?ClienteID=" + clienteID;
                response.sendRedirect(redirigirURL);
            }
        }

    %>

    <div class="container features">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-6">
                <form id="nuevo_cliente_animal_formulario" modelAttribute="nuevo_cliente_animal" method="POST"
                      action="nuevo-animal-cliente.jsp?ClienteID=<%= String.valueOf(clienteID) %>">
                    <div class="form-group">
                        <input type="text" name="NombreAnimal" class="form-control" placeholder="Nombre animal"
                            <% if (read_only == true) { %> disabled <% } %> required >
                    </div>
                    <div class="form-group">
                        <label for="FechaNacimientoCalendario">Fecha Nacimiento</label>
                        <input id="FechaNacimientoCalendario" name="FechaNacimiento" class="form-control" type="date" placeholder="Fecha nacimiento"
                            <% if (read_only == true) { %> disabled <% } %> required />
                    </div>
                    <div class="form-group">
                        <label for="ListadoTipoAnimal">Tipo animal</label>
                        <select id="ListadoTipoAnimal" name="TipoAnimal" class="form-control"
                                <% if (read_only == true) { %> disabled <% } %> required >
                            <%
                                List<Tipos_animales> listaTiposAnimales = Database.jdbi.withExtension(Tipos_animalesDAO.class, dao -> dao.getTiposAnimales());
                                for (Tipos_animales tipo : listaTiposAnimales) {
                            %>
                            <option value="<%= tipo.getId() %>"><%= tipo.getTipo() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>

                    <input type="submit" class="btn btn-secondary btn-block" value="Crear animal" name="NuevoClienteAnimal"
                        <% if (read_only == true) { %> style="visibility: hidden" <% } else { %> style="visibility: visible" <% } %> >
                </form>
            </div>
            <div><%= mensaje %></div>
        </div>
    </div>

</main>

<%@include file="includes/footer.jsp"%>
