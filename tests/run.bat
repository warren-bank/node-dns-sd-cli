@echo off

set DIR=%~dp0.
set workspace=%DIR%\workspace

if exist "%workspace%" rmdir /Q /S "%workspace%"
mkdir "%workspace%"
cd "%workspace%"

call npm init -y
call npm install --save "%DIR%\.."
cls

set PATH=%workspace%\node_modules\.bin;%PATH%

call bonjour --help                           >"1-help.txt"
call bonjour --version                        >"2-version.txt"
call bonjour --services                       >"3-discovery-services.txt"
call bonjour --printers                       >"4-discovery-printers.txt"
call bonjour --chromecast                     >"5-discovery-chromecast.txt"
call bonjour --discover "_airplay._tcp.local" >"6-discovery-appletv.txt"

cls
echo press Ctrl+C to end monitoring..
call bonjour --monitor                        >"7-monitor-packets.txt"
