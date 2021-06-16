{{ config(
    alias='DIM_STOCKS',
    unique_key='ID',
    materialized='incremental'
) }}


WITH STOCKS_DIM AS (
    SELECT 
      ID
    , ISIN
    , STOCK_TICKER
    , SECURITY_DESCRIPTION
    , SECURITY_TYPE
    , TRADED_CURRENCY
    , SECURITY_ID
    FROM {{ ref('stage__xetra__stocks') }}
)

SELECT * 
FROM STOCKS_DIM

