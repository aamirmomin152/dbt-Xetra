USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;
USE DATABASE DEMO_DB;

--Create three schemas for processing layers
CREATE SCHEMA IF NOT EXISTS XETRA_RAW; 
CREATE SCHEMA IF NOT EXISTS XETRA_STAGE;
CREATE SCHEMA IF NOT EXISTS XETRA_PROCESSED;

--Use RAW Schema
USE SCHEMA XETRA_RAW;

--Create stocks table 
CREATE TABLE IF NOT EXISTS STOCKS (
  ISIN STRING
, Mnemonic STRING
, SecurityDesc STRING
, SecurityType STRING 
, Currency STRING 
, SecurityID STRING
, Date STRING
, Time STRING
, StartPrice STRING
, MaxPrice STRING
, MinPrice STRING
, EndPrice STRING
, TradedVolume STRING
, NumberOfTrades STRING
);

--Create external stage from S3
CREATE STAGE XETRA_STAGE
  url='s3://deutsche-boerse-xetra-pds/2017-08-01/'
  credentials=(aws_key_id='AWS_KEY' aws_secret_key='AWS_SECRET');

--Create file format type for ingestion from S3
CREATE FILE FORMAT XETRA_STAGE_CSV_FORMAT 
TYPE = 'CSV' 
COMPRESSION = 'NONE' 
FIELD_DELIMITER = ',' 
RECORD_DELIMITER = '\n' 
SKIP_HEADER = 1 
FIELD_OPTIONALLY_ENCLOSED_BY = '\042' 
TRIM_SPACE = FALSE 
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE 
ESCAPE = 'NONE' 
ESCAPE_UNENCLOSED_FIELD = '\134' 
DATE_FORMAT = 'AUTO' 
TIMESTAMP_FORMAT = 'AUTO' NULL_IF = ('\\N');
  
--List files in S3 Stage
list @XETRA_STAGE;

-- Create the snowpipe to auto ingest data
CREATE OR REPLACE PIPE STOCKS__PIPE
  AUTO_INGEST = TRUE
  AS COPY INTO STOCKS (ISIN,Mnemonic,SecurityDesc,SecurityType,Currency,SecurityID,Date,Time,StartPrice,MaxPrice,MinPrice,EndPrice,TradedVolume,NumberOfTrades)
  FROM (
    SELECT
      $1
    , $2
    , $3
    , $4
    , $5
    , $6
    , $7
    , $8
    , $9
    , $10
    , $11
    , $12
    , $13
    , $14
    FROM @XETRA_STAGE
  )
  file_format = (format_name = XETRA_STAGE_CSV_FORMAT)
  credentials=(aws_key_id='AWS_KEY' aws_secret_key='AWS_SECRET');





