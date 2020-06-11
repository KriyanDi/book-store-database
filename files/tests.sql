-- VIEWS --
SELECT *
FROM V_BOOK_GENRE_COMEDY;

SELECT *
FROM V_BOOK_GENRE_DRAMA;

SELECT *
FROM V_BOOK_GENRE_FANTASY;

SELECT *
FROM V_BOOK_GENRE_THRILLER;

SELECT *
FROM V_ALL_PROD_SKU_CATEGORY;

SELECT T.*
FROM V_ORDER_PRODUCTS_INFO AS T
ORDER BY T.ORDERNO;

SELECT * 
FROM FN45419.V_MEMBER_INFO;

SELECT *
FROM V_VENDOR_FOR_CLIENT_VIEW;

SELECT *
FROM V_BOOK_GENRE_ACTION;

SELECT *
FROM V_BOOK_GENRE_ADVENTURE;

SELECT *
FROM V_BOOK_GENRE_HORROR;

-- FUNCTIONS --

SELECT *
FROM TABLE(FN45419.GET_PROD_INFO(100119));

SELECT FN45419.ORD_STAT_INFO(ORDERNO)
FROM ORDER;

SELECT DISTINCT FN45419.ORD_STAT_INFO('22')
FROM ORDER;

SELECT FN45419.IS_EMAIL_OCP(EMAIL)
FROM MEMBER;

SELECT DISTINCT FN45419.IS_EMAIL_OCP('dummymail@gmail.com')
FROM MEMBER;

SELECT CITY, NEIGHBOURHOOD, POSTALCODE, FN45419.NUM_OF_PEOPLE(ID) AS PEOPLE_LIVING_THERE
FROM ADDRESS
ORDER BY PEOPLE_LIVING_THERE;

SELECT SUM(FN45419.NUM_OF_PEOPLE(ID)) AS ALL_PEOPLE
FROM ADDRESS;

SELECT DISTINCT T.SKU, T.CATEGORY, T.PRICE
FROM BOOK AS B,
     TABLE(FN45419.MOST_EXP_PROD(B.CATEGORY)) AS T;

SELECT DISTINCT T.SKU, T.CATEGORY, T.PRICE
FROM BOOK AS B,
     TABLE(FN45419.MOST_UNEXP_PROD(B.CATEGORY)) AS T;

SELECT T.ORDERNO, T.STATUS, T.TOTAL
FROM  MEMBER AS M,
     TABLE(FN45419.MEMB_ORDER_HIST(M.EMAIL)) AS T;

VALUES(FN45419.AMT_MONEY_SPENT('camélia.pevreal@hud.gov'));

VALUES(FN45419.COUNT_ORD_BY_MEMBER('camélia.pevreal@hud.gov'));

VALUES(FN45419.IS_EXPIRED(3538)); --NON-EXPIRED

VALUES(FN45419.IS_EXPIRED(356)); --EXPIRED

VALUES (FN45419.CHECK_PROD_IS_AVAL(1001));

VALUES (FN45419.CHECK_PROD_IS_AVAL(1005));

SELECT *
FROM TABLE (FN45419.GET_PROD_BY_COMPANY_NAME('Trupe'));

SELECT *
FROM TABLE (FN45419.GET_BOOKS_BY_AUTHOR('Kip Harg'));

VALUES (FN45419.CHECK_BOOK_IS_AVAL_BY_TITLE('Cronos'));

VALUES (FN45419.CHECK_BOOK_IS_AVAL_BY_TITLE('Me'));