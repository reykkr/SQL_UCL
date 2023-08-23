-- Retrieve all vehicles along with their associated prestations

SELECT v.immatriculation, m.libelle AS modele, p.typePrestation, p.description
FROM Vehicule v
JOIN Modele m ON v.idModele = m.id
LEFT JOIN Prestation p ON v.refDossier = p.refDossier;

-- Retrieve details of a specific dossier and its associated prestations

SELECT d.refDossier, v.immatriculation, m.libelle AS modele, p.typePrestation, p.description
FROM Dossier d
JOIN Vehicule v ON d.immatriculation = v.immatriculation
JOIN Modele m ON v.idModele = m.id
LEFT JOIN Prestation p ON d.refDossier = p.refDossier
WHERE d.refDossier = 1;
