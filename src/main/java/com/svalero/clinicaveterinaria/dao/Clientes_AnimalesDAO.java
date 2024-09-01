package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Clientes_Animales;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.Date;
import java.util.List;

public interface Clientes_AnimalesDAO {
    @SqlQuery("SELECT clientes_animales.ID, " +
            "clientes_animales.NombreAnimal, " +
            "clientes_animales.FechaNacimiento, " +
            "clientes_animales.ClienteID, " +
            "tipos_animales.tipo " +
            "FROM clientes_animales " +
            "LEFT JOIN tipos_animales " +
            "ON clientes_animales.TipoAnimal = tipos_animales.ID " +
            "WHERE clientes_animales.ClienteID = ?")
    @UseRowMapper(Clientes_AnimalesMapper.class)
    List<Clientes_Animales> getListaAnimalesCliente(int clienteID);

    @SqlUpdate("INSERT INTO clientes_animales (NombreAnimal, FechaNacimiento, TipoAnimal, ClienteID) VALUES (?, ?, ?, ?)")
    int addCliente_Animal(String nombreanimal, Date fechanacimiento, int tipoanimal, int clienteid);

    @SqlUpdate("UPDATE clientes_animales SET NombreAnimal = ?, FechaNacimiento = ? WHERE ID = ?")
    int updateCliente_Animal(String nombreanimal, Date fechanacimiento, int clienteid);

    @SqlQuery("SELECT clientes_animales.ID, " +
            "clientes_animales.NombreAnimal, " +
            "clientes_animales.FechaNacimiento, " +
            "clientes_animales.ClienteID, " +
            "tipos_animales.tipo " +
            "FROM clientes_animales " +
            "LEFT JOIN tipos_animales " +
            "ON clientes_animales.TipoAnimal = tipos_animales.ID " +
            "WHERE clientes_animales.NombreAnimal = ? AND " +
            "clientes_animales.FechaNacimiento = ? AND " +
            "clientes_animales.ClienteID = ?")
    @UseRowMapper(Clientes_AnimalesMapper.class)
    List<Clientes_Animales> getBusquedaAnimales(String nombreAnimal, Date fechaNacimiento, int clienteID);

    @SqlUpdate("DELETE FROM clientes_animales WHERE ClienteID = :clienteID AND ID = :animalID")
    int deleteCliente_Animal(@Bind("clienteID") int clienteID, @Bind("animalID") int animalID);


}