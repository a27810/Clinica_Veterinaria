<html>
<head>
    <title>Búsqueda Avanzada</title>
</head>
<body>
<h2>Búsqueda en la Base de Datos</h2>
<form action="busqueda" method="get">
    <!-- Campos de búsqueda para Clientes -->
    <label for="nombreCliente">Nombre del Cliente:</label>
    <input type="text" name="nombreCliente" id="nombreCliente">
    <br>
    <label for="apellidoCliente">Apellido del Cliente:</label>
    <input type="text" name="apellidoCliente" id="apellidoCliente">
    <br><br>
    <!-- Campos de búsqueda para Animales -->
    <label for="nombreAnimal">Nombre del Animal:</label>
    <input type="text" name="nombreAnimal" id="nombreAnimal">
    <br>
    <label for="especieAnimal">Especie del Animal:</label>
    <input type="text" name="especieAnimal" id="especieAnimal">
    <br><br>
    <!-- Campos de búsqueda para Tipos de Animales -->
    <label for="tipoAnimal">Tipo de Animal:</label>
    <input type="text" name="tipoAnimal" id="tipoAnimal">
    <br>
    <label for="descripcionAnimal">Descripción del Animal:</label>
    <input type="text" name="descripcionAnimal" id="descripcionAnimal">
    <br><br>
    <button type="submit">Buscar</button>
</form>
</body>
</html>
