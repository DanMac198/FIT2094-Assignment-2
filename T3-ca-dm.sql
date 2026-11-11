--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-ca-dm.sql

--Student ID:
--Student Name:

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


--3(d)


--3(e)

