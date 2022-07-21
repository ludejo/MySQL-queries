# E1 Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;

# E2 Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;

# E3 Llista totes les columnes de la taula producto.
SELECT * FROM producto;

# E4 Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, precio preu€, precio * 1.02 preu$ FROM producto;

# E5 Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS `nom de producto`, precio AS euros, precio * 1.02 AS dòlars FROM producto;

# E6 Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre), precio FROM producto;

# E7 Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre), precio FROM producto;

# E8 Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS inicials FROM fabricante;

# E9 Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre, ROUND(precio) FROM producto;

# E10 Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) FROM producto;

# E11 Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);

# E12 Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT codigo FROM fabricante WHERE codigo IN (SELECT DISTINCT codigo_fabricante FROM producto);

# E13 Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre;

# E14 Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

# E15 Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre, precio FROM producto ORDER BY nombre, precio DESC;

# E16 Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 5;

# E17 Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 2 OFFSET 3;

# E18 Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT).
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;

# E19 Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

# E20 Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

# E21 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT p.nombre, precio, f.nombre AS nombre_fabricante FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo;

# E22 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT p.nombre, precio, f.nombre AS nombre_fabricante FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY nombre_fabricante;

# E23 Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT p.codigo codigo_producto, p.nombre nombre_producto, codigo_fabricante, f.nombre nombre_fabricante FROM producto p LEFT JOIN fabricante f ON p.codigo_fabricante = f.codigo;

# E24 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre nombre_producto, precio, f.nombre nombre_fabricante FROM fabricante f RIGHT JOIN (SELECT * FROM producto p WHERE precio = (SELECT MIN(precio) FROM producto)) p ON f.codigo = p.codigo_fabricante;

# E25 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre nombre_producto, precio, f.nombre nombre_fabricante FROM fabricante f RIGHT JOIN (SELECT * FROM producto p WHERE precio = (SELECT MAX(precio) FROM producto)) p ON f.codigo = p.codigo_fabricante;

# E26 Retorna una llista de tots els productes del fabricant Lenovo.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

# E27 Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Crucial') AND precio > 200;

# E28 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Seagate') OR codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') OR codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard');

# E29 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN. 
SELECT * FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE nombre IN ('Seagate', 'Asus', 'Hewlett-Packard'));

# E30 Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT nombre, precio FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE nombre LIKE '%e');

# E31 Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT nombre, precio FROM producto WHERE codigo_fabricante IN (SELECT codigo FROM fabricante WHERE nombre LIKE '%w%');

# E32 Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre, precio, f.nombre FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo HAVING precio >= 180 ORDER BY precio DESC, p.nombre;

# E33 Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT * FROM fabricante WHERE codigo IN (SELECT codigo_fabricante FROM producto);

# E34 Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT * FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante; 

# E35 Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT * FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);

# E36 Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

# E37 Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

# E38 Llista el nom del producte més car del fabricant Lenovo.
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') AND precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

# E39 Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT nombre FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') AND precio = (SELECT MIN(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard'));

# E40 Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

# E41 Llista tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus') AND precio > (SELECT AVG(precio) FROM producto GROUP BY codigo_fabricante HAVING codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));