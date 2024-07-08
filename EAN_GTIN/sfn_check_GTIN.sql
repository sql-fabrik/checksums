CREATE FUNCTION [dbo].[sfn_check_GTIN13]    
                    ( @in_char13  char(13) )
RETURNS bit  -- TRUE is converted to 1 and FALSE is converted to 0.
AS
BEGIN
----
DECLARE @return   bit
      , @part12   char(12) = SUBSTRING( @in_char13,  1, 12 )
      , @partChk  char(1)  = SUBSTRING( @in_char13, 13,  1 )
      , @calcSUM  int     

SET @calcSUM = CAST( SUBSTRING( @part12,  1, 1 )  as int ) * 1  --01  
             + CAST( SUBSTRING( @part12,  2, 1 )  as int ) * 3  --02  
             + CAST( SUBSTRING( @part12,  3, 1 )  as int ) * 1  --03  
             + CAST( SUBSTRING( @part12,  4, 1 )  as int ) * 3  --04  
             + CAST( SUBSTRING( @part12,  5, 1 )  as int ) * 1  --05  
             + CAST( SUBSTRING( @part12,  6, 1 )  as int ) * 3  --06  
             + CAST( SUBSTRING( @part12,  7, 1 )  as int ) * 1  --07  
             + CAST( SUBSTRING( @part12,  8, 1 )  as int ) * 3  --08  
             + CAST( SUBSTRING( @part12,  9, 1 )  as int ) * 1  --09  
             + CAST( SUBSTRING( @part12, 10, 1 )  as int ) * 3  --10  
             + CAST( SUBSTRING( @part12, 11, 1 )  as int ) * 1  --11  
             + CAST( SUBSTRING( @part12, 12, 1 )  as int ) * 3  --12  

                             --  % = modulo
SET @return = CASE
                  WHEN CAST( @calcSUM % 10       as char(1) ) = @partChk  THEN CAST( 1 as bit )  -- 10er 
                  WHEN CAST( 10- @calcSUM  % 10  as char(1) ) = @partChk  THEN CAST( 1 as bit )          
                  ELSE CAST( 0 as bit )
              END

-- Return the result of the function
RETURN @return

END
--  end FUNCTION
