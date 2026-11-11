--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-ca-dm.sql

--Student ID: 34021396
--Student Name: Daniel Ross Mackay

/*
    -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
    In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
*/

--3(a)
DROP SEQUENCE property_seq;
 
DROP SEQUENCE bin_seq;
 
CREATE SEQUENCE property_seq START WITH 500 INCREMENT BY 1;
 
CREATE SEQUENCE bin_seq START WITH 500 INCREMENT BY 1;

--3(b)
-- Add the new property, then its four bins supplied on 5 October 2026.
INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( property_seq.NEXTVAL,
      '42 Jasmine St, Carlton',
      (
          SELECT
              auth_name
          FROM
              authority
          WHERE
              upper(auth_name) = upper('City of Melbourne')
      ) );
 
-- 100L green waste bin
INSERT INTO bin (
    bin_id,
    bin_rfid,
    bin_supply_date,
    bin_replace_reason,
    prop_id,
    wt_id,
    bt_size,
    prev_bin_id
) VALUES
    ( bin_seq.NEXTVAL,
      '3034F87B2C00A1D000000501',
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      NULL,
      property_seq.CURRVAL,
      (
          SELECT
              wt_id
          FROM
              waste_type
          WHERE
              upper(wt_description) = upper('green waste')
      ),
      100,
      NULL );
 
-- 100L landfill bin
INSERT INTO bin (
    bin_id,
    bin_rfid,
    bin_supply_date,
    bin_replace_reason,
    prop_id,
    wt_id,
    bt_size,
    prev_bin_id
) VALUES
    ( bin_seq.NEXTVAL,
      '3034F87B2C00A1D000000502',
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      NULL,
      property_seq.CURRVAL,
      (
          SELECT
              wt_id
          FROM
              waste_type
          WHERE
              upper(wt_description) = upper('landfill')
      ),
      100,
      NULL );
 
-- 240L glass recycle bin
INSERT INTO bin (
    bin_id,
    bin_rfid,
    bin_supply_date,
    bin_replace_reason,
    prop_id,
    wt_id,
    bt_size,
    prev_bin_id
) VALUES
    ( bin_seq.NEXTVAL,
      '3034F87B2C00A1D000000503',
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      NULL,
      property_seq.CURRVAL,
      (
          SELECT
              wt_id
          FROM
              waste_type
          WHERE
              upper(wt_description) = upper('glass (jars and bottles) recycle')
      ),
      240,
      NULL );
 
-- 240L general recycle bin
INSERT INTO bin (
    bin_id,
    bin_rfid,
    bin_supply_date,
    bin_replace_reason,
    prop_id,
    wt_id,
    bt_size,
    prev_bin_id
) VALUES
    ( bin_seq.NEXTVAL,
      '3034F87B2C00A1D000000504',
      TO_DATE('05-Oct-2026','DD-Mon-YYYY'),
      NULL,
      property_seq.CURRVAL,
      (
          SELECT
              wt_id
          FROM
              waste_type
          WHERE
              upper(wt_description) = upper('general recycle')
      ),
      240,
      NULL );
 
COMMIT;

--3(c)
-- Record the replacement glass bin supplied on 10 October 2026.
-- The new bin row carries the reason (F = bin failure) and points back to
-- the broken bin through prev_bin_id. The property and the broken bin are
-- found by address/authority and waste type, since this may run in a
-- different session from 3(b)
INSERT INTO bin (
    bin_id,
    bin_rfid,
    bin_supply_date,
    bin_replace_reason,
    prop_id,
    wt_id,
    bt_size,
    prev_bin_id
) VALUES
    ( bin_seq.NEXTVAL,
      '3034F87B2C00A1D000000505',
      TO_DATE('10-Oct-2026','DD-Mon-YYYY'),
      'F',
      (
          SELECT
              prop_id
          FROM
              property
          WHERE
                  upper(prop_address) = upper('42 Jasmine St, Carlton')
              AND upper(auth_name) = upper('City of Melbourne')
      ),
      (
          SELECT
              wt_id
          FROM
              waste_type
          WHERE
              upper(wt_description) = upper('glass (jars and bottles) recycle')
      ),
      240,
      -- the property's only existing glass bin is the one being replaced
      (
          SELECT
              b.bin_id
          FROM
                   bin b
              JOIN property   p
              ON b.prop_id = p.prop_id
              JOIN waste_type w
              ON b.wt_id = w.wt_id
          WHERE
                  upper(p.prop_address) = upper('42 Jasmine St, Carlton')
              AND upper(p.auth_name) = upper('City of Melbourne')
              AND upper(w.wt_description) = upper('glass (jars and bottles) recycle')
      ) );
 
COMMIT;
 

--3(d)
-- Two pickups of the property's landfill bin:
--   12 October 2026 - overweight (Y), not collected, so no weight recorded
--   7 days later    - collected (N) with a recorded weight

INSERT INTO bin_collect (
    bin_id,
    collect_date,
    bc_kgs,
    bc_overweight,
    cont_waste_id
) VALUES
    ( (
          SELECT
              b.bin_id
          FROM
                   bin b
              JOIN property   p
              ON b.prop_id = p.prop_id
              JOIN waste_type w
              ON b.wt_id = w.wt_id
          WHERE
                  upper(p.prop_address) = upper('42 Jasmine St, Carlton')
              AND upper(p.auth_name) = upper('City of Melbourne')
              AND upper(w.wt_description) = upper('landfill')
      ),
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      NULL,
      'Y',
      (
          SELECT
              cl.cont_waste_id
          FROM
                   collection cl
              JOIN contract_waste cw
              ON cl.cont_waste_id = cw.cont_waste_id
              JOIN contract       c
              ON cw.contract_no = c.contract_no
              JOIN waste_type     w
              ON cw.wt_id = w.wt_id
          WHERE
                  upper(c.auth_name) = upper('City of Melbourne')
              AND upper(w.wt_description) = upper('landfill')
              AND cl.collect_date = TO_DATE('12-Oct-2026','DD-Mon-YYYY')
      ) );
 
-- successful pickup at the next scheduled landfill collection 
INSERT INTO bin_collect (
    bin_id,
    collect_date,
    bc_kgs,
    bc_overweight,
    cont_waste_id
) VALUES
    ( (
          SELECT
              b.bin_id
          FROM
                   bin b
              JOIN property   p
              ON b.prop_id = p.prop_id
              JOIN waste_type w
              ON b.wt_id = w.wt_id
          WHERE
                  upper(p.prop_address) = upper('42 Jasmine St, Carlton')
              AND upper(p.auth_name) = upper('City of Melbourne')
              AND upper(w.wt_description) = upper('landfill')
      ),
      TO_DATE('12-Oct-2026','DD-Mon-YYYY') + 7,
      18.5,
      'N',
      (
          SELECT
              cl.cont_waste_id
          FROM
                   collection cl
              JOIN contract_waste cw
              ON cl.cont_waste_id = cw.cont_waste_id
              JOIN contract       c
              ON cw.contract_no = c.contract_no
              JOIN waste_type     w
              ON cw.wt_id = w.wt_id
          WHERE
                  upper(c.auth_name) = upper('City of Melbourne')
              AND upper(w.wt_description) = upper('landfill')
              AND cl.collect_date = TO_DATE('12-Oct-2026','DD-Mon-YYYY') + 7
      ) );
 
COMMIT;

--3(e)
-- Remove all glass bins from the property (the broken original and its
-- replacement).
DELETE FROM bin
WHERE
        prop_id = (
            SELECT
                prop_id
            FROM
                property
            WHERE
                    upper(prop_address) = upper('42 Jasmine St, Carlton')
                AND upper(auth_name) = upper('City of Melbourne')
        )
    AND wt_id = (
        SELECT
            wt_id
        FROM
            waste_type
        WHERE
            upper(wt_description) = upper('glass (jars and bottles) recycle')
    );
 
COMMIT;
 
