# 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;

# 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2, telefono FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

# 3 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

# 4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

# 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7;

# 6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT per.apellido1, per.apellido2, per.nombre, dep.nombre FROM persona per INNER JOIN profesor pro ON per.id = pro.id_profesor INNER JOIN departamento dep ON pro.id_departamento = dep.id ORDER BY apellido1, apellido2, per.nombre;

# 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asi.nombre, cur.anyo_inicio, cur.anyo_fin FROM alumno_se_matricula_asignatura ama INNER JOIN asignatura asi ON asi.id = ama.id_asignatura INNER JOIN curso_escolar cur ON ama.id_curso_escolar = cur.id WHERE ama.id_alumno = (SELECT id FROM persona WHERE nif = '26902806M');

# 8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT nombre FROM departamento WHERE id IN (SELECT DISTINCT(id_departamento) FROM profesor WHERE id_profesor IN (SELECT DISTINCT(id_profesor) FROM asignatura WHERE id_grado = (SELECT id FROM grado WHERE nombre = 'Grado en Ingeniería Informática (Plan 2015)')));

# 9 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT * FROM persona WHERE tipo = 'alumno' AND id IN (SELECT DISTINCT(id_alumno) FROM alumno_se_matricula_asignatura WHERE id_curso_escolar = (SELECT id FROM curso_escolar WHERE anyo_inicio = 2018));


# CLÀUSULES LEFT JOIN i RIGHT JOIN
# 1 Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select dep.nombre, per.apellido1, per.apellido2, per.nombre from (select * from persona where tipo = 'profesor') per left join profesor pro on per.id = pro.id_profesor left join departamento dep on pro.id_departamento = dep.id;

# 2 Retorna un llistat amb els professors/es que no estan associats a un departament.
select * from (select * from persona where tipo = 'profesor') per left join profesor pro on per.id = pro.id_profesor where id_departamento is null;

# 3 Retorna un llistat amb els departaments que no tenen professors/es associats.
select d.id, d.nombre from departamento d left join (select distinct(id_departamento) from profesor) p on d.id = p.id_departamento where id_departamento is null;

# 4 Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT * FROM (SELECT * FROM persona WHERE tipo = 'profesor') pd LEFT JOIN (SELECT DISTINCT(id_profesor) FROM asignatura WHERE id_profesor IS NOT NULL) a ON pd.id = a.id_profesor WHERE id_profesor IS NULL;

# 5 Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre, a.ig_grado FROM asignatura a LEFT JOIN persona p ON a.id_profesor = p.id WHERE p.id IS NULL;

# 6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT(d.nombre) FROM asignatura a RIGHT JOIN profesor p USING (id_profesor) RIGHT JOIN departamento d ON id_departamento = d.id WHERE a.id IS NULL;


# CONSULTES RESUM
# 1 Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';

# 2 Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

# 3 Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre, COUNT(*) AS recompte FROM profesor p INNER JOIN departamento d ON p.id_departamento = d.id GROUP BY d.nombre ORDER BY recompte DESC;

# 4 Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat. 
SELECT d.id, d.nombre, IFNULL(resum.recompte, 0) num_professors FROM departamento d LEFT JOIN (SELECT id_departamento, COUNT(*) recompte FROM profesor GROUP BY id_departamento) resum ON d.id = resum.id_departamento ORDER BY num_professors DESC;

# 5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre, resum.recompte FROM grado g LEFT JOIN (SELECT id_grado, COUNT(*) recompte FROM asignatura GROUP BY id_grado) resum ON g.id = resum.id_grado ORDER BY resum.recompte DESC;

# 6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT nombre, resum.recompte FROM (SELECT * FROM (SELECT id_grado, COUNT(*) recompte FROM asignatura GROUP BY id_grado) a WHERE recompte > 40) resum LEFT JOIN grado g ON resum.id_grado = g.id;

# 7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre, a.tipo, suma FROM grado g RIGHT JOIN (SELECT id_grado, tipo, SUM(creditos) suma FROM asignatura GROUP BY id_grado, tipo) a ON g.id = a.id_grado;

# 8 Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT anyo_inicio, IFNULL(ama_red.rec, 0) num_matriculats FROM curso_escolar ce LEFT JOIN (SELECT id_curso_escolar, COUNT(*) rec FROM (SELECT DISTINCT(id_alumno), id_curso_escolar FROM alumno_se_matricula_asignatura) ama GROUP BY ama.id_curso_escolar) ama_red ON ce.id = ama_red.id_curso_escolar;

# 9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT per.id, per.nombre, per.apellido1, per.apellido2, IFNULL(a.num_assign, 0) n_assignatures FROM (SELECT * FROM persona WHERE tipo = 'profesor') per LEFT JOIN (SELECT id_profesor, COUNT(*) num_assign FROM asignatura GROUP BY id_profesor) a ON per.id = a.id_profesor ORDER BY n_assignatures DESC;

# 10 Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);

# 11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT * FROM persona WHERE tipo = 'profesor' AND id IN (SELECT id_profesor FROM profesor) AND id NOT IN (SELECT id_profesor FROM asignatura);