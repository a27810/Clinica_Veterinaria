package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Tipos_animales;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Tipos_animalesMapper implements RowMapper<Tipos_animales> {
    @Override
    public Tipos_animales map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Tipos_animales(rs.getInt("id"),
                rs.getString("tipo"));
    }
}
