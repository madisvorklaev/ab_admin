SET SERVER SERVER1;
CREATE DATABASE TARNE;
CONNECT TARNE;
GRANT CONNECT TO SYSADM IDENTIFIED BY salalukk;


CREATE TABLE Isiku_liik (
       Isiku_liigi_ID       SMALLINT NOT NULL,
       Nimetus              VARCHAR(60) NOT NULL,
       Fyys_jur_isik        VARCHAR(1) NOT NULL,
       Avatud               DATETIME NOT NULL,
       Suletud              DATETIME
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKIsiku_liik ON Isiku_liik
(
       Isiku_liigi_ID
)
SIZE 100 ROWS;


ALTER TABLE Isiku_liik
       PRIMARY KEY (Isiku_liigi_ID);


CREATE TABLE Isik (
       Isiku_ID             SMALLINT NOT NULL,
       Isiku_liigi_ID       SMALLINT NOT NULL,
       Kood                 VARCHAR(15) NOT NULL,
       Nimi                 VARCHAR(35) NOT NULL,
       Eesnimi              VARCHAR(15),
       Kasutajanimi         VARCHAR(32),
       Aadress              VARCHAR(100),
       Pangakaardi_tyyp     VARCHAR(6),
       Pangakaardi_nr       VARCHAR(20),
       Avatud               DATETIME NOT NULL,
       Suletud              DATETIME
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKIsik ON Isik
(
       Isiku_ID
)
SIZE 100 ROWS;

CREATE INDEX XIF14Isik ON Isik
(
       Isiku_liigi_ID                 ASC
);


ALTER TABLE Isik
       PRIMARY KEY (Isiku_ID);


CREATE TABLE Arve (
       Arve_ID              SMALLINT NOT NULL,
       Ostja_ID             SMALLINT NOT NULL,
       Myyja_ID             SMALLINT NOT NULL,
       Number               VARCHAR(10) NOT NULL,
       Tellimuse_kuupaev    DATETIME NOT NULL,
       Soodustuse_prots     SMALLINT,
       Komplekteerimise_k   DATETIME,
       Makse_kuup           DATETIME,
       Saatmise_kuup        DATETIME,
       Kattesaamise_kuup    DATETIME
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKArve ON Arve
(
       Arve_ID
)
SIZE 100 ROWS;

CREATE INDEX XIF11Arve ON Arve
(
       Ostja_ID                       ASC
);

CREATE INDEX XIF12Arve ON Arve
(
       Myyja_ID                       ASC
);


ALTER TABLE Arve
       PRIMARY KEY (Arve_ID);


CREATE TABLE Kaubagrupp (
       Kaubagrupi_ID        SMALLINT NOT NULL,
       Kaubagrupi_nimetus   VARCHAR(60) NOT NULL
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKKaubagrupp ON Kaubagrupp
(
       Kaubagrupi_ID
)
SIZE 100 ROWS;


ALTER TABLE Kaubagrupp
       PRIMARY KEY (Kaubagrupi_ID);


CREATE TABLE Kaup (
       Kauba_ID             SMALLINT NOT NULL,
       Kaubagrupi_ID        SMALLINT NOT NULL,
       Kauba_nimetus        VARCHAR(60) NOT NULL,
       Yhik                 VARCHAR(10) NOT NULL,
       Avatud               DATETIME NOT NULL,
       Suletud              DATETIME
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKKaup ON Kaup
(
       Kauba_ID
)
SIZE 100 ROWS;

CREATE INDEX XIF1Kaup ON Kaup
(
       Kaubagrupi_ID                  ASC
);


ALTER TABLE Kaup
       PRIMARY KEY (Kauba_ID);


CREATE TABLE Tellimus_tarni (
       Tarnija_tellimuse_   SMALLINT NOT NULL,
       Tarnija_ID           SMALLINT NOT NULL,
       Isiku_ID             SMALLINT NOT NULL,
       Tellimuse_number     VARCHAR(10) NOT NULL,
       Tellimuse_kuup       DATETIME NOT NULL,
       Avatud               DATETIME NOT NULL,
       Suletud              DATETIME
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKTellimus_tarni ON Tellimus_tarni
(
       Tarnija_tellimuse_
)
SIZE 100 ROWS;

CREATE INDEX XIF4Tellimus_tarni ON Tellimus_tarni
(
       Isiku_ID                       ASC
);

CREATE INDEX XIF7Tellimus_tarni ON Tellimus_tarni
(
       Tarnija_ID                     ASC
);


ALTER TABLE Tellimus_tarni
       PRIMARY KEY (Tarnija_tellimuse_);


CREATE TABLE Tarne (
       Tarne_ID             SMALLINT NOT NULL,
       Isiku_ID             SMALLINT NOT NULL,
       Tarnija_tellimuse_   SMALLINT,
       Tarne_nr             VARCHAR(10) NOT NULL,
       Tarne_kuup           DATETIME NOT NULL
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKTarne ON Tarne
(
       Tarne_ID
)
SIZE 100 ROWS;

CREATE INDEX XIF5Tarne ON Tarne
(
       Isiku_ID                       ASC
);

CREATE INDEX XIF6Tarne ON Tarne
(
       Tarnija_tellimuse_             ASC
);


ALTER TABLE Tarne
       PRIMARY KEY (Tarne_ID);


CREATE TABLE Kauba_liikumi (
       Kauba_liikumise_ID   SMALLINT NOT NULL,
       Arve_ID              SMALLINT,
       Kauba_ID             SMALLINT NOT NULL,
       Tarne_ID             SMALLINT,
       Kogus                FLOAT NOT NULL,
       Hind                 DECIMAL NOT NULL
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKKauba_liikumi ON Kauba_liikumi
(
       Kauba_liikumise_ID
)
SIZE 100 ROWS;

CREATE INDEX XIF10Kauba_liikumi ON Kauba_liikumi
(
       Kauba_ID                       ASC
);

CREATE INDEX XIF13Kauba_liikumi ON Kauba_liikumi
(
       Arve_ID                        ASC
);

CREATE INDEX XIF9Kauba_liikumi ON Kauba_liikumi
(
       Tarne_ID                       ASC
);


ALTER TABLE Kauba_liikumi
       PRIMARY KEY (Kauba_liikumise_ID);


CREATE TABLE Tarnija_tellim (
       Tarnija_tellimuse_   SMALLINT NOT NULL,
       Kauba_ID             SMALLINT NOT NULL,
       kogus                FLOAT NOT NULL
);

CREATE UNIQUE CLUSTERED HASHED INDEX XPKTarnija_tellim ON Tarnija_tellim
(
       Tarnija_tellimuse_
)
SIZE 100 ROWS;

CREATE INDEX XIF3Tarnija_tellim ON Tarnija_tellim
(
       Kauba_ID                       ASC
);


ALTER TABLE Tarnija_tellim
       PRIMARY KEY (Tarnija_tellimuse_);


ALTER TABLE Isik
       FOREIGN KEY R_14 (Isiku_liigi_ID)
                             REFERENCES Isiku_liik
                             ON DELETE RESTRICT;


ALTER TABLE Arve
       FOREIGN KEY R_12 (Ostja_ID)
                             REFERENCES Isik
                             ON DELETE RESTRICT;


ALTER TABLE Arve
       FOREIGN KEY R_11 (Myyja_ID)
                             REFERENCES Isik
                             ON DELETE RESTRICT;


ALTER TABLE Kaup
       FOREIGN KEY R_1 (Kaubagrupi_ID)
                             REFERENCES Kaubagrupp
                             ON DELETE RESTRICT;


ALTER TABLE Tellimus_tarni
       FOREIGN KEY R_7 (Tarnija_ID)
                             REFERENCES Isik
                             ON DELETE RESTRICT;


ALTER TABLE Tellimus_tarni
       FOREIGN KEY R_4 (Isiku_ID)
                             REFERENCES Isik
                             ON DELETE RESTRICT;


ALTER TABLE Tarne
       FOREIGN KEY R_6 (Tarnija_tellimuse_)
                             REFERENCES Tellimus_tarni
                             ON DELETE SET NULL;


ALTER TABLE Tarne
       FOREIGN KEY R_5 (Isiku_ID)
                             REFERENCES Isik
                             ON DELETE RESTRICT;


ALTER TABLE Kauba_liikumi
       FOREIGN KEY R_13 (Arve_ID)
                             REFERENCES Arve
                             ON DELETE SET NULL;


ALTER TABLE Kauba_liikumi
       FOREIGN KEY R_10 (Kauba_ID)
                             REFERENCES Kaup
                             ON DELETE RESTRICT;


ALTER TABLE Kauba_liikumi
       FOREIGN KEY R_9 (Tarne_ID)
                             REFERENCES Tarne
                             ON DELETE SET NULL;


ALTER TABLE Tarnija_tellim
       FOREIGN KEY R_3 (Kauba_ID)
                             REFERENCES Kaup
                             ON DELETE RESTRICT;


ALTER TABLE Tarnija_tellim
       FOREIGN KEY R_2 (Tarnija_tellimuse_)
                             REFERENCES Tellimus_tarni
                             ON DELETE RESTRICT;





