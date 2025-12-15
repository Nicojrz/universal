package com.universal.app.model;

import com.universal.app.bean.Parque;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ParqueModel extends Connector {
    public ArrayList<Parque> getParques() {
        ArrayList<Parque> parques = new ArrayList<>();
        PreparedStatement ps;
        
        try {
            String sql = "SELECT * "
                       + "FROM Parque";
            
            ps = getConnection().prepareStatement(sql);
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                int Parque_ID = rs.getInt(1);
                String Nombre_Parque = rs.getString(2);
                String Ubicacion = rs.getString(3);
                
                Parque p = new Parque(Parque_ID, Nombre_Parque, Ubicacion);
                
                parques.add(p);
            }
        }
        
        catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        
        finally {
            if (getConnection() != null) {
                try
                { getConnection().close(); }
                catch (SQLException ex)
                { System.err.println(ex.getMessage()); }
            }
        }
        
        return parques;
    }
}
