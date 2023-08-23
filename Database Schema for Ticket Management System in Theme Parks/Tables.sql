-- table billets

CREATE TABLE billet (
    id_billets INT PRIMARY KEY,
    date_billets date,
    caisse  INT,
	type_billets TEXT,
	prix_billets NUMERIC,
	validite_jours INT,
	id_parc INT REFERENCES parc(id_parc),
	id_paiement INT REFERENCES paiement(id_paiement)
);

-- table parc

CREATE TABLE parc (
	id_parc INT PRIMARY KEY,
	nom_parc TEXT 
);

CREATE TABLE paiement (
	id_paiement INT PRIMARY KEY,
	transaction_paiement INT,
	type_paiement TEXT,
	montant_paiement NUMERIC
);

-- table paiement

INSERT INTO billet (id_billets, date_billets, caisse, type_billets, prix_billets, validite_jours, id_parc, id_paiement) VALUES 
	(1, '31/05/2023', 2, 'Adultes(12+)', 57.50, 1, 1, 1),
	(2, '31/05/2023', 2, 'Adultes(12+)', 44.00, 1, 2, 1),
	(3, '31/05/2023', 1, 'Enfant(4-11)', 41.00, 1, 2, 2),
	(4, '31/05/2023', 1, 'Adultes(12+)', 44.00, 1, 2, 2);

INSERT INTO parc (id_parc, nom_parc) VALUES
	(1, 'Europa - Park'),
	(2, 'Rulantica');
	
INSERT INTO paiement (id_paiement, transaction_paiement, type_paiement, montant_paiement) VALUES
	(1, 1, 'CB', 101.5),
	(2, 2, 'CB', 85);

	
SELECT * FROM billet;
SELECT * FROM parc;
SELECT * FROM paiement;
