-- Creates a table to be used to store PSTN information and user information

CREATE TABLE PSTNNumbers_DK (
    PSTNnumber int NOT NULL PRIMARY KEY,
    UsedBy varchar(255),
    ReservedFor varchar(255),
    CountryCode int
);
