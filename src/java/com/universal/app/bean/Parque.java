package com.universal.app.bean;

import java.io.Serializable;

public class Parque implements Serializable {
    private int Parque_ID;
    private String Nombre_Parque;
    private String Ubicacion;
    
    public Parque(int Parque_ID, String Nombre_Parque, String Ubicacion) {
        this.Parque_ID = Parque_ID;
        this.Nombre_Parque = Nombre_Parque;
        this.Ubicacion = Ubicacion;
    }

    public String getUbicacion() {
        return Ubicacion;
    }

    public void setUbicacion(String Ubicacion) {
        this.Ubicacion = Ubicacion;
    }

    public int getParque_ID() {
        return Parque_ID;
    }

    public void setParque_ID(int Parque_ID) {
        this.Parque_ID = Parque_ID;
    }

    public String getNombre_Parque() {
        return Nombre_Parque;
    }

    public void setNombre_Parque(String Nombre_Parque) {
        this.Nombre_Parque = Nombre_Parque;
    }
}