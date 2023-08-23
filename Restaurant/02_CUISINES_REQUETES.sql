/*
   _____ _    _ _____  _____ _____ _   _ ______  _____ 
  / ____| |  | |_   _|/ ____|_   _| \ | |  ____|/ ____|
 | |    | |  | | | | | (___   | | |  \| | |__  | (___  
 | |    | |  | | | |  \___ \  | | | . ` |  __|  \___ \ 
 | |____| |__| |_| |_ ____) |_| |_| |\  | |____ ____) |
  \_____|\____/|_____|_____/|_____|_| \_|______|_____/ 
  
 */
 
 
/*
     REQUETES SUR LES TABLES DU RESTAURANT
*/

-- Informations sur les tables --
select * from table_rest;

-- Nombre de tables --
select count(1) from table_rest;

-- Informations pour une table donnée --
select * from table_rest where table_num ='T1'

-- Capacité d'accueil du restaurant --
select sum(table_nbpers) from table_rest;



/*
	MANIPULATION DES DATES ET HEURES
*/

-- Date et heure actuelle avec time zone --
SELECT NOW();

-- Date actuelle sans time zone --
SELECT CURRENT_DATE;

-- Heure actuelle sans time zone --
SELECT CURRENT_TIME;

-- Jour actuel --
SELECT EXTRACT('day' FROM NOW())

-- Mois actuel --
SELECT EXTRACT('month' FROM NOW())

-- Année actuelle --
SELECT EXTRACT('year' FROM NOW())

-- Heures actuelles --
SELECT EXTRACT('hour' FROM NOW())

-- Minutes actuelles --
SELECT EXTRACT('minutes' FROM NOW())

-- Secondes actuelles ---
SELECT EXTRACT('seconds' FROM NOW())


-- Numéro de la semaine (Day Of Week: dow) 0= Dimanche, 1: Lundi--
SELECT EXTRACT('dow' FROM NOW())

-- Nom du jour actuel --
SELECT to_char(NOW(), 'Day')

-- Extraction et formatage du temps
SELECT to_char(NOW(), 'HH:MI:SS')

-- Extraction et formatage de la date
SELECT to_char(NOW(), 'dd/mm/yyyy')

-- Ajout de jours --
SELECT NOW() + INTERVAL '1 day';

-- Ajout d'heures --
SELECT NOW() + INTERVAL '1 hour';

-- Ajout de minutes --
SELECT NOW() + INTERVAL '10 minutes';


/*
	COMMANDES
*/

-- Création de commandes sans articles --
INSERT INTO commande(table_id,commande_dh) VALUES (1,NOW());

-- Affichage des commandes --
SELECT * FROM commande;


-- JOINTURES --
-- Affichage des commandes et des tables concernées: Inner join --
SELECT * FROM commande cmd INNER JOIN table_rest tr on tr.table_id = cmd.table_id

-- Affichage des commandes et des tables concernées: left outer join --
-- A gauche -> Commande | A droite -> Les tables
SELECT * FROM commande cmd LEFT OUTER JOIN table_rest tr on tr.table_id = cmd.table_id

-- Affichage des commandes et des tables concernées: right outer join --
-- A gauche -> Commande | A droite -> Les tables
SELECT * FROM commande cmd RIGHT OUTER JOIN table_rest tr on tr.table_id = cmd.table_id

-- Affichage des commandes et des tables concernées: left outer join --
-- A gauche -> Les tables | A droite -> Les commandes --
SELECT * FROM table_rest tr LEFT OUTER JOIN commande cmd on cmd.table_id = tr.table_id

-- Affichage de la commande de la table T1 --
SELECT * FROM commande cmd INNER JOIN table_rest tr on tr.table_id = cmd.table_id WHERE tr.table_num='T1'


-- Insertion d'un item pour la commande 1 --
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (1,1,NOW(),0);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (2,1,NOW(),0);


/*
	DASHBOARD DES CUISINES
	
	Si le plat n'est pas servi dans les 10 minutes -> Alerte
*/

-- 1: Recherche des tables necessaires et réalisation des jointures
SELECT * FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id



-- 2: Affichage des champs utiles
-- On ne choisi d'afficher que les plats non servis
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat",  
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande"
FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0


-- 3: Calcul de l'heure de fin théorique de préparation (+10 minutes)
-- Noter que l'on ne peut pas utiliser les alias dans le select
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat",  
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin"
FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0


-- 4: Calcul du temps restant avant le retard et tri par temps restant croissant
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat", 
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI')  as "tps_restant"
FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0
ORDER BY "tps_restant"

-- 5: Indication du retard
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat", 
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI')  as "tps_restant",

CASE 
  WHEN CAST (to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI') AS INTEGER) <  0 THEN 'RETARD' END
  as "Infos"

FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0
ORDER BY "tps_restant"


-- Nous avons besoin d'identifier si une commande est terminée ou pas --
-- Car il n'est pas necaisse d'afficher en cuisine les commandes terminées --
-- ALTER TABLE ....
ALTER TABLE commande ADD commande_status integer;

-- On passe toutes les commandes "Terminée"
UPDATE commande SET commande_status = 1

-- Modification du dashboard des cuisines
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat", 
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI')  as "tps_restant",

CASE 
  WHEN CAST (to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI') AS INTEGER) <  0 THEN 'RETARD'  ELSE '--' END
  as "Infos"

FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0
and cmd.commande_status = 0
ORDER BY "tps_restant"


-- Creation d'une nouvelle commande --
INSERT INTO commande(table_id,commande_dh,commande_status) VALUES (1,NOW(),0);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (1,2,NOW(),0);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (2,2,NOW(),0);

-- Affichage du dashboard des cuisines --
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat", 
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI')  as "tps_restant",

CASE 
  WHEN CAST (to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI') AS INTEGER) <  0 THEN 'RETARD' ELSE '--' END
  as "Infos"

FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0
and cmd.commande_status = 0
ORDER BY "tps_restant"


-- Service d'un plat (Mise à jour de l'heure de service et de son statut) --
UPDATE item_cmd SET item_serv_dh = NOW() , item_servi=1 WHERE item_id = 1 and cmd_id = 2

-- Vérification de la mise à jour --
SELECT * from item_cmd WHERE cmd_id = 2

-- Affichage du dashboard des cuisines --
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat", 
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI')  as "tps_restant",

CASE 
  WHEN CAST (to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI') AS INTEGER) <  0 THEN 'RETARD' ELSE '--' END
  as "Infos"

FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
WHERE it_cmd.item_servi =0
and cmd.commande_status = 0
ORDER BY "tps_restant"


-- Service d'un plat (Mise à jour de l'heure de service et de son statut) --
UPDATE item_cmd SET item_serv_dh = NOW() , item_servi=1 WHERE item_id = 2 and cmd_id = 2

-- Vérification de la mise à jour --
SELECT * from item_cmd WHERE cmd_id = 2


/*
	SERVEURS
	Après avoir supprimé les commandes et leur items
	Mettre à jour la sequence des commandes à 1
	Ajouter des serveurs au restaurant et ajouter un lien à la commande
*/

INSERT INTO serveur (serveur_prenom,serveur_nom) VALUES ('Jean','Dujardin');
INSERT INTO serveur (serveur_prenom,serveur_nom) VALUES ('Alexandra','Lamy');
SELECT * from serveur

-- Suppression des items_cmd --
TRUNCATE TABLE item_cmd;

-- Suppression des commandes utilisation de cascade pour la suppression des item_cmd en même temps --
TRUNCATE TABLE commande CASCADE;

-- Reset de la sequence des commandes à 1 --
ALTER SEQUENCE commande_commande_id_seq RESTART WITH 1;

-- Ajout du champs serveur_id à la table commande
ALTER TABLE commande 
 ADD serveur_id integer,
 ADD CONSTRAINT fk_serveur_id FOREIGN KEY (serveur_id)
        REFERENCES public.serveur (serveur_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID 
		
SELECT * FROM commande

-- Creation de nouvelles commandes
TRUNCATE TABLE commande CASCADE;
ALTER SEQUENCE commande_commande_id_seq RESTART WITH 1;

INSERT INTO commande(table_id,commande_dh,commande_status,serveur_id) VALUES (1,NOW(),0,1);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (1,1,NOW(),0);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (2,1,NOW(),0);

INSERT INTO commande(table_id,commande_dh,commande_status,serveur_id) VALUES (2,NOW(),0,2);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (1,2,NOW(),0);
INSERT INTO item_cmd (item_id,cmd_id,item_cmd_dh,item_servi)VALUES (2,2,NOW(),0);


SELECT * FROM commande;

-- Quel est le serveur de la table T1 ? --
SELECT tr.table_num, srv.serveur_prenom FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN serveur srv on srv.serveur_id = cmd.serveur_id
WHERE tr.table_num='T1'

-- Quel est le serveur de la table T2 ? --
SELECT tr.table_num, srv.serveur_prenom FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN serveur srv on srv.serveur_id = cmd.serveur_id
WHERE tr.table_num='T2'

-- Ajoutons le serveur au Dashboard des cuisines pour l'avertir en cas de retard --
SELECT 
tr.table_num as "num_table", 
it_carte.desc_item as "plat", 
to_char(it_cmd.item_cmd_dh,'HH:MI:SS')  as "heure_commande",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes','HH:MI:SS')  as "heure_fin",
to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI')  as "tps_restant",
srv.serveur_prenom,
CASE 
  WHEN CAST (to_char(it_cmd.item_cmd_dh+ INTERVAL '10 minutes' - NOW() ,'MI') AS INTEGER) <  0 THEN 'RETARD' ELSE '--' END
  as "Infos"

FROM commande cmd 
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN item it_carte on it_carte.item_id = it_cmd.item_id
INNER JOIN serveur srv on srv.serveur_id = cmd.serveur_id
WHERE it_cmd.item_servi =0
and cmd.commande_status = 0
ORDER BY "tps_restant"
