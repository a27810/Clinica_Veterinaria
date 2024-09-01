<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Usuarios" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.UsuariosDAO" %>
<%@ page import="java.util.List" %>

<%@include file="includes/header.jsp"%>

<%
    String mensaje = "";
    Usuarios usuarioActual = new Usuarios();
    if (IDUsuario == 0) {
        Database.connect();
        String nombreUsuario = request.getParameter("Usuario");
        String usuarioPassword = request.getParameter("Password");

        if (nombreUsuario != null && !nombreUsuario.equals("") &&
                usuarioPassword != null && !usuarioPassword.equals("")){
            usuarioActual = Database.jdbi.withExtension(UsuariosDAO.class, dao -> dao.getUsuario(nombreUsuario, usuarioPassword));

            if (usuarioActual == null){
                mensaje = "Usuario no encontrado";
            } else {
                IDUsuario = usuarioActual.getId();
                currentSession.setAttribute("rolUsuario", usuarioActual.getRol());
                currentSession.setAttribute("IDUsuario", IDUsuario);
            }
        }
    }
%>

<div class="container features">
    <div class="row">
        <%
            if (IDUsuario == 0) {
        %>
        <div class="col-lg-4 col-md-4 col-sm-6">
            <form id="login_formulario" method="POST" action="login.jsp">
                <div class="form-group">
                    <input type="text" name="Usuario" class="form-control" placeholder="Usuario" required>
                </div>
                <div class="form-group">
                    <input type="password" name="Password" class="form-control" placeholder="Contraseña" required>
                </div>

                <input type="submit" class="btn btn-secondary btn-block" value="Login" name="Login">
            </form>
        </div>
        <div><%= mensaje %></div>
        <%
        } else {
            // Verificar si el usuario autenticado es "Usuario1"
            if ("Usuario1".equals(usuarioActual.getNombreusuario())) {
                // Recuperar los valores de búsqueda desde la solicitud
                String filtroUsuario = request.getParameter("filtroUsuario");
                String filtroRol = request.getParameter("filtroRol");

                // Si los filtros son nulos, inicializarlos como cadenas vacías
                if (filtroUsuario == null) {
                    filtroUsuario = "";
                }
                if (filtroRol == null) {
                    filtroRol = "";
                }

                // Recuperar la lista de usuarios desde la base de datos según los filtros
                String finalFiltroUsuario = filtroUsuario;
                String finalFiltroRol = filtroRol;
                List<Usuarios> listaUsuarios = Database.jdbi.withExtension(UsuariosDAO.class, dao -> dao.buscarUsuarios(finalFiltroUsuario, finalFiltroRol));

        %>
        <div class="col-lg-12">
            <h2>Tabla de Usuarios</h2>
            <a href="nuevo-usuario.jsp" class="btn btn-success">Añadir Nuevo Usuario</a> <!-- Botón para añadir nuevo usuario -->

            <!-- Formulario de búsqueda -->
            <form method="GET" action="busqueda-usuarios.jsp">
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <input type="text" name="filtroUsuario" class="form-control" placeholder="Buscar por Usuario" value="<%= filtroUsuario %>">
                    </div>
                    <div class="form-group col-md-4">
                        <input type="text" name="filtroRol" class="form-control" placeholder="Buscar por Rol" value="<%= filtroRol %>">
                    </div>
                    <div class="form-group col-md-4">
                        <button type="submit" class="btn btn-primary">Buscar</button>
                    </div>
                </div>
            </form>

            <!-- Tabla de resultados -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Contraseña</th>
                    <th>Rol (1:Admin - 2: Usuario)</th>
                    <th>Acciones</th> <!-- Nueva columna para los botones -->
                </tr>
                </thead>
                <tbody>
                <%
                    for (Usuarios usuario : listaUsuarios) {
                %>
                <tr>
                    <form method="POST" action="login.jsp">
                        <td><%= usuario.getId() %></td>
                        <td><input type="text" name="nombreUsuario" class="form-control" value="<%= usuario.getNombreusuario() %>"></td>
                        <td><input type="text" name="password" class="form-control" value="<%= usuario.getPassword() %>"></td> <!-- Contraseña visible -->
                        <td><input type="text" name="rol" class="form-control" value="<%= usuario.getRol() %>"></td>
                        <td>
                            <input type="hidden" name="id" value="<%= usuario.getId() %>">
                            <button type="submit" name="accion" value="actualizar" class="btn btn-warning">Actualizar</button>
                            <button type="submit" name="accion" value="eliminar" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que deseas eliminar este usuario?');">Eliminar</button>
                        </td>
                    </form>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
        <%
        } else {
        %>
        <div>Usuario <b><%= usuarioActual.getNombreusuario() %></b> correctamente autenticado</div>
        <%
                }
            }
        %>
    </div>
</div>

<%@include file="includes/footer.jsp"%>
