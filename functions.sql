CREATE FUNCTION GET_PROD_INFO(P_SKU INTEGER)
    RETURNS TABLE
            (
                BARCODE     CHAR(12),
                CATEGORY    VARCHAR(100),
                SINGLEPRICE DECIMAL(9, 2)
            )
BEGIN
    ATOMIC

    DECLARE SKUBOOK INTEGER;
    DECLARE SKUNOTEBOOK INTEGER;
    DECLARE SKUPEN INTEGER;
    DECLARE SKUPENCIL INTEGER;

    DECLARE BARCODERES CHAR(12);
    DECLARE CATEGORYRES VARCHAR(100);
    DECLARE SINGLPRICERES DECIMAL(9, 2);

    SET SKUBOOK = (SELECT SKU FROM BOOK WHERE SKU = P_SKU);
    SET SKUNOTEBOOK = (SELECT SKU FROM NOTEBOOK WHERE SKU = P_SKU);
    SET SKUPEN = (SELECT SKU FROM PEN WHERE SKU = P_SKU);
    SET SKUPENCIL = (SELECT SKU FROM PENCIL WHERE SKU = P_SKU);

    IF SKUBOOK IS NOT NULL THEN
        SET BARCODERES = (SELECT BARCODE FROM BOOK WHERE SKU = P_SKU);
        SET CATEGORYRES = (SELECT CATEGORY FROM BOOK WHERE SKU = P_SKU);
        SET SINGLPRICERES = (SELECT PRICE FROM BOOK WHERE SKU = P_SKU);
    END IF;

    IF SKUNOTEBOOK IS NOT NULL THEN
        SET BARCODERES = (SELECT BARCODE FROM NOTEBOOK WHERE SKU = P_SKU);
        SET CATEGORYRES = (SELECT CATEGORY FROM NOTEBOOK WHERE SKU = P_SKU);
        SET SINGLPRICERES = (SELECT PRICE FROM NOTEBOOK WHERE SKU = P_SKU);
    END IF;

    IF SKUPEN IS NOT NULL THEN
        SET BARCODERES = (SELECT BARCODE FROM PEN WHERE SKU = P_SKU);
        SET CATEGORYRES = (SELECT CATEGORY FROM PEN WHERE SKU = P_SKU);
        SET SINGLPRICERES = (SELECT PRICE FROM PEN WHERE SKU = P_SKU);
    END IF;

    IF SKUPENCIL IS NOT NULL THEN
        SET BARCODERES = (SELECT BARCODE FROM PENCIL WHERE SKU = P_SKU);
        SET CATEGORYRES = (SELECT CATEGORY FROM PENCIL WHERE SKU = P_SKU);
        SET SINGLPRICERES = (SELECT PRICE FROM PENCIL WHERE SKU = P_SKU);
    END IF;

    RETURN VALUES (BARCODERES, CATEGORYRES, SINGLPRICERES);
END;

CREATE FUNCTION ORD_STAT_INFO(P_ORDNO CHARACTER(6))
    RETURNS VARCHAR(15)
BEGIN
    ATOMIC

    DECLARE ORDERNO CHARACTER(6);
    DECLARE STATUS VARCHAR(15);

    SET ORDERNO = (SELECT O.ORDERNO FROM ORDER AS O WHERE O.ORDERNO = P_ORDNO);

    IF ORDERNO IS NOT NULL THEN
        SET STATUS = (SELECT O.STATUS FROM ORDER AS O WHERE O.ORDERNO = P_ORDNO);
    END IF;

    IF ORDERNO IS NULL THEN
        SET STATUS = '#INEXIST';
    END IF;

    RETURN STATUS;
END;

CREATE FUNCTION IS_EMAIL_OCP(P_EMAIL CHARACTER(30))
    RETURNS INTEGER
BEGIN
    ATOMIC

    DECLARE VAR_EMAIL CHARACTER(30);

    SET VAR_EMAIL = (SELECT EMAIL FROM MEMBER WHERE EMAIL = P_EMAIL);

    IF VAR_EMAIL IS NULL THEN
        RETURN 0;
    ELSE
        RETURN 1;
    END IF;
END;