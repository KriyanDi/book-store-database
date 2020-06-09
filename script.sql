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

-- setting keys and checks --

-- BOOK --
ALTER TABLE BOOK
    ADD CONSTRAINT PK_BOOK PRIMARY KEY (SKU);

ALTER TABLE BOOK
    ADD CONSTRAINT FK_BOOK_VENDORID FOREIGN KEY (VENDORID)
        REFERENCES VENDOR (ID);

ALTER TABLE BOOK
    ADD CONSTRAINT CH_BARCODE CHECK (LENGTH(BARCODE) = 12);

ALTER TABLE BOOK
    ADD CONSTRAINT CH_CATEGORY CHECK (CATEGORY IN ('book'));

-- NOTEBOOK --
ALTER TABLE NOTEBOOK
    ADD CONSTRAINT PK_NOTEBOOK PRIMARY KEY (SKU);

ALTER TABLE NOTEBOOK
    ADD CONSTRAINT FK_NOTEBOOK_VENDOR_ID FOREIGN KEY (VENDORID)
        REFERENCES VENDOR (ID);

ALTER TABLE NOTEBOOK
    ADD CONSTRAINT CH_BARCODE CHECK (LENGTH(BARCODE) = 12);

ALTER TABLE NOTEBOOK
    ADD CONSTRAINT CH_CATEGORY CHECK (CATEGORY IN ('notebook'));

ALTER TABLE NOTEBOOK
    ADD CONSTRAINT CH_FORMAT CHECK (FORMAT IN ('A2', 'A3', 'A4', 'A5', 'A6'));

ALTER TABLE NOTEBOOK
    ADD CONSTRAINT CH_RECYCLPAPER CHECK (RECYCLPAPER IN ('y', 'n'));

-- PEN --
ALTER TABLE PEN
    ADD CONSTRAINT PK_PEN PRIMARY KEY (SKU);

ALTER TABLE PEN
    ADD CONSTRAINT FK_PEN_VENDOR_ID FOREIGN KEY (VENDORID)
        REFERENCES VENDOR (ID);

ALTER TABLE PEN
    ADD CONSTRAINT CH_BARCODE CHECK (LENGTH(BARCODE) = 12);

ALTER TABLE PEN
    ADD CONSTRAINT CH_CATEGORY CHECK (CATEGORY IN ('pen'));

-- PENCIL --
ALTER TABLE PENCIL
    ADD CONSTRAINT PK_PENCIL PRIMARY KEY (SKU); 

ALTER TABLE PENCIL
    ADD CONSTRAINT FK_PENCIL_VENDOR_ID FOREIGN KEY (VENDORID)
        REFERENCES VENDOR (ID);

ALTER TABLE PENCIL
    ADD CONSTRAINT CH_BARCODE CHECK (LENGTH(BARCODE) = 12);

ALTER TABLE PENCIL
    ADD CONSTRAINT CH_CATEGORY CHECK (CATEGORY IN ('pencil'));

ALTER TABLE PENCIL
    ADD CONSTRAINT CH_ERASER CHECK (ERASER IN ('y', 'n'));

-- ALLSKU --
ALTER TABLE ALLSKU
    ADD CONSTRAINT PK_ALLSKU PRIMARY KEY (SKU);

-- ORDER --
ALTER TABLE ORDER
    ADD CONSTRAINT PK_ORDER PRIMARY KEY (ORDERNO);

ALTER TABLE ORDER
    ADD CONSTRAINT FK_ORDER_PAYMENT FOREIGN KEY (CARDNO)
        REFERENCES PAYMENT (CARDNO);

-- MEMBER --
ALTER TABLE MEMBER
    ADD CONSTRAINT PK_MEMBER PRIMARY KEY (EMAIL);

ALTER TABLE MEMBER
    ADD CONSTRAINT FK_MEMBER_ADDRESS FOREIGN KEY (IDADDRESS)
        REFERENCES ADDRESS (ID);

ALTER TABLE MEMBER
    ADD CONSTRAINT CH_EMAIL CHECK (EMAIL LIKE '%_@%_.%_');

-- PAYMENT --
ALTER TABLE PAYMENT
    ADD CONSTRAINT PK_PAYMENT PRIMARY KEY (CARDNO);

-- ADDRESS --
ALTER TABLE ADDRESS
    ADD CONSTRAINT PK_ADDRESS PRIMARY KEY (ID);

ALTER TABLE ADDRESS
    ADD CONSTRAINT CH_ID CHECK (ID > 0);

ALTER TABLE ADDRESS
    ADD CONSTRAINT CH_APARTAMENTNO CHECK (APARTMENTNO > 0);

ALTER TABLE ADDRESS
    ADD CONSTRAINT CH_POSTALCODE CHECK (POSTALCODE > 0);

-- BASKET --
ALTER TABLE BASKET
    ADD CONSTRAINT PK_BASKET PRIMARY KEY (ID);

ALTER TABLE BASKET
    ADD CONSTRAINT FK_BASKET_ORDER FOREIGN KEY (ORDERNO)
        REFERENCES ORDER (ORDERNO);

ALTER TABLE BASKET
    ADD CONSTRAINT FK_BASKET_PAYMENT FOREIGN KEY (CARDNO)
        REFERENCES PAYMENT (CARDNO);

ALTER TABLE BASKET
    ADD CONSTRAINT FK_BASKET_PRODUCT FOREIGN KEY (SKU)
        REFERENCES ALLSKU (SKU);

ALTER TABLE BASKET
    ADD CONSTRAINT FK_BASKET_MEMBER FOREIGN KEY (EMAIL)
    REFERENCES MEMBER(EMAIL);  

ALTER TABLE BASKET
    ADD CONSTRAINT CH_TOTALPRICE CHECK (TOTALPRICE > 0);     

-- VENDOR --
ALTER TABLE VENDOR
    ADD CONSTRAINT PK_VENDOR PRIMARY KEY (ID);

ALTER TABLE VENDOR
    ADD CONSTRAINT CH_EMAIL CHECK (EMAIL LIKE '%_@%_.%_');

-- VENDORADDRESS
ALTER TABLE VENDORADDRESS
    ADD CONSTRAINT PK_VENDORADDRESS PRIMARY KEY (ID);

ALTER TABLE VENDORADDRESS
    ADD CONSTRAINT FK_VENDORADDRESS_VENDOR FOREIGN KEY (IDVENDOR)
        REFERENCES VENDOR (ID);

ALTER TABLE VENDORADDRESS
    ADD CONSTRAINT FK_VENDORADDRESS_ADDRESS FOREIGN KEY (IDADDRESS)
        REFERENCES ADDRESS (ID);

-- triggers --

-- BOOK --
CREATE TRIGGER AINS_BOOK
    AFTER INSERT
    ON BOOK
    REFERENCING NEW AS N
    FOR EACH ROW
    INSERT INTO ALLSKU
    VALUES (N.SKU);

CREATE TRIGGER AUPD_BOOK
    AFTER UPDATE OF SKU
    ON BOOK
    REFERENCING OLD AS O NEW AS N
    FOR EACH ROW
    UPDATE ALLSKU AS ALSK
    SET ALSK.SKU = N.SKU
    WHERE SKU = N.SKU;

CREATE TRIGGER ADEL_BOOK
    AFTER DELETE
    ON BOOK
    REFERENCING OLD AS O
    FOR EACH ROW
    DELETE
    FROM ALLSKU AS ALSK
    WHERE SKU = O.SKU;

CREATE TRIGGER UPDATE_PROD_QUANTITY_BOOK
    AFTER UPDATE OF STORGQUANT
    ON BOOK
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN (N.STORGQUANT = 0)
    UPDATE BOOK
    SET STORGQUANT = 9
    WHERE SKU = N.SKU;

-- NOTEBOOK --
CREATE TRIGGER AINS_NOTEBOOK
    AFTER INSERT
    ON NOTEBOOK
    REFERENCING NEW AS N
    FOR EACH ROW
    INSERT INTO ALLSKU
    VALUES (N.SKU);

CREATE TRIGGER AUPD_NOTEBOOK
    AFTER UPDATE OF SKU
    ON NOTEBOOK
    REFERENCING OLD AS O NEW AS N
    FOR EACH ROW
    UPDATE ALLSKU AS ALSK
    SET ALSK.SKU = N.SKU
    WHERE SKU = N.SKU;

CREATE TRIGGER ADEL_NOTEBOOK
    AFTER DELETE
    ON NOTEBOOK
    REFERENCING OLD AS O
    FOR EACH ROW
    DELETE
    FROM ALLSKU AS ALSK
    WHERE SKU = O.SKU;

CREATE TRIGGER UPDATE_PROD_QUANTITY_NOTEBOOK
    AFTER UPDATE OF STORGQUANT
    ON NOTEBOOK
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN (N.STORGQUANT = 0)
    UPDATE NOTEBOOK
    SET STORGQUANT = 9
    WHERE SKU = N.SKU;

-- PEN --
CREATE TRIGGER AINS_PEN
    AFTER INSERT
    ON PEN
    REFERENCING NEW AS N
    FOR EACH ROW
    INSERT INTO ALLSKU
    VALUES (N.SKU);

CREATE TRIGGER AUPD_PEN
    AFTER UPDATE OF SKU
    ON PEN
    REFERENCING OLD AS O NEW AS N
    FOR EACH ROW
    UPDATE ALLSKU AS ALSK
    SET ALSK.SKU = N.SKU
    WHERE SKU = N.SKU;

CREATE TRIGGER ADEL_PEN
    AFTER DELETE
    ON PEN
    REFERENCING OLD AS O
    FOR EACH ROW
    DELETE
    FROM ALLSKU AS ALSK
    WHERE SKU = O.SKU;

CREATE TRIGGER UPDATE_PROD_QUANTITY_PEN
    AFTER UPDATE OF STORGQUANT
    ON PEN
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN (N.STORGQUANT = 0)
    UPDATE PEN
    SET STORGQUANT = 9
    WHERE SKU = N.SKU;

-- PENCIL --
CREATE TRIGGER AINS_PENCIL
    AFTER INSERT
    ON PENCIL
    REFERENCING NEW AS N
    FOR EACH ROW
    INSERT INTO ALLSKU
    VALUES (N.SKU);

CREATE TRIGGER AUPD_PENCIL
    AFTER UPDATE OF SKU
    ON PENCIL
    REFERENCING OLD AS O NEW AS N
    FOR EACH ROW
    UPDATE ALLSKU AS ALSK
    SET ALSK.SKU = N.SKU
    WHERE SKU = N.SKU;

CREATE TRIGGER ADEL_PENCIL
    AFTER DELETE
    ON PENCIL
    REFERENCING OLD AS O
    FOR EACH ROW
    DELETE
    FROM ALLSKU AS ALSK
    WHERE SKU = O.SKU;

CREATE TRIGGER UPDATE_PROD_QUANTITY_PENCIL
    AFTER UPDATE OF STORGQUANT
    ON PENCIL
    REFERENCING NEW AS N
    FOR EACH ROW
    WHEN (N.STORGQUANT = 0)
    UPDATE PENCIL
    SET STORGQUANT = 9
    WHERE SKU = N.SKU;

-- MEMBER --
CREATE TRIGGER ADEL_MEMBER
    AFTER DELETE
    ON MEMBER
    REFERENCING OLD AS O
    FOR EACH ROW
BEGIN
    ATOMIC
    DECLARE VAR_PEOPLE_ON_ADDRESS INTEGER;

    SET VAR_PEOPLE_ON_ADDRESS = FN45419.NUM_OF_PEOPLE(O.IDADDRESS);


    IF VAR_PEOPLE_ON_ADDRESS = 0 THEN
        DELETE
        FROM ADDRESS AS A
        WHERE A.ID = O.IDADDRESS;
    END IF;
END;

-- VENDOR --
CREATE TRIGGER ADEL_VENDOR
    AFTER DELETE
    ON VENDOR
    REFERENCING OLD AS O
    FOR EACH ROW
BEGIN
    ATOMIC
    DECLARE VAR_VENDOR_IDADDRESS INTEGER;
    DECLARE VAR_PEOPLE_ON_ADDRESS INTEGER;

    SET VAR_VENDOR_IDADDRESS = (SELECT IDADDRESS FROM VENDORADDRESS WHERE IDVENDOR = O.ID);
    SET VAR_PEOPLE_ON_ADDRESS = FN45419.NUM_OF_PEOPLE(VAR_VENDOR_IDADDRESS);

    IF VAR_PEOPLE_ON_ADDRESS = 0 THEN
        DELETE
        FROM ADDRESS AS A
        WHERE A.ID = VAR_VENDOR_IDADDRESS;
    END IF;
END;

-- inserts --

-- ADDRESS --
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (1, 'Burkina Faso', 'Kaya', 'Mallory', 'Monument', 87, 8516);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (2, 'China', 'Zhaobei', 'Fisk', 'Sunbrook', 9, 3600);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (3, 'Czech Republic', 'Zásmuky', 'Vera', 'Kings', 94, 9084);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (4, 'France', 'Suresnes', 'Algoma', 'Leroy', 59, 8123);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (5, 'Indonesia', 'Bomomani', 'Chive', 'Hayes', 30, 8786);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (6, 'Portugal', 'Casal', 'David', 'Leroy', 73, 1861);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (7, 'Philippines', 'Agdangan', 'Kingsford', 'Laurel', 38, 2452);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (8, 'China', 'Qiaobian', 'Lunder', 'Stuart', 65, 8614);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (9, 'China', 'Erling', 'Monument', 'Oak', 2, 7019);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (10, 'China', 'Huichang', 'Artisan', 'Eastlawn', 61, 4027);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (11, 'Indonesia', 'Cihaurbeuti', 'Orin', 'Hintze', 26, 3047);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (12, 'Finland', 'Virojoki', 'Myrtle', 'Ruskin', 80, 7638);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (13, 'Indonesia', 'Sambirobyong', 'Hagan', 'Homewood', 99, 3829);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (14, 'China', 'Xingshou', 'Heath', '2nd', 58, 8018);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (15, 'Philippines', 'Bato', '4th', 'Kinsman', 64, 7254);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (16, 'Sweden', 'Borlänge', 'Homewood', 'Atwood', 76, 5467);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (17, 'Philippines', 'Bagroy', 'Shopko', 'Randy', 51, 5561);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (18, 'Croatia', 'Soljani', 'Meadow Valley', 'Rowland', 45, 4957);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (19, 'China', 'Shadui', 'International', 'Maple', 33, 1044);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (20, 'Sweden', 'Haninge', 'Mcguire', 'Waxwing', 52, 7811);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (21, 'North Korea', 'Sunan', 'Dorton', 'Amoth', 97, 9325);
insert into ADDRESS (ID, COUNTRY, CITY, NEIGHBOURHOOD, STREET, APARTMENTNO, POSTALCODE) values (22, 'Indonesia', 'Kokop', 'Golf Course', 'Boyd', 18, 4901);

-- VENDOR --
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (1, 'Stacey', 'Ducroe', 'stacey.ducroe@booking.com', '1095811650', 'Flashpoint', 'https://nyu.edu');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (2, 'Melisent', 'Yokel', 'melisent.yokel@posterous.com', '2248593602', 'Photobug', 'https://harvard.edu');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (3, 'Graehme', 'Dyott', 'graehme.dyott@mayoclinic.com', '3125157202', 'Geba', 'https://bloglovin.com');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (4, 'Fayre', 'Neaves', 'fayre.neaves@google.it', '1379764494', 'Brainlounge', 'http://java.com');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (5, 'Kari', 'Seaman', 'kari.seaman@hhs.gov', '9508548768', 'Eabox', 'https://aboutads.info');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (6, 'Daveen', 'Cawsy', 'daveen.cawsy@yolasite.com', '1515985383', 'Layo', 'https://zimbio.com');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (7, 'Brien', 'Kilmartin', 'brien.kilmartin@163.com', '7108191821', 'Eidel', 'https://edublogs.org');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (8, 'Uri', 'Adamo', 'uri.adamo@squidoo.com', '7047678729', 'Janyx', 'https://twitter.com');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (9, 'Matt', 'Kundt', 'matt.kundt@printfriendly.com', '6448554533', 'Kwilith', 'http://springer.com');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (10, 'Nelle', 'Sherrock', 'nelle.sherrock@usda.gov', '5427599780', 'InnoZ', 'http://ted.com');
insert into VENDOR (ID, FIRSTNAME, LASTNAME, EMAIL, PHONE, COMPANYNAME, URL) values (11, 'Nichole', 'Sokill', 'nichole.sokill@google.ca', '6079296805', 'Trupe', 'http://dell.com');
