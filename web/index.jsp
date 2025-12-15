<%@page import="com.universal.app.controller.ParqueController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    ParqueController parqueC = new ParqueController();
%>

<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Universal Orlando Resort - Guía de Parques y Atracciones</title>
        
        <style>
        /* Estilos CSS BÁSICOS para hacer la página legible */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f9;
            color: #333;
        }
        header {
            background-color: #007bff;
            color: white;
            padding: 15px;
            text-align: center;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        .container {
            max-width: 1000px;
            margin: auto;
        }
        .park-section {
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .park-title {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-top: 0;
        }
        .attraction-list {
            list-style-type: none;
            padding: 0;
        }
        .attraction-list li {
            background: #e9ecef;
            margin: 8px 0;
            padding: 10px;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .attraction-details {
            font-size: 0.9em;
            color: #666;
            text-align: right;
        }
        .attraction-details strong {
            color: #333;
        }
        </style>
    </head>
    
    <body>
        <header>
            <h1>Guía de Parques Temáticos y Atracciones</h1>
            <p>Modelo de Datos del Universal Orlando Resort</p>
        </header>
        
        <%= parqueC.getParques() %>
    </body>
</html>
