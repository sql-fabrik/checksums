CREATE FUNCTION [dbo].[sfn_calc_GTIN13]    
                   ( @in_char12  char(12) )
RETURNS char(13)
AS
BEGIN
----
DECLARE @return   char(13)
DECLARE @calcSUM  int     

SET @calcSUM = CAST( SUBSTRING( @in_char12,  1, 1 )  as int ) * 1  --01  
             + CAST( SUBSTRING( @in_char12,  2, 1 )  as int ) * 3  --02  
             + CAST( SUBSTRING( @in_char12,  3, 1 )  as int ) * 1  --03  
             + CAST( SUBSTRING( @in_char12,  4, 1 )  as int ) * 3  --04  
             + CAST( SUBSTRING( @in_char12,  5, 1 )  as int ) * 1  --05  
             + CAST( SUBSTRING( @in_char12,  6, 1 )  as int ) * 3  --06  
             + CAST( SUBSTRING( @in_char12,  7, 1 )  as int ) * 1  --07  
             + CAST( SUBSTRING( @in_char12,  8, 1 )  as int ) * 3  --08  
             + CAST( SUBSTRING( @in_char12,  9, 1 )  as int ) * 1  --09  
             + CAST( SUBSTRING( @in_char12, 10, 1 )  as int ) * 3  --10  
             + CAST( SUBSTRING( @in_char12, 11, 1 )  as int ) * 1  --11  
             + CAST( SUBSTRING( @in_char12, 12, 1 )  as int ) * 3  --12  

                             --  % = modulo
SET @return =  CASE
                   WHEN @calcSUM % 10 = 0 THEN @in_char12 + '0'              
                   ELSE                        @in_char12 + CAST( 10- ( @calcSUM % 10 ) as char(1) )
               END

-- Return the result of the function
RETURN @return

END
--  end FUNCTION
