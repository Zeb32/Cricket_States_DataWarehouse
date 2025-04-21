-------------------------------------------------------------------------------------------
/* This Script Drop Cricket_State_Warehouse and Then Create it. Use Cricket_State_Warehouse
and then Create Schema for All our Layers Bronze, Silver and Gold*/
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

-- Use Master DataBase Before Dropping The Current DataBase
USE master;

GO

-- Drop DataBase Cricket_State_Warehouse
DROP DATABASE Cricket_State_Warehouse;

GO

-- Create DataBase Cricket_State_Warehouse
CREATE DATABASE Cricket_State_Warehouse;

GO

-- Use DataBase Cricket_State_Warehouse
USE Cricket_State_Warehouse;

GO

-- Create Schema for Bronze, Silver And Gold Layers
CREATE SCHEMA Bronze;

GO


CREATE SCHEMA Silver;

GO


CREATE SCHEMA Gold;

GO