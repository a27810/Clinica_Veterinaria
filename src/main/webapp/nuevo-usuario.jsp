<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.UsuariosDAO" %>

<%@include file="includes/header.jsp"%>

<%
    String mensaje = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombreUsuario = request.getParameter("nombreUsuario");
        String password = request.getParameter("password");
        String nuevoRol = request.getParameter("rol");  // Cambiamos el nombre de la variable

        Database.jdbi.useExtension(UsuariosDAO.class, dao -> {
            dao.insertarUsuario(nombreUsuario, password, nuevoRol);  // Usamos la variable nuevoRol aquí
        });

        mensaje = "Usuario añadido correctamente.";
    }
%>

<div class="container">
    <h2>Añadir Nuevo Usuario</h2>
    <form method="POST" action="">
        <div class="form-group">
            <label for="nombreUsuario">Nombre de Usuario</label>
            <input type="text" class="form-control" id="nombreUsuario" name="nombreUsuario" placeholder="Nombre de Usuario" required>
        </div>
        <div class="form-group">
            <label for="password">Contraseña</label>
            <input type="text" class="form-control" id="password" name="password" placeholder="Contraseña" required>
        </div>
        <div class="form-group">
            <label for="rol">Rol</label>
            <input type="text" class="form-control" id="rol" name="rol" placeholder="Rol (1:Admin - 2:Usuario)" required>
        </div>
        <button type="submit" class="btn btn-primary">Añadir Usuario</button>
    </form>

    <p><%= mensaje %></p>
    <a href="login.jsp" class="btn btn-secondary">Volver</a>
</div>

<%@include file="includes/footer.jsp"%>