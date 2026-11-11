// *****PLEASE ENTER YOUR DETAILS BELOW*****
// T5-ca-mongo.mongodb.js

// Student ID: 34021396
// Student Name: Daniel Ross Mackay 

// ===================================================================================
// DO NOT modify or remove any of the comments below (items marked with //)
// Do not use .pretty() in your code, it is not required
//
// -- Submission Declaration - must not be removed - removal will result in no marks being awarded --
// In submitting this SQL script, I confirm that this is my own work without coding assistance from Generative AI
// ===================================================================================

// Use (connect to) your database - you MUST update xyz001
// with your authcate username

//use("abc001");

// (b)
// PLEASE PLACE REQUIRED MONGODB COMMAND TO CREATE THE COLLECTION HERE
// YOU MAY PICK ANY COLLECTION NAME
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Drop collection
db.property_bins.drop();

// Create collection and insert documents
db.createCollection("property_bins");

db.property_bins.insertMany([
 
]);

// List all documents you added
db.property_bins.find();

// (c)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Properties with more than 3 supplied bins (of any waste type) 
db.property_bins.find(
    {
        "bin_stats.number_of_suppliedbins": { $gt: 3 },
        $or: [
            { prop_fulladdress: { $regex: /Shire of Yarra Ranges$/ } },
            { prop_fulladdress: { $regex: /Shire of Mornington Peninsula$/ } }
        ]
    },
    {
        prop_fulladdress: 1,
        "bin_stats.number_of_suppliedbins": 1,
        "bins.bin_rfid": 1,
        "bins.supplied_date": 1
    }
);


// (d)
// PLEASE PLACE REQUIRED MONGODB COMMAND/S FOR THIS PART HERE
// ENSURE that your query is formatted and has a semicolon
// (;) at the end of this answer

// Show details of the property at 14 Wellington Road, Clayton, City of Monash.

// (i)  Add the new bin


// Show details of the property at 14 Wellington Road, Clayton, City of Monash.


// (ii) Add new waste collection


// Show details of the property at 14 Wellington Road, Clayton, City of Monash.


// End of file - do not remove
