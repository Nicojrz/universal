use universal;

-- #####################################################################################
-- ANÁLISIS DE VENTAS POR PARQUE 
-- #####################################################################################
SELECT p.Nombre_Parque AS PARQUE, SUM(cp.Monto_Pagado) AS TOTAL_VENTAS, SUM(cp.Nm_Boletos) AS NUMERO_BOLETOS 
FROM  parque AS p INNER JOIN acceso_boleto_parque AS abp ON p.Parque_ID=abp.Parque_ID
INNER JOIN boleto AS b ON abp.Boleto_ID=b.Boleto_ID INNER JOIN compra_boleto AS cp ON b.Boleto_ID=cp.Boleto_ID group by (p.Nombre_Parque); 

-- #####################################################################################
-- ANÁLISIS DE COMPRAS HECHAS POR CLIENTE 
-- #####################################################################################
SELECT b.Tipo_Boleto AS TIPO_BOLETO, SUM(cp.Nm_Boletos) AS TOTAL_BOLETOS, COUNT(cp.Compra_ID) AS NUM_TRANSACCIONES, SUM(cp.Monto_Pagado) AS VENTA_TOTAL
FROM boleto AS b INNER JOIN compra_boleto AS cp ON b.Boleto_ID=cp.Boleto_ID GROUP BY (b.Tipo_Boleto);

-- #####################################################################################
-- MUESTRA LOS PAQUETES COMPRADOS, CLIENTE, HOTEL Y EL MONTO TOTAL
-- #####################################################################################
SELECT c.Nombre AS CLIENTE, p.Nombre_Paquete AS PAQUETE_ADQUIRIDO, h.Nombre AS HOSPEDAJE, cp.Monto_Total AS TOTAL
FROM cliente AS c INNER JOIN compra_paquete AS cp ON c.Cliente_ID=cp.Cliente_ID
INNER JOIN paquete AS p ON cp.Paquete_ID=p.Paquete_ID 
INNER JOIN hotel AS h ON p.Hotel_ID=h.Hotel_ID;

-- #####################################################################################
-- AQUELLOS PARQUES QUE CIERRAN DESPUÉS DE LAS 10 PM
-- #####################################################################################
SELECT DISTINCT 
    b.Tipo_Boleto AS TIPO_BOLETO,
    p.Nombre_Parque AS PARQUE,
    hp.Hora_Fin AS CIERRA_A
FROM boleto AS b
INNER JOIN acceso_boleto_parque AS abp 
    ON b.Boleto_ID = abp.Boleto_ID
INNER JOIN parque AS p 
    ON abp.Parque_ID = p.Parque_ID
INNER JOIN horario_parque AS hp 
    ON p.Parque_ID = hp.Parque_ID
WHERE hp.Hora_Fin > '22:00:00';


-- #####################################################################################
-- AQUELLOS PAQUETES QUE INCLUYEN BOLETOS PARA EL PARQUE EPIC UNIVERSE
-- #####################################################################################
SELECT DISTINCT
    pq.Nombre_Paquete AS PAQUETE,
    pq.Descripcion AS DESCRIPCION,
    b.Tipo_Boleto AS BOLETO_INCLUIDO,
    p.Nombre_Parque AS PARQUE
FROM paquete AS pq
INNER JOIN boleto AS b
    ON pq.Paquete_ID = b.Paquete_ID
INNER JOIN acceso_boleto_parque AS abp
    ON b.Boleto_ID = abp.Boleto_ID
INNER JOIN parque AS p
    ON abp.Parque_ID = p.Parque_ID
WHERE p.Nombre_Parque = 'Epic Universe';

