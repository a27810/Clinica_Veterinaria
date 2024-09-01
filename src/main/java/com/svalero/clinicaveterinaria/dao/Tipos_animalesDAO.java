package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Tipos_animales;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface Tipos_animalesDAO {
    @SqlQuery("SELECT * FROM tipos_animales")
    @UseRowMapper(Tipos_animalesMapper.class)
    List<Tipos_animales> getTiposAnimales();
}