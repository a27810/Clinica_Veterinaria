<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.svalero.clinicaveterinaria.dao.Database" %>
<%@ page import="com.svalero.clinicaveterinaria.dao.Clientes_AnimalesDAO" %>

<%
    String mensaje = "";
    int clienteID = Integer.parseInt(request.getParameter("ClienteID"));
    int animalID = Integer.parseInt(request.getParameter("AnimalID"));

    if (clienteID != 0 && animalID != 0) {
        Database.connect();

        // Eliminar el registro del animal en la tabla clientes_animales usando la columna ID
        int resultado = Database.jdbi.withExtension(Clientes_AnimalesDAO.class, dao -> dao.deleteCliente_Animal(clienteID, animalID));

        if (resultado == 1) {
            mensaje = "Animal eliminado correctamente.";
        } else {
            mensaje = "Error al eliminar el animal.";
        }
    } else {
        mensaje = "Cliente ID o Animal ID no válido.";
    }

    response.sendRedirect("Detalles-cliente.jsp?ClienteID=" + clienteID + "&mensaje=" + mensaje);
%>
