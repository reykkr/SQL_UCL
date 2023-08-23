-- Database: centre_loisirs

CREATE TABLE avion(
	immarticulation INT PRIMARY KEY,
	type_avion TEXT,
	capacite INT,
	rayon_action DECIMAL,
	date_achat date,
	date_revision date,
	constructeur TEXT
);

CREATE TABLE Type(
	constructeur TEXT PRIMARY KEY,
	capacite NUMERIC,
	rayon_action DECIMAL
); 

CREATE TABLE pilote(
	num_emp INT PRIMARY KEY,
	nom TEXT,
	adresse TEXT,
	salaire TEXT,
	qualification TEXT REFERENCES Type(constructeur)
);

CREATE TABLE vol(
	num_vol INT PRIMARY KEY,
	horaire TEXT,
	trajet TEXT,
	nb_passager NUMERIC,
	avion TEXT REFERENCES Type(constructeur), 
	pilote INT REFERENCES pilote(num_emp) 
);