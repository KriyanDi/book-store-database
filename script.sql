-- creating tables --

CREATE TABLE BOOK
(
    SKU        INTEGER  NOT NULL UNIQUE,
    BARCODE    CHAR(12) NOT NULL UNIQUE,
    PRICE      DECIMAL(9, 2),
    STORGQUANT INTEGER,
    CATEGORY   CHAR(10),
    VENDORID   INTEGER,
    GENRE      CHAR(10),
    TITLE      VARCHAR(50),
    AUTHOR     VARCHAR(50),
    LANGUAGE   VARCHAR(50),
    PUBLISHER  VARCHAR(50),
    NUMOFPAGES INTEGER
);

CREATE TABLE NOTEBOOK
(
    SKU         INTEGER  NOT NULL UNIQUE,
    BARCODE     CHAR(12) NOT NULL UNIQUE,
    PRICE       DECIMAL(9, 2),
    STORGQUANT  INTEGER,
    CATEGORY    CHAR(10),
    VENDORID    INTEGER,
    TYPE        VARCHAR(50),
    FORMAT      CHAR(3),
    RECYCLPAPER CHAR(1),
    NUMOFPAGES  INTEGER
);

CREATE TABLE PEN
(
    SKU        INTEGER  NOT NULL UNIQUE,
    BARCODE    CHAR(12) NOT NULL UNIQUE,
    PRICE      DECIMAL(9, 2),
    STORGQUANT INTEGER,
    CATEGORY   CHAR(10),
    VENDORID   INTEGER,
    SIZE       DECIMAL(9, 2),
    COLOUR     CHAR(10)
);

CREATE TABLE PENCIL
(
    SKU        INTEGER  NOT NULL UNIQUE,
    BARCODE    CHAR(12) NOT NULL UNIQUE,
    PRICE      DECIMAL(9, 2),
    STORGQUANT INTEGER,
    CATEGORY   CHAR(10),
    VENDORID   INTEGER,
    TYPE       CHAR(4),
    ERASER     CHAR(1),
    COLOUR     CHAR(10)
);

CREATE TABLE ALLSKU
(
    SKU INTEGER NOT NULL UNIQUE
);

CREATE TABLE ORDER
(
    ORDERNO CHAR(6) NOT NULL,
    STATUS  CHAR(15),
    CARDNO  INTEGER
);

CREATE TABLE ADDRESS
(
    ID            INTEGER  NOT NULL,
    COUNTRY       CHAR(20) NOT NULL,
    CITY          CHAR(20) NOT NULL,
    NEIGHBOURHOOD CHAR(20) NOT NULL,
    STREET        CHAR(20) NOT NULL,
    APARTMENTNO   INTEGER,
    POSTALCODE    INTEGER
);

CREATE TABLE PAYMENT
(
    CARDNO      INTEGER  NOT NULL,
    CARDTYPE    CHAR(20),
    CARDHOLDERN CHAR(30),
    CARDHOLDERS CHAR(30) NOT NULL,
    CARDEXPIRED DATE
);

CREATE TABLE MEMBER
(
    EMAIL     CHAR(30) NOT NULL UNIQUE,
    NAME      CHAR(30) NOT NULL,
    SURNAME   CHAR(30) NOT NULL,
    PASSWORD  CHAR(16) NOT NULL,
    IDADDRESS INTEGER
);

CREATE TABLE BASKET
(
    ID         INTEGER NOT NULL,
    TOTALPRICE DECIMAL(9, 2),
    ORDERNO    CHAR(6),
    CARDNO     INTEGER,
    EMAIL      CHARACTER(30),
    SKU        INTEGER,
    QUANTITY   INTEGER
);

CREATE TABLE VENDOR
(
    ID          INTEGER  NOT NULL,
    EMAIL       CHAR(40),
    FIRSTNAME   CHAR(12),
    LASTNAME    CHAR(12),
    PHONE       CHAR(10),
    COMPANYNAME CHAR(15) NOT NULL,
    URL         CHAR(32)
);

CREATE TABLE VENDORADDRESS
(
    ID        INTEGER NOT NULL,
    IDVENDOR  INTEGER,
    IDADDRESS INTEGER
);