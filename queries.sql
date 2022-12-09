/* Monday */

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Tuesday */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
--1st transaction
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
--2nd transaction
COMMIT;
SELECT * FROM animals ORDER BY id;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
--3rd transaction
ROLLBACK;
SELECT * FROM animals ORDER BY id;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > DATE '2022-01-01';
SAVEPOINT animals_after_JAN2022;
SELECT * FROM animals ORDER BY id;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals ORDER BY id;
ROLLBACK TO animals_after_JAN2022;
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
--4th transaction
COMMIT;
SELECT * FROM animals ORDER BY id;

/* Aggregates */
SELECT * from animals;
SELECT COUNT(*) AS "Animals_Count" FROM animals;
SELECT COUNT(*) AS "Animals with 0 escape attempts" FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS "Average_Animal_Weight" FROM animals;
SELECT neutered, SUM(escape_attempts) AS "All_Escapes" FROM animals GROUP BY neutered;
SELECT species, MAX(weight_kg) AS "Maximum Weight", MIN(weight_kg) AS "Minimum Weight" FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS "Average_Escape" FROM animals WHERE date_of_birth BETWEEN DATE '1990-01-01' AND '2000-12-31' GROUP BY species;

/* wednesday */
/* Write queries (using JOIN) to answer the following questions */
SELECT * FROM animals a JOIN owners o ON o.id = a.owner_id WHERE o.full_name = 'Melody Pond';
SELECT * FROM animals a JOIN species s ON s.id = a.species_id WHERE s.name = 'Pokemon';
SELECT full_name AS "Owner", a.name AS "Animal" FROM animals a RIGHT JOIN owners o ON o.id = a.owner_id;
SELECT COUNT(a.name) AS "Number of Animals", s.name AS "Species" FROM animals a JOIN species s ON s.id = a.species_id GROUP BY s.name;
SELECT a.name AS "Digimons", o.full_name AS "Owner" FROM animals a JOIN species s ON a.species_id = s.id JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';
SELECT o.full_name AS "Owner", a.name AS "Animal", a.escape_attempts AS "Escapes" FROM animals a JOIN owners o ON o.id = a.owner_id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;
SELECT o.full_name AS "Owner", COUNT(a.name) AS "# of Animals" FROM animals a JOIN owners o  ON a.owner_id = o.id GROUP BY o.full_name ORDER BY "# of Animals" DESC LIMIT 1;

/* Thursday */
SELECT a.name AS "Animal", ve.name AS "Vet Name", vi.date_of_visit AS "Day of Visit" FROM animals a JOIN visits vi ON vi.animal_id = a.id JOIN vets ve ON ve.id = vi.vet_id WHERE ve.name = 'William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;
SELECT COUNT(DISTINCT(a.name)) AS "N_o Animals", ve.name AS "Vet Name" FROM animals a JOIN visits vi ON vi.animal_id = a.id JOIN vets ve ON ve.id = vi.vet_id WHERE ve.name = 'Stephanie Mendez' GROUP BY "Vet Name";
SELECT ve.name AS "Vet Name", s.name AS "Specialization" FROM vets ve LEFT JOIN specializations sp ON sp.vet_id = ve.id LEFT JOIN species s ON s.id = sp.species_id;
SELECT a.name AS "Animal who visited Stephanie Mendez", vi.date_of_visit AS "Day of Visit(April 1st to August 30th, 2020)" FROM animals a JOIN visits vi ON vi.animal_id = a.id JOIN vets ve ON ve.id = vi.vet_id WHERE ve.name = 'Stephanie Mendez' AND date_of_visit BETWEEN DATE '2020-04-01' AND '2020-08-30';
SELECT a.name AS "Animal", COUNT(vi.animal_id) AS visit_count FROM animals a JOIN visits vi ON vi.animal_id = a.id GROUP BY a.name ORDER BY visit_count DESC LIMIT 1;
SELECT a.name AS "Animal", ve.name AS "Vet Name", vi.date_of_visit AS "Day of Visit" FROM animals a JOIN visits vi ON vi.animal_id = a.id JOIN vets ve ON ve.id = vi.vet_id WHERE ve.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;
SELECT a.name AS "Animal", s.name AS "Type", date_of_birth AS "DOB", escape_attempts AS "Escapes", neutered, weight_kg, ve.name AS "Vet Name", spc.name AS "Specialization", age AS "Vets' Age", date_of_graduation AS "Vet's Graduation Date", vi.date_of_visit AS "Day of Visit" FROM animals a JOIN visits vi ON vi.animal_id = a.id JOIN vets ve ON ve.id = vi.vet_id JOIN species s ON s.id = a.species_id JOIN specializations sp ON sp.vet_id = ve.id JOIN species spc ON spc.id = sp.species_id ORDER BY date_of_visit DESC LIMIT 1; 
SELECT COUNT(vi.animal_id) AS "N_o Visits(Animal Type <> Vet Specialization)" FROM animals a JOIN visits vi ON vi.animal_id = a.id JOIN vets ve ON ve.id = vi.vet_id JOIN species s ON s.id = a.species_id JOIN specializations sp ON sp.vet_id = ve.id JOIN species spc ON spc.id = sp.species_id WHERE s.name <> spc.name;
SELECT ve.name AS "Vet's Name", s.name AS "Animal Type", COUNT(s.name) AS "N_o Specialization" FROM vets ve JOIN visits vi ON vi.vet_id = ve.id JOIN animals a ON a.id = vi.animal_id JOIN species s ON s.id = a.species_id WHERE ve.name = 'Maisy Smith' GROUP BY s.name, ve.name ORDER BY "N_o Specialization" DESC LIMIT 1;
