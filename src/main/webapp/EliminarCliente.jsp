<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.ClientesDAO" %>

<%
    String mensaje = "";
    int clienteID = Integer.parseInt(request.getParameter("ClienteID"));

    if (clienteID != 0) {
        Database.connect();

        // Eliminar registros dependientes
        Database.jdbi.useHandle(handle -> {
            handle.execute("DELETE FROM clientes_animales WHERE ClienteID = ?", clienteID);
        });

        // Eliminar cliente
        int resultado = Database.jdbi.withExtension(ClientesDAO.class, dao -> dao.deleteCliente(clienteID));

        if (resultado == 1) {
            mensaje = "Cliente eliminado correctamente.";
        } else {
            mensaje = "Error al eliminar el cliente.";
        }
    } else {
        mensaje = "Cliente ID no válido.";
    }

    response.sendRedirect("index.jsp?mensaje=" + mensaje);
%>
