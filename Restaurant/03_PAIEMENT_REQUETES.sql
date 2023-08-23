/*

  _____        _____ ______ __  __ ______ _   _ _______ 
 |  __ \ /\   |_   _|  ____|  \/  |  ____| \ | |__   __|
 | |__) /  \    | | | |__  | \  / | |__  |  \| |  | |   
 |  ___/ /\ \   | | |  __| | |\/| |  __| | . ` |  | |   
 | |  / ____ \ _| |_| |____| |  | | |____| |\  |  | |   
 |_| /_/    \_\_____|______|_|  |_|______|_| \_|  |_|   
                                                        
                                                       
*/


/*
  DETAIL ET TOTAL DE LA COMMANDE
*/

-- Contenu de la commande --
select cmd.commande_id, it.item_id, it.desc_item, it.pv_item 
FROM commande cmd
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item it on it.item_id = it_cmd.item_id
where tr.table_num='T1'

-- Total de la commande --
select sum(it.pv_item) as "total_a_payer"
FROM commande cmd
INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
INNER JOIN table_rest tr on tr.table_id = cmd.table_id
INNER JOIN item it on it.item_id = it_cmd.item_id
where tr.table_num='T1'


/*
  CREATION DES ADDITIONS

  Lors d'un repas, chaque convive peut payer:
  - La totalité de la commande 
  - Seulement ses plats
  
  La commande peut donc donner lieu à plusieurs additions
  Une addition est liée à une seule et unique commande
  
  On stokera le prix, le libellé car ceux-ci peuvent changer tout au long
  de la vie du restaurant (Refonte de carte...)
  Légalement on doit pouvoir garder la trace de chacune des additions
  avec le descriptif exact et le prix exact
*/


-- Création de l'addition --
INSERT INTO addition (cmd_id,addition_dh)VALUES(1,NOW());
SELECT * FROM addition



-- Insertion avec imbrication d'un select --
INSERT INTO addition_ligne(addition_id,item_id,item_desc,item_pv)
SELECT ad.addition_id, it.item_id, it.desc_item, it.pv_item 
	FROM commande cmd
	INNER JOIN item_cmd it_cmd on it_cmd.cmd_id = cmd.commande_id
	INNER JOIN item it on it.item_id = it_cmd.item_id
	INNER JOIN addition ad on ad.cmd_id = cmd.commande_id
	WHERE cmd.commande_id = 1
	AND it.item_id = 1 -- CHOISIR LE PLAT ICI --


SELECT * FROM addition_ligne

-- Liste des items de la commande faisant objet d'une addition --

SELECT * from item
WHERE item.item_id in(
	SELECT DISTINCT(it_cmd.item_id) 
	FROM item_cmd it_cmd
	WHERE it_cmd.item_id in 
	(
		SELECT adl.item_id 
		FROM addition_ligne adl
		INNER JOIN addition ad on ad.addition_id = adl.addition_id
		INNER JOIN commande cmd on cmd.commande_id = ad.cmd_id
		WHERE cmd.commande_id = 1
	)
)


-- Liste des items de la commande ne faisant pas objet d'une addition --

SELECT * from item
WHERE item.item_id in(
	SELECT DISTINCT(it_cmd.item_id) 
	FROM item_cmd it_cmd
	WHERE it_cmd.item_id not in 
	(
		SELECT adl.item_id 
		FROM addition_ligne adl
		INNER JOIN addition ad on ad.addition_id = adl.addition_id
		INNER JOIN commande cmd on cmd.commande_id = ad.cmd_id
		WHERE cmd.commande_id = 1
	)
)


/*
	TYPE DE PAIEMENTS
*/

SELECT * FROM paiement_type

/*
	REALISATION DES PAIEMENTS
*/

INSERT INTO paiement (addition_id,paiement_type,paiement_montant) VALUES (1,3,2.0);
INSERT INTO paiement (addition_id,paiement_type,paiement_montant) VALUES (1,1,5.6);

SELECT * FROM paiement




