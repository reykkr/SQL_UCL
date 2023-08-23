-- Create the Dossier table
CREATE TABLE Dossier (
    refDossier INT PRIMARY KEY,
    nomFichierExpertise VARCHAR(255),
    immatriculation INT,
    FOREIGN KEY (immatriculation) REFERENCES Vehicule(immatriculation)
);

-- Create the Vehicule table
CREATE TABLE Vehicule (
    immatriculation INT PRIMARY KEY,
    anneeMiseEnCirculation DATE,
    couleur VARCHAR(50),
    idModele INT,
    refDossier INT,
    FOREIGN KEY (idModele) REFERENCES Modele(id),
    FOREIGN KEY (refDossier) REFERENCES Dossier(refDossier)
);

-- Create the Modele table
CREATE TABLE Modele (
    id INT PRIMARY KEY,
    libelle VARCHAR(100),
    marque VARCHAR(100)
);

-- Create the Prestation table
CREATE TABLE Prestation (
    id INT PRIMARY KEY,
    refDossier INT,
    typePrestation VARCHAR(50),
    description TEXT,
    photo VARCHAR(255),
    FOREIGN KEY (refDossier) REFERENCES Dossier(refDossier)
);

-- Populate the Modele table
INSERT INTO Modele (id, libelle, marque) VALUES
    (1, 'Modèle A', 'Marque X'),
    (2, 'Modèle B', 'Marque Y');

-- Populate the Vehicule table
INSERT INTO Vehicule (immatriculation, anneeMiseEnCirculation, couleur, idModele, refDossier) VALUES
    (1, '2020-01-01', 'Red', 1, NULL),
    (2, '2019-03-15', 'Blue', 2, NULL);

-- Populate the Dossier table
INSERT INTO Dossier (refDossier, nomFichierExpertise, immatriculation) VALUES
    (1, 'expertise_1.pdf', 1),
    (2, 'expertise_2.pdf', 2);

-- Populate the Prestation table
INSERT INTO Prestation (id, refDossier, typePrestation, description, photo) VALUES
    (1, 1, 'peinture', 'Réparer et peindre partiellement le pare-chocs avant', 'photo_1.jpg'),
    (2, 1, 'pièce', 'Remplacement de l\'essuie-glace', 'photo_2.jpg'),
    (3, 2, 'peinture', 'Réparer et peindre complètement l\'aile avant gauche', 'photo_3.jpg');
