CREATE TABLE animals (
  id BIGSERIAL NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INTEGER,
  neutered BOOLEAN NOT NULL,
  weight_kg DOUBLE PRECISION NOT NULL,
  species VARCHAR(50) NOT NULL
);