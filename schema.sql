/*Monday*/
CREATE TABLE animals (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INTEGER,
  neutered BOOLEAN NOT NULL,
  weight_kg DOUBLE PRECISION NOT NULL
);

/* Tuesday */
ALTER TABLE animals ADD species VARCHAR(50);

/* wednesday */
/* New table for owners */
CREATE TABLE owners (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	age INTEGER NOT NULL
);

/*New table for species */
CREATE TABLE species (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL
);

alter table animals drop column species; /*DELETE COLUMN species*/
alter table animals add column species_id INT NULL REFERENCES species(id) ON DELETE CASCADE; /*ADD COLUMN species_id, which is a foreign key referencing species table*/
alter table animals add column owner_id INT NULL REFERENCES owners(id) ON DELETE CASCADE; /*ADD COLUMN owner_id, which is a foreign key referencing owners table*/

/* thursday */
CREATE TABLE vets (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name varchar(100) NOT NULL,
  age INT NOT NULL,
  date_of_graduation DATE NOT NULL
);
CREATE TABLE specializations (
  species_id INT NULL REFERENCES species(id) ON DELETE CASCADE,
  vet_id INT NULL REFERENCES vets(id) ON DELETE CASCADE
);
CREATE TABLE visits (
  animal_id INT NULL REFERENCES animals(id) ON DELETE CASCADE,
  vet_id INT NULL REFERENCES vets(id) ON DELETE CASCADE,
  date_of_visit DATE NOT NULL
);
