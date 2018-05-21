/* CREATE TYPE type_user AS ENUM ('Administrateur', 'Humain', 'Chat'); remplacés par 0 1 2 */
/* CREATE TYPE type_sex AS ENUM ('Male','Femelle','Attack helicopter'); remplacés par 0 1 2 */
/* CREATE TYPE type_size AS ENUM ('Miniscule','Petite','Moyenne','Grande','Géante','Ur momma'); remplacés par 0-5*/
/* CREATE TYPE type_coat AS ENUM ('Nu','Court','Mi-long','Long'); remplacés par 0-3 */
CREATE TYPE type_pattern AS ENUM ('Solide','Tabby','Colourpoint','Bicolore','Ecaille de tortue','Calico','Mink','Sepia');

DROP TABLE IF EXISTS Utilisateur;
CREATE TABLE IF NOT EXISTS Utilisateur(
	id_user SERIAL PRIMARY KEY NOT NULL,
	login VARCHAR NOT NULL,
	mail VARCHAR NOT NULL,
	password VARCHAR NOT NULL,
	phone_number INTEGER NOT NULL,
	user_type INTEGER NOT NULL CHECK (0 <= user_type AND user_type < 3)
	);
	
DROP TABLE IF EXISTS Connected;
CREATE TABLE IF NOT EXISTS Connected(
	id_connected INTEGER UNIQUE KEY NOT NULL
	);
	   
DROP TABLE IF EXISTS Cats;
CREATE TABLE IF NOT EXISTS Cats(
       id_cat SERIAL PRIMARY KEY NOT NULL,
       owner INTEGER NOT NULL,
       FOREIGN KEY (owner) REFERENCES Utilisateur(id_user),
       name_cat VARCHAR NOT NULL,
       purety BOOLEAN,
       pattern type_pattern, /* NULL s'il n'y en a pas */

       birthday_cat DATE,
       sage_min INTEGER,
       sage_max INTEGER,

       sex INTEGER NOT NULL CHECK (0 <= sex AND sex < 3),
       ssex INTEGER NOT NULL CHECK (0 <= sex AND sex < 3),

       csize INTEGER CHECK (0 <= csize AND csize < 3),
       scsize_min INTEGER CHECK (0 <= csize AND csize < 3),
       scsize_max INTEGER CHECK (0 <= csize AND csize < 3),

       coat INTEGER CHECK (0<=coat AND coat < 4),
       scoat_min INTEGER CHECK (0<=coat AND coat < 4),
       scoat_max INTEGER CHECK (0<=coat AND coat < 4),

       weight FLOAT CHECK (0<weight),
       sweight_min FLOAT CHECK (0<weight),
       sweight_max FLOAT CHECK (0<weight)

	   );

		/* contient aussi une race (Cat_breed), une ou plusieurs couleurs (Cat_color) et traits de caractères (cat_personnality) 
		et les critères de recherche correspondants + pattern recherchés */

DROP TABLE IF EXISTS Breeds;
CREATE TABLE IF NOT EXISTS Breeds(
       id_breed SERIAL PRIMARY KEY NOT NULL,
       name_breed VARCHAR NOT NULL
	   );
	   
DROP TABLE IF EXISTS Colors;   
CREATE TABLE IF NOT EXISTS Colors(
       id_color SERIAL PRIMARY KEY NOT NULL,
       name_color VARCHAR NOT NULL
       );

DROP TABLE IF EXISTS Personality_traits;	   
CREATE TABLE IF NOT EXISTS Personality_traits(
       id_trait SERIAL PRIMARY KEY NOT NULL,
       name_trait VARCHAR NOT NULL
       );

DROP TABLE IF EXISTS Cat_color;	   
CREATE TABLE IF NOT EXISTS Cat_colors(
		cat INTEGER,
		color INTEGER,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		FOREIGN KEY (color) REFERENCES Colors(id_color),
		PRIMARY KEY (cat,color)
		);

DROP TABLE IF EXISTS Cat_breed;		
CREATE TABLE IF NOT EXISTS Cat_breed(
		cat INTEGER,
		breed INTEGER,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		FOREIGN KEY (breed) REFERENCES Breeds(id_breed),
		PRIMARY KEY (cat,breed)
		);

DROP TABLE IF EXISTS Cat_personality;
CREATE TABLE IF NOT EXISTS Cat_personality(
		cat INTEGER,
		trait INTEGER,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		FOREIGN KEY (trait) REFERENCES Personality_traits(id_trait),
		PRIMARY KEY(cat,trait)
		);

DROP TABLE IF EXISTS Searched_traits;
CREATE TABLE IF NOT EXISTS Searched_traits(
		cat INTEGER,
		trait INTEGER,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		FOREIGN KEY (trait) REFERENCES Personality_traits(id_trait),
		PRIMARY KEY(cat,trait)
		);

DROP TABLE IF EXISTS Searched_breeds;	   
CREATE TABLE IF NOT EXISTS Searched_breeds(
		cat INTEGER,
		breed INTEGER,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		FOREIGN KEY (breed) REFERENCES Breeds(id_breed),
		PRIMARY KEY(cat,breed)
		);

DROP TABLE IF EXISTS Searched_colors;	   
CREATE TABLE IF NOT EXISTS Searched_colors(
		cat INTEGER,
		color INTEGER,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		FOREIGN KEY (color) REFERENCES Colors(id_color),
		PRIMARY KEY(cat,color)
		);

DROP TABLE IF EXISTS Searched_patterns;
CREATE TABLE IF NOT EXISTS Searched_patterns(
		cat INTEGER NOT NULL,
		pattern type_pattern NOT NULL,
		FOREIGN KEY (cat) REFERENCES Cats(id_cat),
		PRIMARY KEY(cat,type_pattern)
		);

INSERT INTO Colors VALUES ('1','Noir');
INSERT INTO Colors VALUES ('2','Bleu');
INSERT INTO Colors VALUES ('3','Chocolat');
INSERT INTO Colors VALUES ('4','Lilas');
INSERT INTO Colors VALUES ('5','Cannelle');
INSERT INTO Colors VALUES ('6','Fauve');
INSERT INTO Colors VALUES ('7','Roux');
INSERT INTO Colors VALUES ('8','Crème');
INSERT INTO Colors VALUES ('9','Blanc');
INSERT INTO Colors VALUES ('10','Ambre');
INSERT INTO Colors VALUES ('11','Ambre clair');
INSERT INTO Colors VALUES ('12','Abricot');


INSERT INTO Personality_traits VALUES('1','Malicieux');
INSERT INTO Personality_traits VALUES('2','Joueur');
INSERT INTO Personality_traits VALUES('3','Calin');
INSERT INTO Personality_traits VALUES('4','Paresseux');
INSERT INTO Personality_traits VALUES('5','Bruyant');
INSERT INTO Personality_traits VALUES('6','Tonique');
INSERT INTO Personality_traits VALUES('7','Emotif');
INSERT INTO Personality_traits VALUES('8','Chasseur');


INSERT INTO Breeds VALUES ('1','Siamois');
INSERT INTO Breeds VALUES ('2','Persan');
INSERT INTO Breeds VALUES ('3','Ragdoll');
INSERT INTO Breeds VALUES ('4','Bengan');
INSERT INTO Breeds VALUES ('5','Sphynx');
INSERT INTO Breeds VALUES ('6','Abyssin');
INSERT INTO Breeds VALUES ('7','Burmese');
INSERT INTO Breeds VALUES ('8','Bobtail américain');
INSERT INTO Breeds VALUES ('9','British Shorthair');
INSERT INTO Breeds VALUES ('10','Maine coon');
INSERT INTO Breeds VALUES ('11','Sacré de Birmanie');
INSERT INTO Breeds VALUES ('12','Sibérien');
INSERT INTO Breeds VALUES ('13','Cornish rex');
INSERT INTO Breeds VALUES ('14','Ocicat');
INSERT INTO Breeds VALUES ('15','Norvégien');
INSERT INTO Breeds VALUES ('16','Tonkinois');
INSERT INTO Breeds VALUES ('17','Manx');
INSERT INTO Breeds VALUES ('18','Angora Turc');
INSERT INTO Breeds VALUES ('19','Savannah');
INSERT INTO Breeds VALUES ('20','Himalayen');


INSERT INTO Utilisateur VALUES ('1','Jesus','Jesus@paradise.net','406fcef6cb90b615f5e4c5239f05d4dc','0001001001','0'); /* mdp Amen0 :*/
INSERT INTO Utilisateur VALUES ('2','Alphabet','boss@google.net','0c4ea8bb1bd4ef54defc54a73d5c9612','0008008008','1'); /* mdp Ch1en */
INSERT INTO Utilisateur VALUES ('3','Clochard','mauvais@rue.com','483a6adfa09079059fd9eb3849932724','9876543210','1'); /* mdp SNCF2merde */
INSERT INTO Utilisateur VALUES ('4','Jean-Eudes','je.dieseman@diese.org','42f66f9ed55f43a0eb4bd560e7cf87a5','0154879632','1'); /* mdp D1eseRecherche */

INSERT INTO Cats VALUES ('1','1','Pierre',TRUE,NULL,'0001-12-25',NULL,NULL, '0','1', '1',NULL,NULL, '1',NULL,NULL, 5,NULL,NULL);
INSERT INTO Cat_color VALUES ('1','9');
INSERT INTO Cat_breed VALUES ('1','14');
INSERT INTO Cat_personnality VALUES ('1','2');

