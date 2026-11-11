--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T1-ca-schema.sql

--Student ID: 34021396
--Student Name: Daniel Ross Mackay

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/


/* drop table statements - do not remove*/

DROP TABLE bin CASCADE CONSTRAINTS PURGE;

DROP TABLE bin_collect CASCADE CONSTRAINTS PURGE;

DROP TABLE property CASCADE CONSTRAINTS PURGE;

-- Task 1 Add Create table statements for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- BIN
CREATE TABLE bin (
    bin_id             NUMBER(8) NOT NULL,
    bin_rfid           CHAR(24) NOT NULL,
    bin_supply_date    DATE NOT NULL,
    bin_replace_reason CHAR(1),
    prop_id            NUMBER(6) NOT NULL,
    wt_id              CHAR(2) NOT NULL,  
    bt_size            NUMBER(3) NOT NULL,  
    prev_bin_id        NUMBER(8)
);
 
COMMENT ON COLUMN bin.bin_id IS
    'Bin unique identifier (surrogate key)';
 
COMMENT ON COLUMN bin.bin_rfid IS
    'Hexadecimal RFID code used to identify a bin';
 
COMMENT ON COLUMN bin.bin_supply_date IS
    'The date bin supplied to property';
 
COMMENT ON COLUMN bin.bin_replace_reason IS
    'Reason for replacement of bin (D, F, P or S)';
 
COMMENT ON COLUMN bin.prop_id IS
    'ID of the property the bin is supplied to';
 
COMMENT ON COLUMN bin.wt_id IS
    'Waste type ID of the bin type';
 
COMMENT ON COLUMN bin.bt_size IS
    'Size of the bin type';
 
COMMENT ON COLUMN bin.prev_bin_id IS
    'Bin ID of the bin which this bin replaces';
 
ALTER TABLE bin ADD CONSTRAINT bin_pk PRIMARY KEY ( bin_id );
 
ALTER TABLE bin ADD CONSTRAINT bin_nk UNIQUE ( bin_rfid );
 
ALTER TABLE bin ADD CONSTRAINT bin_prev_bin_nk UNIQUE ( prev_bin_id );
 
ALTER TABLE bin
    ADD CONSTRAINT bin_replace_reason_chk
        CHECK ( bin_replace_reason IN ( 'D', 'F', 'P', 'S' ) );


-- BIN_COLLECT
CREATE TABLE bin_collect (
    bin_id        NUMBER(8) NOT NULL,
    collect_date  DATE NOT NULL,
    bc_kgs        NUMBER(3, 1),
    bc_overweight CHAR(1) NOT NULL,
    cont_waste_id NUMBER(4) NOT NULL   
);
 
COMMENT ON COLUMN bin_collect.bin_id IS
    'Bin ID of the bin emptied in this pickup';
 
COMMENT ON COLUMN bin_collect.collect_date IS
    'Date of the collection run';
 
COMMENT ON COLUMN bin_collect.bc_kgs IS
    'Number of kilograms collected in this pickup';
 
COMMENT ON COLUMN bin_collect.bc_overweight IS
    'Indicates if bin is overweight (Y or N)';
 
COMMENT ON COLUMN bin_collect.cont_waste_id IS
    'Contract waste ID of the collection run';
 
ALTER TABLE bin_collect ADD CONSTRAINT bin_collect_pk PRIMARY KEY ( bin_id,
                                                                    collect_date );
 
ALTER TABLE bin_collect
    ADD CONSTRAINT bc_overweight_chk CHECK ( bc_overweight IN ( 'Y', 'N' ) );


-- PROPERTY
CREATE TABLE property (
    prop_id      NUMBER(6) NOT NULL,
    prop_address VARCHAR2(50) NOT NULL,
    auth_name    VARCHAR2(80) NOT NULL
);
 
COMMENT ON COLUMN property.prop_id IS
    'Property ID';
 
COMMENT ON COLUMN property.prop_address IS
    'Property Address (includes street no, street name, suburb)';
 
COMMENT ON COLUMN property.auth_name IS
    'Name of the local authority the property is located in';
 
ALTER TABLE property ADD CONSTRAINT property_pk PRIMARY KEY ( prop_id );
 
ALTER TABLE property ADD CONSTRAINT property_nk UNIQUE ( prop_address,
                                                         auth_name );

-- Add all missing FK Constraints below here

ALTER TABLE property
    ADD CONSTRAINT authority_property_fk FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );
 
ALTER TABLE bin
    ADD CONSTRAINT property_bin_fk FOREIGN KEY ( prop_id )
        REFERENCES property ( prop_id );
 
-- composite FK: a bin's type is identified by waste type + size
ALTER TABLE bin
    ADD CONSTRAINT bin_type_bin_fk FOREIGN KEY ( wt_id,
                                                 bt_size )
        REFERENCES bin_type ( wt_id,
                              bt_size );
 
-- recursive FK: the bin this bin replaces
ALTER TABLE bin
    ADD CONSTRAINT bin_bin_fk FOREIGN KEY ( prev_bin_id )
        REFERENCES bin ( bin_id );
 
ALTER TABLE bin_collect
    ADD CONSTRAINT bin_bin_collect_fk FOREIGN KEY ( bin_id )
        REFERENCES bin ( bin_id );
 
-- composite FK: collect_date is shared between the PK and this FK
ALTER TABLE bin_collect
    ADD CONSTRAINT collection_bin_collect_fk FOREIGN KEY ( cont_waste_id,
                                                           collect_date )
        REFERENCES collection ( cont_waste_id,
                                collect_date );
 
