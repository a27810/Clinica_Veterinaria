<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">

    <script>
        $(function() {
            $(".datepicker").datepicker();
        });
    </script>

    <title>Clinica Veterinaria</title>
</head>

<%
    HttpSession currentSession = request.getSession();
    String rol;
    int IDUsuario = 0;
    if (currentSession.getAttribute("rolUsuario") != null) {
        rol = currentSession.getAttribute("rolUsuario").toString();
    } else {
        rol = "anonymous";
    }
    if (currentSession.getAttribute("IDUsuario") != null) {
        IDUsuario = Integer.parseInt(currentSession.getAttribute("IDUsuario").toString());
    }
%>

<body>
    <nav class="navbar navbar-expand-md">
        <div class="collapse navbar-collapse" id="main-navigation">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/ClinicaVeterinaria_war_exploded">Home</a>
                </li>
                <li class="nav-item">
                    <%
                        if (IDUsuario == 0) {
                    %>
                    <a class="nav-link" href="login.jsp" id="loginbutton">Login</a>
                    <%
                        } else {
                    %>
                    <a class="nav-link" href="logout.jsp" id="logoutbutton">Logout</a>
                    <%
                        }
                    %>
                </li>
            </ul>
        </div>
    </nav>