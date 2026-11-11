/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-ca-insert.sql

--Student ID:
--Student Name:

/*
Indicate if AI was used (Yes/No):

If AI was used, you must clearly acknowledge the source following Monash Guidelines
(https://www.monash.edu/student-academic-success/ai-hub/acknowledging-the-use-of-ai)

AI and GenAI Acknowledgement and Prompts:

*/

--------------------------------------
--INSERT INTO property
--------------------------------------
-- 25 properties, 5 in each of the 5 authorities (prop_id 1 - 25).
-- The last property in each authority (5, 10, 15, 20, 25) is a new
-- property with no bins yet.
-- Properties 10 and 15 share the same address in different authorities,
-- which is allowed since an address is only unique within an authority.

-- Borough of Queenscliffe
INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 1,
      '12 Hesse Street, Queenscliff',
      'Borough of Queenscliffe' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 2,
      '3 Gellibrand Street, Queenscliff',
      'Borough of Queenscliffe' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 3,
      '45 Point Lonsdale Road, Point Lonsdale',
      'Borough of Queenscliffe' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 4,
      '8 Stokes Street, Queenscliff',
      'Borough of Queenscliffe' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 5,
      '27 Ocean Road, Point Lonsdale',
      'Borough of Queenscliffe' );

-- Shire of Yarra Ranges
INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 6,
      '14 Main Street, Lilydale',
      'Shire of Yarra Ranges' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 7,
      '2 Maroondah Highway, Healesville',
      'Shire of Yarra Ranges' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 8,
      '9 Monbulk Road, Belgrave',
      'Shire of Yarra Ranges' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 9,
      '31 Warburton Highway, Seville',
      'Shire of Yarra Ranges' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 10,
      '1 Hobbit Lane, Wheelers Hill',
      'Shire of Yarra Ranges' );

-- City of Monash
INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 11,
      '20 Kingsway, Glen Waverley',
      'City of Monash' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 12,
      '5 Atherton Road, Oakleigh',
      'City of Monash' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 13,
      '118 Wellington Road, Clayton',
      'City of Monash' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 14,
      '7 Stephensons Road, Mount Waverley',
      'City of Monash' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 15,
      '1 Hobbit Lane, Wheelers Hill',
      'City of Monash' );

-- Shire of Mornington Peninsula
INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 16,
      '33 Main Street, Mornington',
      'Shire of Mornington Peninsula' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 17,
      '4 Point Nepean Road, Rosebud',
      'Shire of Mornington Peninsula' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 18,
      '61 Ocean Beach Road, Sorrento',
      'Shire of Mornington Peninsula' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 19,
      '15 High Street, Hastings',
      'Shire of Mornington Peninsula' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 20,
      '9 Esplanade, Mount Martha',
      'Shire of Mornington Peninsula' );

-- City of Melbourne
INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 21,
      '250 Swanston Street, Melbourne',
      'City of Melbourne' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 22,
      '18 Lygon Street, Carlton',
      'City of Melbourne' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 23,
      '77 Errol Street, North Melbourne',
      'City of Melbourne' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 24,
      '6 Domain Road, South Yarra',
      'City of Melbourne' );

INSERT INTO property (
    prop_id,
    prop_address,
    auth_name
) VALUES
    ( 25,
      '40 Bellair Street, Kensington',
      'City of Melbourne' );


--------------------------------------
--INSERT INTO bin
--------------------------------------
-- Bins 1 - 64 are original bins: one recycle (RC), green waste (GW) and
-- landfill (LF) bin for each of 20 properties, plus a glass (RG) bin for
-- properties 16, 17, 21 and 22 (only these authorities have a glass contract).
-- Each bin's waste type is covered by a contract of the property's authority
-- and each waste type/size pair exists in BIN_TYPE.
-- Properties 4 and 24 only received their bins part-way through October 2026.

-- Property 1 (Borough of Queenscliffe)
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
    ( 1,
      'E280689400004025A1B2DEEF',
      TO_DATE('13-Jul-2026','DD-Mon-YYYY'),
      NULL,
      1,
      'RC',
      240,
      NULL );

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
    ( 2,
      'E28068940000404AA1B2FDDE',
      TO_DATE('13-Jul-2026','DD-Mon-YYYY'),
      NULL,
      1,
      'GW',
      240,
      NULL );

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
    ( 3,
      'E28068940000406FA1B31CCD',
      TO_DATE('13-Jul-2026','DD-Mon-YYYY'),
      NULL,
      1,
      'LF',
      100,
      NULL );

-- Property 2 (Borough of Queenscliffe)
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
    ( 4,
      'E280689400004094A1B33BBC',
      TO_DATE('14-Jul-2026','DD-Mon-YYYY'),
      NULL,
      2,
      'RC',
      240,
      NULL );

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
    ( 5,
      'E2806894000040B9A1B35AAB',
      TO_DATE('14-Jul-2026','DD-Mon-YYYY'),
      NULL,
      2,
      'GW',
      100,
      NULL );

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
    ( 6,
      'E2806894000040DEA1B3799A',
      TO_DATE('14-Jul-2026','DD-Mon-YYYY'),
      NULL,
      2,
      'LF',
      240,
      NULL );

-- Property 3 (Borough of Queenscliffe)
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
    ( 7,
      'E280689400004103A1B39889',
      TO_DATE('15-Jul-2026','DD-Mon-YYYY'),
      NULL,
      3,
      'RC',
      100,
      NULL );

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
    ( 8,
      'E280689400004128A1B3B778',
      TO_DATE('15-Jul-2026','DD-Mon-YYYY'),
      NULL,
      3,
      'GW',
      75,
      NULL );

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
    ( 9,
      'E28068940000414DA1B3D667',
      TO_DATE('15-Jul-2026','DD-Mon-YYYY'),
      NULL,
      3,
      'LF',
      100,
      NULL );

-- Property 4 (Borough of Queenscliffe)
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
    ( 10,
      'E280689400004172A1B3F556',
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      NULL,
      4,
      'RC',
      240,
      NULL );

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
    ( 11,
      'E280689400004197A1B41445',
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      NULL,
      4,
      'GW',
      240,
      NULL );

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
    ( 12,
      'E2806894000041BCA1B43334',
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      NULL,
      4,
      'LF',
      240,
      NULL );

-- Property 6 (Shire of Yarra Ranges)
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
    ( 13,
      'E2806894000041E1A1B45223',
      TO_DATE('04-May-2026','DD-Mon-YYYY'),
      NULL,
      6,
      'RC',
      240,
      NULL );

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
    ( 14,
      'E280689400004206A1B47112',
      TO_DATE('04-May-2026','DD-Mon-YYYY'),
      NULL,
      6,
      'GW',
      240,
      NULL );

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
    ( 15,
      'E28068940000422BA1B49001',
      TO_DATE('04-May-2026','DD-Mon-YYYY'),
      NULL,
      6,
      'LF',
      100,
      NULL );

-- Property 7 (Shire of Yarra Ranges)
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
    ( 16,
      'E280689400004250A1B4AEF0',
      TO_DATE('05-May-2026','DD-Mon-YYYY'),
      NULL,
      7,
      'RC',
      240,
      NULL );

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
    ( 17,
      'E280689400004275A1B4CDDF',
      TO_DATE('05-May-2026','DD-Mon-YYYY'),
      NULL,
      7,
      'GW',
      100,
      NULL );

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
    ( 18,
      'E28068940000429AA1B4ECCE',
      TO_DATE('05-May-2026','DD-Mon-YYYY'),
      NULL,
      7,
      'LF',
      240,
      NULL );

-- Property 8 (Shire of Yarra Ranges)
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
    ( 19,
      'E2806894000042BFA1B50BBD',
      TO_DATE('06-May-2026','DD-Mon-YYYY'),
      NULL,
      8,
      'RC',
      100,
      NULL );

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
    ( 20,
      'E2806894000042E4A1B52AAC',
      TO_DATE('06-May-2026','DD-Mon-YYYY'),
      NULL,
      8,
      'GW',
      75,
      NULL );

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
    ( 21,
      'E280689400004309A1B5499B',
      TO_DATE('06-May-2026','DD-Mon-YYYY'),
      NULL,
      8,
      'LF',
      100,
      NULL );

-- Property 9 (Shire of Yarra Ranges)
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
    ( 22,
      'E28068940000432EA1B5688A',
      TO_DATE('07-May-2026','DD-Mon-YYYY'),
      NULL,
      9,
      'RC',
      240,
      NULL );

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
    ( 23,
      'E280689400004353A1B58779',
      TO_DATE('07-May-2026','DD-Mon-YYYY'),
      NULL,
      9,
      'GW',
      240,
      NULL );

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
    ( 24,
      'E280689400004378A1B5A668',
      TO_DATE('07-May-2026','DD-Mon-YYYY'),
      NULL,
      9,
      'LF',
      240,
      NULL );

-- Property 11 (City of Monash)
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
    ( 25,
      'E28068940000439DA1B5C557',
      TO_DATE('01-Jun-2026','DD-Mon-YYYY'),
      NULL,
      11,
      'RC',
      240,
      NULL );

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
    ( 26,
      'E2806894000043C2A1B5E446',
      TO_DATE('01-Jun-2026','DD-Mon-YYYY'),
      NULL,
      11,
      'GW',
      240,
      NULL );

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
    ( 27,
      'E2806894000043E7A1B60335',
      TO_DATE('01-Jun-2026','DD-Mon-YYYY'),
      NULL,
      11,
      'LF',
      100,
      NULL );

-- Property 12 (City of Monash)
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
    ( 28,
      'E28068940000440CA1B62224',
      TO_DATE('02-Jun-2026','DD-Mon-YYYY'),
      NULL,
      12,
      'RC',
      240,
      NULL );

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
    ( 29,
      'E280689400004431A1B64113',
      TO_DATE('02-Jun-2026','DD-Mon-YYYY'),
      NULL,
      12,
      'GW',
      100,
      NULL );

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
    ( 30,
      'E280689400004456A1B66002',
      TO_DATE('02-Jun-2026','DD-Mon-YYYY'),
      NULL,
      12,
      'LF',
      240,
      NULL );

-- Property 13 (City of Monash)
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
    ( 31,
      'E28068940000447BA1B67EF1',
      TO_DATE('03-Jun-2026','DD-Mon-YYYY'),
      NULL,
      13,
      'RC',
      100,
      NULL );

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
    ( 32,
      'E2806894000044A0A1B69DE0',
      TO_DATE('03-Jun-2026','DD-Mon-YYYY'),
      NULL,
      13,
      'GW',
      75,
      NULL );

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
    ( 33,
      'E2806894000044C5A1B6BCCF',
      TO_DATE('03-Jun-2026','DD-Mon-YYYY'),
      NULL,
      13,
      'LF',
      100,
      NULL );

-- Property 14 (City of Monash)
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
    ( 34,
      'E2806894000044EAA1B6DBBE',
      TO_DATE('04-Jun-2026','DD-Mon-YYYY'),
      NULL,
      14,
      'RC',
      240,
      NULL );

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
    ( 35,
      'E28068940000450FA1B6FAAD',
      TO_DATE('04-Jun-2026','DD-Mon-YYYY'),
      NULL,
      14,
      'GW',
      240,
      NULL );

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
    ( 36,
      'E280689400004534A1B7199C',
      TO_DATE('04-Jun-2026','DD-Mon-YYYY'),
      NULL,
      14,
      'LF',
      240,
      NULL );

-- Property 16 (Shire of Mornington Peninsula)
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
    ( 37,
      'E280689400004559A1B7388B',
      TO_DATE('03-Aug-2026','DD-Mon-YYYY'),
      NULL,
      16,
      'RC',
      240,
      NULL );

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
    ( 38,
      'E28068940000457EA1B7577A',
      TO_DATE('03-Aug-2026','DD-Mon-YYYY'),
      NULL,
      16,
      'GW',
      240,
      NULL );

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
    ( 39,
      'E2806894000045A3A1B77669',
      TO_DATE('03-Aug-2026','DD-Mon-YYYY'),
      NULL,
      16,
      'LF',
      100,
      NULL );

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
    ( 40,
      'E2806894000045C8A1B79558',
      TO_DATE('03-Aug-2026','DD-Mon-YYYY'),
      NULL,
      16,
      'RG',
      240,
      NULL );

-- Property 17 (Shire of Mornington Peninsula)
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
    ( 41,
      'E2806894000045EDA1B7B447',
      TO_DATE('04-Aug-2026','DD-Mon-YYYY'),
      NULL,
      17,
      'RC',
      240,
      NULL );

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
    ( 42,
      'E280689400004612A1B7D336',
      TO_DATE('04-Aug-2026','DD-Mon-YYYY'),
      NULL,
      17,
      'GW',
      100,
      NULL );

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
    ( 43,
      'E280689400004637A1B7F225',
      TO_DATE('04-Aug-2026','DD-Mon-YYYY'),
      NULL,
      17,
      'LF',
      240,
      NULL );

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
    ( 44,
      'E28068940000465CA1B81114',
      TO_DATE('04-Aug-2026','DD-Mon-YYYY'),
      NULL,
      17,
      'RG',
      240,
      NULL );

-- Property 18 (Shire of Mornington Peninsula)
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
    ( 45,
      'E280689400004681A1B83003',
      TO_DATE('05-Aug-2026','DD-Mon-YYYY'),
      NULL,
      18,
      'RC',
      100,
      NULL );

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
    ( 46,
      'E2806894000046A6A1B84EF2',
      TO_DATE('05-Aug-2026','DD-Mon-YYYY'),
      NULL,
      18,
      'GW',
      75,
      NULL );

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
    ( 47,
      'E2806894000046CBA1B86DE1',
      TO_DATE('05-Aug-2026','DD-Mon-YYYY'),
      NULL,
      18,
      'LF',
      100,
      NULL );

-- Property 19 (Shire of Mornington Peninsula)
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
    ( 48,
      'E2806894000046F0A1B88CD0',
      TO_DATE('06-Aug-2026','DD-Mon-YYYY'),
      NULL,
      19,
      'RC',
      240,
      NULL );

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
    ( 49,
      'E280689400004715A1B8ABBF',
      TO_DATE('06-Aug-2026','DD-Mon-YYYY'),
      NULL,
      19,
      'GW',
      240,
      NULL );

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
    ( 50,
      'E28068940000473AA1B8CAAE',
      TO_DATE('06-Aug-2026','DD-Mon-YYYY'),
      NULL,
      19,
      'LF',
      240,
      NULL );

-- Property 21 (City of Melbourne)
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
    ( 51,
      'E28068940000475FA1B8E99D',
      TO_DATE('05-Jan-2026','DD-Mon-YYYY'),
      NULL,
      21,
      'RC',
      240,
      NULL );

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
    ( 52,
      'E280689400004784A1B9088C',
      TO_DATE('05-Jan-2026','DD-Mon-YYYY'),
      NULL,
      21,
      'GW',
      240,
      NULL );

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
    ( 53,
      'E2806894000047A9A1B9277B',
      TO_DATE('05-Jan-2026','DD-Mon-YYYY'),
      NULL,
      21,
      'LF',
      100,
      NULL );

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
    ( 54,
      'E2806894000047CEA1B9466A',
      TO_DATE('05-Jan-2026','DD-Mon-YYYY'),
      NULL,
      21,
      'RG',
      240,
      NULL );

-- Property 22 (City of Melbourne)
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
    ( 55,
      'E2806894000047F3A1B96559',
      TO_DATE('06-Jan-2026','DD-Mon-YYYY'),
      NULL,
      22,
      'RC',
      240,
      NULL );

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
    ( 56,
      'E280689400004818A1B98448',
      TO_DATE('06-Jan-2026','DD-Mon-YYYY'),
      NULL,
      22,
      'GW',
      100,
      NULL );

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
    ( 57,
      'E28068940000483DA1B9A337',
      TO_DATE('06-Jan-2026','DD-Mon-YYYY'),
      NULL,
      22,
      'LF',
      240,
      NULL );

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
    ( 58,
      'E280689400004862A1B9C226',
      TO_DATE('06-Jan-2026','DD-Mon-YYYY'),
      NULL,
      22,
      'RG',
      240,
      NULL );

-- Property 23 (City of Melbourne)
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
    ( 59,
      'E280689400004887A1B9E115',
      TO_DATE('07-Jan-2026','DD-Mon-YYYY'),
      NULL,
      23,
      'RC',
      100,
      NULL );

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
    ( 60,
      'E2806894000048ACA1BA0004',
      TO_DATE('07-Jan-2026','DD-Mon-YYYY'),
      NULL,
      23,
      'GW',
      75,
      NULL );

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
    ( 61,
      'E2806894000048D1A1BA1EF3',
      TO_DATE('07-Jan-2026','DD-Mon-YYYY'),
      NULL,
      23,
      'LF',
      100,
      NULL );

-- Property 24 (City of Melbourne)
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
    ( 62,
      'E2806894000048F6A1BA3DE2',
      TO_DATE('09-Oct-2026','DD-Mon-YYYY'),
      NULL,
      24,
      'RC',
      240,
      NULL );

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
    ( 63,
      'E28068940000491BA1BA5CD1',
      TO_DATE('09-Oct-2026','DD-Mon-YYYY'),
      NULL,
      24,
      'GW',
      240,
      NULL );

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
    ( 64,
      'E280689400004940A1BA7BC0',
      TO_DATE('09-Oct-2026','DD-Mon-YYYY'),
      NULL,
      24,
      'LF',
      240,
      NULL );

-- Replacement bins (65 - 71): each records the bin it replaces and the reason.
-- A replacement is supplied after the last pickup of the bin it replaces and
-- goes to the same property for the same waste type (the size may change).
-- Bin 71 replaces bin 70, which itself replaced bin 61 (a chain of replacements).

-- Property 2: bin 65 replaces bin 6 (damaged during pickup)
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
    ( 65,
      'E280689400004965A1BA9AAF',
      TO_DATE('12-Oct-2026','DD-Mon-YYYY'),
      'P',
      2,
      'LF',
      240,
      6 );

-- Property 7: bin 66 replaces bin 17 (stolen)
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
    ( 66,
      'E28068940000498AA1BAB99E',
      TO_DATE('20-Oct-2026','DD-Mon-YYYY'),
      'S',
      7,
      'GW',
      100,
      17 );

-- Property 11: bin 67 replaces bin 25 (damaged by owner)
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
    ( 67,
      'E2806894000049AFA1BAD88D',
      TO_DATE('15-Oct-2026','DD-Mon-YYYY'),
      'D',
      11,
      'RC',
      240,
      25 );

-- Property 18: bin 68 replaces bin 47 (bin failure)
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
    ( 68,
      'E2806894000049D4A1BAF77C',
      TO_DATE('14-Oct-2026','DD-Mon-YYYY'),
      'F',
      18,
      'LF',
      100,
      47 );

-- Property 22: bin 69 replaces bin 56 (stolen)
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
    ( 69,
      'E2806894000049F9A1BB166B',
      TO_DATE('16-Oct-2026','DD-Mon-YYYY'),
      'S',
      22,
      'GW',
      240,
      56 );

-- Property 23: bin 70 replaces bin 61 (damaged during pickup)
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
    ( 70,
      'E280689400004A1EA1BB355A',
      TO_DATE('08-Oct-2026','DD-Mon-YYYY'),
      'P',
      23,
      'LF',
      100,
      61 );

-- Property 23: bin 71 replaces bin 70 (bin failure)
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
    ( 71,
      'E280689400004A43A1BB5449',
      TO_DATE('15-Oct-2026','DD-Mon-YYYY'),
      'F',
      23,
      'LF',
      240,
      70 );


--------------------------------------
--INSERT INTO bin_collect
--------------------------------------


