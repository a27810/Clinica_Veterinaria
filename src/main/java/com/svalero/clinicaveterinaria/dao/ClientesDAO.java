package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Clientes;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;
import java.util.Optional;

public interface ClientesDAO {
    @SqlQuery("SELECT * FROM Clientes")
    @UseRowMapper(ClientesMapper.class)
    List<Clientes> getListaClientes();

    @SqlQuery("SELECT * FROM Clientes WHERE ID = ?")
    @UseRowMapper(ClientesMapper.class)
    Clientes getClientePorID(int id);

    @SqlQuery("SELECT * FROM Clientes WHERE Nombre = ? AND Apellido1 = ? AND Apellido2 LIKE CONCAT('%', ?,'%')")
    @UseRowMapper(ClientesMapper.class)
    List<Clientes> getClientePorNombreApellidos(String nombre, String apellido1, String apellido2);

    @SqlUpdate("INSERT INTO Clientes (Nombre, Apellido1, Apellido2, Telefono) VALUES (?, ?, ?, ?)")
    int addCliente(String nombre, String apellido1, String apellido2, String telefono);

    @SqlUpdate("UPDATE Clientes SET Nombre = ?, Apellido1 = ?, Apellido2 = ?, Telefono = ? WHERE ID = ?")
    int updateCliente(String nombre, String apellido1, String apellido2, String telefono, int id);

    @SqlUpdate("DELETE FROM clientes WHERE id = :id")
    int deleteCliente(@Bind("id") int id);

}
