package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Clientes;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientesMapper implements RowMapper<Clientes> {
    @Override
    public Clientes map(ResultSet rs, StatementContext ctx) throws SQLException {

        return new Clientes(rs.getInt("id"),
                rs.getString("nombre"),
                rs.getString("apellido1"),
                rs.getString("apellido2"),
                rs.getString("telefono"),
                rs.getString("rutafoto"));
    }
}