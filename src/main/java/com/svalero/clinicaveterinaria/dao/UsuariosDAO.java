package com.svalero.clinicaveterinaria.dao;

import com.svalero.clinicaveterinaria.domain.Usuarios;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;
import java.util.List;

public interface UsuariosDAO {
    @SqlQuery("SELECT * FROM usuarios")
    @UseRowMapper(UsuariosMapper.class)
    List<Usuarios> getUsuarios();

    @SqlQuery("SELECT clinicaveterinaria.usuarios.ID, " +
            "clinicaveterinaria.usuarios.NombreUsuario, " +
            "clinicaveterinaria.usuarios.Password, " +
            "clinicaveterinaria.usuarios_roles.Rol " +
            "FROM clinicaveterinaria.usuarios " +
            "LEFT JOIN clinicaveterinaria.usuarios_roles " +
            "ON clinicaveterinaria.usuarios.Rol = clinicaveterinaria.usuarios_roles.ID " +
            "WHERE clinicaveterinaria.usuarios.NombreUsuario = ? AND clinicaveterinaria.usuarios.Password = ?")
    @UseRowMapper(UsuariosMapper.class)
    Usuarios getUsuario(String nombre, String password);

    /* Filtrar y buscar por NOMBRE DE USUARIO + ROL */
    @SqlQuery("SELECT * FROM usuarios WHERE NombreUsuario LIKE CONCAT('%', :NombreUsuario, '%') AND Rol LIKE CONCAT('%', :Rol, '%')")
    @UseRowMapper(UsuariosMapper.class)
    List<Usuarios> buscarUsuarios(@Bind("NombreUsuario") String NombreUsuario, @Bind("Rol") String Rol);

    @SqlUpdate("INSERT INTO usuarios (NombreUsuario, Password, Rol) VALUES (:NombreUsuario, :Password, :Rol)")
    void insertarUsuario(@Bind("NombreUsuario") String NombreUsuario,
                         @Bind("Password") String password,
                         @Bind("Rol") String Rol);

    /* Método para eliminar un usuario por su ID */
    @SqlUpdate("DELETE FROM usuarios WHERE ID = :id")
    void eliminarUsuario(@Bind("id") int usuarioId);

    /* Método para actualizar un usuario */
    @SqlUpdate("UPDATE usuarios SET NombreUsuario = :nombreUsuario, Password = :password, Rol = :rol WHERE ID = :id")
    void actualizarUsuario(@Bind("id") int usuarioId,
                           @Bind("nombreUsuario") String nombreUsuario,
                           @Bind("password") String password,
                           @Bind("rol") String rol);


}