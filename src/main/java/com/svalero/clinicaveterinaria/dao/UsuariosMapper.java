package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Usuarios;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import java.sql.ResultSet;
import java.sql.SQLException;
/*import java.util.List;*/

public class UsuariosMapper implements RowMapper<Usuarios> {
    @Override
    public Usuarios map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Usuarios(rs.getInt("id"),
                rs.getString("nombreusuario"),
                rs.getString("password"),
                rs.getString("rol"));
    }

}

