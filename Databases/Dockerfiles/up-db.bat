@ECHO OFF

REM Changes directory into this one
cd /D "%~dp0"

REM Set path variable
SET thisScriptPath=%~dp0/

REM Setting variables via property file
@echo off  
FOR /F "tokens=1,2 delims==" %%G IN (%thisScriptPath%/database/properties.local.properties) DO (set %%G=%%H)  

docker-compose -f ./database/docker-compose.yml up -d