/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T5-ca-json.sql

--Student ID: 34021396
--Student Name: Daniel Ross Mackay

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

SET PAGESIZE 100
SET WRAP OFF
SET HEADING OFF

-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

-- 5(a)
-- One JSON document per property that has at least one bin (the inner join
-- from PROPERTY to BIN drops properties with no bins).
-- Each bin row is extended with:
--   t - an inline view giving the bin's total kgs and total cost over all of
--       its pickups (cost = kgs collected x the contract's cost per kg);
--       outer joined because a bin may never have been collected
--   r - the bin that replaced this one, if any (outer joined; a bin is
--       replaced at most once, so this never duplicates a bin row)
-- Grouping by property then gives the bin statistics and the bins array.
-- NVL turns "no pickups" into 0, and costs are rounded to cents.
SELECT
    JSON_OBJECT(
        '_id' VALUE p.prop_id,
                'prop_fulladdress' VALUE p.prop_address
                                         || ', '
                                         || p.auth_name,
                'bin_stats' VALUE JSON_OBJECT(
            'number_of_suppliedbins' VALUE COUNT(b.bin_id),
                    'total_bin_supply_charge' VALUE SUM(bt.bt_sply_cost),
                    'total_waste_cost' VALUE SUM(round(
                nvl(t.total_cost, 0),
                2
            ))
        ),
                'bins' VALUE JSON_ARRAYAGG(
            JSON_OBJECT(
                'bin_id' VALUE b.bin_id,
                        'bin_rfid' VALUE b.bin_rfid,
                        'waste_type' VALUE w.wt_description,
                        'supplied_date' VALUE to_char(
                    b.bin_supply_date,
                    'DD-Mon-YYYY'
                ),
                        'bin_wasreplaced' VALUE
                    CASE
                        WHEN r.bin_id IS NULL THEN
                            'N'
                        ELSE
                            'Y'
                    END,
                        'waste_kgs' VALUE nvl(t.total_kgs, 0),
                        'waste_cost' VALUE round(
                    nvl(t.total_cost, 0),
                    2
                )
            )
        )
    FORMAT JSON)
    || ','
FROM
         property p
    JOIN bin        b
    ON p.prop_id = b.prop_id
    JOIN waste_type w
    ON b.wt_id = w.wt_id
    JOIN bin_type   bt
    ON b.wt_id = bt.wt_id
       AND b.bt_size = bt.bt_size
    LEFT OUTER JOIN (
        SELECT
            bc.bin_id,
            SUM(bc.bc_kgs)                 AS total_kgs,
            SUM(bc.bc_kgs * cw.cw_cost_kg) AS total_cost
        FROM
                 bin_collect bc
            JOIN contract_waste cw
            ON bc.cont_waste_id = cw.cont_waste_id
        GROUP BY
            bc.bin_id
    )          t
    ON b.bin_id = t.bin_id
    LEFT OUTER JOIN bin        r
    ON b.bin_id = r.prev_bin_id
GROUP BY
    p.prop_id,
    p.prop_address,
    p.auth_name
ORDER BY
    p.prop_id;
 
