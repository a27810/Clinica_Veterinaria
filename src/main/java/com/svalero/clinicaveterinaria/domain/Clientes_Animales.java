package com.svalero.clinicaveterinaria.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Clientes_Animales {
    private int id;
    private String nombreanimal;
    private Date fechanacimiento;
    private String tipo;
    private int clienteid;
}
