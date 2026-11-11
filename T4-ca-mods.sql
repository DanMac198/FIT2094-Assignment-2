--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-ca-mods.sql

--Student ID: 34021396
--Student Name: Daniel Ross Mackay

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--4(a)
-- Add collect_kgs to COLLECTION: the total kgs of waste picked up on that
-- scheduled collection. 
ALTER TABLE collection DROP COLUMN collect_kgs;
 
-- DEFAULT 0 NOT NULL: every existing row starts at 0, and inserts made by
-- other users of the live database (which do not list this column) still work.

ALTER TABLE collection ADD (
    collect_kgs NUMBER(7,1) DEFAULT 0 NOT NULL
);
 
COMMENT ON COLUMN collection.collect_kgs IS
    'Total kilograms of waste collected on this scheduled collection';
 
-- Set each collection's total to the sum of its pickups in BIN_COLLECT.
-- A collection that has not happened yet has no pickups, and an overweight
-- pickup has no weight
UPDATE collection c
SET
    collect_kgs = (
        SELECT
            nvl(
                sum(bc.bc_kgs),
                0
            )
        FROM
            bin_collect bc
        WHERE
                bc.cont_waste_id = c.cont_waste_id
            AND bc.collect_date = c.collect_date
    );
 
COMMIT;
 
DESC collection;
 
SELECT
    cont_waste_id,
    to_char(
        collect_date,
        'DD-Mon-YYYY'
    ) AS collection_date,
    truck_vin,
    collect_kgs
FROM
    collection
ORDER BY
    cont_waste_id,
    collect_date;
 

--4(b)
-- BIN_AUDIT: one row per authority and bin type (waste type + size) used in
-- that authority, with the number of original bins and replacement bins.
DROP TABLE bin_audit CASCADE CONSTRAINTS PURGE;
 
CREATE TABLE bin_audit (
    auth_name        VARCHAR2(80) NOT NULL,
    wt_id            CHAR(2) NOT NULL,
    bt_size          NUMBER(3) NOT NULL,
    ba_bin_total     NUMBER(5) NOT NULL,
    ba_replace_total NUMBER(5) NOT NULL
);
 
COMMENT ON COLUMN bin_audit.auth_name IS
    'Name of the authority';
 
COMMENT ON COLUMN bin_audit.wt_id IS
    'Identifier for type of waste';
 
COMMENT ON COLUMN bin_audit.bt_size IS
    'Size in ltrs for this bin type';
 
COMMENT ON COLUMN bin_audit.ba_bin_total IS
    'Total number of bins of this type in the authority, excluding replacement bins';
 
COMMENT ON COLUMN bin_audit.ba_replace_total IS
    'Total number of replacement bins of this type in the authority';
 
-- an authority has at most one audit row per bin type
ALTER TABLE bin_audit
    ADD CONSTRAINT bin_audit_pk PRIMARY KEY ( auth_name,
                                              wt_id,
                                              bt_size );
 
ALTER TABLE bin_audit
    ADD CONSTRAINT authority_bin_audit_fk FOREIGN KEY ( auth_name )
        REFERENCES authority ( auth_name );
 
ALTER TABLE bin_audit
    ADD CONSTRAINT bin_type_bin_audit_fk FOREIGN KEY ( wt_id,
                                                       bt_size )
        REFERENCES bin_type ( wt_id,
                              bt_size );
 
-- Populate from the current data. A bin belongs to an authority through its property. 
-- Only bin types that actually have bins in an authority produce a row.
INSERT INTO bin_audit (
    auth_name,
    wt_id,
    bt_size,
    ba_bin_total,
    ba_replace_total
)
    SELECT
        p.auth_name,
        b.wt_id,
        b.bt_size,
        COUNT(b.bin_id) - COUNT(b.prev_bin_id),
        COUNT(b.prev_bin_id)
    FROM
             bin b
        JOIN property p
        ON b.prop_id = p.prop_id
    GROUP BY
        p.auth_name,
        b.wt_id,
        b.bt_size;
 
COMMIT;
 
DESC bin_audit;
 
SELECT
    *
FROM
    bin_audit
ORDER BY
    auth_name,
    wt_id,
    bt_size;
 