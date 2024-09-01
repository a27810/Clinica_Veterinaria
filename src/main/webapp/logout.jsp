<%-- Este es el archivo logout.jsp que manejará el cierre de sesión --%>
<%
    // Obtener la sesión actual, si existe
    if (session != null) {
        session.invalidate(); // Invalidar la sesión
    }
    // Redirigir a la página de login después de cerrar la sesión
    response.sendRedirect("login.jsp");
%>
