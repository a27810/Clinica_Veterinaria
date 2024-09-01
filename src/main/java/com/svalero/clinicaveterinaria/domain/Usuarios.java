package com.svalero.clinicaveterinaria.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Usuarios {
    private int id;
    private String nombreusuario;
    private String password;
    private String rol;
}
