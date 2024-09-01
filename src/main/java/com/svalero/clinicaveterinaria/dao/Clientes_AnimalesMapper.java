package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Clientes_Animales;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Clientes_AnimalesMapper implements RowMapper<Clientes_Animales> {
    @Override
    public Clientes_Animales map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Clientes_Animales(rs.getInt("id"),
                rs.getString("nombreanimal"),
                rs.getDate("fechanacimiento"),
                rs.getString("tipo"),
                rs.getInt("clienteid"));
    }
}
