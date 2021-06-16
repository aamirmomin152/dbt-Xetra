{{ config(
    alias='FACT_STOCKS',
    unique_key='ID',
    materialized='incremental'
) }}


WITH STOCKS_FACT AS (
    SELECT 
      ID
    , START_PRICE
    , MAXIMUM_PRICE
    , MINUMUM_PRICE
    , END_PRICE
    , TRADED_VOLUME
    , NUMBER_OF_TRADES
    FROM {{ ref('stage__xetra__stocks') }}
)

SELECT * 
FROM STOCKS_FACT

