use lead_gen_business;
select *
from billing;
select *
from clients;
select *
from leads;
select *
from sites;

/*1*/
SELECT SUM(amount) AS ingresos_totales
FROM billing
WHERE charged_datetime >= '2012-03-01' AND charged_datetime < '2012-04-01';

/*2*/
SELECT SUM(amount) AS ingresos_totales
FROM billing
WHERE client_id = 2;

/*3*/
SELECT *
FROM sites
WHERE client_id = 10;
/*4*/
SELECT YEAR(created_datetime) AS anio, MONTH(created_datetime) AS mes, COUNT(*) AS total_sitios
FROM sites
WHERE client_id = 1
GROUP BY YEAR(created_datetime), MONTH(created_datetime)
ORDER BY YEAR(created_datetime), MONTH(created_datetime);


/*5*/
SELECT s.site_id, s.domain_name, 
       COUNT(l.leads_id) AS total_leads
FROM sites s
LEFT JOIN leads l ON s.site_id = l.site_id
WHERE l.registered_datetime >= '2011-01-01' 
  AND l.registered_datetime <= '2011-02-15'
GROUP BY s.site_id, s.domain_name;

/*6*/
SELECT c.first_name, c.last_name, 
       COUNT(l.leads_id) AS total_leads
FROM clients c
LEFT JOIN sites s ON c.client_id = s.client_id
LEFT JOIN leads l ON s.site_id = l.site_id
WHERE l.registered_datetime >= '2011-01-01' 
  AND l.registered_datetime <= '2011-12-31'
GROUP BY c.client_id, c.first_name, c.last_name
ORDER BY c.last_name, c.first_name;

/*7*/
SELECT c.first_name, c.last_name,
    COUNT(l.leads_id) AS total_clientes_potenciales
FROM clients c
LEFT JOIN sites s ON c.client_id = s.client_id
LEFT JOIN leads l ON s.site_id = l.site_id
WHERE YEAR(l.registered_datetime) = 2011 AND MONTH(l.registered_datetime) BETWEEN 1 AND 6
GROUP BY c.client_id
ORDER BY c.last_name, c.first_name;

/*8*/
SELECT c.client_id,c.first_name,c.last_name,s.site_id,s.domain_name,
    COUNT(l.leads_id) AS total_leads
FROM clients c
JOIN sites s ON c.client_id = s.client_id
LEFT JOIN leads l ON s.site_id = l.site_id
WHERE l.registered_datetime >= '2011-01-01' AND l.registered_datetime <= '2011-12-31'
GROUP BY c.client_id, s.site_id
ORDER BY c.client_id, s.site_id;

/*9*/
SELECT c.client_id,c.first_name,c.last_name,
    MONTH(b.charged_datetime) as meses,
    SUM(b.amount) AS total_revenue
FROM clients c
LEFT JOIN billing b ON c.client_id = b.client_id
GROUP BY c.client_id, meses
ORDER BY c.client_id, meses;

/*10*/
SELECT c.client_id,c.first_name,c.last_name,
    GROUP_CONCAT(s.domain_name) AS sitios
FROM clients c
JOIN sites s ON c.client_id = s.client_id
GROUP BY c.client_id, c.first_name, c.last_name
ORDER BY c.client_id;

