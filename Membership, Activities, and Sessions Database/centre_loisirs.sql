-- Database: centre_loisirs

CREATE TABLE Adherent (
    id_adh SERIAL PRIMARY KEY,
    nom TEXT,
    adresse TEXT,
    age INT
);

CREATE TABLE Activite (
    nom_act TEXT PRIMARY KEY,
    cout_uni DECIMAL,
    prix_uni DECIMAL
);

CREATE TABLE Seance (
    nom_act TEXT REFERENCES Activite(nom_act),
	id_adh INT REFERENCES Adherent(id_adh),
    date_seance date,
	heure TIMESTAMP,
	note_app TEXT
);