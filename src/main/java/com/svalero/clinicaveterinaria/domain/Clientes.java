package com.svalero.clinicaveterinaria.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Clientes {
    private int id;
    private String nombre;
    private String apellido1;
    private String apellido2;
    private String telefono;
    private String rutafoto;
}