-- 1. #adatbázis létrehozása 
CREATE DATABASE feltalalok
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

-- 2. #táblák létrehozása
CREATE TABLE talalmany (
  tkod int,
  talnev varchar(250),
  PRIMARY KEY (tkod)
);
CREATE TABLE kutato (
  fkod int,
  nev varchar(250),
  szul int,
  meghal int,
  PRIMARY KEY (fkod)
);
CREATE TABLE kapcsol (
  tkod int,
  fkod int
);

ALTER TABLE kapcsol ADD FOREIGN KEY (tkod) REFERENCES talalmany(tkod);
ALTER TABLE kapcsol ADD FOREIGN KEY (fkod) REFERENCES kutato(fkod);


#Adatok feltöltése

#	1. kutato.txt
#	2. talalmany.txt
#	3. kapcsol.txt

#feladatok

-- 3.	Listázza ki ábécérendben lekérdezés segítségével azoknak a
-- 	találmányoknak a nevét, amelyek nevében szerepel a „motor” szó!
SELECT talnev FROM talalmany
WHERE talnev LIKE '%motor%';

	
-- 4.	Lekérdezéssel írassa ki Forgó László találmányainak nevét!
SELECT talnev FROM talalmany
WHERE tkod IN (SELECT tkod FROM kutato WHERE nev LIKE 'Forgó László');

-- 5.	Adja meg lekérdezés segítségével, hogy ki volt a golyóstoll feltalálója és hány évig élt!
SELECT nev, meghal-szul AS eletkor FROM kutato
WHERE tkod IN (SELECT tkod FROM talalmany WHERE talnev LIKE 'golyóstoll');


-- 6.	Milyen találmányaik voltak azoknak a kutatóknak, akik a XIX. század első felében
-- 	(1801 és 1850 között, a határokat is beleszámolva) is éltek?
-- 	A kutatók és a találmányok nevét adja meg lekérdezés használatával!


	
-- 7.	Sorolja fel lekérdezés alkalmazásával azoknak a kutatóknak a nevét és a találmányaik számát,
-- 	akik legalább 3 kutatási eredménnyel szerepelnek az adatbázisban!
	
	
-- 8.	Adja meg lekérdezés segítségével, hogy a „transzformátor” feltalálóinak – a „transzformátor”-on kívül –
-- 	milyen más találmányaik vannak az adatbázisban! Minden találmány neve egyszer szerepeljen a listában!


	




