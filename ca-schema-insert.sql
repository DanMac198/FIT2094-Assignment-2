/*
  Databases 2026 S2 Assignment 2
  --Clear Away schema and Initial Data
  --ca-schema-insert.sql

  Description:
  This file creates the Clear Away tables
  and populates several of the tables (those shown in purple on the supplied model).
  You should read this schema file carefully
  and be sure you understand the various data requirements.

AI acknowledgement and prompt used:
The teaching team acknowledge the use of Google Gemini (https://gemini.google.com) 
to generate some of the insert statements that were included within ca-schema-insert.sql (this file).
The output of GenAI were manually checked and edited to comply with the assignment requirements. 

We entered the following prompts on 12 October 2026:
Given this schema file and data, write generate Oracle insert statements to add:
- five authorities with different types (shire, city, borough)
- five to ten properties in each authority
- one to three contracts for each authority covering different period between 1 January 2026 till 31 December 2026
- ten trucks
- collection dates for each contract waste between 1 October and 30 November, different authorities use different trucks.

The generated data is then manually edited to suits the assignment task requirements.

Author: FIT Database Teaching Team
License: Copyright Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice.

*/
   SET ECHO ON

DROP TABLE authority CASCADE CONSTRAINTS PURGE;

DROP TABLE bin_type CASCADE CONSTRAINTS PURGE;

DROP TABLE collection CASCADE CONSTRAINTS PURGE;

DROP TABLE contract CASCADE CONSTRAINTS PURGE;

DROP TABLE contract_waste CASCADE CONSTRAINTS PURGE;

DROP TABLE truck CASCADE CONSTRAINTS PURGE;

DROP TABLE waste_type CASCADE CONSTRAINTS PURGE;

----------------------------------------------------------------
--CREATE TABLE authority along with its check and PK constraints
----------------------------------------------------------------
CREATE TABLE authority (
    auth_name     VARCHAR2(80) NOT NULL,
    auth_ceogname VARCHAR2(50),
    auth_ceofname VARCHAR2(30),
    auth_phone    CHAR(10) NOT NULL,
    auth_area     NUMBER(6) NOT NULL,
    auth_type     CHAR(1) NOT NULL
);

ALTER TABLE authority
    ADD CONSTRAINT chk_auth_type
        CHECK ( auth_type IN ( 'B',
                               'C',
                               'D',
                               'S',
                               'T' ) );

COMMENT ON COLUMN authority.auth_name IS
    'Name of the authority';

COMMENT ON COLUMN authority.auth_ceogname IS
    'CEO given name';

COMMENT ON COLUMN authority.auth_ceofname IS
    'CEO family name';

COMMENT ON COLUMN authority.auth_phone IS
    'Authority contact phone number';

COMMENT ON COLUMN authority.auth_area IS
    'Area of LGA in sq km';

COMMENT ON COLUMN authority.auth_type IS
    'Type of local authority ';

ALTER TABLE authority ADD CONSTRAINT authority_pk PRIMARY KEY ( auth_name );

----------------------------------------------------
--CREATE TABLE bin_type along with its PK constraint
----------------------------------------------------
CREATE TABLE bin_type (
    wt_id        CHAR(2) NOT NULL,
    bt_size      NUMBER(3) NOT NULL,
    bt_sply_cost NUMBER(5,2) NOT NULL
);

COMMENT ON COLUMN bin_type.wt_id IS
    'Identifier for type of waste';

COMMENT ON COLUMN bin_type.bt_size IS
    'Size in ltrs for this bin type';

COMMENT ON COLUMN bin_type.bt_sply_cost IS
    'Supply cost to produce this type of bin';

ALTER TABLE bin_type ADD CONSTRAINT bin_type_pk PRIMARY KEY ( wt_id,
                                                              bt_size );

------------------------------------------------------
--CREATE TABLE collection along with its PK constraint
------------------------------------------------------
CREATE TABLE collection (
    cont_waste_id NUMBER(4) NOT NULL,
    collect_date  DATE NOT NULL,
    truck_vin     CHAR(17) NOT NULL
);

COMMENT ON COLUMN collection.cont_waste_id IS
    'Surrogate key added to indentify CONTRACT_WASTE';

COMMENT ON COLUMN collection.collect_date IS
    'Date collection is made';

COMMENT ON COLUMN collection.truck_vin IS
    'Identifier for truck';

ALTER TABLE collection ADD CONSTRAINT collection_pk PRIMARY KEY ( collect_date,
                                                                  cont_waste_id );

----------------------------------------------------
--CREATE TABLE contract along with its PK constraint
----------------------------------------------------
CREATE TABLE contract (
    contract_no    NUMBER(6) NOT NULL,
    contract_start DATE NOT NULL,
    contract_end   DATE NOT NULL,
    auth_name      VARCHAR2(80) NOT NULL
);

COMMENT ON COLUMN contract.contract_no IS
    'Contract identifier';

COMMENT ON COLUMN contract.contract_start IS
    'Date contract starts';

COMMENT ON COLUMN contract.contract_end IS
    'Date contract ends';

COMMENT ON COLUMN contract.auth_name IS
    'Name of the authority';

ALTER TABLE contract ADD CONSTRAINT contract_pk PRIMARY KEY ( contract_no );

-----------------------------------------------------------------------------
--CREATE TABLE contract_waste along with its PK, check and unique constraints
-----------------------------------------------------------------------------
CREATE TABLE contract_waste (
    cont_waste_id NUMBER(4) NOT NULL,
    cw_cost_kg    NUMBER(4,2) NOT NULL,
    cw_frequency  CHAR(1) NOT NULL,
    contract_no   NUMBER(6) NOT NULL,
    wt_id         CHAR(2) NOT NULL
);

ALTER TABLE contract_waste
    ADD CONSTRAINT chk_cw_frequency
        CHECK ( cw_frequency IN ( 'F',
                                  'M',
                                  'W' ) );

COMMENT ON COLUMN contract_waste.cont_waste_id IS
    'Surrogate key added to indentify CONTRACT_WASTE';

COMMENT ON COLUMN contract_waste.cw_cost_kg IS
    'Cost per kilogram to collect this tyoe of waste';

COMMENT ON COLUMN contract_waste.cw_frequency IS
    'Frequency wirh which collections for this type of waste are made';

COMMENT ON COLUMN contract_waste.contract_no IS
    'Contract identifier';

COMMENT ON COLUMN contract_waste.wt_id IS
    'Identifier for type of waste';

ALTER TABLE contract_waste ADD CONSTRAINT contract_waste_pk PRIMARY KEY ( cont_waste_id
);

ALTER TABLE contract_waste ADD CONSTRAINT contract_waste_nk UNIQUE ( contract_no,
                                                                     wt_id );

----------------------------------------------------
--CREATE TABLE truck along with its PK constraint
----------------------------------------------------

CREATE TABLE truck (
    truck_vin   CHAR(17) NOT NULL,
    truck_rego  CHAR(6) NOT NULL,
    truck_make  VARCHAR2(30) NOT NULL,
    truck_model VARCHAR2(30) NOT NULL,
    truck_year  NUMBER(4) NOT NULL
);

COMMENT ON COLUMN truck.truck_vin IS
    'Identifier for truck';

COMMENT ON COLUMN truck.truck_rego IS
    'Truck registration number eg CRAY02';

COMMENT ON COLUMN truck.truck_make IS
    'Make of truck';

COMMENT ON COLUMN truck.truck_model IS
    'Truck model';

COMMENT ON COLUMN truck.truck_year IS
    'Truck year of manufacture';

ALTER TABLE truck ADD CONSTRAINT truck_pk PRIMARY KEY ( truck_vin );

----------------------------------------------------
--CREATE TABLE waste_type along with its PK constraint
----------------------------------------------------

CREATE TABLE waste_type (
    wt_id          CHAR(2) NOT NULL,
    wt_description VARCHAR2(40) NOT NULL
);

COMMENT ON COLUMN waste_type.wt_id IS
    'Identifier for type of waste';

COMMENT ON COLUMN waste_type.wt_description IS
    'Description of type of waste';

ALTER TABLE waste_type ADD CONSTRAINT waste_type_pk PRIMARY KEY ( wt_id );

ALTER TABLE waste_type ADD CONSTRAINT waste_type_nk UNIQUE ( wt_description );

--------------------------------------
-- ALTER FK constraints
--------------------------------------
-- bin_type table FK
ALTER TABLE bin_type
    ADD CONSTRAINT waste_type_bin_type_fk FOREIGN KEY ( wt_id )
        REFERENCES waste_type ( wt_id );

-- contract table FK
ALTER TABLE contract
    ADD CONSTRAINT authority_contract_fk FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );

-- collection table FKs
ALTER TABLE collection
    ADD CONSTRAINT con_waste_collect_fk FOREIGN KEY ( cont_waste_id )
        REFERENCES contract_waste ( cont_waste_id );

ALTER TABLE collection
    ADD CONSTRAINT truck_collection_fk FOREIGN KEY ( truck_vin )
        REFERENCES truck ( truck_vin );

-- collection contract_waste FKs
ALTER TABLE contract_waste
    ADD CONSTRAINT waste_type_con_waste_fk FOREIGN KEY ( wt_id )
        REFERENCES waste_type ( wt_id );

ALTER TABLE contract_waste
    ADD CONSTRAINT contract_con_waste_fk FOREIGN KEY ( contract_no )
        REFERENCES contract ( contract_no );

--------------------------------------
--INSERT INTO waste_type - manual input
--------------------------------------
INSERT INTO waste_type (
    wt_id,
    wt_description
) VALUES
    ( 'GW',
      'Green waste' );

INSERT INTO waste_type (
    wt_id,
    wt_description
) VALUES
    ( 'LF',
      'Landfill' );

INSERT INTO waste_type (
    wt_id,
    wt_description
) VALUES
    ( 'RC',
      'General recycle' );

INSERT INTO waste_type (
    wt_id,
    wt_description
) VALUES
    ( 'RG',
      'Glass (jars and bottles) recycle' );

--------------------------------------
--INSERT INTO bin_type - manual input
--------------------------------------
INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'GW',
      75,
      45 );

INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'GW',
      100,
      50 );

INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'GW',
      240,
      65 );

INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'LF',
      100,
      66 );

INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'LF',
      240,
      76 );

INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'RC',
      100,
      60 );

INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'RC',
      240,
      75 );


INSERT INTO bin_type (
    wt_id,
    bt_size,
    bt_sply_cost
) VALUES
    ( 'RG',
      240,
      99 );

--------------------------------------
--INSERT INTO authority - GenAI input
--------------------------------------

INSERT INTO authority (
    auth_name,
    auth_ceogname,
    auth_phone,
    auth_area,
    auth_type
) VALUES
    ( 'Borough of Queenscliffe',
      'Martin',
      '0352581377',
      11,
      'B' );

INSERT INTO authority (
    auth_name,
    auth_ceogname,
    auth_ceofname,
    auth_phone,
    auth_area,
    auth_type
) VALUES
    ( 'Shire of Yarra Ranges',
      'Tammi',
      'Rose',
      '1300368333',
      2468,
      'S' );

INSERT INTO authority (
    auth_name,
    auth_ceofname,
    auth_phone,
    auth_area,
    auth_type
) VALUES
    ( 'City of Monash',
      'Loveridge',
      '0395183555',
      81,
      'C' );

INSERT INTO authority (
    auth_name,
    auth_ceogname,
    auth_ceofname,
    auth_phone,
    auth_area,
    auth_type
) VALUES
    ( 'Shire of Mornington Peninsula',
      'John',
      'Baker',
      '1300850600',
      724,
      'S' );

INSERT INTO authority (
    auth_name,
    auth_ceogname,
    auth_ceofname,
    auth_phone,
    auth_area,
    auth_type
) VALUES
    ( 'City of Melbourne',
      'Alison',
      'Leighton',
      '0396589658',
      37,
      'C' );

--------------------------------------
-- INSERT INTO contract - GenAI input, then checked and manually edited 
--------------------------------------

-- 1. Borough of Queenscliffe (2 contracts)
INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 1,
      TO_DATE('10-Jul-2026','DD-Mon-YYYY'),
      TO_DATE('15-Dec-2026','DD-Mon-YYYY'),
      'Borough of Queenscliffe' );

INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 2,
      TO_DATE('10-Jul-2026','DD-Mon-YYYY'),
      TO_DATE('15-Dec-2026','DD-Mon-YYYY'),
      'Borough of Queenscliffe' );


-- 2. Shire of Yarra Ranges (3 contracts)
INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 3,
      TO_DATE('01-Feb-2026','DD-Mon-YYYY'),
      TO_DATE('15-May-2026','DD-Mon-YYYY'),
      'Shire of Yarra Ranges' );

INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 4,
      TO_DATE('01-Feb-2026','DD-Mon-YYYY'),
      TO_DATE('15-May-2026','DD-Mon-YYYY'),
      'Shire of Yarra Ranges' );

INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 5,
      TO_DATE('06-May-2026','DD-Mon-YYYY'),
      TO_DATE('20-Dec-2026','DD-Mon-YYYY'),
      'Shire of Yarra Ranges' );


-- 3. City of Monash (2 contracts)
INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 6,
      TO_DATE('10-Jan-2026','DD-Mon-YYYY'),
      TO_DATE('14-Apr-2026','DD-Mon-YYYY'),
      'City of Monash' );

INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 7,
      TO_DATE('01-Jun-2026','DD-Mon-YYYY'),
      TO_DATE('30-Nov-2026','DD-Mon-YYYY'),
      'City of Monash' );


-- 4. Shire of Mornington Peninsula (1 contract)
INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 8,
      TO_DATE('1-Aug-2026','DD-Mon-YYYY'),
      TO_DATE('28-Dec-2026','DD-Mon-YYYY'),
      'Shire of Mornington Peninsula' );


-- 5. City of Melbourne (2 contracts)
INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 9,
      TO_DATE('01-Jan-2026','DD-Mon-YYYY'),
      TO_DATE('31-Dec-2026','DD-Mon-YYYY'),
      'City of Melbourne' );

INSERT INTO contract (
    contract_no,
    contract_start,
    contract_end,
    auth_name
) VALUES
    ( 10,
      TO_DATE('01-Jan-2026','DD-Mon-YYYY'),
      TO_DATE('31-Dec-2026','DD-Mon-YYYY'),
      'City of Melbourne' );

--------------------------------------------
-- INSERT INTO contract_waste - manual input
--------------------------------------------
-- 1. Borough of Queenscliffe
INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 1,
      0.35,
      'F',
      1,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 2,
      0.10,
      'F',
      2,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 3,
      0.15,
      'W',
      2,
      'LF' );

-- 2. Shire of Yarra Ranges
INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 4,
      0.30,
      'F',
      3,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 5,
      0.15,
      'F',
      3,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 6,
      0.20,
      'W',
      4,
      'LF' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 7,
      0.30,
      'F',
      5,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 8,
      0.15,
      'F',
      5,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 9,
      0.20,
      'W',
      5,
      'LF' );

-- 3. City of Monash
INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 10,
      0.20,
      'F',
      6,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 11,
      0.10,
      'W',
      6,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 12,
      0.10,
      'F',
      6,
      'LF' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 13,
      0.20,
      'F',
      7,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 14,
      0.10,
      'W',
      7,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 15,
      0.15,
      'F',
      7,
      'LF' );

-- 4. Shire of Mornington Peninsula
INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 16,
      0.20,
      'F',
      8,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 17,
      0.10,
      'W',
      8,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 18,
      0.15,
      'W',
      8,
      'LF' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 19,
      0.30,
      'M',
      8,
      'RG' );

-- 5. City of Melbourne
INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 20,
      0.30,
      'F',
      9,
      'RC' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 21,
      0.30,
      'M',
      9,
      'RG' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 22,
      0.10,
      'W',
      10,
      'GW' );

INSERT INTO contract_waste (
    cont_waste_id,
    cw_cost_kg,
    cw_frequency,
    contract_no,
    wt_id
) VALUES
    ( 23,
      0.20,
      'W',
      10,
      'LF' );

--------------------------------------
-- INSERT INTO truck - GenAI Input
--------------------------------------

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN11H123456',
      'TRK001',
      'Isuzu',
      'F-Series FSR 140-260',
      2021 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN12H123457',
      'TRK002',
      'Isuzu',
      'FV-Series FVR 165-300',
      2022 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN13H123458',
      'TRK003',
      'Hino',
      '500 Series Wide Cab',
      2020 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN14H123459',
      'TRK004',
      'Hino',
      '700 Series',
      2023 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN15H123460',
      'TRK005',
      'Volvo',
      'FE Electric',
      2022 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN16H123461',
      'TRK006',
      'Volvo',
      'FL 250',
      2019 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN17H123462',
      'TRK007',
      'Mercedes-Benz',
      'Econic 2630 L',
      2021 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN18H123463',
      'TRK008',
      'Mercedes-Benz',
      'Atego 1530',
      2020 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN19H123464',
      'TRK009',
      'MAN',
      'TGM 18.290',
      2023 );

INSERT INTO truck (
    truck_vin,
    truck_rego,
    truck_make,
    truck_model,
    truck_year
) VALUES
    ( '1HTMMAAN20H123465',
      'TRK010',
      'Scania',
      'L-Series L280',
      2024 );

---------------------------------------------------------------------------------------
-- INSERT INTO COLLECTION - GenAI Input, then checked and manually edited 
---------------------------------------------------------------------------------------

-- 1. BOROUGH OF QUEENSCLIFFE
-- Contract 1 (RC - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 1,
      TO_DATE('01-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN11H123456' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 1,
      TO_DATE('15-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN11H123456' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 1,
      TO_DATE('29-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN11H123456' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 1,
      TO_DATE('12-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN11H123456' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 1,
      TO_DATE('26-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN11H123456' );

-- Contract 2 (GW - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 2,
      TO_DATE('08-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 2,
      TO_DATE('22-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 2,
      TO_DATE('05-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 2,
      TO_DATE('19-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );

-- Contract 2 (LF - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('02-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('09-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('16-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('23-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('30-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('06-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('13-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('20-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 3,
      TO_DATE('27-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN12H123457' );


-- 2. SHIRE OF YARRA RANGES
-- Contract 5 (RC - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 7,
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN13H123458' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 7,
      TO_DATE('19-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN13H123458' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 7,
      TO_DATE('02-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN13H123458' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 7,
      TO_DATE('16-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN13H123458' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 7,
      TO_DATE('30-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN13H123458' );

-- Contract 5 (GW - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 8,
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 8,
      TO_DATE('26-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 8,
      TO_DATE('09-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 8,
      TO_DATE('23-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );

-- Contract 5 (LF - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('01-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('08-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('15-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('22-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('29-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('05-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('12-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('19-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 9,
      TO_DATE('26-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN14H123459' );


-- 3. CITY OF MONASH
-- Contract 7 (RC - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 13,
      TO_DATE('06-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 13,
      TO_DATE('20-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 13,
      TO_DATE('03-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 13,
      TO_DATE('17-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );

-- Contract 7 (GW - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('07-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('14-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('21-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('28-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('04-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('11-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('18-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 14,
      TO_DATE('25-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN16H123461' );

-- Contract 7 (LF - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 15,
      TO_DATE('13-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 15,
      TO_DATE('27-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 15,
      TO_DATE('10-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 15,
      TO_DATE('24-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN15H123460' );


-- 4. SHIRE OF MORNINGTON PENINSULA
-- Contract 8 (RC - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 16,
      TO_DATE('02-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 16,
      TO_DATE('16-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 16,
      TO_DATE('30-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 16,
      TO_DATE('13-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 16,
      TO_DATE('27-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );

-- Contract 8 (GW - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('03-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('10-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('17-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('24-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('31-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('07-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('14-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('21-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 17,
      TO_DATE('28-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );

-- Contract 8 (LF - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('19-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('26-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('02-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('09-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('16-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('23-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 18,
      TO_DATE('30-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN18H123463' );

-- Contract 8 (RG - 'M' Monthly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 19,
      TO_DATE('01-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 19,
      TO_DATE('01-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN17H123462' );


-- 5. CITY OF MELBOURNE
-- Contract 9 (RC - 'F' Fortnightly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 20,
      TO_DATE('04-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 20,
      TO_DATE('18-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 20,
      TO_DATE('01-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 20,
      TO_DATE('15-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 20,
      TO_DATE('29-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );

-- Contract 9 (RG - 'M' Monthly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 21,
      TO_DATE('15-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 21,
      TO_DATE('15-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN19H123464' );

-- Contract 10 (GW - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('04-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('11-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('18-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('25-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('01-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('08-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('15-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('22-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 22,
      TO_DATE('29-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );

-- Contract 10 (LF - 'W' Weekly) | Active Oct-Nov
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('19-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('26-Oct-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('02-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('09-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('16-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('23-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );
INSERT INTO collection (
    cont_waste_id,
    collect_date,
    truck_vin
) VALUES
    ( 23,
      TO_DATE('30-Nov-2026','DD-Mon-YYYY'),
      '1HTMMAAN20H123465' );

COMMIT;

   SET ECHO OFF