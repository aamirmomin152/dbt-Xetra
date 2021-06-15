{{ config(
    alias='STOCKS',
    unique_key='ID',
    materialized='incremental'
) }}

WITH STOCKS AS (
    SELECT 
      uuid_string() AS ID
    , ISIN::STRING AS ISIN
    , Mnemonic::STRING AS STOCK_TICKER
    , SecurityDesc::STRING AS SECURITY_DESCRIPTION
    , SecurityType::STRING AS SECURITY_TYPE
    , Currency::STRING AS TRADED_CURRENCY
    , SecurityID::int AS SECURITY_ID
    , Date::DATE as TRADING_PERIOD_DATE
    , Time::TIME AS TRADING_PERIOD_TIME
    , StartPrice::float AS START_PRICE
    , MaxPrice::float AS MAXIMUM_PRICE
    , MinPrice::float AS MINUMUM_PRICE
    , EndPrice::float AS END_PRICE
    , TradedVolume::float AS TRADED_VOLUME
    , NumberOfTrades::int AS NUMBER_OF_TRADES
    FROM {{ source('raw__stocks', 'STOCKS') }}
)

SELECT * 
FROM STOCKS



