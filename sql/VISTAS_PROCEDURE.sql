use universal;
-- #####################################################################################
-- VISTA QUE MUESTRA EL CATALOGO DE EVENTOS DE CADA PARQUE Y SI NECESITAN BOLETO ADICIONAL
-- #####################################################################################
DROP VIEW IF EXISTS catalogo_eventos;
CREATE VIEW catalogo_eventos AS 
	SELECT p.Nombre_parque AS PARQUE, e.Nombre AS EVENTO, 
    he.Dia_Semana AS DIA, he.Hora_Inicio AS INICIA, 
    he.Hora_Fin AS TERMINA, e.Requiere_Boleto_Adicional AS BOLETO_ADICIONAL
    FROM parque p INNER JOIN evento e ON p.Parque_ID=e.Parque_ID 
    INNER JOIN horario_evento he ON e.Evento_ID=he.Evento_ID;
    
-- #####################################################################################
-- VISTA QUE MUESTRA EL AFRUPAMIENTO DE COMPRAS DE BOLETOS POR CLIENTE
-- #####################################################################################
DROP VIEW IF EXISTS historial_boletos;
CREATE VIEW historial_boletos AS
	SELECT c.Nombre AS CLIENTE, c.Email AS CONTACTO,
    cp.Fecha_Compra AS FECHA_COMPRA, p.Nombre_Parque AS PARQUE, 
    b.Tipo_Boleto AS TIPO_BOLETO, cp.Monto_Pagado AS TOTAL, cp.Metodo_Pago AS FORMA_PAGO
    FROM cliente AS c INNER JOIN compra_boleto AS cp ON c.Cliente_ID=cp.Cliente_ID 
    INNER JOIN boleto AS b ON cp.Boleto_ID=b.Boleto_ID
    INNER JOIN acceso_boleto_parque AS abp ON b.Boleto_ID=abp.Boleto_ID
    INNER JOIN parque AS p ON abp.Parque_ID=p.Parque_ID;
    
-- #####################################################################################
-- VISTA QUE MUESTRA EL CATALOGO QUE HAY EN CADA PARQUE 
-- #####################################################################################
DROP VIEW IF EXISTS catalogo_atracciones;
CREATE VIEW catalogo_atracciones AS
	SELECT p.Nombre_Parque AS PARQUE, a.Nombre AS ATRACCION, 
    a.Restriccion_Altura AS RESTRICCION_ALTURA, a.Tiempo_Fila_Promedio AS TIEMPO_DE_ESPERA
    FROM parque AS p INNER JOIN atraccion AS a ON p.Parque_ID=a.Parque_ID;
    
    
-- #####################################################################################
-- PROCEDIMIENTO QUE MUESTRE LOS BOLETOS DISPONIBLES DE ACUERDO A UN PRESUPUESTO
-- #####################################################################################
DROP PROCEDURE IF EXISTS boleto_presupuesto;
DELIMITER #
CREATE PROCEDURE boleto_presupuesto(IN presupuesto DECIMAL(10,2))
BEGIN
	SELECT b.Tipo_Boleto AS TIPO_BOLETO, p.Nombre_Parque AS PARQUE,
    abp.Dias_Incluidos AS DIAS_INCLUIDOS, b.Precio_Base AS COSTO,
    b.Opcion_ParkToPark AS PARK_TO_PARK 
    FROM boleto AS b INNER JOIN acceso_boleto_parque AS abp ON b.Boleto_ID=abp.Boleto_ID
    INNER JOIN parque AS p ON abp.Parque_ID=p.Parque_ID
    WHERE b.Precio_Base<=presupuesto;
    
    SELECT pq.Nombre_Paquete AS TIPO_PAQUETE, pq.Descripcion AS INCLUYE,
    pq.Precio_Base AS COSTO, h.Nombre AS HOSPEDAJE
    FROM paquete AS pq INNER JOIN hotel AS h ON pq.Hotel_ID=h.Hotel_ID
    WHERE pq.Precio_Base<=presupuesto;
END #
DELIMITER ;


-- #####################################################################################
-- PROCEDIMIENTO QUE MUESTRE LOS EVENTOS QUE EXISTEN POR PARQUE
-- #####################################################################################
DROP PROCEDURE IF EXISTS eventos_por_parque;
DELIMITER #
CREATE PROCEDURE eventos_por_parque(IN id_parque INT)
BEGIN
    SELECT p.Nombre_Parque AS PARQUE,
           e.Nombre AS EVENTO,
           he.Dia_Semana AS DIA,
           he.Hora_Inicio AS INICIA,
           he.Hora_Fin AS TERMINA,
           e.Requiere_Boleto_Adicional AS BOLETO_ADICIONAL
    FROM parque p
    INNER JOIN evento e ON p.Parque_ID = e.Parque_ID
    INNER JOIN horario_evento he ON e.Evento_ID = he.Evento_ID
    WHERE p.Parque_ID = id_parque;
END #
DELIMITER ;

-- #####################################################################################
-- PROCEDIMIENTO QUE HACE EL RESGISTRO EN LA COMPRA DE PAQUETES
-- #####################################################################################
DROP PROCEDURE IF EXISTS registrar_compra_paquete;
DELIMITER #
CREATE PROCEDURE registrar_compra_paquete(
    IN id_cliente INT,
    IN id_paquete INT,
    IN fecha_inicio DATE,
    IN fecha_fin DATE,
    IN metodo_pago VARCHAR(50)
)
BEGIN
    DECLARE precio DECIMAL(10,2); -- es una variable local para almacenar el precio del paquete

    SELECT Precio_Base
    INTO precio -- introduce el precio base en el precio que declaramos teninedo en cuenta el ID
    FROM paquete
    WHERE Paquete_ID = id_paquete;

    INSERT INTO compra_paquete
    (Cliente_ID, Paquete_ID, Fecha_Inicio, Fecha_Fin, Monto_Total, Metodo_Pago)
    VALUES
    (id_cliente, id_paquete, fecha_inicio, fecha_fin, precio, metodo_pago);
END #
DELIMITER ;


