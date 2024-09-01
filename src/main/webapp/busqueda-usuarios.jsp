<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.domain.Usuarios" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.UsuariosDAO" %>
<%@ page import="java.util.List" %>

<%@include file="includes/header.jsp"%>

<%
    // Obtener los parámetros de búsqueda desde la URL
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

<div class="container features">
    <div class="row">
        <div class="col-lg-12">
            <h2>Resultados de la Búsqueda</h2>

            <!-- Tabla de resultados -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Contraseña</th>
                    <th>Rol (1:Admin - 2: Usuario)</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (Usuarios usuario : listaUsuarios) {
                %>
                <tr>
                    <td><%= usuario.getId() %></td>
                    <td><%= usuario.getNombreusuario() %></td>
                    <td><%= usuario.getPassword() %></td>
                    <td><%= usuario.getRol() %></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>

            <%
                if (listaUsuarios.isEmpty()) {
            %>
            <p>No se encontraron usuarios que coincidan con los criterios de búsqueda.</p>
            <%
                }
            %>

        </div>
    </div>
</div>

<%@include file="includes/footer.jsp"%>
