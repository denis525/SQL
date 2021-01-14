DROP TABLE IF EXISTS Racun;
DROP TABLE IF EXISTS Postavka;
DROP TABLE IF EXISTS Cenik;
DROP TABLE IF EXISTS Izposoja;
DROP TABLE IF EXISTS RegistrskaTablica;
DROP TABLE IF EXISTS Opremljenost;
DROP TABLE IF EXISTS DodatnaOprema;
DROP TABLE IF EXISTS Avto;
DROP TABLE IF EXISTS Barva;
DROP TABLE IF EXISTS Tip;
DROP TABLE IF EXISTS Gorivo;
DROP TABLE IF EXISTS Narocnik;
DROP TABLE IF EXISTS Poraba;
DROP TABLE IF EXISTS VozniskoDovoljenje;
DROP TABLE IF EXISTS Naslov;
DROP TABLE IF EXISTS Kraj;

CREATE TABLE Kraj (
	idKraj INT NOT NULL, 
	postnaStevilka INT NOT NULL,
    imePoste VARCHAR(30)
);
ALTER TABLE Kraj ADD CONSTRAINT pk_kraj_id PRIMARY KEY (idKraj);

CREATE TABLE Naslov (
	idNaslov INT NOT NULL, 
	ulica VARCHAR(20) NOT NULL,
    hisnaStevilka INT NOT NULL,
    idKraj INT NOT NULL
);
ALTER TABLE Naslov ADD CONSTRAINT pk_naslov_id PRIMARY KEY (idNaslov);
ALTER TABLE Naslov ADD CONSTRAINT fk_kraj_id FOREIGN KEY (idKraj) REFERENCES Kraj (idKraj) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE VozniskoDovoljenje (
	idVozniskoDovoljenje INT NOT NULL,
    stVozniskegaDovoljenja INT NOT NULL,
    veljaOd DATE NOT NULL,
    veljaDo DATE NOT NULL, 
    upravnaEnota VARCHAR(30) NOT NULL,
    emso INT NOT NULL 
);

ALTER TABLE VozniskoDovoljenje ADD CONSTRAINT pk_vozniskoDovoljenje_id PRIMARY KEY (idVozniskoDovoljenje);

CREATE TABLE Tip (
	idTip INT NOT NULL,
    tipAvtomobila VARCHAR(30) NOT NULL
);

ALTER TABLE Tip ADD CONSTRAINT pk_tip_id PRIMARY KEY (idTip);

CREATE TABLE DodatnaOprema(
	idDodatnaOprema INT NOT NULL,
    tipDoddatneOpreme VARCHAR(30)
);

ALTER TABLE DodatnaOprema ADD CONSTRAINT pk_dodatnaoprema_id PRIMARY KEY (idDodatnaOprema);

CREATE TABLE Barva (
	idBarva INT NOT NULL,
    barva VARCHAR(30) NOT NULL
);

ALTER TABLE Barva ADD CONSTRAINT pk_barva_id PRIMARY KEY (idBarva);

CREATE TABLE Gorivo (
	idGorivo INT NOT NULL,
    vrstaGoriva VARCHAR(30) NOT NULL
);

ALTER TABLE Gorivo ADD CONSTRAINT pk_gorivo_id PRIMARY KEY (idGorivo);


CREATE TABLE Poraba (
	idPoraba INT NOT NULL,
    kombiniranaVoznja DOUBLE NOT NULL,
    izvenMestnaVoznja DOUBLE NOT NULL,
    mestnaVoznja DOUBLE NOT NULL
);

ALTER TABLE Poraba ADD CONSTRAINT pk_poraba_id PRIMARY KEY (idPoraba);

CREATE TABLE Avto (
	idAvto INT NOT NULL,
    ime VARCHAR(20) NOT NULL,
    letnik INT NOT NULL,
    stPrevozenihKm DOUBLE NOT NULL,
    idTip INT NOT NULL,
    idBarva INT NOT NULL,
    idPoraba INT NOT NULL,
    idGorivo INT NOT NULL,
    idCena INT NOT NULL
);

ALTER TABLE Avto ADD CONSTRAINT pk_avto_id PRIMARY KEY (idAvto);
ALTER TABLE Avto ADD CONSTRAINT fk_tip_id FOREIGN KEY (idTip) REFERENCES Tip (idTip) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Avto ADD CONSTRAINT fk_barva_id FOREIGN KEY (idBarva) REFERENCES Barva (idBarva) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Avto ADD CONSTRAINT fk_poraba_id FOREIGN KEY (idPoraba) REFERENCES Poraba (idPoraba) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Avto ADD CONSTRAINT fk_gorivo_id FOREIGN KEY (idGorivo) REFERENCES Gorivo (idGorivo) ON DELETE CASCADE ON UPDATE CASCADE;
/*ALTER TABLE Avto ADD CONSTRAINT fk_cena_id FOREIGN KEY (idCena) REFERENCES Cena (idCena) ON DELETE CASCADE ON UPDATE CASCADE;*/

CREATE TABLE Narocnik (
	idNarocnik INT NOT NULL, 
    ime VARCHAR(30) NOT NULL,
    priimek VARCHAR(30) NOT NULL,
    idNaslov INT NOT NULL,
    idVozniskoDovoljenje INT NOT NULL
);

ALTER TABLE Narocnik ADD CONSTRAINT pk_narocnik_id PRIMARY KEY (idNarocnik);
ALTER TABLE Narocnik ADD CONSTRAINT fk_naslov_id  FOREIGN KEY (idNaslov) REFERENCES Naslov (idNaslov) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Narocnik ADD CONSTRAINT fk_vozniskoDovoljenje_id FOREIGN KEY (idVozniskoDovoljenje) REFERENCES VozniskoDovoljenje (idVozniskoDovoljenje) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE RegistrskaTablica (
	idRegistrska INT NOT NULL,
    registracija VARCHAR(30) NOT NULL,
    datumOd DATE NOT NULL,
    datumDo DATE NOT NULL,
    idAvto INT NOT NULL
);

ALTER TABLE RegistrskaTablica ADD CONSTRAINT pk_registrska_id PRIMARY KEY (idRegistrska);
ALTER TABLE RegistrskaTablica ADD CONSTRAINT fk_avto_id FOREIGN KEY (idAvto) REFERENCES Avto (idAvto) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE Opremljenost (
	idOpremljenost INT NOT NULL,
    idAvto INT NOT NULL,
    idDodatnaOprema INT NOT NULL
);

ALTER TABLE Opremljenost ADD CONSTRAINT pk_opremljenost_id PRIMARY KEY (idOpremljenost);
ALTER TABLE Opremljenost ADD CONSTRAINT fk_car_id FOREIGN KEY (idAvto) REFERENCES Avto (idAvto) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Opremljenost ADD CONSTRAINT fk_dodatnaoprema_id FOREIGN KEY (idDodatnaOprema) REFERENCES DodatnaOprema (idDodatnaOprema) ON DELETE CASCADE ON UPDATE CASCADE;


CREATE TABLE Izposoja (
	idIzposoja INT NOT NULL,
    stPrevozenihNarocnika INT NOT NULL,
    datumIzposoje DATE NOT NULL,
    datumVrnitve DATE NOT NULL,
    idAvto INT NOT NULL,
    idNarocnik INT NOT NULL,
    idCenik INT NOT NULL
);

ALTER TABLE Izposoja ADD CONSTRAINT pk_izposoja_id PRIMARY KEY (idIzposoja);
ALTER TABLE Izposoja ADD CONSTRAINT fk_avtek_id FOREIGN KEY (idAvto) REFERENCES Avto (idAvto) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Izposoja ADD CONSTRAINT fk_narocnikec_id FOREIGN KEY (idNarocnik) REFERENCES Narocnik (idNarocnik) ON DELETE CASCADE ON UPDATE CASCADE;
/*ALTER TABLE Izposoja ADD CONSTRAINT fk_cenik_id FOREIGN KEY (idCenik) REFERENCES Cena (idCenik) ON DELETE CASCADE ON UPDATE CASCADE;*/


CREATE TABLE Cenik (
	idCenik INT NOT NULL,
    cena DOUBLE NOT NULL
);

ALTER TABLE Cenik ADD CONSTRAINT pk_cenik_id PRIMARY KEY (idCenik);

CREATE TABLE Postavka (
	idPostavka INT NOT NULL,
    kolicina INT NOT NULL,
    idCenik INT NOT NULL
);

ALTER TABLE Postavka ADD CONSTRAINT pk_postavka_id PRIMARY KEY (idPostavka);
ALTER TABLE Postavka ADD CONSTRAINT fk_cenik_id FOREIGN KEY (idCenik) REFERENCES Cenik (idCenik) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE Racun (
	idRacun INT NOT NULL,
    stRacuna INT NOT NULL,
    idPostavka INT NOT NULL,
    idNarocnik INT NOT NULL
);

ALTER TABLE Racun ADD CONSTRAINT pk_racun_id PRIMARY KEY (idRacun);
ALTER TABLE Racun ADD CONSTRAINT fk_postavka_id FOREIGN KEY (idPostavka) REFERENCES Postavka (idPostavka) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Racun ADD CONSTRAINT fk_narocnik_id FOREIGN KEY (idNarocnik) REFERENCES Narocnik (idNarocnik) ON DELETE CASCADE ON UPDATE CASCADE;



/*DODAJANJE - INSERTI....pri navadnih 5, pri tujih 10 vnosov vsaj*/
INSERT INTO Kraj (idKraj, postnaStevilka, imePoste) VALUES (1, 9000, "Murska Sobota"); /*navadna*/
INSERT INTO Kraj (idKraj, postnaStevilka, imePoste) VALUES (2, 2000, "Maribor");
INSERT INTO Kraj (idKraj, postnaStevilka, imePoste) VALUES (3, 1000, "Ljubljana");
INSERT INTO Kraj (idKraj, postnaStevilka, imePoste) VALUES (4, 6000, "Koper");
INSERT INTO Kraj (idKraj, postnaStevilka, imePoste) VALUES (5, 4000, "Kranj");

INSERT INTO VozniskoDovoljenje(idVozniskoDovoljenje, stVozniskegaDovoljenja, veljaOd, veljaDo, upravnaEnota, emso) VALUES (1, 12345,"2000-06-15","2035-03-03", "Ljubljana",12839); /*navadna*/
INSERT INTO VozniskoDovoljenje(idVozniskoDovoljenje, stVozniskegaDovoljenja, veljaOd, veljaDo, upravnaEnota, emso) VALUES (2, 12245,"1996-03-12","2025-06-12", "Maribor",38473);
INSERT INTO VozniskoDovoljenje(idVozniskoDovoljenje, stVozniskegaDovoljenja, veljaOd, veljaDo, upravnaEnota, emso) VALUES (3, 12335,"2005-09-13","2031-01-07", "Ptuj",42946);
INSERT INTO VozniskoDovoljenje(idVozniskoDovoljenje, stVozniskegaDovoljenja, veljaOd, veljaDo, upravnaEnota, emso) VALUES (4, 12645,"2002-08-11","2037-02-09", "Koper",93846);
INSERT INTO VozniskoDovoljenje(idVozniskoDovoljenje, stVozniskegaDovoljenja, veljaOd, veljaDo, upravnaEnota, emso) VALUES (5, 12445,"1992-03-02","2022-05-18", "Celje",58372);

INSERT INTO Cenik(idCenik, cena) VALUES (1, 20.500); /*navadna*/
INSERT INTO Cenik(idCenik, cena) VALUES (2, 35.000);
INSERT INTO Cenik(idCenik, cena) VALUES (3, 12.000);
INSERT INTO Cenik(idCenik, cena) VALUES (4, 18.900);
INSERT INTO Cenik(idCenik, cena) VALUES (5, 22.300);

INSERT INTO Gorivo(idGorivo, vrstaGoriva) VALUES(1, "bencin95"); /*navadna*/
INSERT INTO Gorivo(idGorivo, vrstaGoriva) VALUES(2, "bencin98");
INSERT INTO Gorivo(idGorivo, vrstaGoriva) VALUES(3, "diesel");
INSERT INTO Gorivo(idGorivo, vrstaGoriva) VALUES(4, "plin");
INSERT INTO Gorivo(idGorivo, vrstaGoriva) VALUES(5, "elektrika");

INSERT INTO Barva(idBarva, barva) VALUES(1, "bela"); /*navadna*/
INSERT INTO Barva(idBarva, barva) VALUES(2, "črna");
INSERT INTO Barva(idBarva, barva) VALUES(3, "rdeča");
INSERT INTO Barva(idBarva, barva) VALUES(4, "zelena");
INSERT INTO Barva(idBarva, barva) VALUES(5, "modra");

INSERT INTO Poraba(idPoraba, kombiniranaVoznja, izvenMestnaVoznja, mestnaVoznja) VALUES (1,5.4,5.2,5.5); /*navadna*/
INSERT INTO Poraba(idPoraba, kombiniranaVoznja, izvenMestnaVoznja, mestnaVoznja) VALUES (2,5.3,5.1,5.8);
INSERT INTO Poraba(idPoraba, kombiniranaVoznja, izvenMestnaVoznja, mestnaVoznja) VALUES (3,5.2,5.1,5.6);
INSERT INTO Poraba(idPoraba, kombiniranaVoznja, izvenMestnaVoznja, mestnaVoznja) VALUES (4,5.3,5.2,5.4);
INSERT INTO Poraba(idPoraba, kombiniranaVoznja, izvenMestnaVoznja, mestnaVoznja) VALUES (5,5.5,5.2,5.7);

INSERT INTO Tip(idTip, tipAvtomobila) VALUES(1, "limuzina"); /*navadna*/
INSERT INTO Tip(idTip, tipAvtomobila) VALUES(2, "karavan"); 
INSERT INTO Tip(idTip, tipAvtomobila) VALUES(3, "terenec"); 
INSERT INTO Tip(idTip, tipAvtomobila) VALUES(4, "coupe"); 
INSERT INTO Tip(idTip, tipAvtomobila) VALUES(5, "oldtimer"); 

INSERT INTO DodatnaOprema(idDodatnaOprema, tipDoddatneOpreme) VALUES(1,"klima"); /*navadna*/
INSERT INTO DodatnaOprema(idDodatnaOprema, tipDoddatneOpreme) VALUES(2,"navigacija");
INSERT INTO DodatnaOprema(idDodatnaOprema, tipDoddatneOpreme) VALUES(3,"tempomat");
INSERT INTO DodatnaOprema(idDodatnaOprema, tipDoddatneOpreme) VALUES(4,"parkirnaKamera");
INSERT INTO DodatnaOprema(idDodatnaOprema, tipDoddatneOpreme) VALUES(5,"elPomikStekel");

INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (1, "Gosposvetska", 10, 1); /*tuji*/
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (2, "Trubarjeva", 5, 2);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (3, "Slovenska", 12, 3);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (4, "Cankarjeva", 7, 4);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (5, "Slomškova", 18, 5);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (6, "Kroška", 11, 1);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (7, "Panonska", 12, 2);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (8, "Ravenska", 19, 3);
INSERT INTO Naslov (idNaslov, ulica, hisnaStevilka, idKraj) VALUES (9, "Prešernova", 20, 4);

INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (1, "Andrej", "Gomboc",1,1); /*tuji*/
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (2, "Denis", "Kumin",2,2);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (3, "Marjan", "Šarec",3,3);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (4, "Urban", "Šket",4,4);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (5, "Jaka", "Kugler",5,5);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (6, "Luka", "Krajnc",6,1);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (7, "Klemen", "Roc",7,2);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (8, "Tilen", "Pavlovič",8,3);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (9, "Jure", "Magdič",9,4);
INSERT INTO Narocnik (idNarocnik, ime, priimek, idNaslov, idVozniskoDovoljenje) VALUES (10, "Timotej", "Novak",1,5);

INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (1,1,1); /*tuji*/
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (2,2,2);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (3,3,3);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (4,4,4);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (5,5,5);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (6,6,5);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (7,7,4);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (8,8,3);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (9,9,2);
INSERT INTO Postavka(idPostavka, kolicina, idCenik) VALUES (10,10,1);

INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (1, 1025,1,1); /*tuji*/
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (2, 1026,2,2);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (3, 1027,3,3);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (4, 1028,4,4);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (5, 1029,5,5);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (6, 1030,6,6);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (7, 1031,7,7);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (8, 1032,8,8);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (9, 1033,9,9);
INSERT INTO Racun(idRacun, stRacuna, idPostavka, idNarocnik) VALUES (10, 1034,10,10);

INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(1,"Renault Clio",2014,59.100,1,5,1,1,1); /*tuji*/
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(2,"Renault Laguna",2007,20.000,2,4,2,2,3);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(3,"Renault Twingo",2009,15.000,3,3,3,2,4);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(4,"Audi A4" ,2009,130.000,4,2,4,3,2);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(5,"Audi A8" ,2003,8.000,5,1,5,1,1);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(6,"Audi A6" ,2009,280.000,1,5,1,4,5);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(7,"Audi A5" ,2002,320.000,2,4,2,5,3);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(8,"Audi A3" ,2009,27.000,3,3,3,1,2);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(9, "Audi A2",2010,36.000,4,2,4,2,1);
INSERT INTO Avto(idAvto, ime, letnik, stPrevozenihKm, idTip, idBarva, idPoraba, idGorivo, idCena) VALUES(10,"Audi A1" ,2005,19.500,5,1,5,3,3);

INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(1,190,"2017-06-15","2017-06-18",1,10,1); /*tuji*/
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(2,40,"2017-08-12","2017-08-15",2,9,2);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(3,30,"2017-09-11","2017-09-13",3,8,3);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(4,85,"2017-02-15","2017-02-17",4,7,4);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(5,22,"2017-04-15","2017-04-18",5,6,5);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(6,11,"2017-06-15","2017-06-17",6,5,1);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(7,33,"2017-09-15","2017-09-18",7,4,2);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(8,55,"2017-01-10","2017-01-14",8,3,3);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(9,27,"2017-02-10","2017-02-13",8,2,4);
INSERT INTO Izposoja(idIzposoja, stPrevozenihNarocnika,datumIzposoje, datumVrnitve, idAvto, idNarocnik, idCenik) VALUES(10,38,"2017-04-15","2017-04-18",10,1,5);

INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(1,"MBRC663","2017-05-15","2018-05-15",1); /*tuji*/
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(2,"LJLJLJ","2017-04-17","2018-04-16",2);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(3,"GOGOGO","2017-02-11","2018-02-11",3);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(4,"LJLLJ","2017-01-10","2018-01-10",4);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(5,"MSMSMSM","2017-03-12","2018-03-12",5);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(6,"POPOPO","2017-04-15","2018-04-15",6);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(7,"KPKPKP","2017-02-15","2018-02-15",7);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(8,"SGSGSG","2017-06-16","2018-06-16",8);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(9,"MBMMMB","2017-04-04","2018-04-04",9);
INSERT INTO RegistrskaTablica(idRegistrska, registracija, datumOd, datumDo, idAvto) VALUES(10,"MSMMMS","2017-09-19","2018-09-19",10);

INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(1,10,1); /*tuji*/
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(2,9,1);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(3,8,2);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(4,7,2);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(5,6,3);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(6,5,3);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(7,4,2);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(8,3,4);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(9,2,4);
INSERT INTO Opremljenost(idOpremljenost, idAvto, idDodatnaOprema) VALUES(10,1,5);


/*VPRAŠANJA*/

/*Kolikšna je povprečna cena izposoje avtomobilov, ki so starejši od 3 let?*/
SELECT AVG(cena) FROM Izposoja
JOIN Avto ON Izposoja.idAvto = Avto.idAvto
JOIN Cenik ON Cenik.idCenik = Avto.idCena
WHERE letnik < YEAR(curdate()) - 3;

/*Katera stranka je do sedaj prevozila največ kilometrov z 'Renault Clio'*/
SELECT narocnik.ime, priimek, MAX(stPrevozenihNarocnika) FROM Narocnik
JOIN Izposoja ON Izposoja.idNarocnik = Narocnik.idNarocnik
JOIN Avto ON Izposoja.idAvto = Avto.idAvto
WHERE Avto.idAvto = (SELECT idAvto FROM Avto WHERE ime = "Renault Clio");

/*Koliko denarja smo zaračunali z izposojo v zadnjem mesecu?*/
SELECT SUM(cena) FROM Izposoja
JOIN Cenik ON Cenik.idCenik = Izposoja.idCenik
WHERE YEAR(datumVrnitve) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH) AND MONTH(datumVrnitve) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH);

/*Kateri avto je bil največkrat izposojen?*/
SELECT Avto.ime FROM Izposoja
JOIN Avto ON Izposoja.idAvto = Avto.idAvto
GROUP BY Izposoja.idAvto
HAVING COUNT(Izposoja.idAvto) =
(SELECT MAX(steviloizposoj) FROM
        (SELECT COUNT(Izposoja.idAvto) AS steviloizposoj
         FROM Izposoja
         GROUP BY Izposoja.idAvto) t1);
         
/*Spremeni registrsko številko avtomobila MBRC633 v MBRC663*/
UPDATE RegistrskaTablica SET registracija = "MBRC663" WHERE registracija = "MBRC633";

/*Izbriši naročnika z imenom 'Jože Kos'*/
DELETE FROM Narocnik WHERE ime='Jože' AND priimek='Kos';


/*PROŽILEC*/
DELIMITER &
CREATE TRIGGER spremeni_prevozene_km
AFTER UPDATE ON Izposoja
FOR EACH ROW
UPDATE Avto SET stPrevozenihKm = stPRevozenihKm + OLD.stPrevozenihNarocnika 
WHERE idAvto = OLD.idAvto
& DELIMITER ;