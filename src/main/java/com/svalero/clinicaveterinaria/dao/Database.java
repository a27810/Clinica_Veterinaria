package com.svalero.clinicaveterinaria.dao;

import static com.svalero.clinicaveterinaria.util.Constantes.*;

import com.svalero.clinicaveterinaria.domain.Clientes;
import org.jdbi.v3.core.Handle;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.sql.SQLException;
import java.util.List;

public class Database {
    public static Jdbi jdbi;
    public static Handle db;

    public static void connect() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        jdbi = Jdbi.create(CONNECTION_STRING, USUARIO, PASSWORD);
        jdbi.installPlugin(new SqlObjectPlugin());
        db = jdbi.open();
        System.out.println("Conexion a la base de datos correctamente establecida.");
    }

    public static void close() throws SQLException {
        db.close();
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Database.connect();

        List<Clientes> lstClientes = null;
        lstClientes = Database.jdbi.withExtension(ClientesDAO.class, ClientesDAO::getListaClientes);

        for (Clientes cliente : lstClientes) {
            System.out.println(cliente.getNombre());
        }
    }
}