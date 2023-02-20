-- A feladatok megoldására elkészített SQL parancsokat illessze be a feladat sorszáma után!
USE `mozi`;

-- 2. feladat

CREATE DEFINER=`root`@`localhost` PROCEDURE `vetitesek_szama`(IN idatum DATE, IN ikezdes TIME)
BEGIN
    SELECT COUNT(*) AS vetitesek_szama
    FROM vetites
    WHERE datum > idatum OR (datum = idatum AND kezdes > ikezdes);
END


-- 3. feladat

CREATE DEFINER=`root`@`localhost` PROCEDURE `toplista`(IN n INT)
BEGIN
    SELECT COUNT(j.id) AS jegy_db, v.nev AS vendeg_nev
    FROM jegy j
    JOIN vetites vts ON j.vetitesId = vts.id
    JOIN vendeg v ON j.vendegId = v.id
    GROUP BY v.nev
    ORDER BY jegy_db DESC
    LIMIT n;
END

-- 4. feladat

CREATE DEFINER=`root`@`localhost` PROCEDURE `uj_tipus`(IN nev VARCHAR(255))
BEGIN
    INSERT INTO filmtipus (nev) VALUES (nev);
END

CALL uj_tipus('Animációs');


CREATE DEFINER=`root`@`localhost` PROCEDURE `jegyek_szama`(IN vendegId INT, IN kedvezmeny BOOLEAN, OUT jegyekSzama INT)
BEGIN
    IF kedvezmeny THEN
        SELECT COUNT(j.id) INTO jegyekSzama
        FROM jegy j
        JOIN vetites vts ON j.vetitesId = vts.id
        JOIN vendeg v ON j.vendegId = v.id
        WHERE v.id = vendegId AND j.kedvezmeny > 0;
    ELSE
        SELECT COUNT(j.id) INTO jegyekSzama
        FROM jegy j
        JOIN vetites vts ON j.vetitesId = vts.id
        JOIN vendeg v ON j.vendegId = v.id
        WHERE v.id = vendegId;
    END IF;
END

CALL jegyek_szama(1, 0, @jegyekSzama);
SELECT @jegyekSzama;

-- 6. feladat

CREATE DEFINER=`root`@`localhost` PROCEDURE `kategorizal`(IN filmId INT, OUT kategoria VARCHAR(255))
BEGIN
    DECLARE atlagJegyar INT;
    SELECT AVG(jegyar) INTO atlagJegyar FROM film;
    SELECT CASE
        WHEN jegyar < atlagJegyar * 0.8 THEN 'olcsó'
        WHEN jegyar < atlagJegyar * 1.2 THEN 'átlagos'
        ELSE 'drága'
    END INTO kategoria
    FROM film
    WHERE id = filmId;
END
