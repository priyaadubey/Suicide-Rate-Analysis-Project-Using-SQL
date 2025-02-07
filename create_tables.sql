-- Log in to Oracle as SYSTEM
--It is private so done only by my side 

--Create Pluggable Database
CREATE PLUGGABLE DATABASE suicide_pdb
  ADMIN USER pdb_admin IDENTIFIED BY admin_password
  FILE_NAME_CONVERT = (
    'C:\APP\7EIN\PRODUCT\21C\ORADATA\XE\PDBSEED\', 
    'C:\APP\7EIN\PRODUCT\21C\ORADATA\XE\suicide_pdb\'
  );

--Switch to the newly created Pluggable Database
ALTER SESSION SET CONTAINER=suicide_pdb;

-- Create a user with a password
CREATE USER suicide_user IDENTIFIED BY suicide_pass;

-- Grant CONNECT and RESOURCE roles to the user
GRANT CONNECT, RESOURCE TO suicide_user;

-- Connect as the suicide_user to create the table
CONNECT suicide_user/suicide_pass@localhost:1521/suicide_pdb;

--Set the session schema to suicide_user
ALTER SESSION SET CURRENT_SCHEMA = suicide_user;

--making sure changes are made
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') FROM dual;

--Creating table
CREATE TABLE SUICIDE_STATISTICS (
    ID          NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    STATE       VARCHAR2(100) ,
    YEAR        NUMBER(4) ,
    TYPE_CODE   VARCHAR2(100),
    TYPE        VARCHAR2(255),
    GENDER      VARCHAR2(10),
    AGE_GROUP   VARCHAR2(50),
    TOTAL       NUMBER
);

--summary for structure
desc suicide_user.SUICIDE_STATISTICS;

--Grant access
GRANT SELECT, INSERT, UPDATE, DELETE ON suicide_user.SUICIDE_STATISTICS TO suicide_user;


SELECT column_name FROM all_tab_columns WHERE table_name = 'SUICIDE_STATISTICS';

--Verify the table exists in the correct schema
SELECT table_name FROM all_tables WHERE table_name = 'SUICIDE_STATISTICS' AND owner = 'SUICIDE_USER';

--Verify user access to the table
SELECT * FROM all_tab_privs WHERE table_name = 'SUICIDE_STATISTICS' AND grantee = 'SUICIDE_USER';
select * from SUICIDE_STATISTICS;