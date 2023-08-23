-- Database: Devoir Maison

-- gestionnaire

CREATE TABLE gestionnaire (
    id_gest INT PRIMARY KEY,
    nom_gest TEXT
);

INSERT INTO gestionnaire (id_gest, nom_gest) VALUES 
	(1, 'Lille gestion'),
	(2, 'Paris gestion'),
	(3, 'Madrid gestion');
	
SELECT * FROM gestionnaire;

-- locaux

CREATE TABLE local (
    id_loc INT PRIMARY KEY,
    nom_loc TEXT,
    descp_loc TEXT,
    diagnostic TEXT,
    date_loc DATE,
	id_gest INT REFERENCES gestionnaire(id_gest),
    id_equip INT REFERENCES equipements(id_equip)
);

INSERT INTO local (id_loc, nom_loc, descp_loc, diagnostic, date_loc, id_gest, id_equip)
VALUES (1, 'universite catholique de lille', 'ecole dans le centre de lille', 'chauffage ne marche pas','20/05/2023',1,1),
	   (2, 'salle exposition paris', 'musee de DA-Vinci', 'pas assé de composant', '22/05/2023',2,2),
	   (3, 'chauffage de madrid','centre de chauffagerie' ,'temperature>30', '01/05/2023',3,3);

SELECT * FROM local;

-- constituants

CREATE TABLE constituant(
    id_cons INT PRIMARY KEY,
    nom_cons TEXT,
    descp_cons TEXT,
    quantite INT,
    doc_ref TEXT,
	id_loc INT REFERENCES local(id_loc)
);

INSERT INTO constituant(id_cons, nom_cons, descp_cons, quantite, doc_ref, id_loc)
VALUES (1, 'mur', 'murs des classes', 10, '325', 1),
	   (2, 'sol', 'la terre', 5, '578', 1),			
	   (3, 'meuble', 'tout les meubles', 50, '415', 1),
	   (4, 'equipements', 'electrique', 5, '485', 1),
	   (5, 'mur', 'murs des salles', 15, '354', 2),
	   (6, 'sol', 'la terre', 7, '528', 2),			
	   (7, 'meuble', 'tout les meubles', 50, '415', 2),
	   (8, 'equipements', 'electrique', 15, '485', 2),
	   (9, 'mur', 'murs des batiments', 30, '925', 3),
	   (10, 'sol', 'la terre', 15, '478', 3),			
	   (11, 'meuble', 'tout les meubles', 126, '615', 3),
	   (12, 'equipements', 'electrique', 15, '685', 3);

SELECT * FROM constituant;

-- Budget

CREATE TABLE lignebudget (
    id_lbg INT PRIMARY KEY,
    code_lbg NUMERIC,
	montant NUMERIC,
	id_gest INT REFERENCES gestionnaire(id_gest),
	id_equip INT REFERENCES equipements(id_equip)
);

INSERT INTO lignebudget (id_lbg, code_lbg, montant, id_gest, id_equip)
VALUES (1, 20, 2500, 1,1),
	   (2, 50, 4866, 2,2),
	   (3, 70, 89552, 3,3);

SELECT * FROM lignebudget;

--Equipements

CREATE TABLE equipements (
    id_equip INT PRIMARY KEY,
    nom_equip TEXT,
    descp_equip TEXT
);

INSERT INTO equipements (id_equip, nom_equip, descp_equip) 
VALUES (1, 'groupe scolaire','etudiant de la catho'),
	   (2, 'musee','muse de da vinci'),
	   (3, 'employe','travailleur de usine madrid');

SELECT * FROM equipements;

--Prestation

CREATE TABLE prestation (
    id_ps INT PRIMARY KEY,
    status TEXT,
    dep_prevue NUMERIC,
    cout NUMERIC,
    date_ps DATE,
	nom_entreprise TEXT,
	id_mar INT REFERENCES marche(id_mar),
    id_cons INT REFERENCES constituant(id_cons)
);

INSERT INTO prestation (id_ps,  status, dep_prevue, cout, date_ps, nom_entreprise, id_mar,id_cons) 
VALUES 
       (1, 'valider', 100, 75, '2023-05-18', 'auchan', 1, 10),
 	   (2, 'en cours', 150, 500, '2022-05-01', 'oney', 2, 11),
	   (3, 'pas encore', 200, 150, '2021-05-18', 'kingfisher', 3, 12);
	   (4, 'valider', 100, 75, '2023-05-18', 'auchan', 1, 10),
 	   (5, 'Décidée', 150, 500, '2022-05-01', 'oney', 2, 11),
	   (6, 'Décidée', 200, 150, '2021-05-18', 'kingfisher', 3, 12);
	   (7, 'Décidée', 100, 75, '2023-05-18', 'auchan', 1, 10),
 	   (8, 'En projet', 150, 500, '2022-05-01', 'oney', 2, 11),
	   (9, 'En projet', 200, 150, '2021-05-18', 'kingfisher', 3, 12);
       (10, 'En projet', 100, 75, '2023-05-18', 'auchan', 1, 10),
 	   (11, 'en cours', 150, 500, '2022-05-01', 'oney', 2, 11),
	   (12, 'pas encore', 200, 150, '2021-05-18', 'kingfisher', 3, 12);

SELECT * FROM prestation;

--Marches

CREATE TABLE marche (
    id_mar INT PRIMARY KEY,
    date_mar DATE,
    nature TEXT,
	id_entreprise SERIAL,
	nom_entreprise TEXT,
	addresse_entreprise TEXT
);

INSERT INTO marche (id_mar, date_mar, nature, id_entreprise, nom_entreprise, addresse_entreprise) 
VALUES (1, '05/11/2021','saisonier', 1, 'adeo','lille 59000'),
	   (2, '11/05/2022','ferme', 2, 'mystartupai','paris 75000'),
	   (3, '05/11/2023','captif', 3, 'beko','madrid 95000');

SELECT * FROM marche;

-- query 1 

SELECT e.nom_equip, g.nom_gest, p.dep_prevue
FROM equipements e
JOIN lignebudget lb ON lb.id_equip = e.id_equip
JOIN gestionnaire g ON g.id_gest = lb.id_gest
LEFT JOIN prestation p ON e.id_equip = e.id_equip AND g.id_gest = g.id_gest
WHERE  (p.status = 'Décidée' OR p.status = 'En projet');
  
-- query 2

SELECT e.nom_entreprise, e.addresse_entreprise, m.id_mar, m.nature, m.date_mar, SUM(p.cout) AS cout_total
FROM marche e
JOIN marche m ON m.id_entreprise = e.id_entreprise
JOIN prestation p ON p.id_mar = m.id_mar
WHERE m.date_mar >= 
GROUP BY e.nom_entreprise, e.addresse_entreprise, m.id_mar, m.nature, m.date_mar;
