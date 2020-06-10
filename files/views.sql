CREATE VIEW V_BOOK_GENRE_COMEDY
AS
SELECT *
FROM BOOK
WHERE GENRE = 'comedy';

CREATE VIEW V_BOOK_GENRE_DRAMA
AS
SELECT *
FROM BOOK
WHERE GENRE = 'drama';

CREATE VIEW V_BOOK_GENRE_THRILLER
AS
SELECT *
FROM BOOK
WHERE GENRE = 'thriller';

CREATE VIEW V_BOOK_GENRE_FANTASY
AS
SELECT *
FROM BOOK
WHERE GENRE = 'fantasy';

CREATE VIEW V_ORDER_PRODUCTS_INFO
AS
SELECT O.ORDERNO,
       T.BARCODE,
       T.CATEGORY,
       T.SINGLEPRICE,
       B.TOTALPRICE,
       B.QUANTITY
FROM ORDER AS O
         INNER JOIN BASKET B on O.ORDERNO = B.ORDERNO,
     TABLE(FN45419.GET_PROD_INFO(B.SKU)) AS T;

CREATE VIEW V_ALL_PROD_SKU_CATEGORY
AS
SELECT SKU, CATEGORY
FROM BOOK

UNION
SELECT SKU, CATEGORY
FROM NOTEBOOK

UNION
SELECT SKU, CATEGORY
FROM PEN

UNION
SELECT SKU, CATEGORY
FROM PENCIL;

CREATE VIEW V_MEMBER_INFO (EMAIL, FIRSTNAME, SURNAME, NUM_ORDERS, TOTAL_AMT_SPENT)
AS
SELECT MEMBER.EMAIL, MEMBER.NAME, MEMBER.SURNAME, FN45419.COUNT_ORD_BY_MEMBER(MEMBER.EMAIL), FN45419.AMT_MONEY_SPENT(MEMBER.EMAIL)
    FROM MEMBER
    GROUP BY (MEMBER.EMAIL, MEMBER.NAME, MEMBER.SURNAME);

CREATE VIEW V_NUM_BOOKS_PER_GENRE(GENRE, NUMBER_PER_GENRE) AS
SELECT GENRE, COUNT(*)
FROM BOOK
GROUP BY (GENRE);

CREATE VIEW V_NUM_BOOKS_PER_VENDOR(VENDORID, NUMBER_PER_VENDOR) AS
SELECT VENDORID, COUNT(*)
FROM BOOK
GROUP BY (VENDORID);

CREATE VIEW V_MOST_COMMON_VENDOR_INFO(ID, EMAIL, FIRSTNAME, LASTNAME, PHONE, COMPANY, URL) AS
    SELECT*
        FROM VENDOR
        WHERE VENDOR.ID IN (SELECT VENDORID FROM V_NUM_BOOKS_PER_VENDOR WHERE NUMBER_PER_VENDOR = (SELECT MAX(NUMBER_PER_VENDOR)
                                                                                                FROM V_NUM_BOOKS_PER_VENDOR));