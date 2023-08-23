/*
   _____          _____ _______ ______ 
  / ____|   /\   |  __ \__   __|  ____|
 | |       /  \  | |__) | | |  | |__   
 | |      / /\ \ |  _  /  | |  |  __|  
 | |____ / ____ \| | \ \  | |  | |____ 
  \_____/_/    \_\_|  \_\ |_|  |______|

*/



/*
     REQUETES SUR LES CATEGORIES
*/

-- Affichage de l'ensemble des colonnes de catégories --
SELECT * FROM public.categorie;

-- Comptage des catégories --
SELECT count(1) FROM public.categorie;

-- Affichage des noms des catégories --
SELECT cat_nom FROM public.categorie;

-- Affichage des identifiants des catégories --
SELECT cat_id FROM public.categorie;

-- Affichage des noms et identifiants des catégories --
SELECT cat_nom, cat_id FROM public.categorie;

-- Affichage des noms et identifiants des catégories triées par identifiant croissants --
SELECT cat_nom, cat_id FROM public.categorie ORDER BY cat_id;

-- Affichage des noms et identifiants des catégories triées par identifiant décroissants --
SELECT cat_nom, cat_id FROM public.categorie ORDER BY cat_id DESC;

-- Affichage des noms et identifiants des catégories triées par noms croissants --
SELECT cat_nom, cat_id FROM public.categorie ORDER BY cat_nom;

-- Affichage des noms et identifiants des catégories triées par noms décroissants --
SELECT cat_nom, cat_id FROM public.categorie ORDER BY cat_nom DESC;

-- Affichage des noms et identifiants des catégories dont l'id est égal à 1 --
SELECT cat_nom, cat_id FROM public.categorie WHERE cat_id = 1;

-- Affichage des noms et identifiants des catégories dont l'id est égal à 0 --
SELECT cat_nom, cat_id FROM public.categorie WHERE cat_id = 0;

-- Affichage des noms et identifiants des catégories dont le nom correspond strictement à 'Les salades'--
SELECT cat_nom, cat_id FROM public.categorie WHERE cat_nom = 'Les salades';

-- Affichage des noms et identifiants des catégories dont le nom correspond strictement à 'les salades'--
-- Aucun résultats, car aucune catégorie n'a strictement ce nom --
SELECT cat_nom, cat_id FROM public.categorie WHERE cat_nom = 'les Salades';

-- Affichage des noms et identifiants des catégories dont le nom, transformé en minuscules, correspond strictement à 'Les salades' transformé en minuscules--
SELECT cat_nom, cat_id FROM public.categorie WHERE lower(cat_nom) = lower('les Salades');
SELECT cat_nom, cat_id FROM public.categorie WHERE upper(cat_nom) = upper('les Salades');

-- Affichage des noms et identifiants des catégories dont le nom, transformé en minuscules, commence par 'les' --
SELECT cat_nom, cat_id FROM public.categorie WHERE lower(cat_nom) like ('les%');

-- Affichage des noms et identifiants des catégories dont le nom, transformé en minuscules, se termine par 'ées' --
SELECT cat_nom, cat_id FROM public.categorie WHERE lower(cat_nom) like ('%ées');

-- Affichage des noms et identifiants des catégories dont le nom, transformé en minuscules, contient par 'la' --
SELECT cat_nom, cat_id FROM public.categorie WHERE lower(cat_nom) like ('%la%');


-- ========================================================================================= --
-- ========================================================================================= --

/*
     REQUETES SUR LES ITEMS
*/

-- Nombre d'items --
SELECT count(1) from item;

-- Toutes les colonnes de tous les items --
SELECT * from item;

-- Items ayant un prix de vente inférieur à 5€ --
SELECT * FROM item WHERE pv_item < 5.00;

-- Items dont la description (en minuscules) ne commence pas par le mot oeuf --
SELECT * FROM item WHERE lower(desc_item) NOT LIKE lower('oeuf%')

-- Items dont la description (en minuscules) ne commence pas par le mot oeuf et le détail  (en minuscules) du plat ne commence pas par le mot oeuf --
SELECT * FROM item WHERE lower(desc_item) NOT LIKE lower('oeuf%') AND lower(det_item) NOT LIKE lower('oeuf%')

-- Items dont la description (en minuscules) ne commence pas par le mot oeuf et le détail (en minuscules) du plat ne contient pas le mot oeuf --
SELECT * FROM item WHERE lower(desc_item) NOT LIKE lower('%oeuf%') AND lower(det_item) NOT LIKE lower('%oeuf%')

-- Statistiques : prix maximal --
SELECT MAX(pv_item) FROM item;

-- Statistiques : prix minimal --
SELECT MIN(pv_item) FROM item;

-- Statistiques : prix moyen --
SELECT AVG(pv_item) FROM item;

-- Statistiques : prix moyen arrondi --
SELECT ROUND(AVG(pv_item),2) FROM item;

-- Statistiques: Item correspondants aux prix moyen (utilisation de sous requêtes)--
SELECT * FROM item WHERE pv_item = (SELECT MIN(pv_item) FROM item);