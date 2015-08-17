
CREATE TABLE O1 (
 PKEY          INTEGER NOT NULL,
 A_INT         INTEGER,
 A_INLINE_STR  VARCHAR(10),
 A_POOL_STR    VARCHAR(1024),
 PRIMARY KEY (PKEY)
);

PARTITION TABLE O1 ON COLUMN PKEY;
CREATE INDEX IDX_O1_A_INT_PKEY on O1 (A_INT, PKEY);
CREATE PROCEDURE Truncate01 AS DELETE FROM O1;

-- replicated table used in pro TestCatalogUpdateSuite test
CREATE TABLE O2 (
 PKEY          INTEGER,
 A_INT         INTEGER,
 A_INLINE_STR  VARCHAR(10),
 A_POOL_STR    VARCHAR(1024),
 PRIMARY KEY (PKEY)
);
 

CREATE TABLE O3 (
 PK1 INTEGER NOT NULL,
 PK2 INTEGER NOT NULL,
 I3  INTEGER NOT NULL,
 I4  INTEGER NOT NULL,
 PRIMARY KEY (PK1, PK2)
 );

CREATE INDEX O3_TREE ON O3 (I3 DESC);
CREATE INDEX O3_PARTIAL_TREE ON O3 (I4) WHERE PK2 > 0;
CREATE PROCEDURE Truncate03 AS DELETE FROM O3;


create table a
(
  a integer not null
);

partition table a on column a;

create table b
(
  a integer not null
);

create procedure TruncateA as DELETE FROM A;
create procedure TruncateB as DELETE FROM B;

CREATE TABLE P (
    P_D0 INTEGER NOT NULL,
    P_D1 INTEGER NOT NULL,
    P_D2 INTEGER NOT NULL,
    P_D3 INTEGER NOT NULL,
);

CREATE INDEX P_D0_IDX ON P (P_D0);
CREATE INDEX P_D1_IDX ON P (P_D1);
CREATE INDEX P_D32_IDX ON P (P_D3, P_D2);
CREATE INDEX P_D32_10_IDX ON P (P_D3 / 10, P_D2);


PARTITION TABLE P ON COLUMN P_D0;

CREATE TABLE P1 (
    P1_D0 INTEGER NOT NULL,
    P1_D1 INTEGER NOT NULL,
    P1_D2 INTEGER NOT NULL,
);

PARTITION TABLE P1 ON COLUMN P1_D0;

CREATE PROCEDURE TruncateP as DELETE FROM P;
CREATE PROCEDURE TruncateP1 as DELETE FROM P1;

CREATE VIEW V_P (V_P_D1, V_P_D2, V_CNT, V_SUM_P_D3, V_SUM_P_D0)
    AS SELECT P_D1, P_D2, COUNT(*), SUM(P_D3), COUNT(P_D0) 
    FROM P  GROUP BY P_D1, P_D2;
