--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-ca-mods.sql

--Student ID:
--Student Name:

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
