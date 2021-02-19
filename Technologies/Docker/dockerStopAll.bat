@ECHO OFF
FOR /f "tokens=*" %%i IN ('docker ps -a -q'); DO docker stop %%i && docker rm %%i