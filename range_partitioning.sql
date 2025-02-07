-- Range Partitioning by Year

CREATE TABLE SUICIDE_STATISTICS_PARTITIONED (
    ID          NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    STATE       VARCHAR2(100),
    YEAR        NUMBER(4),
    TYPE_CODE   VARCHAR2(100),
    TYPE        VARCHAR2(255),
    GENDER      VARCHAR2(10),
    AGE_GROUP   VARCHAR2(50),
    TOTAL       NUMBER
)
PARTITION BY RANGE (YEAR) (
    PARTITION p_2001 VALUES LESS THAN (2002),
    PARTITION p_2005 VALUES LESS THAN (2006),
    PARTITION p_2010 VALUES LESS THAN (2011),
    PARTITION p_2015 VALUES LESS THAN (2016),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);

-- checking the execution of a query

EXPLAIN PLAN FOR 
SELECT * FROM SUICIDE_STATISTICS WHERE YEAR = 2003;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


--Caching Query Results for Faster Re-execution as frequent accessed data remains cached in memory reducing disk reads

ALTER TABLE SUICIDE_STATISTICS STORAGE (BUFFER_POOL KEEP);


