CREATE TABLE SYSADM.GRUPP (
  GR_NIMI VARCHAR(100) NOT NULL)
PCTFREE 10
/
INSERT INTO SYSADM.GRUPP VALUES(
    :1)
\
ADMINISTRAATOR,
OPERAATOR,
KAUBATUNDJA,
TELLIJA,
KOMPLEKTEERIJA,
LAOHOIDJA,
RAAMATUPIDAJA,
/
CREATE UNIQUE INDEX SYSADM.XGRUPP ON SYSADM.GRUPP(
  GR_NIMI)
PCTFREE 10
/
CREATE TABLE SYSADM.GRUPI_OIGUSED (
  ID INTEGER NOT NULL,
  NAME VARCHAR(100),
  GR_NIMI VARCHAR(100),
  OIGUSED VARCHAR(100),
  ALATES DATE,
  KUNI DATE)
PCTFREE 10
/
INSERT INTO SYSADM.GRUPI_OIGUSED VALUES(
    :1,
	:2,
	:3,
	:4,
	:5,
	:6)
\
1,ISIKU_LIIK,OPERAATOR,SELECT,2000-01-01,2050-01-01,
2,ISIKU_LIIK,OPERAATOR,INSERT,2000-01-01,2050-01-01,
3,ISIKU_LIIK,OPERAATOR,UPDATE,2000-01-01,2050-01-01,
4,ISIK,OPERAATOR,SELECT,2000-01-01,2050-01-01,
5,ISIK,OPERAATOR,INSERT,2000-01-01,2050-01-01,
6,ISIK,OPERAATOR,UPDATE,2000-01-01,2050-01-01,
/
CREATE UNIQUE INDEX SYSADM.XGRUPI_OIGUSED ON SYSADM.GRUPI_OIGUSED(
  ID)
PCTFREE 10
/
CREATE TABLE SYSADM.KASUTAJA_GRUPIS (
  ID INTEGER NOT NULL,
  NAME VARCHAR(100),
  GR_NIMI VARCHAR(100),
  ALATES DATE,
  KUNI DATE)
PCTFREE 10
/
INSERT INTO SYSADM.KASUTAJA_GRUPIS VALUES(
    :1,
	:2,
	:3,
	:4,
	:5)
\
1,kasutaja1,1,2000-01-01,2050-01-01,
2,kasutaja2,2,2000-01-01,2050-01-01,
3,kasutaja3,3,2000-01-01,2050-01-01,
4,kasutaja4,4,2000-01-01,2050-01-01,
5,kasutaja5,5,2000-01-01,2050-01-01,
6,kasutaja6,6,2000-01-01,2050-01-01,
7,kasutaja7,7,2000-01-01,2050-01-01,
8,kasutaja11,1,2000-01-01,2050-01-01,
9,kasutaja22,2,2000-01-01,2050-01-01,
10,kasutaja33,3,2000-01-01,2050-01-01,
11,kasutaja44,4,2000-01-01,2050-01-01,
12,kasutaja55,5,2000-01-01,2050-01-01,
13,kasutaja66,6,2000-01-01,2050-01-01,
14,kasutaja77,7,2000-01-01,2050-01-01,
/
CREATE UNIQUE INDEX SYSADM.XKASUTAJA_GRUPIS ON SYSADM.KASUTAJA_GRUPIS(
  ID)
PCTFREE 10
/
ALTER TABLE SYSADM.GRUPP PRIMARY KEY (
  GR_NIMI)
/
ALTER TABLE SYSADM.GRUPI_OIGUSED PRIMARY KEY (
	ID)
/
ALTER TABLE SYSADM.KASUTAJA_GRUPIS PRIMARY KEY (
	ID)
/
SET REFINTCHECK ON
/
SET REFINTCHECK OFF
/
ALTER TABLE SYSADM.GRUPI_OIGUSED FOREIGN KEY FK01 (
  GR_NIMI) REFERENCES SYSADM.GRUPP ON DELETE RESTRICT
/
ALTER TABLE SYSADM.KASUTAJA_GRUPIS FOREIGN KEY FK02 (
  GR_NIMI) REFERENCES SYSADM.GRUPP ON DELETE RESTRICT
/