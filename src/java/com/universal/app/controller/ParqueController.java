package com.universal.app.controller;

import com.universal.app.bean.Parque;
import com.universal.app.model.ParqueModel;

public class ParqueController
{
    public String getParques()
    {
        String htmlcode = "";

        ParqueModel parqueM = new ParqueModel();

        for (Parque p : parqueM.getParques())
              htmlcode +=   "<section class=\"park-section\">\n" +
                            "   <h2 class=\"park-title\">"+ p.getNombre_Parque() +"</h2>\n" +
                            "       <p>Ubicación: "+ p.getUbicacion() +"</p>\n" +
                            "       <h3>Atracciones:</h3>\n" +
                            "           <ul class=\"attraction-list\">\n" +
                            "               <li>\n" +
                            "                   <span><XD</span>\n" +
                            "                   <div class=\"attraction-details\">\n" +
                            "                       <p>Mín. Altura: <strong>d cm</strong> | Fila Promedio: <strong>c min</strong></p>\n" +
                            "                   </div>\n" +
                            "               </li>\n" +
                            "            </ul>\n" +
                            " </section>";

        return htmlcode;
    }
}