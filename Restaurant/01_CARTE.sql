/*
   _____          _____ _______ ______ 
  / ____|   /\   |  __ \__   __|  ____|
 | |       /  \  | |__) | | |  | |__   
 | |      / /\ \ |  _  /  | |  |  __|  
 | |____ / ____ \| | \ \  | |  | |____ 
  \_____/_/    \_\_|  \_\ |_|  |______|

*/


----
--  CATEGORIES DE PRODUIT
----
/*
	cat_id  : clé
	cat_nom : nom de la catégorie
*/

-- Sequence --
DROP SEQUENCE IF EXISTS public.categorie_cat_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.categorie_cat_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY categorie.cat_id;

ALTER SEQUENCE public.categorie_cat_id_seq
    OWNER TO postgres;

-- table --
DROP TABLE IF EXISTS public.categorie;

CREATE TABLE IF NOT EXISTS public.categorie
(
    cat_id integer NOT NULL DEFAULT nextval('categorie_cat_id_seq'::regclass),
    cat_nom character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categorie_pkey PRIMARY KEY (cat_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categorie
    OWNER to postgres;
	
	
	
INSERT INTO categorie (cat_nom) VALUES ('Les crêpes salées');
INSERT INTO categorie (cat_nom) VALUES ('Spécialités galettes Sarrasins');
INSERT INTO categorie (cat_nom) VALUES ('Fromages galettes sarrasins');
INSERT INTO categorie (cat_nom) VALUES ('Les salades');
INSERT INTO categorie (cat_nom) VALUES ('Les crêpes sucrées');
INSERT INTO categorie (cat_nom) VALUES ('Les glaces');	

	

----
--  ITEMS (PRODUITS DE LA CARTE)
---
/*
	item_id   : clé
	desc_item : Description de l'item (Nom du plat)
	det_item  : Détail supplémentaire de l'item (Composition du plat)
	pv_item   : Prix de vente TTC
	cat_id    : clé étrangère vers la catégorie
*/

-- sequence --
DROP SEQUENCE IF EXISTS public.item_item_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.item_item_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 2147483647
    CACHE 1
    OWNED BY item.item_id;

ALTER SEQUENCE public.item_item_id_seq
    OWNER TO postgres;

-- table --
DROP TABLE IF EXISTS public.item;

CREATE TABLE IF NOT EXISTS public.item
(
    item_id integer NOT NULL DEFAULT nextval('item_item_id_seq'::regclass),
    desc_item character varying COLLATE pg_catalog."default" NOT NULL,
    det_item character varying COLLATE pg_catalog."default",
    pv_item numeric NOT NULL,
    cat_id integer NOT NULL,
    CONSTRAINT pk_item PRIMARY KEY (item_id),
    CONSTRAINT fk_categorie FOREIGN KEY (cat_id)
        REFERENCES public.categorie (cat_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.item
    OWNER to postgres;
	
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, fromage, champignons frais','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Lardons, oignons, fromage','',6.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, champignons frais, fromage','',6.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Coulis tomates, olives, anchois','',6.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, champignons frais','',6.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, épinards','',6.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Jambon, champignons frais, fromage','',6.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Jambon, poireaux frais, fromage','',6.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Endives fraîches, jambon, fromage, crème fraîche','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Ratatouille, Oeuf brouillé, fromage','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, bacon, fromage','',6.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, lardons, oignons frais, fromage','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, épinards, fromage','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, coulis tomate, fromage','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Jambon, coulis tomate, fromage, champignons frais','',7.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, coulis tomate, fromage, champignons frais','',8.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Steak haché, oeuf, oignons, ketchup, salade','',8.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oignons frais, véritable Andouille de Vire, fromage, Oeuf','',8.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon, fromage, tomates crues, salade','',8.40,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, lardons, coulis tomate, fromage, champignons frais','',8.90,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, fromage','',5.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf','',3.90,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Fromage','',4.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oignons','',4.00,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Lardons','',4.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Jambon','',4.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Champignons frais','',4.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Véritable andouille de Vire, crème fraîche','',7.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Epinards','',4.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Poireaux frais','',5.30,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Beurre','',3.10,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, jambon','',5.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, bacon','',5.60,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Oeuf, champignons frais','',5.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Jambon, fromage','',5.70,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Champignons frais, fromage','',5.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Epinards, jambon','',5.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Véritable andouille de Vire, oignons, crème fraîche','',8.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Complète','Oeuf, jambon, fromage',6.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Super Complète','Doubles Oeufs, double jambon, fromage',8.50,1);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Nordique','Saumon, citron, crème fraiche',9.40,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Monsieur Seguin','Fromage de chèvre, bacon, miel, noix',8.90,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Cavalière','Steak haché, oeuf, tomates crues, oignons frais, salade',9.50,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Parmentière','Steak, oignons, pommes de terre, fromage, crème fraîche',9.60,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Saumon, épinards','',10.20,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Bicquette','Fromage de chèvre, pomme de terre, lardons',8.90,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Ch''tifflette','Maroilles, pommes de terre, lardons, oignons frais',9.20,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Suprême','Quenelle de volaille, béchamel, fromage, champignons frais',9.20,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Poulet','Poulet, béchamel, champignons frais, fromage, citron',10.40,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Popeye','Epinards, champignons frais, jambon, fromage',7.90,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('L''Indienne','Sauté de poulet aux épices, fromage, champignons frais',10.40,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('L''Orientale','Merguez, tomates, oignons, olives, poivrons',8.60,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Pizza','Coulis de tomates, jambon, mozzarella, olives, crème fraiche',7.90,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Italienne','Jambon cru, Mozzarella, tomates, pesto maison',8.90,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Paysanne','Pomme de terre, lardons, oignons frais, crème fraîche, salade',8.70,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Raclette','Jambon, bacon, fromage raclette, pommes de terre, salade',10.00,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('L''Avenoise','Maroilles, jambon, crème',8.30,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Bergère','Jambon, Roquefort, Noix',7.90,2);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Roquefort','',6.20,3);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Roquefort - Poire','',7.20,3);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Maroilles','',6.20,3);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Welsh et sa salade','Jambon, cheddar',7.80,3);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chèvre au romarin','',6.20,3);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Maroilles - Oignons frais','',6.90,3);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Romaine','Salade verte, jambon cru, tomates, mozzarella, toasts, huile d''olive, vinaigre balsamique',10.00,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Salade de Chèvre','Chèvre chaud sur toast',6.60,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Savoyarde','Salade verte, fromage, jambon, noix',7.80,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Flamande','Salade verte, tomate, oeuf dur, pomme de terre, jambon',7.70,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Printanière','Salade verte, lardons, oeuf dur , fromage, noix',7.80,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Salade de poulet au Roquefort','Poulet, roquefort, noix, poires, salade verte',8.80,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Salade verte - tomates','',4.70,4);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Cassonade','',3.50,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Sucre','',3.00,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Banane','',4.20,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Miel','',4.20,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Compote (maison) pomme ou rhubarbe','',4.20,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Citron','',4.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chocolat','',4.40,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Au 2 Chocolats (noir et blanc)','',4.60,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Nutella','',4.60,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Confiture de lait','',3.90,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Miel, amande','',5.00,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Miel, noix, citron','',5.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Caramel beurre salé','Maison',5.20,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chocolat, noix de coco','',5.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chocolat chantilly','',5.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chocolat, noix ou amandes','',5.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chocolat, banane','',5.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chocolat, banane, chantilly','',5.90,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Frangipane','Maison',5.90,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Confiture Fraise, framboise, orange, myrtille, figue, abricot, mûre, groseille','',3.80,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Mont blanc','Crème de marrons, chantilly',5.30,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Flambée','Rhum, calvados, grand marnier',5.65,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Kinder','Nutella, choco blanc, croustibilles',5.50,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('After Eight','Glace menthe, chocolat',5.50,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Crunchy','Chocolat, caramel au beurre salé, biscuit',6.10,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Belle Hélène','Poires, chocolat, chantilly',6.50,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Bourdaloue','Frangipane maison, poires',6.50,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Antillaise','Banane, rhum, chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Dame Rouge','Sorbet fraise, coulis fruits Rouges, chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Australienne','Glace vanille, kiwi, coulis de framboises, chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Dame Blanche','Glace vanille, chocolat, chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Amarena','Glace vanille, coulis de framboise chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Exotique','Sorbet passion, coulis de framboise, chantilly',6.60,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Spéculos','Crème spéculos, glace vanille chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Créole','Banane, ananas, glace citron',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('St Malo','Glace vanille, caramel beurre salé, chantilly.',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Congolaise','Glace noix de coco, chocolat, chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Pain d’épices','Glace pain d’épices, caramel beurre salé, chantilly',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Bounty','Chocolat, noix de coco, banane.',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Carrément Cara','Glace caramel, chantilly, caramel beurre salé',6.70,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Royale','Chocolat, grand marnier, chantilly',6.80,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Normande','Pommes flambées au calvados',6.90,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Suzette','Orange, flambée grand marnier',6.90,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Beaurepaire','Sorbet passion, poire, coulis de framboise, chantilly',7.00,5);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Banana Split','Chocolat, Fraise, Vanille, Chantilly, Chocolat chaud maison, banane',6.00,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Dame Blanche','Vanille, Chocolat chaud maison, chantilly',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Copacabana','Fruits de la passion, Citron vert, Noix de coco, Coulis de fruits rouges',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Poire belle Hélène','Poire fruit, Vanille, Chantilly, Chocolat chaud maison',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Anglaise','Chocolat, Menthe, Chantilly, Chocolat chaud maison',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Chococo','Noix de coco, chocolat au lait',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Duchesse','Nougat, Praliné, Speculoos',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Coupe Guérandaise','Caramel fleur de sel, 1/2 poire coulis de caramel',6.00,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Abricotine','Abricot, pain d''épices',5.80,6);
INSERT INTO item (desc_item,det_item,pv_item,cat_id) VALUES ('Nougat Framboise','Framboise, nougat',5.80,6);
